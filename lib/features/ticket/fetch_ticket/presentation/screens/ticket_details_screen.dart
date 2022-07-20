import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/presentation/cubits/tickets/fetch_tickets_cubit.dart';

import '../../../../../core/config/size.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import '../../../../../core/widgets/custom_drawer.dart';
import '../../../../trips/data/models/trip_model.dart';
import '../../domain/entities/booking.dart';
import '../widgets/custombuttonwidget.dart';
import '../widgets/labelwidget.dart';
import '../widgets/textlabelwidget.dart';

class TicketDetailsScreen extends StatefulWidget {
  static const routeName = '/ticket-details';
  const TicketDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  Booking initBooking = Booking.empty;
  TripModel initTrip = TripModel.empty;
  final qrKey = GlobalKey();
  final qrKey2 = GlobalKey();
  String qrData = 'Our Qr Data';
  String qrData2 = 'Our Qr Data';

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      initBooking = arguments as Booking;
    }
    FetchTicketsCubit _fetchTicketsCubit =
        BlocProvider.of<FetchTicketsCubit>(context);
    _fetchTicketsCubit.fetchTrip(initBooking.tripId);
    print(
        "TicketDetailsStateCurrentTrip${_fetchTicketsCubit.state.currentTrip}");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FetchTicketsCubit _fetchTicketsCubit =
        BlocProvider.of<FetchTicketsCubit>(context);
    return Scaffold(
        appBar: customAppBar(title: "My Ticket", context: context),
        endDrawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size(context).height * 0.013),
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
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          _fetchTicketsCubit.state.currentTrip.departureRoute
                              .source.stationName,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "To",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          _fetchTicketsCubit.state.currentTrip.departureRoute
                              .destination.stationName,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size(context).height * 0.02),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _fetchTicketsCubit.state.currentTrip.busId.name,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black),
                        ),
                        TextLabelWidget(
                          label: 'Time:',
                          value: _fetchTicketsCubit
                              .state.currentTrip.departureTime
                              .toString()
                              .split(' ')[1],
                        ),
                        TextLabelWidget(
                          label: 'Date:',
                          value: _fetchTicketsCubit
                              .state.currentTrip.tripStartDate
                              .toString()
                              .split(' ')[0],
                        ),
                        TextLabelWidget(
                          label: "Bus No:",
                          value: _fetchTicketsCubit
                              .state.currentTrip.busId.plateNumber,
                        ),
                        TextLabelWidget(
                          label: "Ticket No:",
                          value: initBooking.id,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size(context).height * 0.04),
                Text("Passenger Details",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: size(context).height * 0.02,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.all(size(context).height * 0.007),
                  child: Container(
                      height: size(context).height * 0.49,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size(context).width * 0.04),
                          color: Theme.of(context).colorScheme.onPrimary,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: size(context).height * 0.08,
                              color: Color.fromARGB(36, 206, 203, 203),
                              spreadRadius: size(context).height * 0.03,
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(size(context).height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: RepaintBoundary(
                                key: qrKey,
                                child: QrImage(
                                  data: initBooking.id,
                                  version: QrVersions.auto,
                                  size: size(context).height * 0.18,
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              "${_fetchTicketsCubit.state.currentTrip.busId.name} - ${_fetchTicketsCubit.state.currentTrip.busId.plateNumber}",
                              style: TextStyle(
                                  fontSize: size(context).height * 0.02),
                            )),
                            Padding(
                              padding:
                                  EdgeInsets.all(size(context).height * 0.01),
                              child: DottedLine(
                                lineLength: double.infinity,
                                dashLength: 5,
                                lineThickness: 2,
                                dashColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelWidget(
                                        label: "Ticket No:",
                                        value: initBooking.id),
                                    LabelWidget(label: "Seat No:", value: "A1"),
                                  ],
                                ),
                                LabelWidget(
                                    label: "Name:", value: initBooking.name),
                                LabelWidget(
                                    label: "Phone No:",
                                    value: initBooking.phone),
                                LabelWidget(
                                    label: "Email:", value: initBooking.email),
                              ],
                            ),
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
