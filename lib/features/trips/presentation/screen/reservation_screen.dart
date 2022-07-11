import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button2_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_textformfield_widget.dart';
import '../../../../core/widgets/passenger_detail_textformfield.dart';
import 'proceed_to_pay_screen.dart';

class ReservationScreen extends StatefulWidget {
  static const routeName = '/reservation';
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Passenger Details', context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(size(context).width * 0.04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter Passenger Details:",
                          style: TextStyle(
                              fontSize: size(context).height * 0.018,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size(context).height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size(context).width * 0.05),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: size(context).width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    PassengerTextFormField(
                                        onChanged: () {},
                                        hintText: "Full Name",
                                        errorText: ""),
                                    SizedBox(
                                      height: size(context).height * 0.012,
                                    ),
                                    PassengerTextFormField(
                                        onChanged: () {},
                                        hintText: "Contact Number",
                                        errorText: "")
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size(context).height * 0.03),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: size(context).width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    PassengerTextFormField(
                                        onChanged: () {},
                                        hintText: "Full Name",
                                        errorText: ""),
                                    SizedBox(
                                      height: size(context).height * 0.012,
                                    ),
                                    PassengerTextFormField(
                                        onChanged: () {},
                                        hintText: "Contact Number",
                                        errorText: "")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                    "Contact person Details: ",
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
                          disable: false))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
