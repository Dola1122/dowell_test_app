import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class ImagesHelper {
  final ImagePicker _picker = ImagePicker();

  Future<String?> takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image?.path;
    // FormData data = await createFormData(image.path);
  }

  Future<FormData> createFormData(String photoURL) async {
    String imageUrl = photoURL;
    // images.add(imageUrl);
    String fileName = photoURL.split('/').last;
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        photoURL,
        filename: fileName,
      )
    });
    return data;
    // await upload(data); //edit
    // List<String> apiImages = await _upload(data); //edit
    // List<String> apiImages = [
    //   'https://picsum.photos/seed/831/600',
    //   'https://picsum.photos/seed/831/600',
    // ]; //edit
    // images.addAll(apiImages);
    // return imageUrl;
  }

  Future<List<String>?> uploadFormData(FormData data) async {
    List<String> resultImagesUrls = [];
    try {
      var response = await Dio()
          .post('https://100091.pythonanywhere.com/upload-logo/', data: data);
      var images = response.data['results'];
      resultImagesUrls.addAll(List<String>.from(images));
      log(response.data.toString());
      return resultImagesUrls;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
