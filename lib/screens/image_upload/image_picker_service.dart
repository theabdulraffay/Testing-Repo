import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }
}
