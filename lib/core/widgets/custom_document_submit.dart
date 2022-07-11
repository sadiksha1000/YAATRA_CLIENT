import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../config/size.dart';
import 'image_upload_bottom_sheet.dart';

class DocumentSubmit extends StatelessWidget {
  final Function onImageUploaded;
  const DocumentSubmit({Key? key, required this.onImageUploaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size(context).width * 0.07),
      child: DottedBorder(
        color: Theme.of(context).colorScheme.secondary,
        borderType: BorderType.RRect,
        radius: Radius.circular(size(context).width * 0.02),
        strokeWidth: size(context).width * 0.002,
        dashPattern: [
          size(context).width * 0.035,
          size(context).width * 0.02,
          size(context).width * 0.035,
          size(context).width * 0.02,
          size(context).width * 0.035,
          size(context).width * 0.02,
        ],
        //dash patterns, 10 is dash width, 6 is space width
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
                onImageUploaded: (List<String>value) {
                  onImageUploaded(value);
                },
              ),
            );
          },
          child: Container(
            height: size(context).height * 0.1,
            width: double.infinity,
            color: Theme.of(context).colorScheme.onPrimary,
            child: Row(
              children: [
                SizedBox(
                  width: size(context).width * 0.03,
                ),
                Center(
                  child: Icon(
                    Icons.add,
                    size: size(context).height * 0.035,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  width: size(context).width * 0.03,
                ),
                Text(
                  'Sumbit your document',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
