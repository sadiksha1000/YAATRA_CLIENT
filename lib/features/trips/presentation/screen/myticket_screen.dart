import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button2_widget.dart';
import '../../../../core/widgets/custom_button3.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../../core/widgets/text_label2_widget.dart';
import '../../../../core/config/size.dart';
import '../../../../core/widgets/text_label_widget.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({Key? key}) : super(key: key);

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  final qrKey = GlobalKey();
  final qrKey2 = GlobalKey();
  String qrData = 'Our Qr Data';
  String qrData2 = 'Our Qr Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "My Ticket", context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size(context).height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text('Kathmandu'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("To",
                            style: Theme.of(context).textTheme.titleSmall),
                        Text("Pokhara")
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size(context).height * 0.02),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Swiss Travel",
                            style: Theme.of(context).textTheme.headline5),
                        const TextLabelWidget(
                          label: 'Time',
                          value: '12:00 PM',
                        ),
                        const TextLabelWidget(
                          label: 'Date:',
                          value: '12/12/2020',
                        ),
                        const TextLabelWidget(
                            label: "Bus No:", value: "Ba 4 pa 2343"),
                        const TextLabelWidget(
                            label: "Ticket No:", value: "Ba 4 pa 2343"),
                        const TextLabelWidget(
                            label: "Pick-Up Location", value: "Koteshwor"),
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
                SizedBox(height: size(context).height * 0.04),
                Text("Passenger Details",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: size(context).height * 0.02)),

                // Container(
                //   height: size(context).height * 0.53,
                //   child: ListView.builder(
                //       itemCount: 2,
                //       itemBuilder: (BuildContext context, int index) {
                //         return Container(
                //             // height: size(context).height * 0.53,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(
                //                     size(context).width * 0.04),
                //                 color: Theme.of(context).colorScheme.onPrimary,
                //                 boxShadow: [
                //                   BoxShadow(
                //                     blurRadius: size(context).height * 0.08,
                //                     color: const Color.fromRGBO(
                //                         129, 124, 124, 0.15),
                //                     spreadRadius: size(context).height * 0.03,
                //                   )
                //                 ]),
                //             child: Padding(
                //               padding:
                //                   EdgeInsets.all(size(context).height * 0.01),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                       SizedBox(
                //                         width: size(context).width * 0.35,
                //                         height: size(context).height * 0.04,
                //                         child: TeritaryCustomButton(
                //                             onPressed: () {},
                //                             label: "Send ticket to Phone",
                //                             disable: false),
                //                       ),
                //                       SizedBox(
                //                         width: size(context).width * 0.35,
                //                         height: size(context).height * 0.04,
                //                         child: TeritaryCustomButton(
                //                             onPressed: () {},
                //                             label: "Send ticket to Email",
                //                             disable: false),
                //                       ),
                //                     ],
                //                   ),
                //                   Center(
                //                     child: RepaintBoundary(
                //                       key: qrKey2,
                //                       child: QrImage(
                //                         data: qrData2,
                //                         version: QrVersions.auto,
                //                         size: size(context).height * 0.18,
                //                       ),
                //                     ),
                //                   ),
                //                   Center(
                //                       child: Text(
                //                     "Ba 03 PA 3040",
                //                     style: TextStyle(
                //                         fontSize: size(context).height * 0.015),
                //                   )),
                //                   DottedLine(
                //                     lineLength: double.infinity,
                //                     dashLength: 5,
                //                     lineThickness: 2,
                //                     dashColor:
                //                         Theme.of(context).colorScheme.secondary,
                //                   ),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           TextLabel2Widget(
                //                               label: "Ticket No:",
                //                               value: "abcd"),
                //                           TextLabel2Widget(
                //                               label: "Seat No:", value: "abcd"),
                //                         ],
                //                       ),
                //                       TextLabel2Widget(
                //                           label: "Name:", value: "Riya Ranjit"),
                //                       TextLabel2Widget(
                //                           label: "Phone No:",
                //                           value: "98277356477"),
                //                       TextLabel2Widget(
                //                           label: "Email:",
                //                           value: "riyaranjit00@gmail.com"),
                //                     ],
                //                   ),
                //                   SizedBox(height: size(context).height * 0.01),
                //                   Center(
                //                     child: CustomButton(
                //                         onPressed: () {},
                //                         label: "Download Ticket",
                //                         disable: false),
                //                   )
                //                 ],
                //               ),
                //             ));
                //       }),
                // ),
                Padding(
                  padding: EdgeInsets.all(size(context).height * 0.02),
                  child: Container(
                      height: size(context).height * 0.53,
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
                        padding: EdgeInsets.all(size(context).height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: size(context).width * 0.35,
                                  height: size(context).height * 0.04,
                                  child: TeritaryCustomButton(
                                      onPressed: () {},
                                      label: "Send ticket to Phone",
                                      disable: false),
                                ),
                                SizedBox(
                                  width: size(context).width * 0.35,
                                  height: size(context).height * 0.04,
                                  child: TeritaryCustomButton(
                                      onPressed: () {},
                                      label: "Send ticket to Email",
                                      disable: false),
                                ),
                              ],
                            ),
                            Center(
                              child: RepaintBoundary(
                                key: qrKey,
                                child: QrImage(
                                  data: qrData,
                                  version: QrVersions.auto,
                                  size: size(context).height * 0.18,
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              "Ba 03 PA 3040",
                              style: TextStyle(
                                  fontSize: size(context).height * 0.015),
                            )),
                            DottedLine(
                              lineLength: double.infinity,
                              dashLength: 5,
                              lineThickness: 2,
                              dashColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextLabel2Widget(
                                        label: "Ticket No:", value: "abcd"),
                                    TextLabel2Widget(
                                        label: "Seat No:", value: "A1"),
                                  ],
                                ),
                                TextLabel2Widget(
                                    label: "Name:", value: "Riya Ranjit"),
                                TextLabel2Widget(
                                    label: "Phone No:", value: "98277356477"),
                                TextLabel2Widget(
                                    label: "Email:",
                                    value: "riyaranjit00@gmail.com"),
                              ],
                            ),
                            SizedBox(height: size(context).height * 0.01),
                            Center(
                              child: CustomButton(
                                  onPressed: () {},
                                  label: "Download Ticket",
                                  disable: false),
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
