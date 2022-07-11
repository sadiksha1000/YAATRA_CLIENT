import 'dart:convert';

import '../../domain/entities/upload_image.dart';

class UploadImageModel extends UploadImage {
  const UploadImageModel({required List<String> uploadedImages})
      : super(uploadedImages: uploadedImages);

  static const empty = UploadImageModel(uploadedImages: []);

  bool get isEmpty => this == UploadImageModel.empty;
  bool get isNotEmpty => this != UploadImageModel.empty;

  Map<String, dynamic> toMap() {
    return {
      'images': uploadedImages,
    };
  }

  factory UploadImageModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> imagesPath = map['data']['imagesPath'];
    List<String> uploadedImagesPathList =
        imagesPath.map((e) => e.toString()).toList();
    return UploadImageModel(
      uploadedImages: uploadedImagesPathList,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadImageModel.fromJson(String source) =>
      UploadImageModel.fromMap(json.decode(source));
}
