import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_intro_header.dart';
import '../../../../core/widgets/otp_action_widget.dart';
import 'create_password_screen.dart';
import 'register_screen.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/countdown_timer.dart';
import '../../../../core/widgets/otp_number_widget.dart';
import '../blocs/cubit/auth_cubit.dart';

class OTPVerificationScreen extends StatelessWidget {
  static const routeName = '/otp-verification';
  OTPVerificationScreen({Key? key}) : super(key: key);

  List<String> _otpList = ["0", "0", '0', '0', "0", "0"];

  @override
  Widget build(BuildContext context) {
    AuthCubit _registerCubit = BlocProvider.of<AuthCubit>(context);
    const String OTPImageName = 'assets/images/illustrations/OTP.svg';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroHeader(
                introHeader: 'Verify OTP',
                introDesc: 'Please enter OTP code sent to your phone number',
                size1: size(context).height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.all(size(context).width * 0.05),
                child: const AuthIllustrationWidget(
                  registerImageName: OTPImageName,
                  label: 'OTP Illustration',
                ),
              ),
              StreamBuilder<Object>(
                  stream: _registerCubit.phoneNumber,
                  builder: (context, snapshot) {
                    return OTPActionWidget(
                        phoneNumber: snapshot.data.toString(),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        });
                  }),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size(context).width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OTPNumberWidget(
                      onChanged: (value) {
                        _otpList.clear();
                        _otpList.insert(0, value);
                        final listOTP = _otpList.join();
                        _registerCubit.otpChanged(listOTP);
                      },
                    ),
                    OTPNumberWidget(
                      onChanged: (value) {
                        _otpList.insert(1, value);
                        final listOTP = _otpList.join();
                        _registerCubit.otpChanged(listOTP);
                      },
                    ),
                    OTPNumberWidget(
                      onChanged: (value) {
                        _otpList.insert(2, value);
                        final listOTP = _otpList.join();
                        _registerCubit.otpChanged(listOTP);
                      },
                    ),
                    OTPNumberWidget(
                      onChanged: (value) {
                        _otpList.insert(3, value);
                        final listOTP = _otpList.join();
                        _registerCubit.otpChanged(listOTP);
                      },
                    ),
                    OTPNumberWidget(
                      onChanged: (value) {
                        _otpList.insert(4, value);
                        final listOTP = _otpList.join();
                        _registerCubit.otpChanged(listOTP);
                      },
                    ),
                    OTPNumberWidget(
                      onChanged: (value) {
                        _otpList.insert(5, value);
                        final listOTP = _otpList.join();
                        _registerCubit.otpChanged(listOTP);
                        print(listOTP);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size(context).height * 0.05),
              Center(
                child: StreamBuilder<Object>(
                    stream: _registerCubit.isOTPValid,
                    builder: (context, snapshot) {
                      return CustomButton(
                          padding1: EdgeInsets.symmetric(horizontal: size(context).width*0.04),
                        onPressed: () {
                          bool isVerified = _registerCubit.otpVerified();
                          if (isVerified) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP Verified"),
                              ),
                            );
                            Navigator.of(context)
                                .pushReplacementNamed(CreatePassword.routeName);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      size(context).width * 0.02),
                                ),
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Invalid OTP",
                                  style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .fontFamily,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        label: 'Verify',
                        disable: snapshot.hasData ? false : true,
                      );
                    }),
              ),
              CountdownTimer(
                time: 200,
                label: 'Resend in:',
                onPressed: () {},
              ),
              SizedBox(
                height: size(context).height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
