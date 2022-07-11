import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  String? errorMessage = '';
  Color? color;
  // Color? primary1;
  // Color? onPrimary1;
  bool disable = false;
  final String label;
  EdgeInsets? padding1;

  CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.errorMessage,
    this.color,
    required this.disable,
    this.padding1,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.disable ? null : () => widget.onPressed(),
      child: Text(widget.label),
      style: ElevatedButton.styleFrom(
        // onPrimary: widget.onPrimary1,
        primary: widget.color,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: size(context).width * 0.12,
        ),
     
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            size(context).height * 0.04,
          ),
        ),
      ),
    );
  }
}
