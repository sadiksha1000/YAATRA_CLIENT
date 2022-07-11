import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/config/size.dart';

class PassengerTextFormField extends StatelessWidget {
  final Function onChanged;
  final String hintText;
  final String errorText;
  final List<TextInputFormatter>? inputFormatters;
  int? maxLength = 10;
  TextInputType? keyboardType = TextInputType.text;
  PassengerTextFormField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.errorText,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: size(context).height * 0.035),
      padding: EdgeInsets.symmetric(horizontal: size(context).width * 0.04),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius:
              BorderRadius.all(Radius.circular(size(context).height * 0.015))),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          errorText: errorText.isNotEmpty ? errorText : "",
          errorMaxLines: 1,
          errorStyle:
              TextStyle(fontSize: size(context).width * 0.023, height: 0.056),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.subtitle2,
          border: InputBorder.none,
        ),
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
