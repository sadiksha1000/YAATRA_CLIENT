import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yaatra_client/core/config/size.dart';

class CountDownTimerWidget extends StatefulWidget {
  final String label;
  final Function onTimeUp;

  ///[timeOutInSeconds] after which the button is enabled
  final int timeOutInSeconds;

  const CountDownTimerWidget({
    Key? key,
    required this.label,
    required this.timeOutInSeconds,
    required this.onTimeUp,
  }) : super(key: key);

  @override
  _CountDownTimerWidgetState createState() => _CountDownTimerWidgetState();
}

class _CountDownTimerWidgetState extends State<CountDownTimerWidget> {
  int timeCounter = 0;

  String get _timerText => '$timeCounter s';
  String get _minText => '${timeCounter ~/ 60}';
  String get _secText => '${timeCounter % 60}';

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: 1), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0) {
        _timerUpdate();
      } else {
        widget.onTimeUp();
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
            widget.label,
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
