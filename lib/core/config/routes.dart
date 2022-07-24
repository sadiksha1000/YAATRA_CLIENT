import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/features/passenger/applyasagent/presentation/screens/agent_dashboard_screen.dart';
import 'package:yaatra_client/features/passenger/dashboard/presentation/screens/passenger_dashboard_screen.dart';
import 'package:yaatra_client/features/passenger/profile/presentation/cubit/passenger_profile_cubit.dart';

import '../../features/app/presentation/blocs/app/app_bloc.dart';
import '../../features/app/presentation/screen/splash_screen.dart';
import '../../features/authentication/presentation/blocs/cubit/auth_cubit.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';

Widget onGenerateAppScreen(AppState state, BuildContext context) {
  context.read<AuthCubit>().emitInitialStatusState;
  if (state.user.uid.isNotEmpty) {
    context.read<AuthCubit>().refreshCurrentUser();
  }
  context.read<AppBloc>().add(
        AppUserChanged(
          user: context.read<AuthCubit>().state.user,
        ),
      );
  context
      .read<PassengerProfileCubit>()
      .getCurrentPassenger(context.read<AppBloc>().state.user.uid);

  if (state.status == AppStatus.authenticated) {
    if (state.isAgent && state.isPassenger) {
      if (state.activeRole == 'passenger') {
        return const PassengerDashboardScreen();
      } else if (state.activeRole == 'agent') {
        return const AgentDashboardScreen();
      }
    } else if (state.isPassenger) {
      return const PassengerDashboardScreen();
    } else if (state.isAgent) {
      return const AgentDashboardScreen();
    }
  } else if (state.status == AppStatus.unauthenticated) {
    return const LoginScreen();
  }
  return const SplashScreen();
}
