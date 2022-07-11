import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/config/size.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Function onChanged;
  final String hintText;
  final String errorText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  int? maxLength = 10;
  TextInputType? keyboardType = TextInputType.text;
  CustomTextFormField({
    Key? key,
    required this.icon,
    required this.onChanged,
    this.iconColor,
    required this.hintText,
    required this.errorText,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size(context).height * 0.035),
      padding: EdgeInsets.only(
        top: size(context).height * 0.006,
        left: size(context).height * 0.006,
        right: size(context).height * 0.006,
        bottom: size(context).height * 0.002,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius:
              BorderRadius.all(Radius.circular(size(context).height * 0.01))),
      child: TextFormField(
        // maxLength: maxLength
        initialValue: initialValue,
        enableSuggestions: false,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          errorText: errorText.isNotEmpty ? errorText : "",
          errorMaxLines: 1,
          errorStyle:
              TextStyle(fontSize: size(context).width * 0.023, height: 0.056),

          // counter: Container(),
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
