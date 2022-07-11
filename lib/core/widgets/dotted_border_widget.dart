import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/image_upload_bottom_sheet.dart';

import '../../../../../core/config/size.dart';

class DotBorder extends StatelessWidget {
  final Function imageUpload;
  const DotBorder({
    Key? key,
    required this.imageUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [size(context).height * 0.004, size(context).height * 0.002],
      strokeWidth: size(context).height * 0.003,
      color: Theme.of(context).colorScheme.secondary,
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size(context).width * 0.02),
                topRight: Radius.circular(size(context).width * 0.02),
              ),
            ),
            context: context,
            builder: (builder) => ImageUploadBottomSheet(
              onImageUploaded: imageUpload,
            ),
          );
        },
        child: Container(
          height: size(context).height * 0.13,
          width: size(context).width * 0.25,
          child: Center(
            child: Icon(
              Icons.add_a_photo,
              color: Theme.of(context).colorScheme.secondary,
              size: size(context).height * 0.035,
            ),
          ),
        ),
      ),
    );
  }
}
