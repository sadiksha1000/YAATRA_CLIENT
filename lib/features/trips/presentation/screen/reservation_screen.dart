import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/config/custom_icon_icons.dart';
import 'package:yaatra_client/core/widgets/custom_snackbar.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/passenger_details.dart';
import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button2_widget.dart';
import '../../../../core/widgets/custom_textformfield_widget.dart';
import '../../../../core/widgets/passenger_detail_textformfield.dart';
import '../../../passenger/booking/presentation/cubit/booking_cubit.dart';
import 'proceed_to_pay_screen.dart';

class ReservationScreen extends StatefulWidget {
  static const routeName = '/reservation';
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<PassengerDetailsModel> _passengerDetails = [];
  PassengerDetailsModel _contactPersonDetails = PassengerDetailsModel.empty;
  @override
  void initState() {
    BookingCubit bookingCubit = BlocProvider.of<BookingCubit>(context);
    _passengerDetails = List.generate(
      bookingCubit.state.selectedSeatsByUser.length,
      (index) => PassengerDetailsModel(
        contact: '',
        name: '',
        email: '',
        seat: bookingCubit.state.selectedSeatsByUser[index],
      ),
    );
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  final ScrollPhysics _scrollPhysics = const ScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Passenger Details', context: context),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: _scrollPhysics,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(parent: _scrollPhysics),
          children: [
            Container(
              margin: EdgeInsets.all(size(context).width * 0.04),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Text(
                        "Enter Passenger Details:",
                        style: TextStyle(
                            fontSize: size(context).height * 0.018,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
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
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(
                              parent: _scrollPhysics),
                          itemCount: state.selectedSeatsByUser.length,
                          itemBuilder: ((context, index) {
                            return PassengerDetailsWidget(
                              seat: state.selectedSeatsByUser[index],
                              onChangedContact: (String value) {
                                _passengerDetails[index] =
                                    _passengerDetails[index].copyWith(
                                  contact: value,
                                );
                              },
                              onChangedName: (String value) {
                                _passengerDetails[index] =
                                    _passengerDetails[index].copyWith(
                                  name: value,
                                );
                              },
                            );
                          }),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
              indent: size(context).width * 0.06,
              endIndent: size(context).width * 0.06,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Container(
              margin: EdgeInsets.all(size(context).width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Person Details: ",
                    style: TextStyle(
                      fontSize: size(context).height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Booking details will be sent to the below contact person",
                    style: TextStyle(
                        fontSize: size(context).height * 0.014,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: size(context).height * 0.02,
                  ),
                  CustomTextFormField(
                      icon: Icons.person,
                      onChanged: (value) {
                        _contactPersonDetails = _contactPersonDetails.copyWith(
                          name: value,
                        );
                      },
                      hintText: "Contact Name",
                      errorText: ""),
                  SizedBox(
                    height: size(context).height * 0.012,
                  ),
                  CustomTextFormField(
                      icon: Icons.phone,
                      onChanged: (value) {
                        _contactPersonDetails = _contactPersonDetails.copyWith(
                          contact: value,
                        );
                      },
                      hintText: "Contact Number",
                      errorText: ""),
                  SizedBox(
                    height: size(context).height * 0.012,
                  ),
                  CustomTextFormField(
                      icon: Icons.email,
                      onChanged: (value) {
                        _contactPersonDetails = _contactPersonDetails.copyWith(
                          email: value,
                        );
                      },
                      hintText: "Email address",
                      errorText: ""),
                  SizedBox(
                    height: size(context).height * 0.05,
                  ),
                  Center(
                    child: SecondaryCustomButton(
                        onPressed: () {
                          if (_contactPersonDetails.name.isNotEmpty &&
                                  _contactPersonDetails.contact.isNotEmpty ||
                              _contactPersonDetails.email.isNotEmpty) {
                            // push
                            context
                                .read<BookingCubit>()
                                .changePassengerAndContactDetails(
                                    passengerDetails: _passengerDetails,
                                    contactPersonDetails:
                                        _contactPersonDetails);
                            Navigator.of(context)
                                .pushNamed(ProceedToPay.routeName);
                          } else {
                            customSnackbar(
                                context: context,
                                isError: true,
                                message: "Please fill all the details");
                          }
                        },
                        label: "Proceed",
                        disable: false),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PassengerDetailsWidget extends StatelessWidget {
  final Function onChangedName;
  final Function onChangedContact;
  final TripSeat seat;
  const PassengerDetailsWidget({
    Key? key,
    required this.onChangedName,
    required this.onChangedContact,
    required this.seat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size(context).height * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                CustomIcon.seat_fill,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(seat.seat.label),
            ],
          ),
          SizedBox(
            width: size(context).width * 0.05,
          ),
          Expanded(
            child: Column(
              children: [
                PassengerTextFormField(
                  onChanged: (String value) {
                    onChangedName(value);
                  },
                  hintText: "Full Name",
                  errorText: "",
                ),
                SizedBox(
                  height: size(context).height * 0.012,
                ),
                PassengerTextFormField(
                  keyboardType: TextInputType.phone,
                  onChanged: (String value) {
                    onChangedContact(value);
                  },
                  hintText: "Contact Number",
                  errorText: "",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PassengerViewDetailsWidget extends StatelessWidget {
  final TripSeat seat;
  final PassengerDetailsModel passenger;
  const PassengerViewDetailsWidget({
    Key? key,
    required this.passenger,
    required this.seat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size(context).width * 0.02),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(size(context).height * 0.01),
      ),
      margin: EdgeInsets.only(bottom: size(context).height * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                CustomIcon.seat_fill,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(seat.seat.label),
            ],
          ),
          SizedBox(
            width: size(context).width * 0.05,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  passenger.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: size(context).height * 0.002,
                ),
                Text(
                  passenger.contact,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContactViewDetailsWidget extends StatelessWidget {
  final PassengerDetailsModel passenger;
  const ContactViewDetailsWidget({
    Key? key,
    required this.passenger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size(context).width * 0.02),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(size(context).height * 0.01),
      ),
      margin: EdgeInsets.only(bottom: size(context).height * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          SizedBox(
            width: size(context).width * 0.05,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  passenger.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: size(context).height * 0.002,
                ),
                Text(
                  passenger.contact,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: size(context).height * 0.002,
                ),
                Text(
                  passenger.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
