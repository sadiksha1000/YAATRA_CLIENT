import 'package:flutter/material.dart';
import '../config/size.dart';

class CustomChipButton extends StatelessWidget {
  String? errorMessage = '';
  final String label;
  EdgeInsets? padding1;
  Function? onTap;

  CustomChipButton(
      {Key? key, required this.label, this.errorMessage, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(label);
        }
      },
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
              color: Colors.black, fontSize: size(context).height * 0.017),
          overflow: TextOverflow.visible,
        ),
        elevation: 2.0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shadowColor: Colors.black.withOpacity(0.25),
        padding: EdgeInsets.symmetric(
          horizontal: size(context).width * 0.04,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
