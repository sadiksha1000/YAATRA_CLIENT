import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/config/size.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../cubits/tickets/fetch_tickets_cubit.dart';
import 'ticket_details_screen.dart';

import '../../../../../core/widgets/custom_drawer.dart';
import '../../../../authentication/presentation/blocs/cubit/auth_cubit.dart';
import '../../../../trips/domain/entities/user.dart';
import '../../domain/entities/booking.dart';
import '../widgets/viewticket.dart';

class TicketScreen extends StatefulWidget {
  static const routeName = '/passenger/ticket';
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void didChangeDependencies() async {
    AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context);
    print("User ${_authCubit.state.user.uid}");
    var tickets = context
        .read<FetchTicketsCubit>()
        .fetchAllBookings(_authCubit.state.user.uid);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: "Tickets",
        context: context,
        isBackButton: false,
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: size(context).height,
                margin: EdgeInsets.symmetric(
                    horizontal: size(context).height * 0.015),
                padding: EdgeInsets.all(size(context).height * 0.01),
                child: BlocBuilder<FetchTicketsCubit, FetchTicketsState>(
                  builder: (context, state) {
                    return state.tickets.isEmpty
                        ? Text(
                            "No tickets available",
                            style: TextStyle(
                              fontSize: size(context).height * 0.03,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.tickets.length,
                            itemBuilder: (ctx, index) {
                              Booking _booking = state.tickets[index];
                              return ViewTicket(
                                booking: _booking,
                                onPressed: (booking) {
                                  Navigator.pushNamed(
                                      context, TicketDetailsScreen.routeName,
                                      arguments: booking);
                                },
                              );
                            },
                          );
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
