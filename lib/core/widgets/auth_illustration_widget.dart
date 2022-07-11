import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/config/size.dart';

class AuthIllustrationWidget extends StatelessWidget {
  const AuthIllustrationWidget({
    Key? key,
    required this.registerImageName,
    required this.label,
  }) : super(key: key);

  final String registerImageName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      registerImageName,
      semanticsLabel: label,
      height: size(context).height * 0.3,
    );
  }
}
