import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/config/size.dart';

class CustomPasswordField extends StatefulWidget {
  final IconData icon;
  final Color? iconColor;
  final Function onChanged;
  final String hintText;
  final String errorText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  int? maxLength = 10;
  TextInputType? keyboardType = TextInputType.text;
  CustomPasswordField({
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
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool showPassword = true;

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

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
        enableSuggestions: false,
        obscureText: showPassword,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            errorText: widget.errorText.isNotEmpty ? widget.errorText : "",
            errorMaxLines: 1,
            errorStyle:
                TextStyle(fontSize: size(context).width * 0.023, height: 0.056),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.subtitle2,
            prefixIcon: Icon(
              widget.icon,
              size: size(context).height * 0.025,
              color:
                  widget.iconColor ?? Theme.of(context).colorScheme.secondary,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              splashRadius: 20,
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                size: size(context).height * 0.025,
                color:
                    widget.iconColor ?? Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () => toggleShowPassword(),
            )),
        onChanged: (value) => widget.onChanged(value),
      ),
    );
  }
}
