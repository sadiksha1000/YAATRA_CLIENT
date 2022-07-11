import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_chip.dart';
import '../../../../core/widgets/custom_intro_header.dart';

import 'package:dotted_line/dotted_line.dart';
import '../../data/models/station_model.dart';
import '../../domain/entities/station.dart';
import '../../../bus/presentation/cubits/fetch_bus_cubit/fetch_buses_cubit.dart';
import '../../../bus/presentation/cubits/search_bus_cubit/search_bus_cubit.dart';
import '../cubits/fetch_station_cubit/fetch_station_cubit.dart';
import '../cubits/fetch_trip_cubit/fetch_trip_cubit.dart';
import 'view_buses_screen.dart';

import '../../../../core/widgets/custom_drawer.dart';
import '../../../../core/widgets/home_custom_chip.dart';
import '../../../app/presentation/blocs/app/app_bloc.dart';
import '../../../passenger/profile/presentation/cubit/passenger_profile_cubit.dart';

class PassengerHomeScreen extends StatefulWidget {
  static const routeName = '/passenger/home';
  const PassengerHomeScreen({Key? key}) : super(key: key);

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  TextEditingController dateController = TextEditingController();

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
        dateController.text = DateFormat.yMd().format(selectedDate);
        context.read<FetchTripCubit>().selectedDateChanged(picked);
      });
    }
  }

  TextEditingController seatController = TextEditingController();
  String selectedSeat = '';

  Future<String> _selectSeat(value) async {
    setState(() {
      selectedSeat = value;
      seatController.text = value;
    });
    print("selecting a seat$selectedSeat");
    return selectedSeat;
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

    dateController.text = DateFormat.yMd().format(DateTime.now());

    ///whatever you want to run on page build
  }

  final List<String> listOfQuickSeats = ['2', '3', '4', '5', '6'];

  @override
  void didChangeDependencies() {
    fetchCurrentPassenger();
    context.read<FetchStationCubit>().fetchAllStations();
    super.didChangeDependencies();
  }

  void fetchCurrentPassenger() async {
    print("Fetch current passenger");
    PassengerProfileCubit _passengerCubit =
        BlocProvider.of<PassengerProfileCubit>(context);
    var passenger = await _passengerCubit
        .getCurrentPassenger(BlocProvider.of<AppBloc>(context).state.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    FetchAllBusesCubit _fetchBusCubit =
        BlocProvider.of<FetchAllBusesCubit>(context);

    SearchBusCubit _searchBusCubit = BlocProvider.of<SearchBusCubit>(context);
    FetchStationCubit _fetchStationCubit =
        BlocProvider.of<FetchStationCubit>(context);

    FetchTripCubit _fetchTripCubit = BlocProvider.of<FetchTripCubit>(context);
    tomorrowDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1);

    return Scaffold(
        appBar: customAppBar(
          title: "",
          context: context,
          isBackButton: false,
          isDrawerEnabled: true,
        ),
        endDrawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroHeader(
                  size1: size(context).height * 0.025,
                  introHeader: "Hey Passenger",
                  introDesc: "What's your next trip?"),
              Padding(
                padding: EdgeInsets.all(size(context).height * 0.0165),
                child: Container(
                    height: size(context).height * 0.465,
                    decoration: Constants.cardDecoration(context),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                height: size(context).height * 0.165,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              size(context).height * 0.026,
                                          horizontal:
                                              size(context).height * 0.03),
                                      child: Column(
                                        children: [
                                          Icon(
                                            size: size(context).height * 0.023,
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
                                            size: size(context).height * 0.023,
                                            Icons.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size(context).width * 0.02),

                                    // from and too
                                    Flexible(
                                      child: SizedBox(
                                        width: size(context).width * 0.55,
                                        height: size(context).height * 0.3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            StreamBuilder<Station>(
                                              stream: _fetchTripCubit
                                                  .selectedFromStation,
                                              builder: (context, snapshot) {
                                                return BlocBuilder<
                                                    FetchStationCubit,
                                                    FetchStationState>(
                                                  builder: (ctx, state) {
                                                    return SourceDestinationInputWidget(
                                                      stations: state.station,
                                                      label: 'From',
                                                      onTap: (station) {
                                                        _fetchTripCubit
                                                            .selectedFromStationChanged(
                                                                station);
                                                      },
                                                      selectedStation:
                                                          snapshot.data ??
                                                              Station.empty,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            BlocBuilder<FetchStationCubit,
                                                FetchStationState>(
                                              builder: (ctx, state) {
                                                return StreamBuilder<Station>(
                                                    stream: _fetchTripCubit
                                                        .selectedToStation,
                                                    builder:
                                                        (context, snapshot) {
                                                      return SourceDestinationInputWidget(
                                                        stations: state.station,
                                                        label: 'To',
                                                        selectedStation:
                                                            snapshot.data !=
                                                                    null
                                                                ? snapshot.data
                                                                    as Station
                                                                : Station.empty,
                                                        onTap: (station) {
                                                          context
                                                              .read<
                                                                  FetchTripCubit>()
                                                              .selectedToStationChanged(
                                                                station,
                                                              );
                                                        },
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              size(context).width * 0.04),
                                      width: size(context).width * 0.12,
                                      height: size(context).width * 0.12,
                                      decoration:
                                          Constants.circleDecoration(context),
                                      child: StreamBuilder<Station>(
                                          stream: _fetchTripCubit
                                              .selectedFromStation,
                                          builder: (context, fromSnapshot) {
                                            return StreamBuilder<Station>(
                                                stream: _fetchTripCubit
                                                    .selectedToStation,
                                                builder: (context, toSnapshot) {
                                                  return IconButton(
                                                      icon: Icon(
                                                        Icons.compare_arrows,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      onPressed: () {
                                                        _fetchTripCubit
                                                            .selectedFromStationChanged(
                                                                toSnapshot.data
                                                                    as StationModel);
                                                        _fetchTripCubit
                                                            .selectedToStationChanged(
                                                                fromSnapshot
                                                                        .data
                                                                    as StationModel);
                                                        // _searchBusCubit.searchBus();
                                                      });
                                                });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size(context).height * 0.25,
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
                                                .secondary),
                                        DottedLine(
                                          direction: Axis.vertical,
                                          lineLength: 89,
                                          dashRadius: 50,
                                          dashLength: 2,
                                          lineThickness: 2,
                                          dashColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        Icon(
                                          size: size(context).height * 0.03,
                                          Icons.person_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: size(context).width * 0.02),
                                  Expanded(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextFormField(
                                          onTap: () async {
                                            _selectDate(context);
                                          },
                                          readOnly: true,
                                          controller: dateController,
                                          decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              labelText: "Date",
                                              // hintText:
                                              //     '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                                              // hintStyle: TextStyle(
                                              //   fontSize: size(context).height *
                                              //       0.016,
                                              // ),
                                              labelStyle: TextStyle(
                                                fontSize: size(context).height *
                                                    0.022,
                                              ),
                                              border: InputBorder.none),
                                        ),
                                        Row(
                                          children: [
                                            HomeCustomChipButton(
                                              label: "Today",
                                              onTap: (label) {
                                                setState(() {
                                                  selectedDate = DateTime.now();
                                                  dateController.text =
                                                      DateFormat.yMd()
                                                          .format(selectedDate);
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: size(context).width * 0.05,
                                            ),
                                            HomeCustomChipButton(
                                              label: "Tomorrow",
                                              onTap: (label) {
                                                setState(() {
                                                  selectedDate = tomorrowDate!;
                                                  dateController.text =
                                                      DateFormat.yMd()
                                                          .format(selectedDate);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  size(context).height * 0.005),
                                              child: SizedBox(
                                                width:
                                                    size(context).width * 0.55,
                                                child: DottedLine(
                                                  dashColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          // initialValue: '$selectedSeat',
                                          keyboardType: TextInputType.number,
                                          controller: seatController,
                                          decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              // hintText: '$selectedSeat',
                                              labelText: "Number of seats",
                                              hintStyle: TextStyle(
                                                fontSize: size(context).height *
                                                    0.016,
                                              ),
                                              labelStyle: TextStyle(
                                                fontSize: size(context).height *
                                                    0.022,
                                              ),
                                              border: InputBorder.none),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: listOfQuickSeats.length,
                                            itemBuilder: ((context, index) {
                                              return HomeCustomChipButton(
                                                  onTap: (value) {
                                                    _selectSeat(value);
                                                    _fetchTripCubit
                                                        .selectedNumberOfSeatsChanged(
                                                            value);
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
                          child: StreamBuilder<bool>(
                              stream: _fetchTripCubit.submitValid,
                              builder: (context, snapshot) {
                                return CustomButton(
                                  onPressed: () async {
                                    print('searched');
                                    await _fetchTripCubit.searchBuses();
                                    // _fetchBusCubit.fetchAllBuses();
                                    Navigator.of(context)
                                        .pushNamed(ViewBusesScreen.routeName);
                                  },
                                  label: "Search",
                                  disable: false,
                                );
                              }),
                        )
                      ],
                    )),
              ),
              SizedBox(height: size(context).height * 0.025),
              Padding(
                padding: EdgeInsets.all(size(context).height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Destinations",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: size(context).height * 0.020,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                      // textDirection: TextDirection.ltr,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(size(context).height * 0.01),
                        height: 135,
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
                                child: Text(
                                  popDestinations[index]["name"],
                                  style: TextStyle(
                                    fontSize: size(context).width * 0.0335,
                                  ),
                                ),
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
                padding: EdgeInsets.all(size(context).height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Buses",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: size(context).height * 0.020,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                      // textDirection: TextDirection.ltr,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 135,
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
                                child: Text(
                                  popBuses[index]["name"],
                                  style: TextStyle(
                                    fontSize: size(context).width * 0.0335,
                                  ),
                                ),
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

class SourceDestinationInputWidget extends StatelessWidget {
  final String label;
  final Station selectedStation;
  final Function onTap;
  final List<StationModel> stations;
  const SourceDestinationInputWidget({
    required this.onTap,
    required this.label,
    required this.selectedStation,
    required this.stations,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: size(context).height * 0.018),
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: size(context).width * 0.033,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        SizedBox(height: size(context).height * 0.0013),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size(context).width * 0.02),
                  topRight: Radius.circular(size(context).width * 0.02),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return ListView.builder(
                    itemCount: stations.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(stations[index].stationName),
                        subtitle: Text(
                          stations[index].placeId.name,
                          style:
                              TextStyle(fontSize: size(context).width * 0.03),
                        ),
                        onTap: () {
                          onTap(stations[index]);
                          // _fetchBusCubit.setSource(state.station[index]);
                          Navigator.pop(context);
                        },
                      );
                    });
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(size(context).width * 0.01)),
            width: double.infinity,
            child: Text(
              selectedStation.isNotEmpty
                  ? "${selectedStation.stationName} (${selectedStation.placeId.name})"
                  : '',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: size(context).height * 0.018,
                  ),
            ),
          ),
        ),
        DottedLine(
          dashColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
