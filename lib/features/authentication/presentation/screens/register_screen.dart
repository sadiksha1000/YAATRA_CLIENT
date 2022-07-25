import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/auth_actionwidget.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_textformfield_widget.dart';
import 'otp_verification_screen.dart';
import '../blocs/cubit/auth_cubit.dart';
import '../../../../../core/config/size.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final String registerImageName = 'assets/images/illustrations/register.svg';
  String phone = '';
  @override
  Widget build(BuildContext context) {
    final AuthCubit _registerBlocProvider = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size(context).height,
          width: double.infinity,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.otpStatus == OtpStatus.success) {
                Navigator.of(context).pushReplacementNamed(
                  OTPVerificationScreen.routeName,
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {},
                  child: Column(
                    children: [
                      SizedBox(
                        child: AuthIllustrationWidget(
                          registerImageName: registerImageName,
                          label: 'Register Illustration',
                        ),
                      ),
                      SizedBox(
                        height: size(context).height * 0.04,
                      ),
                      // input field
                      StreamBuilder<String>(
                          stream: _registerBlocProvider.phoneNumber,
                          builder: (context, snapshot) {
                            return CustomTextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                              keyboardType: TextInputType.phone,
                              hintText: "Phone Number",
                              icon: Icons.phone,
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : '',
                              onChanged:
                                  _registerBlocProvider.phoneNumberChanged,
                            );
                          }),
                      SizedBox(
                        height: size(context).height * 0.02,
                      ),

                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                            previous.otpStatus != current.otpStatus,
                        builder: (context, state) {
                          if (state.otpStatus == OtpStatus.loading) {
                            return Center(
                              child: CustomProgressIndicator(
                                onTap: () {
                                  _registerBlocProvider.cancelRegistration();
                                },
                              ),
                            );
                          }
                          return StreamBuilder<Object>(
                              stream: _registerBlocProvider.isPhoneNumberValid,
                              builder: (context, snapshot) {
                                return CustomButton(
                                  disable: snapshot.hasData ? false : true,
                                  label: 'Register',
                                  onPressed: () {
                                    _registerBlocProvider.sendOTP();
                                  },
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
                // have account
                AuthActionWidget(
                  buttonLabel: "Login",
                  label: "Already have an account?",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginScreen()),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
