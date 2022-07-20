import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class SecondaryCustomButton extends StatefulWidget {
  final Function onPressed;
  String? errorMessage = '';
  Color? color;
  bool disable = false;
  final String label;
  EdgeInsets? padding1;

  SecondaryCustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.errorMessage,
    this.color,
    required this.disable,
    this.padding1,
  }) : super(key: key);

  @override
  State<SecondaryCustomButton> createState() => _SecondaryCustomButtonState();
}

class _SecondaryCustomButtonState extends State<SecondaryCustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.disable ? null : () => widget.onPressed(),
      child: Text(widget.label),
      style: ElevatedButton.styleFrom(
        // onPrimary: widget.onPrimary1,
        primary: widget.color,
        elevation: 0,
        padding: widget.padding1 ??
            EdgeInsets.symmetric(
              horizontal: size(context).width * 0.3,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            size(context).height * 0.01,
          ),
        ),
      ),
    );
  }
}
