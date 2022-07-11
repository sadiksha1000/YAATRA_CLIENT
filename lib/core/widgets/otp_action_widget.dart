import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class OTPActionWidget extends StatelessWidget {
  final String phoneNumber;
  final Function onPressed;

  const OTPActionWidget({
    Key? key,
    required this.phoneNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size(context).width * 0.065),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'An OTP code was sent to $phoneNumber',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: size(context).height * 0.005,
          ),
          GestureDetector(
            child: Text(
              'Change Phone Number?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () => onPressed(),
          ),
        ],
      ),
    );
  }
}
