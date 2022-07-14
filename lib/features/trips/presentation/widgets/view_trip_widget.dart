import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/config/size.dart';
import '../../domain/entities/trip.dart';

class ViewTrip extends StatelessWidget {
  final Trip _trip;
  final Function(Trip) _onPressed;

  const ViewTrip({
    Key? key,
    required Trip trip,
    required Function(Trip) onPressed,
  })  : _trip = trip,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPressed(_trip),
      child: Container(
        margin: EdgeInsets.only(bottom: size(context).height * 0.015),
        padding: EdgeInsets.all(size(context).height * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(context).width * 0.03),
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              blurRadius: size(context).height * 0.08,
              color: const Color.fromARGB(35, 147, 146, 146),
              spreadRadius: size(context).height * 0.03,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: size(context).width * 0.08,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  // Title, Time, Features
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _trip.busId.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      children: [
                        Text(
                          "Time: ",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "07:00 AM",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: size(context).height * 0.017,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size(context).height * 0.009,
                    ),
                    Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 10.0,
                        //   child:Icon(Icons.tv)
                        // ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.tv,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.wifi,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.airline_seat_recline_normal,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              // Price, Total Seats, Available Seats, Seat Status
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rs. " + _trip.busId.ticketPrice.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: size(context).height * 0.0175,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size(context).height * 0.009,
                ),
                Row(
                  children: [
                    Text(
                      "Total Seats: ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: size(context).height * 0.015,
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
                      "Available Seats: ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: size(context).height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
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
                SizedBox(height: size(context).height * 0.01),
                Container(
                  width: size(context).width * 0.28,
                  height: size(context).height * 0.0025,
                  child: LinearProgressIndicator(
                    value: 0.2,
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
