import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_button_widget.dart';

import '../../features/app/presentation/blocs/app/app_bloc.dart';
import '../../features/authentication/presentation/blocs/cubit/auth_cubit.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/passenger/applyasagent/presentation/screens/apply_as_agent_screen.dart';
import '../../features/passenger/dashboard/presentation/screens/passenger_dashboard_screen.dart';
import '../config/size.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _authCubit = BlocProvider.of<AuthCubit>(context);
    var _appBloc = BlocProvider.of<AppBloc>(context);
    if (_appBloc.state.user.uid.isNotEmpty) {
      context.read<AuthCubit>().refreshCurrentUser();
    }
    context.read<AppBloc>().add(
          AppUserChanged(
            user: context.read<AuthCubit>().state.user,
          ),
        );
    print("AuthUser${_authCubit.state.user.phone}");
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SafeArea(
          child: SizedBox(
            height: size(context).height * 0.1,
            width: size(context).height * 0.1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_authCubit.state.user.phone),
                  Text(_authCubit.state.user.activeRole),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size(context).width * 0.5),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        Column(
          children: [
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state.user.isPassenger && state.user.isAgent) {
                  if (state.user.activeRole == 'passenger' &&
                      state.loginStatus != AuthStatus.loading) {
                    return CustomButton(
                      onPressed: () {
                        _authCubit.switchUserRole('agent');
                        _appBloc
                            .add(AppUserChanged(user: _authCubit.state.user));
                        if (state.loginStatus == AuthStatus.loading) {
                          return const CircularProgressIndicator();
                        } else {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, PassengerDashboardScreen.routeName);
                        }
                      },
                      label: "Switch to Agent",
                      disable: false,
                    );
                  } else if (state.user.activeRole == 'agent' &&
                      state.loginStatus != AuthStatus.loading) {
                    return CustomButton(
                      onPressed: () {
                        _authCubit.switchUserRole('passenger');
                        _appBloc
                            .add(AppUserChanged(user: _authCubit.state.user));
                        if (state.loginStatus == AuthStatus.loading) {
                          return const CircularProgressIndicator();
                        } else {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, PassengerDashboardScreen.routeName);
                        }
                      },
                      label: "Switch to Passenger",
                      disable: false,
                    );
                  }
                }
                return CustomButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ApplyAsAgentScreen.routeName);
                    },
                    label: "Apply to Become Agent",
                    disable: false);
              },
            ),
            CustomButton(
              onPressed: () {
                // context.read<AppBloc>().add(AppLogoutRequested());
                // _authCubit.emitInitialState;
                Navigator.popUntil(context, (route) => false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                  ),
                );
              },
              label: "Log out",
              disable: false,
            ),
            SizedBox(
              height: size(context).height * 0.03,
            )
          ],
        )
      ],
    ));
  }
}
