import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class IntroHeader extends StatelessWidget {
  final String introHeader;
  // double? size1;
  final String introDesc;
  final double size1;
  const IntroHeader({
    Key? key,
    required this.introHeader,
    required this.introDesc,
    required this.size1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        size(context).width * 0.025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            introHeader,
            style: TextStyle(
              fontSize: size1,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          SizedBox(
            width: size(context).width * 0.02,
          ),
          Text(
            introDesc,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
