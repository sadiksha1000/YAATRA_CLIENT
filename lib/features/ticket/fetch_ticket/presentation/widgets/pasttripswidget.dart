import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../domain/entities/booking.dart';

import '../../../../../core/config/size.dart';

class PastTrips extends StatelessWidget {
  final Booking _booking;
  final Function(Booking) _onPressed;
  const PastTrips(
      {Key? key,
      required Booking booking,
      required Function(Booking) onPressed})
      : _booking = booking,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPressed(_booking),
      child: Container(
        height: size(context).height * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(context).width * 0.02),
            color: Theme.of(context).colorScheme.onPrimary,
            boxShadow: [
              BoxShadow(
                blurRadius: size(context).height * 0.05,
                color: Color.fromARGB(36, 206, 203, 203),
                spreadRadius: size(context).height * 0.015,
              ),
            ]),
        margin: EdgeInsets.only(top: size(context).height * 0.02),
        padding: EdgeInsets.all(size(context).width * 0.02),
        child: Row(
          children: [
            Container(
              width: size(context).width * 0.19,
              height: size(context).height * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                    fit: BoxFit.cover),
              ),
            ),
            // Past trips
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: size(context).width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _booking.tripId.busId.name,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black,
                          fontSize: size(context).height * 0.021),
                    ),
                    Row(
                      children: [
                        Text(
                          "Departed Time: ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "07:00 AM",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: size(context).height * 0.016,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Departed Date: ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _booking.tripId.tripStartDate
                              .toIso8601String()
                              .split('T')[0],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: size(context).height * 0.016,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              // Price, Total Seats, Available Seats, Seat Status
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rs. ${_booking.totalAmount.toString()}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: size(context).height * 0.018,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size(context).height * 0.02,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Book Again",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: size(context).height * 0.017,
                        fontWeight: FontWeight.bold),
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
