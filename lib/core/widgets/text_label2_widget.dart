import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../config/size.dart';

class TextLabel2Widget extends StatelessWidget {
  final String label;
  final String value;
  const TextLabel2Widget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.left,
        ),
        SizedBox(
          width: size(context).height * 0.02,
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
