import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // musíš importnout hooks

import 'package:image_picker/image_picker.dart';

class CameraScreen extends HookConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = useState<XFile?>(null); // místo proměnné useState
    final ImagePicker _picker = ImagePicker();

    Future<void> _takePicture() async {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        image.value = pickedImage;
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image.value != null
              ? Image.file(File(image.value!.path))
              : const Text('Zatím žádný obrázek'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _takePicture,
            child: const Text('Vyfoť obrázek'),
          ),
        ],
      ),
    );
  }
}