import 'package:flutter/material.dart';

import '../../../../core/config/size.dart';

class StatusWidget extends StatefulWidget {
  Color color;
  final String label;
  final double fontsize;

  StatusWidget({
    Key? key,
    required this.color,
    required this.label,
    required this.fontsize,
  }) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: size(context).height * 0.02,
          width: size(context).height * 0.02,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: widget.color,
            ),
          ),
        ),
        SizedBox(
          width: size(context).width * 0.02,
        ),
        Text(
          widget.label,
          style: TextStyle(
            color: widget.color,
            fontSize: widget.fontsize,
          ),
        )
      ],
    );
  }
}
