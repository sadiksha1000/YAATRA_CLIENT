import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/shared/image/presentation/image_cubit/image_cubit.dart';
import '../config/size.dart';
import '../utils/status.dart';

class ImageUploadBottomSheet extends StatefulWidget {
  final Function onImageUploaded;
  const ImageUploadBottomSheet({Key? key, required this.onImageUploaded})
      : super(key: key);

  @override
  State<ImageUploadBottomSheet> createState() => _ImageUploadBottomSheetState();
}

class _ImageUploadBottomSheetState extends State<ImageUploadBottomSheet> {
  List<File> _images = []; //?
  @override
  void initState() {
    super.initState();
    _images = [];
  }

  //method to open image from gallery
  _imageFromGallery() async {
    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // pick multiple image and save it in list
    final images = await ImagePicker().pickMultiImage();
    images?.forEach((file) {
      _images.add(File(file.path));
    });
    setState(() {});
  }

  //method to open image from camera
  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    _images.add(File(image!.path));
    setState(() {});
  }

  List<Widget> previewImages() {
    List<Widget> images = [];
    for (var image in _images) {
      images.add(
        Image.file(
          image,
          height: 100,
          width: 100,
        ),
      );
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    ImageCubit _imageCubit = BlocProvider.of<ImageCubit>(context);
    return SizedBox(
      child: SingleChildScrollView(
        child: BlocConsumer<ImageCubit, ImageState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image Uploaded Successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state.status == Status.error) {
              // alert dialog
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.errorMessage),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                previewImages().isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Double tap to delete photo",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: size(context).width * 0.02,
                          ),
                          const Text("Or"),
                          state.status == Status.loading
                              ? Container(
                                  margin: EdgeInsets.all(
                                      size(context).width * 0.02),
                                  height: size(context).height * 0.02,
                                  width: size(context).height * 0.02,
                                  child: const CircularProgressIndicator(),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    _imageCubit.localImagesListChanged(_images);
                                    List<String> _uploadedImages =
                                        await _imageCubit.uploadImages();
                                    widget.onImageUploaded(_uploadedImages);
                                  },
                                  child: const Text("Confirm Upload"),
                                )
                        ],
                      )
                    : Container(),
                previewImages().isNotEmpty
                    ? SizedBox(
                        height: size(context).height * 0.4,
                        child: ListView.builder(
                            itemCount: previewImages().length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onDoubleTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Image'),
                                      content: const Text(
                                          'Are you sure you want to delete this image?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () {
                                            _images.removeAt(index);
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                    padding: EdgeInsets.all(
                                      size(context).width * 0.01,
                                    ),
                                    child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: previewImages()[index])),
                              );
                            }),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _imageFromCamera();
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text('Camera'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _imageFromGallery();
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
