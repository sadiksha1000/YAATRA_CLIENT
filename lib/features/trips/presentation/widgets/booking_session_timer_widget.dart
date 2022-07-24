import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/config/size.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_session_cubit.dart';

class BookingSessionTimerWidget extends StatefulWidget {
  @override
  _BookingSessionTimerWidgetState createState() =>
      _BookingSessionTimerWidgetState();
}

class _BookingSessionTimerWidgetState extends State<BookingSessionTimerWidget> {
  int timeCounter = 0;

  String get _timerText => '$timeCounter s';
  String get _minText => '${timeCounter ~/ 60}';
  String get _secText => '${timeCounter % 60}';

  @override
  void initState() {
    super.initState();
    timeCounter = context.read<BookingSessionCubit>().state.timeOutInSeconds;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: 1), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0) {
        context.read<BookingSessionCubit>().decreaseTimerCount();
        _timerUpdate();
      } else {
        context.read<BookingSessionCubit>().resetSession(context);
      }
    });
  }

  Widget _buildChild() {
    TextStyle? activeTextStyle;

    return Container(
      padding: EdgeInsets.all(size(context).width * 0.03),
      margin: EdgeInsets.symmetric(horizontal: size(context).width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 255, 226, 224),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Time left to complete booking",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            _minText + ':' + _secText + " min",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }
}
