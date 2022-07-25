import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/widgets/custom_progress_indicator.dart';

import '../../../../../core/config/size.dart';
import '../../../../core/utils/status.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/countdown_timer.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_intro_header.dart';
import '../../../../core/widgets/otp_action_widget.dart';
import '../blocs/cubit/auth_cubit.dart';
import 'create_password_screen.dart';

class OTPVerificationScreen extends StatelessWidget {
  OTPVerificationScreen({Key? key}) : super(key: key);
  static const routeName = '/otp-verification';

  List<String> _otpList = ["0", "0", '0', '0', "0", "0"];
  @override
  Widget build(BuildContext context) {
    AuthCubit _registerCubit = BlocProvider.of<AuthCubit>(context);
    const String OTPImageName = 'assets/images/illustrations/OTP.svg';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const IntroHeader(
                  introHeader: 'Verify OTP',
                  introDesc: 'Please enter OTP code sent to your phone number',
                  size1: 0,
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
                          Navigator.of(context).pushNamed('/register');
                        },
                      );
                    }),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size(context).width * 0.09),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OTPNumberWidget(
                        first: true,
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
                        last: true,
                        onChanged: (value) {
                          _otpList.insert(5, value);
                          final listOTP = _otpList.join();
                          _registerCubit.otpChanged(listOTP);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size(context).height * 0.04,
                ),
                StreamBuilder<Object>(
                    stream: _registerCubit.isOTPValid,
                    builder: (context, snapshot) {
                      return BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state.verifyOtpStatus == Status.success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP Verified Successfully"),
                              ),
                            );
                            Navigator.of(context)
                                .pushReplacementNamed(CreatePassword.routeName);
                          } else if (state.verifyOtpStatus == Status.error) {
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
                        builder: (context, state) {
                          return state.verifyOtpStatus == Status.loading
                              ? CustomProgressIndicator(onTap: () {
                                  context
                                      .read<AuthCubit>()
                                      .cancelRegistration();
                                })
                              : CustomButton(
                                  disable: snapshot.hasData ? false : true,
                                  onPressed: () {
                                    _registerCubit.otpVerified();
                                  },
                                  label: 'Verify',
                                );
                        },
                      );
                    }),
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
      ),
    );
  }
}

class OTPNumberWidget extends StatelessWidget {
  final bool first;
  final bool last;
  final Function onChanged;
  const OTPNumberWidget(
      {Key? key,
      required this.onChanged,
      this.first = false,
      this.last = false})
      : super(key: key);

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
          hintText: "0",
          hintStyle: Theme.of(context).textTheme.headline3?.copyWith(
              color: Colors.grey.withOpacity(0.5),
              fontWeight: FontWeight.normal),
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
          else if (value.isEmpty)
            {
              onChanged(value),
              FocusScope.of(context).previousFocus(),
            }
        },
      ),
    );
  }
}
