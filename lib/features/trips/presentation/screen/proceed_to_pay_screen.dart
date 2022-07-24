import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yaatra_client/core/config/constants.dart';
import 'package:yaatra_client/features/app/presentation/blocs/app/app_bloc.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_cubit.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_session_cubit.dart';
import 'package:yaatra_client/features/trips/presentation/screen/reservation_screen.dart';
import 'package:yaatra_client/features/trips/presentation/widgets/booking_session_timer_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_button2_widget.dart';
import '../../../../core/widgets/text_label_widget.dart';

class ProceedToPay extends StatefulWidget {
  static const routeName = '/proceed_to_pay';
  const ProceedToPay({Key? key}) : super(key: key);

  @override
  State<ProceedToPay> createState() => _ProceedToPayState();
}

class _ProceedToPayState extends State<ProceedToPay> {
  // bool value = false;
  int _val = 0;
  @override
  Widget build(BuildContext context) {
    BookingCubit bookingCubit = context.read<BookingCubit>();
    return Scaffold(
      appBar:
          customAppBar(title: "Confirm Reservation and Pay", context: context),
      body: Column(
        children: [
          BookingSessionTimerWidget(),
          Padding(
            padding: EdgeInsets.all(size(context).height * 0.02),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bookingCubit.state.selectedTrip.busId.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    )),
                            TextLabelWidget(
                                label: "Time:",
                                value: DateFormat.Hms().format(bookingCubit
                                    .state.selectedTrip.departureTime)),
                            TextLabelWidget(
                                label: "Date:",
                                value: DateFormat.yMd().format(bookingCubit
                                    .state.selectedTrip.departureTime)),
                            TextLabelWidget(
                                label: "Bus No: ",
                                value: bookingCubit
                                    .state.selectedTrip.busId.plateNumber),
                            TextLabelWidget(
                                label: "Total Price:",
                                value:
                                    "${Constants.currency()} ${bookingCubit.state.totalPrice.toString()}")
                          ],
                        ),
                        SizedBox(
                          width: size(context).width * 0.2,
                        ),
                        Container(
                          height: size(context).height * 0.12,
                          width: size(context).height * 0.12,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/illustrations/googleicon.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size(context).height * 0.02,
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.secondary,
                    endIndent: size(context).width * 0.03,
                    indent: size(context).width * 0.03,
                  ),
                  SizedBox(
                    height: size(context).height * 0.01,
                  ),
                  Text("Passenger and Seat Information",
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(
                    height: size(context).height * 0.02,
                  ),
                  Container(
                    // height: size(context).height * 0.6,
                    padding: EdgeInsets.symmetric(
                        horizontal: size(context).width * 0.05),
                    child: BlocBuilder<BookingCubit, BookingState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.selectedSeatsByUser.length,
                          itemBuilder: ((context, index) {
                            return PassengerViewDetailsWidget(
                              seat: state.selectedSeatsByUser[index],
                              passenger: state.passengerDetails[index],
                            );
                          }),
                        );
                      },
                    ),
                  ),
                  Text("Contact Details",
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(
                    height: size(context).height * 0.02,
                  ),
                  Container(
                    // height: size(context).height * 0.6,
                    padding: EdgeInsets.symmetric(
                        horizontal: size(context).width * 0.05),
                    child: BlocBuilder<BookingCubit, BookingState>(
                      builder: (context, state) {
                        return ContactViewDetailsWidget(
                          passenger: state.contactPersonDetails,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size(context).height * 0.02),
                  Text("Pay with",
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(
                      child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                            leading: Radio(
                              value: 1,
                              groupValue: _val,
                              onChanged: (value) {
                                setState(() {
                                  _val = value as int;
                                });
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              toggleable: true,
                            ),
                            title: const Image(
                                height: 50,
                                width: 80,
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSrdIN0L5Gy8rX7PxApTq0T-cL9qwS-tgRpvxhSet8cJYsJy1oEt1rti6Xx20ORHYb2_4&usqp=CAU'))),
                      ),
                      Expanded(
                        child: ListTile(
                            leading: Radio(
                              value: 2,
                              groupValue: _val,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.green),
                              onChanged: (value) {
                                setState(() {
                                  _val = value as int;
                                });
                              },
                              toggleable: true,
                            ),
                            title: const Image(
                                height: 50,
                                width: 80,
                                image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/en/f/fd/Khalti_Digital_Wallet_Logo.png'))),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: size(context).height * 0.02,
                  ),
                  Center(
                      child: SecondaryCustomButton(
                          onPressed: () {
                            if (_val == 1) {
                              // bookingCubit.payWithEsewa();
                            } else if (_val == 2) {
                              bookingCubit.payWithKhalti(
                                context: context,
                                userId: context.read<AppBloc>().state.uid,
                                bookingSessionId: context
                                    .read<BookingSessionCubit>()
                                    .state
                                    .bookingSuccessSession
                                    .id,
                              );
                            }
                            // Navigator.of(context).pushNamed(ProceedToPay.routeName);
                          },
                          padding1: EdgeInsets.symmetric(
                            horizontal: size(context).width * 0.1,
                          ),
                          label: _val == 0
                              ? "Select Payment Method"
                              : "Pay ${Constants.currency()} ${bookingCubit.state.totalPrice.toString()} with ${_val == 1 ? "Esewa" : _val == 2 ? "Khalti" : "Select Payment Method"}",
                          disable: _val == 0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
