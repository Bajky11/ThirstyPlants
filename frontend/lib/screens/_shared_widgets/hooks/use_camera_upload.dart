import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

typedef CameraHook = ({XFile? image, Future<void> Function() takePicture});

CameraHook useCamera() {
  final image = useState<XFile?>(null);
  final picker = ImagePicker();

  Future<void> takePicture() async {
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      image.value = pickedImage;
    }
  }

  return (image: image.value, takePicture: takePicture);
}
