import 'package:image_picker/image_picker.dart';

class MediaHelper {
  var imagePicker = ImagePicker();

 Future<XFile?> takeImageFromCamera() async {
   return await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
  }

  Future<XFile?>takeVideoFromCamera() async {
    return await imagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(minutes: 30));
  }

  Future<XFile?> getImageFromGallery() async {
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<List<XFile>>getMultiImageFromGallery() async {
    return await imagePicker.pickMultiImage();
  }

  Future<XFile?> getVideosFromGallery() async {
    return await imagePicker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(minutes: 30));
  }
}
