import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class CustomNumberFormField extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Function onChanged;
  final String hintText;
  final String? initialValue;
  const CustomNumberFormField({
    Key? key,
    required this.icon,
    required this.onChanged,
    this.iconColor,
    required this.hintText,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size(context).height * 0.035),
      padding: EdgeInsets.all(size(context).height * 0.006),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius:
              BorderRadius.all(Radius.circular(size(context).height * 0.01))),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.phone,
        enableSuggestions: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.subtitle2,
          prefixIcon: Icon(
            icon,
            size: size(context).height * 0.025,
            color: iconColor ?? Theme.of(context).colorScheme.secondary,
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
