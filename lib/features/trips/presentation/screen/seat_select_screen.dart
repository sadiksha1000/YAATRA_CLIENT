import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/utils/status.dart';
import 'package:yaatra_client/core/widgets/custom_progress_indicator.dart';
import 'package:yaatra_client/core/widgets/custom_snackbar.dart';
import 'package:yaatra_client/core/widgets/shimmer.dart';
import 'package:yaatra_client/features/app/presentation/blocs/app/app_bloc.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_cubit.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_session_cubit.dart';
import 'package:yaatra_client/features/trips/presentation/widgets/seat_widget.dart';
import 'reservation_screen.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_chip.dart';
import '../../../../core/widgets/status_widget.dart';
import '../../domain/entities/trip.dart';

class SelectSeatScreen extends StatefulWidget {
  static const routeName = '/select-seat';
  const SelectSeatScreen({Key? key}) : super(key: key);

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen>
    with TickerProviderStateMixin {
  Trip initTrip = Trip.empty;
  late TabController _tabController;

  @override
  void initState() {
    context.read<BookingCubit>().emptySelectedSeatAndPriceByUser();
    context.read<BookingCubit>().refreshSelectedTrip(
        context.read<BookingCubit>().state.selectedTrip.id);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    print("Argumnets: $arguments");
    if (arguments != null) {
      initTrip = arguments as Trip;
    }
    super.didChangeDependencies();

    BookingCubit bookingCubit = context.read<BookingCubit>();
    print(
        "All trip in seat select screen : ${bookingCubit.state.selectedTrip.allTripSeats}");
    bookingCubit
        .fetchAllTripSeats(bookingCubit.state.selectedTrip.allTripSeats);
    _tabController = TabController(length: 3, vsync: this);
  }

  final List<String> facilitiesName = [
    "AC",
    "Wheelchair",
    "Toilet",
    "Comfortable Seats",
    "Charging Port"
  ];

  List images = ["change_password.svg", "login_image.svg", "googleicon.png"];

  @override
  Widget build(BuildContext context) {
    var subject;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: customAppBar(title: initTrip.busId.name, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(size(context).height * 0.02),
              child: Row(
                children: [
                  Column(
                    children: [
                      Icon(
                        size: size(context).height * 0.025,
                        Icons.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        lineLength: size(context).height * 0.055,
                        dashRadius: 50,
                        dashLength: 2,
                        lineThickness: 2,
                        dashColor: Theme.of(context).colorScheme.secondary,
                      ),
                      Icon(
                        size: size(context).height * 0.025,
                        Icons.circle,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ],
                  ),
                  SizedBox(width: size(context).width * 0.045),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        initTrip.departureRoute.source.stationName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: size(context).height * 0.0175),
                      ),
                      SizedBox(height: size(context).height * 0.05),
                      Text(
                        initTrip.departureRoute.destination.stationName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: size(context).height * 0.0175),
                      )
                    ],
                  ),
                  SizedBox(
                    width: size(context).width * 0.25,
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
              padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * 0.05,
                  vertical: size(context).height * 0.005),
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
                            color: const Color.fromARGB(36, 206, 203, 203),
                            spreadRadius: size(context).height * 0.03,
                          )
                        ]),
                    child: Column(
                      children: [
                        // Seat legend information
                        const SeatLegendWidget(),
                        // grid view
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => context
                                .read<BookingCubit>()
                                .refreshSelectedTrip(context
                                    .read<BookingCubit>()
                                    .state
                                    .selectedTrip
                                    .id),
                            child: BlocBuilder<BookingCubit, BookingState>(
                              // buildWhen: (previous, current) =>
                              //     current.selectedTrip != previous.selectedTrip,
                              builder: (context, state) {
                                return state.refreshSelectedTripStatus ==
                                        Status.loading
                                    ? const SeatShimmerWidget()
                                    : GridView.builder(
                                        itemCount: state
                                            .selectedTrip.allTripSeats.length,
                                        padding: const EdgeInsets.all(10),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          childAspectRatio: 1.5,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return state.selectedTrip
                                                      .allTripSeats[index] ==
                                                  null
                                              ? Container()
                                              : SeatWidget(
                                                  index: index,
                                                  onClicked: () {},
                                                  seat: state.selectedTrip
                                                      .allTripSeats[index],
                                                );
                                        },
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                      // Seat map
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * 0.05,
                  vertical: size(context).height * 0.005),
              child: Container(
                // height: size(context).height * 0.14,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(size(context).width * 0.04),
                    color: Theme.of(context).colorScheme.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: size(context).height * 0.08,
                        color: const Color.fromARGB(36, 206, 203, 203),
                        spreadRadius: size(context).height * 0.03,
                      )
                    ]),
                child: BlocBuilder<BookingCubit, BookingState>(
                    builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context).height * 0.02,
                            vertical: size(context).width * 0.02),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Selected Seats:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize:
                                              size(context).height * 0.0165),
                                ),
                                SizedBox(
                                  height: size(context).height * 0.030,
                                  width: size(context).width * 0.3,
                                  child: GridView.builder(
                                    itemCount: state.selectedSeatsByUser.isEmpty
                                        ? 0
                                        : state.selectedSeatsByUser.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            "${state.selectedSeatsByUser[index].seat.label} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: size(context).width * 0.33),
                            Column(
                              children: [
                                Text(
                                  "Amount:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize:
                                              size(context).height * 0.0165),
                                ),
                                SizedBox(
                                  child: Text(
                                    "NPR ${state.totalPrice.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: size(context).height * 0.02),
                      BlocConsumer<BookingSessionCubit, BookingSessionState>(
                        listener: (context, state) {
                          if (state.sessionStatus == Status.error) {
                            context
                                .read<BookingCubit>()
                                .clearSelectedUnavailableSeats(state
                                    .bookingFailureSession.unAvailableSeats);
                            customSnackbar(
                                context: context,
                                isError: true,
                                message: state.bookingFailureSession.message);
                          } else if (state.sessionStatus == Status.success) {
                            context
                                .read<BookingSessionCubit>()
                                .setSessionStatusInitial();
                            Navigator.pushNamed(
                                context, ReservationScreen.routeName);
                          }
                        },
                        builder: (context, state) {
                          return state.sessionStatus == Status.loading
                              ? CustomProgressIndicator(onTap: () {
                                  context
                                      .read<BookingSessionCubit>()
                                      .cancelSessionLoading();
                                })
                              : CustomButton(
                                  onPressed: () async {
                                    // check all the seats is available or not
                                    BookingSessionCubit bookingSessionCubit =
                                        context.read<BookingSessionCubit>();
                                    BookingCubit bookingCubit =
                                        context.read<BookingCubit>();

                                    await bookingSessionCubit
                                        .checkSeatsAvailability(
                                      selectedSeats: bookingCubit
                                          .state.selectedSeatsByUser,
                                      tripId:
                                          bookingCubit.state.selectedTrip.id,
                                      userId: context
                                          .read<AppBloc>()
                                          .state
                                          .user
                                          .uid,
                                    );
                                  },
                                  label: "Buy Tickets",
                                  disable: context
                                          .read<BookingCubit>()
                                          .state
                                          .selectedSeatsByUser
                                          .isEmpty
                                      ? true
                                      : false);
                        },
                      )
                    ],
                  );
                }),
              ),
            ),
            SizedBox(
              height: size(context).height * 0.03,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size(context).width * 0.02),
              child: Container(
                // height: size(context).height * 0.19,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size(context).height * 0.02,
                      vertical: size(context).width * 0.02),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Facilities",
                            style: TextStyle(
                                fontSize: size(context).height * 0.019,
                                fontWeight: FontWeight.w500,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size(context).height * 0.015,
                      ),
                      SizedBox(
                        width: size(context).width * 0.99,
                        child: GridView.builder(
                            shrinkWrap: true,
                            clipBehavior: Clip.hardEdge,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 173,
                                    childAspectRatio: 3 / 1,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                            itemCount: facilitiesName.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(size(context).width * 0.005),
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
            SizedBox(height: size(context).height * 0.03),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size(context).width * 0.07),
              child: Container(
                // color: Colors.blue,
                height: size(context).height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Photos",
                      style: TextStyle(
                          fontSize: size(context).height * 0.019,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
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
                      height: size(context).height * 0.6,
                      child: TabBarView(controller: _tabController, children: [
                        GridView.builder(
                            shrinkWrap: true,
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
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
                                    color: Colors.white,
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
                                    color: Colors.white,
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

class SeatShimmerWidget extends StatelessWidget {
  const SeatShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 30,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.5,
        crossAxisSpacing: 0,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            highlightColor: Colors.grey.withOpacity(0.1),
            enabled: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size(context).width * 0.01),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SeatLegendWidget extends StatelessWidget {
  const SeatLegendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size(context).height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(size(context).width * 0.01),
            child: StatusWidget(
              label: "Available",
              color: Theme.of(context).colorScheme.secondary,
              fontsize: size(context).height * 0.015,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size(context).width * 0.01),
            child: StatusWidget(
              label: "Selected",
              color: Theme.of(context).colorScheme.primary,
              fontsize: size(context).height * 0.015,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size(context).width * 0.01),
            child: StatusWidget(
              label: "Booked",
              color: Theme.of(context).colorScheme.error,
              fontsize: size(context).height * 0.015,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size(context).width * 0.01),
            child: StatusWidget(
              label: "Hold",
              color: Theme.of(context).colorScheme.onTertiary,
              fontsize: size(context).height * 0.015,
            ),
          ),
        ],
      ),
    );
  }
}
