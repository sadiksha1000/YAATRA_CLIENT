import 'package:flutter/material.dart';
import 'size.dart';

class Constants {
  static cardBorderRadius(BuildContext context) =>
      BorderRadius.circular(size(context).width * 0.04);

  static cardBoxShadow(BuildContext context) => [
        BoxShadow(
          blurRadius: size(context).height * 0.05,
          color: Color.fromARGB(36, 206, 203, 203),
          spreadRadius: size(context).height * 0.01,
        )
      ];

  static cardDecoration(BuildContext context) => BoxDecoration(
        borderRadius: cardBorderRadius(context),
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: cardBoxShadow(context),
      );

  // circles
  static circleBorderRadius(BuildContext context) =>
      BorderRadius.circular(size(context).width);

  static circleDecoration(BuildContext context) => BoxDecoration(
        borderRadius: circleBorderRadius(context),
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: cardBoxShadow(context),
      );
  static currency() => "Rs.";
}
