import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class AuthActionWidget extends StatelessWidget {
  final String label;
  final String buttonLabel;
  final Function onPressed;
  const AuthActionWidget({
    Key? key,
    required this.label,
    required this.buttonLabel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(
          width: size(context).width * 0.02,
        ),
        GestureDetector(
          child: Text(
            buttonLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onTap: () => onPressed(),
        ),
      ],
    );
  }
}
