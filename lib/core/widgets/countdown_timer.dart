import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/config/size.dart';

class CountdownTimer extends StatefulWidget {
  final String label;
  final Function onPressed;
  final int time;
  const CountdownTimer({
    Key? key,
    required this.label,
    required this.time,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _counter;

  Duration _duration = const Duration(seconds: 10);

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    _counter =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(
      () {
        final seconds = _duration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          _counter!.cancel();
        } else {
          _duration = Duration(seconds: seconds);
        }
      },
    );
  }

  bool isTimerEnd() {
    final seconds = _duration.inSeconds;
    if (seconds < 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _counter!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(_duration.inSeconds.remainder(60));
    final minutes = strDigits(_duration.inMinutes.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(
          width: size(context).width * 0.02,
        ),
        !isTimerEnd()
            ? Text(
                "$minutes:$seconds",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : TextButton(onPressed: () {}, child: const Text("Resend"))
      ],
    );
  }
}
