import 'package:flutter/material.dart';
import 'package:yaatra_client/features/authentication/presentation/screens/create_password_screen.dart';
import 'package:yaatra_client/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:yaatra_client/features/passenger/applyasagent/presentation/screens/apply_as_agent_screen.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/presentation/screens/my_trips_screen.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/presentation/screens/ticket_details_screen.dart';
import 'package:yaatra_client/features/trips/presentation/screen/proceed_to_pay_screen.dart';
import 'package:yaatra_client/features/trips/presentation/screen/seat_select_screen.dart';
import 'package:yaatra_client/features/trips/presentation/screen/view_buses_screen.dart';
import 'package:yaatra_client/features/passenger/dashboard/presentation/screens/passenger_dashboard_screen.dart';
import 'package:yaatra_client/features/trips/presentation/screen/passenger_homescreen.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/presentation/screens/ticket_screen.dart';

import '../../features/authentication/presentation/screens/create_password_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/otp_verification_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/passenger/profile/presentation/screens/passenger_profile_screen.dart';
import '../../features/trips/presentation/screen/reservation_screen.dart';
import '../../features/trips/presentation/screen/seat_select_screen.dart';
import '../../features/trips/presentation/screen/view_buses_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case OTPVerificationScreen.routeName:
        return MaterialPageRoute(builder: (_) => OTPVerificationScreen());
      case CreatePassword.routeName:
        return MaterialPageRoute(builder: (_) => CreatePassword());
      case PassengerDashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => PassengerDashboardScreen());
      case PassengerHomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => PassengerHomeScreen());
      case TicketScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => TicketScreen(), settings: settings);
      case AccountScreen.routeName:
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case ViewBusesScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewBusesScreen());
      case SelectSeatScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SelectSeatScreen(), settings: settings);
      case ReservationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ReservationScreen(), settings: settings);
      case ProceedToPay.routeName:
        return MaterialPageRoute(
            builder: (_) => ProceedToPay(), settings: settings);
      case TicketDetailsScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => TicketDetailsScreen(), settings: settings);
      case MyTrips.routeName:
        return MaterialPageRoute(builder: (_) => MyTrips(), settings: settings);
      case ApplyAsAgentScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ApplyAsAgentScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
