import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/size.dart';

class OTPNumberWidget extends StatelessWidget {
  final Function onChanged;
  const OTPNumberWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size(context).width * 0.12,
      height: size(context).width * 0.12,
      child: TextFormField(
        style: Theme.of(context).textTheme.headline3,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size(context).width * 0.013),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        onChanged: (value) => {
          if (value.length == 1)
            {
              onChanged(value),
              FocusScope.of(context).nextFocus(),
            }
        },
      ),
    );
  }
}
