import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/auth_actionwidget.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_textformfield_widget.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';

import '../../../../core/config/size.dart';
import '../blocs/cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/passenger/register';
  const RegisterScreen({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
        child: SizedBox(
          height: size(context).height,
          width: double.infinity,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state.otpStatus == OtpStatus.success) {
                Navigator.of(context)
                    .pushReplacementNamed(OTPVerificationScreen.routeName);
              }
            },
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size(context).height * 0.1,
                  ),
                  AuthIllustrationWidget(
                    registerImageName: registerImageName,
                    label: 'Register Illustration',
                  ),
                  SizedBox(
                    height: size(context).height * 0.045,
                  ),
                  StreamBuilder<String>(
                      stream: _registerBlocProvider.phoneNumber,
                      builder: (context, snapshot) {
                        return CustomTextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          onChanged: _registerBlocProvider.phoneNumberChanged,
                          hintText: "Phone Number",
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : '',
                        );
                      }),
                  SizedBox(
                    height: size(context).height * 0.03,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.otpStatus != current.otpStatus,
                    builder: (context, state) {
                      if (state.otpStatus == OtpStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return StreamBuilder<Object>(
                          stream: _registerBlocProvider.isPhoneNumberValid,
                          builder: (context, snapshot) {
                            return CustomButton(
                             
                              onPressed: () {
                                _registerBlocProvider.sendOTP();
                              },
                              label: 'Register',
                              disable: snapshot.hasData ? false : true,
                            );
                          });
                    },
                  ),
                  SizedBox(
                    height: size(context).height * 0.25,
                  ),
                  AuthActionWidget(
                    label: 'Already have an account?',
                    buttonLabel: "Login",
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
      )),
    );
  }
}
