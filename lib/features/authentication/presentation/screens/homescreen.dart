import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_chip.dart';
import '../../../../core/widgets/custom_intro_header.dart';
import 'package:dotted_line/dotted_line.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/passenger/homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  var selected = "Kathmandu";
  var to = "Pokhara";

  DateTime selectedDate = DateTime.now();
  DateTime? tomorrowDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String selectedSeat = '';

  Future<void> _selectSeat(String seat) async {
    setState(() {
      selectedSeat = seat;
    });
  }

  List<Map> popDestinations = [];
  List<Map> popBuses = [];
  @override
  void initState() {
    super.initState();

    popDestinations = List.generate(
        20, (index) => {"id": index, "name": "Destination $index"}).toList();

    popBuses =
        List.generate(10, (index) => {"id": index, "name": "Buses $index"})
            .toList();

    ///whatever you want to run on page build
  }

  final List<String> listOfQuickSeats = ['2', '3', '4', '5', '6'];

  @override
  Widget build(BuildContext context) {
    tomorrowDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1);

    return Scaffold(
        appBar: customAppBar(title: "", context: context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroHeader(
                  size1: size(context).height * 0.025,
                  introHeader: "Hey Passenger",
                  introDesc: "What's your next trip?"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: size(context).height * 0.56,
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
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                height: size(context).height * 0.20,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              size(context).height * 0.015,
                                          horizontal:
                                              size(context).height * 0.03),
                                      child: Column(
                                        children: [
                                          Icon(
                                            size: 20,
                                            Icons.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: 50,
                                            dashRadius: 50,
                                            dashLength: 2,
                                            lineThickness: 2,
                                            dashColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          Icon(
                                            size: 20,
                                            Icons.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size(context).width * 0.06),

                                    // from and too
                                    Flexible(
                                      child: SizedBox(
                                        width: size(context).width * 0.55,
                                        height: size(context).height * 0.3,
                                        child: Column(
                                          children: [
                                            DropdownButtonFormField(
                                              icon: const Visibility(
                                                  visible: false,
                                                  child: Icon(
                                                      Icons.arrow_downward)),
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'From',
                                                  labelStyle:
                                                      TextStyle(fontSize: 12)),
                                              value: selected,
                                              items: [
                                                "Kathmandu",
                                                "Pokhara",
                                                "Biratnagar"
                                              ]
                                                  .map((label) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          label,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        value: label,
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() => selected =
                                                    value.toString());
                                              },
                                            ),
                                            DottedLine(
                                              dashColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            DropdownButtonFormField(
                                              icon: Visibility(
                                                  visible: false,
                                                  child: Icon(
                                                      Icons.arrow_downward)),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'To',
                                                  labelStyle:
                                                      TextStyle(fontSize: 12)),
                                              value: to,
                                              items: [
                                                "Kathmandu",
                                                "Pokhara",
                                                "Biratnagar"
                                              ]
                                                  .map((label) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          label,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        value: label,
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() => selected =
                                                    value.toString());
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_upward_rounded)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: size(context).height * 0.36,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size(context).height * 0.025,
                                        horizontal:
                                            size(context).height * 0.03),
                                    child: Column(
                                      children: [
                                        Icon(
                                          size: size(context).height * 0.03,
                                          Icons.date_range_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        DottedLine(
                                          direction: Axis.vertical,
                                          lineLength: 80,
                                          dashRadius: 50,
                                          dashLength: 2,
                                          lineThickness: 2,
                                          dashColor: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                        Icon(
                                          size: size(context).height * 0.03,
                                          Icons.person_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: size(context).width * 0.06),
                                  Expanded(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextFormField(
                                          onTap: () async {
                                            _selectDate(context);
                                          },
                                          decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              labelText: "Date",
                                              hintText:
                                                  '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                                              labelStyle:
                                                  TextStyle(fontSize: 10),
                                              border: InputBorder.none),
                                        ),
                                        Row(
                                          children: [
                                            CustomChipButton(
                                              label: "Today",
                                              onTap: (label) {
                                                print("i am here");
                                                setState(() {
                                                  selectedDate = DateTime.now();
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: size(context).width * 0.05,
                                            ),
                                            CustomChipButton(
                                              label: "Tomorrow",
                                              onTap: (label) {
                                                print("i am here");
                                                setState(() {
                                                  selectedDate = tomorrowDate!;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: size(context).width * 0.55,
                                              child: DottedLine(
                                                dashColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          initialValue: '$selectedSeat',
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: '$selectedSeat',
                                              labelText: "Number of seats",
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                              labelStyle:
                                                  TextStyle(fontSize: 10),
                                              border: InputBorder.none),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: listOfQuickSeats.length,
                                            itemBuilder: ((context, index) {
                                              return CustomChipButton(
                                                  onTap: (value) {
                                                    _selectSeat(value);
                                                  },
                                                  label:
                                                      listOfQuickSeats[index]);
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            bottom: -26,
                            left: 80,
                            right: 80,
                            child: CustomButton(
                                onPressed: () {},
                                label: "Search",
                                disable: false,
                                padding1: EdgeInsets.symmetric(
                                    horizontal: size(context).width * 0.1,
                                    vertical: size(context).height * 0.02)))
                      ],
                    )),
              ),
              SizedBox(height: size(context).height * 0.025),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Destinations",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                      textDirection: TextDirection.ltr,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 120,
                        width: 300,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 220,
                                    childAspectRatio: 4 / 1,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 10),
                            itemCount: popDestinations.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(popDestinations[index]["name"]),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Buses",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                      textDirection: TextDirection.ltr,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 120,
                        width: 300,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 220,
                                    childAspectRatio: 4 / 1,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 10),
                            itemCount: popBuses.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(popBuses[index]["name"]),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
