import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_passwordfield_widget.dart';
import 'otp_verification_screen.dart';
import 'register_screen.dart';
import '../../../passenger/dashboard/presentation/screens/passenger_dashboard_screen.dart';

import '../../../../core/widgets/auth_actionwidget.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_textformfield_widget.dart';
import '../../../app/presentation/blocs/app/app_bloc.dart';
import '../blocs/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/passenger/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    const String loginImageName = 'assets/images/illustrations/login_image.svg';
    const String googleImage = 'assets/images/illustrations/googleicon.png';
    AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context);
    AppBloc _appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.loginStatus == AuthStatus.error) {
                  _appBloc.add(AppUserChanged(user: state.user));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage,
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyLarge?.fontFamily,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state.loginStatus == AuthStatus.success) {
                  _appBloc.add(AppUserChanged(user: state.user));
                  if (state.user.isPassenger && state.user.isAgent) {
                    if (state.user.activeRole == 'passenger') {
                      Navigator.of(context).pushReplacementNamed(
                          PassengerDashboardScreen.routeName);
                    }
                    if (state.user.activeRole == 'agent') {
                      Navigator.of(context).pushReplacementNamed(
                          PassengerDashboardScreen.routeName);
                    }
                  } else if (state.user.isPassenger) {
                    Navigator.of(context).pushReplacementNamed(
                        PassengerDashboardScreen.routeName);
                  } else if (state.user.isAgent) {
                    Navigator.of(context).pushReplacementNamed(
                        PassengerDashboardScreen.routeName);
                  }
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: size(context).height * 0.085,
                  ),
                  AuthIllustrationWidget(
                    registerImageName: loginImageName,
                    label: 'Login Image',
                  ),
                  SizedBox(
                    height: size(context).height * 0.045,
                  ),
                  StreamBuilder<Object>(
                      stream: _authCubit.isPhoneNumberValid,
                      builder: (context, snapshot) {
                        return CustomTextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          keyboardType: TextInputType.phone,
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : '',
                          icon: Icons.phone,
                          onChanged: _authCubit.phoneNumberChanged,
                          hintText: "Phone Number",
                          maxLength: 10,
                        );
                      }),
                  SizedBox(
                    height: size(context).height * 0.02,
                  ),
                  // CustomPasswordField(
                  //   icon: Icons.password,
                  //   onChanged: _authCubit.passwordChanged,
                  // ),
                  CustomTextFormField(
                    errorText: '',
                    icon: Icons.password,
                    onChanged: _authCubit.passwordChanged,
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: size(context).height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromRGBO(2, 173, 36, 1),
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size(context).height * 0.06,
                  ),
                  StreamBuilder<Object>(
                      stream: _authCubit.isLoginFormValid,
                      builder: (context, snapshot) {
                        return CustomButton(
                          disable: false,
                          label: 'Login',
                          onPressed: () {
                            _authCubit.login();
                          },
                        );
                      }),
                  SizedBox(
                    height: size(context).height * 0.06,
                  ),
                  AuthActionWidget(
                    buttonLabel: "Register Now",
                    label: "Don’t have an account?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const RegisterScreen()),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
