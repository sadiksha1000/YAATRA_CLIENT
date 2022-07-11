import 'package:flutter/material.dart';

customSnackbar(
    {required context, required bool isError, required String? message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    isError
        ? SnackBar(
            backgroundColor: Colors.red,
            content: Text(message.toString()),
          )
        : SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(
              message.toString(),
            ),
          ),
  );
}
