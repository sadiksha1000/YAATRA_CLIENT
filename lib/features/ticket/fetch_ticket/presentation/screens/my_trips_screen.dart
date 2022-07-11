import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticket_details_screen.dart';
import '../widgets/pasttripswidget.dart';

import '../../../../../core/config/size.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_drawer.dart';
import '../../../../authentication/presentation/blocs/cubit/auth_cubit.dart';
import '../../domain/entities/booking.dart';
import '../cubits/tickets/fetch_tickets_cubit.dart';

class MyTrips extends StatefulWidget {
  static const routeName = '/trips';
  const MyTrips({Key? key}) : super(key: key);

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context);
    print("User ${_authCubit.state.user.uid}");
    var tickets = context
        .read<FetchTicketsCubit>()
        .fetchAllBookings(_authCubit.state.user.uid);
    super.didChangeDependencies();
  }

  List name = ["Bullet Deluxe", "Sajha Yatayat"];

  List<Object> trips = [
    {
      "name": "Bullet Deluxe",
      "time": "05:00",
      "date": "25 APR 2020",
      "price": "900",
    },
    {
      "name": "Bullet Deluxe",
      "time": "05:00",
      "date": "25 APR 2020",
      "price": "900",
    },
    {
      "name": "Bullet Deluxe",
      "time": "05:00",
      "date": "25 APR 2020",
      "price": "900",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "My Trips",
        context: context,
        isBackButton: false,
      ),
      endDrawer: const CustomDrawer(),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size(context).height * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab Bar
                TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    tabs: const [
                      Tab(
                        child: Text('Past'),
                      ),
                      Tab(
                        child: Text('Ongoing'),
                      ),
                      Tab(
                        child: Text('Cancelled'),
                      ),
                    ]),

                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocBuilder<FetchTicketsCubit, FetchTicketsState>(
                        builder: (context, state) {
                          return state.tickets.isEmpty
                              ? Text('No Trips taken till date')
                              : ListView.builder(
                                  itemCount: state.tickets.length,
                                  itemBuilder: (ctx, index) {
                                    Booking _booking = state.tickets[index];
                                    return PastTrips(
                                      booking: _booking,
                                      onPressed: (booking) {
                                        Navigator.pushNamed(context,
                                            TicketDetailsScreen.routeName,
                                            arguments: booking);
                                      },
                                    );
                                  },
                                );
                        },
                      ),
                      // ongoing
                      ListView.builder(
                        itemCount: name.length,
                        itemBuilder: (context, index) {
                          // Card
                          return Container(
                            height: size(context).height * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    size(context).width * 0.02),
                                color: Theme.of(context).colorScheme.onPrimary,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: size(context).height * 0.05,
                                    color: Color.fromARGB(36, 206, 203, 203),
                                    spreadRadius: size(context).height * 0.015,
                                  ),
                                ]),
                            margin: EdgeInsets.all(size(context).width * 0.015),
                            padding:
                                EdgeInsets.all(size(context).height * 0.015),
                            child: Row(
                              children: [
                                Container(
                                  width: size(context).width * 0.19,
                                  height: size(context).height * 0.09,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                //
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: size(context).width * 0.04),
                                    child: Column(
                                      // Title, Time, Features
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          name[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize:
                                                      size(context).height *
                                                          0.021),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Time: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              "07:00 AM",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: size(context).height *
                                                    0.018,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Date: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              "25 APR 2022",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: size(context).height *
                                                    0.018,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  // Price, Total Seats, Available Seats, Seat Status
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rs. 900",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize:
                                              size(context).height * 0.018,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size(context).height * 0.009,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize:
                                                size(context).height * 0.017,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Cancelled
                      ListView.builder(
                        itemCount: name.length,
                        itemBuilder: (context, index) {
                          // Card
                          return Container(
                            height: size(context).height * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    size(context).width * 0.02),
                                color: Theme.of(context).colorScheme.onPrimary,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: size(context).height * 0.05,
                                    color: Color.fromARGB(36, 206, 203, 203),
                                    spreadRadius: size(context).height * 0.015,
                                  ),
                                ]),
                            margin: EdgeInsets.all(size(context).width * 0.015),
                            padding:
                                EdgeInsets.all(size(context).height * 0.015),
                            child: Row(
                              children: [
                                Container(
                                  width: size(context).width * 0.19,
                                  height: size(context).height * 0.09,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                //
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: size(context).width * 0.04),
                                    child: Column(
                                      // Title, Time, Features
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          name[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize:
                                                      size(context).height *
                                                          0.021),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Time: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              "07:00 AM",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: size(context).height *
                                                    0.018,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Date: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              "25 APR 2022",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: size(context).height *
                                                    0.018,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Rs. 900",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: size(context).height * 0.018,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
