import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../../../core/config/custom_icon_icons.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_drawer.dart';
import '../../../profile/presentation/screens/passenger_profile_screen.dart';
import '../../../../ticket/fetch_ticket/presentation/screens/my_trips_screen.dart';
import '../../../../trips/presentation/screen/passenger_homescreen.dart';
import '../../../../ticket/fetch_ticket/presentation/screens/ticket_screen.dart';

class PassengerDashboardScreen extends StatefulWidget {
  static const routeName = '/passenger/dashboard';
  const PassengerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PassengerDashboardScreen> createState() =>
      _PassengerDashboardScreenState();
}

class _PassengerDashboardScreenState extends State<PassengerDashboardScreen> {
  var currentNavigationIndex = 0;
  var screen = [
    PassengerHomeScreen(),
    TicketScreen(),
    MyTrips(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentNavigationIndex,
          onTap: (index) {
            print("index $index");
            setState(() {
              currentNavigationIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.ticket),
              label: "Tickets",
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.trips),
              label: "My Trips",
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.profile),
              label: "Account",
            ),
          ]),
      body: screen[currentNavigationIndex],
    );
  }
}
