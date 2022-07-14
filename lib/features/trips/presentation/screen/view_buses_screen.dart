import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_cubit.dart';
import 'seat_select_screen.dart';
import '../widgets/view_trip_widget.dart';

import '../../../../core/config/size.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../domain/entities/station.dart';
import '../../domain/entities/trip.dart';
import '../cubits/fetch_trip_cubit/fetch_trip_cubit.dart';

class ViewBusesScreen extends StatefulWidget {
  static const routeName = '/view-buses';
  const ViewBusesScreen({Key? key}) : super(key: key);

  @override
  State<ViewBusesScreen> createState() => _ViewBusesScreenState();
}

class _ViewBusesScreenState extends State<ViewBusesScreen> {
  DateTime selectedDate = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    FetchTripCubit _fetchTripCubit = BlocProvider.of<FetchTripCubit>(context);
    return Scaffold(
      appBar: customAppBar(title: "Available Buses", context: context),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // From -- To
                Padding(
                  padding: EdgeInsets.all(size(context).height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "From",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          StreamBuilder<Station>(
                              stream: _fetchTripCubit.selectedFromStation,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData
                                      ? snapshot.data!.stationName
                                      : "Select From",
                                  style: Theme.of(context).textTheme.subtitle1,
                                );
                              }),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("To",
                              style: Theme.of(context).textTheme.titleSmall),
                          StreamBuilder<Station>(
                              stream: _fetchTripCubit.selectedToStation,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData
                                      ? snapshot.data!.stationName
                                      : "Select To",
                                  style: Theme.of(context).textTheme.subtitle1,
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                // Date
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      size(context).height * 0.005,
                      size(context).height * 0,
                      size(context).height * 0.005,
                      size(context).height * 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_left_rounded)),
                      SizedBox(
                        width: size(context).width * 0.27,
                        child: StreamBuilder<DateTime>(
                            stream: _fetchTripCubit.selectedDate,
                            builder: (context, snapshot) {
                              return TextFormField(
                                onTap: () async {
                                  _selectDate(context);
                                },
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: snapshot.hasData
                                        ? snapshot.data!
                                            .toIso8601String()
                                            .split('T')[0]
                                        : "Select Date",
                                    labelStyle: const TextStyle(fontSize: 10),
                                    border: InputBorder.none),
                              );
                            }),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_right_rounded))
                    ],
                  ),
                ),
                // Card
                Container(
                  height: size(context).height * 0.73,
                  padding: EdgeInsets.all(size(context).height * 0.01),
                  child: BlocBuilder<FetchTripCubit, FetchTripState>(
                    builder: (context, state) {
                      return state.trip.isEmpty
                          ? const Text('No trips available')
                          : ListView.builder(
                              itemCount: state.trip.length,
                              itemBuilder: (ctx, index) {
                                Trip _trip = state.trip[index];
                                return ViewTrip(
                                  trip: _trip,
                                  onPressed: (trip) {
                                    context
                                        .read<BookingCubit>()
                                        .changeSelectedTrip(trip);
                                    Navigator.pushNamed(
                                        context, SelectSeatScreen.routeName,
                                        arguments: trip);
                                  },
                                );
                              });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
