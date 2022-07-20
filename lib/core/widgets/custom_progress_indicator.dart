import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Function onTap;
  const CustomProgressIndicator({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => onTap()),
      child: Center(
        child: Column(children: [
          const CircularProgressIndicator(),
          Text('Cancel', style: Theme.of(context).textTheme.bodyText1),
        ]),
      ),
    );
  }
}
