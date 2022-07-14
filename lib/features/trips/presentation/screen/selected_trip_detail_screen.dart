import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button_widget.dart';

import '../../../../core/widgets/text_label_widget.dart';

class SelectedTripDetail extends StatefulWidget {
  static const routeName = "/selected-trip";
  const SelectedTripDetail({Key? key}) : super(key: key);

  @override
  State<SelectedTripDetail> createState() => _SelectedTripDetailState();
}

class _SelectedTripDetailState extends State<SelectedTripDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Trip Details", context: context),
      body: Padding(
        padding: EdgeInsets.all(size(context).width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.amber,
                height: size(context).height * 0.2,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Trip ID:",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: size(context).height * 0.025),
                            ),
                            SizedBox(
                              width: size(context).width * 0.025,
                            ),
                            Text(
                              "AGT4D0",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: size(context).height * 0.02),
                            )
                          ],
                        ),
                        SizedBox(height: size(context).height * 0.01),
                        Text(
                          'Bullet Deluxe',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: size(context).height * 0.02),
                        ),
                        SizedBox(height: size(context).height * 0.01),
                        const TextLabelWidget(
                          label: 'Departed Date:',
                          value: 'Ajay Purbe',
                        ),
                        const TextLabelWidget(
                          label: 'Departed Time:',
                          value: 'Ajay Purbe',
                        ),
                        const TextLabelWidget(
                          label: 'Total Fair:',
                          value: "Rs. ",
                        ),
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
                        // shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Icon(
                        size: 20,
                        Icons.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        lineLength: size(context).height * 0.05,
                        dashRadius: 50,
                        dashLength: 2,
                        lineThickness: 2,
                        dashColor: Theme.of(context).colorScheme.secondary,
                      ),
                      Icon(
                        size: 20,
                        Icons.circle,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ],
                  ),
                  SizedBox(width: size(context).width * 0.04),
                  Column(
                    children: [
                      Text("Kathmandu"),
                      SizedBox(height: size(context).height * 0.05),
                      Text("Janakpur")
                    ],
                  ),
                ],
              ),
              SizedBox(height: size(context).height * 0.04),
              Text("Passenger Details",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: size(context).height * 0.02)),
              SizedBox(height: size(context).height * 0.02),
              SingleChildScrollView(
                child: Container(
                  // color: Colors.amber,
                  height: size(context).height * 0.3,
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Icon(
                              Icons.chair,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              "Bibekananda Kushwaha",
                              style: Theme.of(context).textTheme.subtitle2,
                            ));
                        // return Row(
                        //   children: [
                        //     Icon(
                        //       Icons.chair,
                        //       color: Theme.of(context).colorScheme.primary,
                        //     ),
                        //     SizedBox(width: size(context).width * 0.04),
                        //     Text(
                        //       "Bibekananda Kushwaha",
                        //       style: Theme.of(context).textTheme.subtitle2,
                        //     ),
                        //     SizedBox(
                        //       height: size(context).height * 0.05,
                        //     )
                        //   ],
                        // );
                      }),
                ),
              ),
              SizedBox(
                height: size(context).height * 0.04,
              ),
              Center(
                child: CustomButton(
                    onPressed: () {}, label: "Book Again", disable: false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
