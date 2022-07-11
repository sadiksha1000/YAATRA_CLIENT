import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../../core/server/server.dart';
import '../models/upload_image_model.dart';

abstract class UploadImageRemoteDataSource {
  /// it will hit http://localhost:3001/uploadImages will return list of string
  /// that holds uploaded image urls
  /// Throws [ServerFailure] when not resolved
  Future<UploadImageModel> uploadImages({required List<File> uploadImages}) {
    throw UnimplementedError();
  }
}

class UploadImageRemoteDataSourceImpl implements UploadImageRemoteDataSource {
  http.Client client;
  UploadImageRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<UploadImageModel> uploadImages(
      {required List<File> uploadImages}) async {
    try {
      var images = uploadImages;
      final Uri uri = Uri.parse("$serverUrl/upload/multiple");

      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      // request.headers[''] = '';
      // request.fields['user_id'] = '10';
      // request.fields['post_details'] = 'dfsfdsfsd';

      List<http.MultipartFile> newList = [];
      for (int i = 0; i < images.length; i++) {
        File imageFile = File(images[i].path);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile("images", stream, length,
            filename: imageFile.path);

        newList.add(multipartFile);
      }
      request.files.addAll(newList);
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return UploadImageModel.fromJson(responseData);
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
