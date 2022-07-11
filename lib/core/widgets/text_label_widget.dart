import 'package:flutter/material.dart';

import '../config/size.dart';

class TextLabelWidget extends StatelessWidget {
  final String label;
  final String value;
  const TextLabelWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.subtitle2),
        SizedBox(
          width: size(context).width * 0.02,
        ),
        Text(
          value,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: size(context).height * 0.015),
        ),
      ],
    );
  }
}
