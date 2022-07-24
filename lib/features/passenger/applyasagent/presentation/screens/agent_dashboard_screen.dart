import 'package:flutter/material.dart';
import '../../../../../core/config/custom_icon_icons.dart';
import '../../../../../core/widgets/custom_drawer.dart';
import '../../../profile/presentation/screens/passenger_profile_screen.dart';
import '../../../../ticket/fetch_ticket/presentation/screens/my_trips_screen.dart';
import '../../../../trips/presentation/screen/passenger_homescreen.dart';
import '../../../../ticket/fetch_ticket/presentation/screens/ticket_screen.dart';

class AgentDashboardScreen extends StatefulWidget {
  static const routeName = '/agent/dashboard';
  const AgentDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AgentDashboardScreen> createState() => _AgentDashboardScreenState();
}

class _AgentDashboardScreenState extends State<AgentDashboardScreen> {
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
              label: "Agent",
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.ticket),
              label: "Agent",
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.trips),
              label: "Agent",
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.profile),
              label: "Agent",
            ),
          ]),
      body: screen[currentNavigationIndex],
    );
  }
}
