import 'package:flutter/material.dart';
import '../config/size.dart';

class HomeCustomChipButton extends StatelessWidget {
  String? errorMessage = '';
  final String label;
  EdgeInsets? padding1;
  Function? onTap;

  HomeCustomChipButton(
      {Key? key, required this.label, this.errorMessage, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(label);
        }
      },
      child: Chip(
        label: Text(
          label,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        elevation: 2.0,
        shadowColor: Colors.black.withOpacity(0.25),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
