import 'package:equatable/equatable.dart';

class UploadImage extends Equatable {
  final List<String> uploadedImages;
  const UploadImage({
    required this.uploadedImages,
  });

  static const empty = UploadImage(uploadedImages: []);

  bool get isEmpty => this == UploadImage.empty;
  bool get isNotEmpty => this != UploadImage.empty;


  @override
  List<Object> get props => [uploadedImages];
}
