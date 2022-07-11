import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/config/size.dart';
import '../../../../../core/utils/status.dart';
import '../../../../../core/widgets/image_upload_bottom_sheet.dart';
import '../../domain/usecases/upload_image_usecase.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  UploadImagesUseCase uploadImageUseCase;
  ImageCubit({required UploadImagesUseCase upImageUseCase})
      : uploadImageUseCase = upImageUseCase,
        super(ImageState.initial());

// streams
  final _localImagesListController = BehaviorSubject<List<File>>();

// sinks
  Function(List<File>) get localImagesListChanged =>
      _localImagesListController.sink.add;

// getters
  ValueStream<List<File>> get localImagesList =>
      _localImagesListController.stream;

  // use case to upload image
  Future<List<String>> uploadImages() async {
    emit(state.copyWith(status: Status.loading));
    var imageEither = await uploadImageUseCase(
      uploadImages: _localImagesListController.value,
    );
    imageEither.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: failure.message,
          status: Status.error,
        ),
      ),
      (success) async {
        emit(state.copyWith(
          uploadedImages: success.uploadedImages,
          status: Status.success,
        ));
      },
    );
    return state.uploadedImages;
  }

  void setImageUploadStatus(Status status) {
    emit(state.copyWith(status: status));
  }

  Future<List<String>> showImageUploadSheet(BuildContext context) async{
    List<String> imagePaths = [];
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size(context).width * 0.02),
          topRight: Radius.circular(size(context).width * 0.02),
        ),
      ),
      context: context,
      builder: (builder) => ImageUploadBottomSheet(
        onImageUploaded: (List<String> paths) {
          imagePaths = paths;
        },
      ),
    );
    return imagePaths;
  }
}
