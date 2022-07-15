import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/config/size.dart';
import '../../domain/entities/booking.dart';

class ViewTicket extends StatelessWidget {
  final Booking _booking;
  final Function(Booking) _onPressed;

  const ViewTicket({
    Key? key,
    required Booking booking,
    required Function(Booking) onPressed,
  })  : _booking = booking,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPressed(_booking),
      child: Padding(
        padding: EdgeInsets.only(top: size(context).height * 0.025),
        child: Container(
          height: size(context).height * 0.13,
          padding: EdgeInsets.all(size(context).height * 0.01),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(context).width * 0.035),
              color: Theme.of(context).colorScheme.onPrimary,
              boxShadow: [
                BoxShadow(
                  blurRadius: size(context).height * 0.05,
                  color: Color.fromARGB(36, 206, 203, 203),
                  spreadRadius: size(context).height * 0.015,
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //     "${_booking.tripId.departureRoute.source.placeId.name} to ${_booking.tripId.departureRoute.destination.placeId.name}",
              //     style: Theme.of(context)
              //         .textTheme
              //         .headline4!
              //         .copyWith(color: Theme.of(context).colorScheme.primary)),
              SizedBox(height: size(context).height * 0.005),
              Row(
                children: [
                  Container(
                    width: size(context).width * 0.2,
                    height: size(context).height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: size(context).width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   _booking.tripId.busId.name,
                          //   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          //       color: Colors.black,
                          //       fontSize: size(context).height * 0.02),
                          // ),
                          Row(
                            children: [
                              Text(
                                "Time: ",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: size(context).height * 0.016,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "07:00 AM",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: size(context).height * 0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Date: ",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: size(context).height * 0.016,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Text(
                              //   _booking.tripId.tripStartDate
                              //       .toIso8601String()
                              //       .split('T')[0],
                              //   style: TextStyle(
                              //       color: Theme.of(context).colorScheme.primary,
                              //       fontSize: size(context).height * 0.015,
                              //       fontWeight: FontWeight.bold),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Seats: ",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: size(context).height * 0.016,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "40",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: size(context).height * 0.015,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Seat numbers",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: size(context).height * 0.016,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "22",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: size(context).height * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
