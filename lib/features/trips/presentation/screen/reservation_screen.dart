import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                              onChangedContact: (String value) {
                                print(value);
                              },
                              onChangedName: (String value) {
                                print(value);
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
                      onChanged: () {},
                      hintText: "Contact Name",
                      errorText: ""),
                  SizedBox(
                    height: size(context).height * 0.012,
                  ),
                  CustomTextFormField(
                      icon: Icons.phone,
                      onChanged: () {},
                      hintText: "Contact Number",
                      errorText: ""),
                  SizedBox(
                    height: size(context).height * 0.012,
                  ),
                  CustomTextFormField(
                      icon: Icons.email,
                      onChanged: () {},
                      hintText: "Email address",
                      errorText: ""),
                  SizedBox(
                    height: size(context).height * 0.05,
                  ),
                  Center(
                    child: SecondaryCustomButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ProceedToPay.routeName);
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
  const PassengerDetailsWidget({
    Key? key,
    required this.onChangedName,
    required this.onChangedContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size(context).height * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.person),
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
