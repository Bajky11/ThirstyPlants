import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/screens/_shared_widgets/hooks/use_camera_upload.dart';
import 'package:frontend/screens/_shared_widgets/hooks/use_cloudflare_images.dart';
import 'package:frontend/services/flower/flower_query.dart';
import 'package:frontend/services/flower/models/dto/add_flower_request_dto_model.dart';
import 'package:frontend/services/flower/models/dto/flower_response_dto.dart';
import 'package:frontend/services/flower/models/dto/update_flower_request_dto_model.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlowerEditDialog extends HookConsumerWidget {
  const FlowerEditDialog({super.key, this.flower});

  final FlowerResponseDTO? flower;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider).asData?.value;
    final camera = useCamera();
    final cloudflareImages = useCloudflareImages();
    final homeId = appState!.selectedHome!.id;
    final formKey = GlobalKey<FormBuilderState>();
    bool renderEditForm = flower != null;

    Future<void> validateFormAndCreateFlower() async {
      if (!(formKey.currentState?.saveAndValidate() ?? false)) {
        return;
      }

      final data = formKey.currentState!.value;
      String? imageId = await cloudflareImages.uploadImage(camera.image);

      if (imageId == null) {
        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("Error"),
                content: Text(
                  "Failed to upload image, try again while editing plant.",
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"),
                  ),
                ],
              ),
        );
      }

      await addFlowerMutation(homeId)
          .mutate(
            AddFlowerRequestDTO(
              name: data['name'],
              homeId: homeId,
              cloudflareImageId: imageId,
              wateringFrequencyDays: int.parse(
                data["wateringFrequencyDays"].toString(),
              ),
            ),
          )
          .then((val) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Flower created')));
            Navigator.of(context).pop();
          })
          .onError(
            (error, stackTrace) => Future(() {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Error')));
              Navigator.of(context).pop();
            }),
          );
    }

    Future<void> validateFormAndUpdateFlower(FlowerResponseDTO flower) async {
      if (!(formKey.currentState?.saveAndValidate() ?? false)) {
        return;
      }

      final data = formKey.currentState!.value;

      updateFlowerMutation(flower.id, homeId)
          .mutate(
            UpdateFlowerRequestDTO(
              name: data["name"],
              wateringFrequencyDays: int.parse(data["wateringFrequencyDays"]),
            ),
          )
          .then((val) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Flower updated')));
            Navigator.of(context).pop();
          })
          .onError(
            (error, stackTrace) => Future(() {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Error')));
              Navigator.of(context).pop();
            }),
          );
    }

    Future<void> deleteFlower(int homeId, FlowerResponseDTO flower) async {
      if (flower.cloudflareImageId != null) {
        final result = await cloudflareImages.deleteImage(
          flower.cloudflareImageId!,
        );

        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Failed to delete image. Flower can not deleted now. Try again later.',
              ),
            ),
          );
          return;
        }
      }

      await deleteFlowerMutation(homeId)
          .mutate(flower.id)
          .then((val) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Plant deleted')));
            Navigator.of(context).pop();
          })
          .onError((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error while deleting plant')),
            );
          });
    }

    return AlertDialog(
      title: renderEditForm ? Text('Update flower') : Text("New flower"),
      content: SingleChildScrollView(
        child: FormBuilder(
          key: formKey,
          child: Column(
            spacing: 24,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              FormBuilderTextField(
                name: 'name',
                initialValue: renderEditForm ? flower!.name : null,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),

              FormBuilderTextField(
                name: 'wateringFrequencyDays',
                initialValue:
                    renderEditForm
                        ? flower!.wateringFrequencyDays.toString()
                        : "1",
                decoration: const InputDecoration(
                  labelText: 'Watter every ? days',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),

              if (!renderEditForm)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: camera.takePicture,
                    child: const Text('Capture flower'),
                  ),
                ),

              if (!renderEditForm)
                camera.image != null
                    ? Image.file(File(camera.image!.path))
                    : const Text('Zatím žádná fotka'),
            ],
          ),
        ),
      ),
      // actions vykreslí tlačítka pod obsahem; samy se přizpůsobí šířce dialogu
      actions: [
        if (renderEditForm)
          ElevatedButton(
            onPressed: () => deleteFlower(homeId, flower!),
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ElevatedButton(
          onPressed:
              cloudflareImages.loading.value
                  ? null
                  : () async {
                    if (renderEditForm) {
                      await validateFormAndUpdateFlower(flower!);
                    } else {
                      await validateFormAndCreateFlower();
                    }
                  },
          child:
              cloudflareImages.loading.value
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                  : Text(renderEditForm ? 'Update' : 'Create'),
        ),
      ],
    );
  }
}
