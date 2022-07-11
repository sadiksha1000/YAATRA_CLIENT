import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button_widget.dart';

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
  int _val = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Proceed To Pay", context: context),
      body: Padding(
        padding: EdgeInsets.all(size(context).height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size(context).height * 0.2,
                // width: double.infinity,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Review Ticket",
                            style: Theme.of(context).textTheme.headline4),
                        Text("Swiss Travel",
                            style: Theme.of(context).textTheme.subtitle1),
                        const TextLabelWidget(
                            label: "Time:", value: "12:00 AM"),
                        const TextLabelWidget(
                            label: "Date:", value: "12/12/2022"),
                        const TextLabelWidget(
                            label: "Bus No: ", value: "Ba 4 pa 2343"),
                        const TextLabelWidget(
                            label: "Ticket No:", value: "Ba 4 pa 2343"),
                        const TextLabelWidget(
                            label: "Pickup location:", value: "Koteshwor")
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
              Text("Passenger Information",
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(
                height: size(context).height * 0.02,
              ),
              Container(
                height: size(context).height * 0.15,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(size(context).width * 0.04),
                    color: Theme.of(context).colorScheme.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: size(context).height * 0.08,
                        color: const Color.fromRGBO(129, 124, 124, 0.15),
                        spreadRadius: size(context).height * 0.03,
                      )
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(size(context).height * 0.02),
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Seat A1:  ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Riya Ranjit",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(width: size(context).width * 0.02),
                                Text(
                                  "98376457772",
                                  style: Theme.of(context).textTheme.subtitle2,
                                )
                              ],
                            )
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(height: size(context).height * 0.02),
              Text("Pay with", style: Theme.of(context).textTheme.headline4),
              Container(
                  height: size(context).height * 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                            leading: Radio(
                              value: 1,
                              groupValue: _val,
                              onChanged: (value) {
                                print(value);
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
                                print(value);
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
                height: size(context).height * 0.05,
              ),
              Center(
                  child: SecondaryCustomButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(ProceedToPay.routeName);
                      },
                      label: "Proceed",
                      disable: false))
            ],
          ),
        ),
      ),
    );
  }
}
