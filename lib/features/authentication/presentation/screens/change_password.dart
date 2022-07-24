import 'package:flutter/material.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_intro_header.dart';
import '../../../../core/widgets/custom_passwordfield_widget.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String registerImageName =
        'assets/images/illustrations/change_password.svg';

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
                  introHeader: "Change Password",
                  introDesc: "Update your new password",
                  size1: 0,
                ),
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
                    // input field
                    CustomPasswordField(
                      errorText: '',
                      hintText: 'New Password',
                      icon: Icons.lock,
                      onChanged: () {},
                    ),
                    SizedBox(
                      height: size(context).height * 0.02,
                    ),
                    CustomPasswordField(
                      errorText: '',
                      hintText: 'Confirm Password',
                      icon: Icons.lock,
                      onChanged: () {},
                    ),
                    SizedBox(
                      height: size(context).height * 0.02,
                    ),

                    // register button
                    CustomButton(
                      disable: false,
                      label: 'Save',
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: size(context).height * 0.015,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
