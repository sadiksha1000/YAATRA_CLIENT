import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_appbar.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_chip.dart';
import '../../../../core/widgets/status_widget.dart';
import '../../../../core/config/size.dart';

class SelectSeatScreen extends StatefulWidget {
  const SelectSeatScreen({Key? key}) : super(key: key);

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> facilitiesName = [
    "AC",
    "Wheelchair",
    "Toilet",
    "Comfortable Seats",
    "Charging Port"
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List images = ["change_password.svg", "login_image.svg", "googleicon.png"];

  @override
  Widget build(BuildContext context) {
    var subject;

    return Scaffold(
      appBar: customAppBar(title: "Swiss Bus", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
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
                  SizedBox(
                    width: size(context).width * 0.4,
                  ),
                  Container(
                    height: size(context).height * 0.1,
                    width: size(context).height * 0.1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/illustrations/googleicon.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size(context).width * 0.05),
              child: SingleChildScrollView(
                child: Container(
                    height: size(context).height * 0.55,
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
                    child: Column(
                      children: [
                        Container(
                          height: size(context).height * 0.05,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StatusWidget(
                                  label: "Available",
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontsize: size(context).height * 0.02,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StatusWidget(
                                  label: "Selected",
                                  color: Theme.of(context).colorScheme.primary,
                                  fontsize: size(context).height * 0.02,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StatusWidget(
                                  label: "Booked",
                                  color: Theme.of(context).colorScheme.error,
                                  fontsize: size(context).height * 0.02,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StatusWidget(
                                  label: "Hold",
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                  fontsize: size(context).height * 0.02,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size(context).width * 0.05),
              child: Container(
                height: size(context).height * 0.13,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(size(context).width * 0.01),
                    color: Theme.of(context).colorScheme.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: size(context).height * 0.08,
                        color: const Color.fromRGBO(129, 124, 124, 0.15),
                        spreadRadius: size(context).height * 0.03,
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size(context).height * 0.02,
                          vertical: size(context).width * 0.02),
                      child: Row(
                        children: [
                          Text(
                            "Selected Seats:",
                          ),
                          SizedBox(width: size(context).width * 0.33),
                          Text("Amount:")
                        ],
                      ),
                    ),
                    SizedBox(height: size(context).height * 0.02),
                    CustomButton(
                        onPressed: () {}, label: "Buy Tickets", disable: false)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size(context).height * 0.05,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size(context).width * 0.05),
              child: Container(
                height: size(context).height * 0.17,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size(context).height * 0.02,
                      vertical: size(context).width * 0.018),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Facilities",
                            style: TextStyle(
                                fontSize: size(context).height * 0.018,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size(context).height * 0.01,
                      ),
                      Container(
                        height: size(context).height * 0.1,
                        width: size(context).width * 0.99,
                        child: GridView.builder(
                            clipBehavior: Clip.hardEdge,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100,
                                    childAspectRatio: 2 / 1,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 5),
                            itemCount: facilitiesName.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(size(context).width * 0.01),
                                child: CustomChipButton(
                                    label: facilitiesName[index]),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size(context).height * 0.05),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size(context).width * 0.07),
              child: Container(
                // color: Colors.blue,
                height: size(context).height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Photos",
                        style: TextStyle(
                            fontSize: size(context).height * 0.018,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSecondary)),
                    TabBar(
                        controller: _tabController,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.onSecondary,
                        labelColor: Colors.black,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        tabs: const [
                          Tab(
                            child: Text('Exterior'),
                          ),
                          Tab(
                            child: Text('Interior'),
                          ),
                          Tab(
                            child: Text('Seats'),
                          ),
                        ]),
                    SizedBox(height: size(context).height * 0.01),
                    Container(
                      width: double.maxFinite,
                      height: size(context).height * 0.2,
                      child: TabBarView(controller: _tabController, children: [
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5),
                            itemCount: images.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin:
                                    EdgeInsets.all(size(context).width * 0.04),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://www.eichertrucksandbuses.com/front/images/buses_img01.png"),
                                        fit: BoxFit.fill)),
                              );
                            }),
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5),
                            itemCount: images.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin:
                                    EdgeInsets.all(size(context).width * 0.04),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/illustrations/" +
                                                images[index]))),
                              );
                            }),
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5),
                            itemCount: images.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin:
                                    EdgeInsets.all(size(context).width * 0.04),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/illustrations/" +
                                                images[index]))),
                              );
                            }),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
