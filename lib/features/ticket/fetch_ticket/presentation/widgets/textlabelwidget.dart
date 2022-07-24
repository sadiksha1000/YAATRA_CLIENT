import 'package:flutter/material.dart';

import '../../../../../core/config/size.dart';

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
    return Padding(
      padding: EdgeInsets.only(top: size(context).height * 0.007),
      child: Row(
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(
            width: size(context).width * 0.02,
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: size(context).height * 0.0175,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
