import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../../../core/config/size.dart';

class TeritaryCustomButton extends StatefulWidget {
  final Function onPressed;
  String? errorMessage = '';
  Color? color;
  bool disable = false;
  final String label;
  EdgeInsets? padding1;

  TeritaryCustomButton({
    Key? key,
    required this.onPressed,
    this.errorMessage,
    this.color,
    required this.disable,
    required this.label,
    this.padding1,
  }) : super(key: key);

  @override
  State<TeritaryCustomButton> createState() => _TeritaryCustomButtonState();
}

class _TeritaryCustomButtonState extends State<TeritaryCustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.disable ? null : () => widget.onPressed(),
      child: Text(
        widget.label,
        style: TextStyle(fontSize: size(context).height * 0.01323),
      ),
      style: ElevatedButton.styleFrom(
        primary: widget.color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            size(context).height * 0.015,
          ),
        ),
      ),
    );
  }
}
