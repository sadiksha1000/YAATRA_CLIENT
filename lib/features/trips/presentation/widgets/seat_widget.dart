import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/utils/status.dart';
import 'package:yaatra_client/core/widgets/custom_popup_message.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_cubit.dart';
import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

import '../../../../../core/config/custom_icon_icons.dart';

class SeatWidget extends StatefulWidget {
  final TripSeat seat;
  final IconData? icon;
  final int index;
  final Function onClicked;

  const SeatWidget({
    Key? key,
    this.icon = Icons.add,
    required this.index,
    required this.onClicked,
    required this.seat,
  }) : super(key: key);

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  String seatName = "";

  String ticketPrice = "";
  bool isSelected = false;

  Widget showValidSeat({required BookingCubit bookingCubit}) {
    if (widget.seat.isBooked) {
      return Column(
        children: [
          Icon(
            CustomIcon.seat_fill,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(widget.seat.seat.label),
        ],
      );
    } else if (widget.seat.isHolded) {
      return Column(
        children: [
          const Icon(
            CustomIcon.seat_fill,
            color: Colors.orange,
          ),
          Text(widget.seat.seat.label),
        ],
      );
    } else if (isSelected) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          bookingCubit.removeSelectedSeatByUser(widget.seat);
        },
        child: Column(
          children: [
            Icon(
              CustomIcon.seat_fill,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(widget.seat.seat.label),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          bookingCubit.addSelectedSeatByUser(widget.seat);
        },
        child: Column(
          children: [
            Icon(
              CustomIcon.seat_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Text(widget.seat.seat.label),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    BookingCubit _bookingCubit = BlocProvider.of<BookingCubit>(context);
    print("I am rebuilding");

    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state.refreshSelectedTripStatus == Status.loading) {
          isSelected = false;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            isSelected = !isSelected;
            context
                .read<BookingCubit>()
                .updateSelectedSeats(widget.index, isSelected);
          },
          child: Center(
            child: showValidSeat(bookingCubit: _bookingCubit),
          ),
        );
      },
    );
  }
}
