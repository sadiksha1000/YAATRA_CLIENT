import 'package:flutter/material.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/bottom_text_button.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_intro_header.dart';
import '../../../../core/widgets/custom_number_form_field.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String registerImageName =
        'assets/images/illustrations/forget_password.svg';
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IntroHeader(
                    introHeader: "Forget Password",
                    introDesc: "Change your password", size1: 0,),
                SizedBox(
                  height: size(context).height * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      child: AuthIllustrationWidget(
                        registerImageName: registerImageName,
                        label: 'Register Illustration',
                      ),
                    ),
                    SizedBox(
                      height: size(context).height * 0.04,
                    ),
                    CustomNumberFormField(
                        icon: Icons.phone,
                        onChanged: () {},
                        hintText: "Phone Number"),
                    SizedBox(
                      height: size(context).height * 0.02,
                    ),
      
                    // register button
                    CustomButton(
                      disable: false,
                      label: 'Send OTP',
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: size(context).height * 0.015,
                ),
                    BottomTextButton(
                        label: "Remember your password?",
                        buttonLabel: "Login now",
                        onPressed: () {}),
                        SizedBox(
                  height: size(context).height * 0.015,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
