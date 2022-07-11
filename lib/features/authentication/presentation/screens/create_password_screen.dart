import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/auth_illustration_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_intro_header.dart';
import '../../../../core/widgets/custom_passwordfield_widget.dart';
import '../blocs/cubit/auth_cubit.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key}) : super(key: key);
  static const routeName = '/create-password';

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  @override
  Widget build(BuildContext context) {
    const String createPasswordImageName =
        'assets/images/illustrations/create_password.svg';

    AuthCubit _registerCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.registerStatus == AuthStatus.success) {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You have successfully registered"),
                  ),
                );
              } else if (state.registerStatus == AuthStatus.error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntroHeader(
                    size1: size(context).height * 0.03,
                    introHeader: 'Create Password',
                    introDesc: 'Create your new password'),
                Column(
                  children: [
                    const AuthIllustrationWidget(
                      registerImageName: createPasswordImageName,
                      label: 'Password Illsutration',
                    ),
                    SizedBox(
                      height: size(context).height * 0.04,
                    ),
                    CustomPasswordField(
                      icon: Icons.lock,
                      onChanged: (value) {
                        _registerCubit.passwordChanged(value);
                      },
                    ),
                    SizedBox(height: size(context).height * 0.02),
                    CustomPasswordField(
                      icon: Icons.lock,
                      onChanged: (value) {
                        _registerCubit.confirmPasswordChanged(value);
                      },
                    ),
                    StreamBuilder<Object>(
                        stream: _registerCubit.isPasswordValid,
                        builder: (context, snapshot) {
                          return snapshot.hasError
                              ? Text(
                                  snapshot.error.toString(),
                                  style: const TextStyle(color: Colors.red),
                                )
                              : Container();
                        }),
                    SizedBox(
                      height: size(context).height * 0.02,
                    ),
                    StreamBuilder<Object>(
                        stream: _registerCubit.isPasswordMatched,
                        builder: (context, snapshot) {
                          return BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state.registerStatus == AuthStatus.loading) {
                                return const CircularProgressIndicator();
                              }
                              return CustomButton(
                                disable: snapshot.hasData ? false : true,
                                label: 'Save',
                                onPressed: () {
                                  _registerCubit
                                      .registerUserWithPhoneAndPassword();
                                },
                              );
                            },
                          );
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
