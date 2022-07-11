part of 'image_cubit.dart';

class ImageState extends Equatable {
  final Status status;
  final List<File> localImages;
  final List<String> uploadedImages;
  final String errorMessage;
  const ImageState({
    required this.status,
    required this.localImages,
    required this.uploadedImages,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [status, localImages, uploadedImages];

  factory ImageState.initial() {
    return const ImageState(
        status: Status.initial,
        localImages: [],
        uploadedImages: [],
        errorMessage: '');
  }

  ImageState copyWith(
      {Status? status,
      List<File>? localImages,
      List<String>? uploadedImages,
      String? errorMessage}) {
    return ImageState(
      localImages: localImages ?? this.localImages,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
