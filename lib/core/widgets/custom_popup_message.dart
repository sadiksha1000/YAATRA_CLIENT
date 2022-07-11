import 'package:flutter/material.dart';

import '../config/size.dart';

customPopMessage(
  BuildContext context, {
  bool isError = false,
  String message = "Successful",
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsAlignment: MainAxisAlignment.center,
          content: Container(
            margin: EdgeInsets.symmetric(
              vertical: size(context).width * 0.1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size(context).width * 0.02,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: size(context).height * 0.08,
                  color: const Color.fromRGBO(129, 124, 124, 0.15),
                  spreadRadius: size(context).height * 0.03,
                )
              ],
            ),
            padding: EdgeInsets.all(size(context).width * 0.03),
            child: SizedBox(
              width: size(context).width * 0.8,
              child: ListTile(
                leading: Icon(
                  Icons.check_box_outlined,
                  color: isError
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  message,
                  style: isError
                      ? Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.red, overflow: TextOverflow.fade)
                      : Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        );
      },
    );
