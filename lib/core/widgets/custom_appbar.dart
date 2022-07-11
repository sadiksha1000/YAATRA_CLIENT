import 'package:flutter/material.dart';

AppBar customAppBar({
  required String title,
  required BuildContext context,
  bool isDrawerEnabled = true,
  bool isBackButton = true,
}) {
  return AppBar(
    leading: isBackButton
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Theme.of(context).colorScheme.primary,
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            icon: const Icon(Icons.chevron_left),
          )
        : null,

    title: Text(
      title,
    ),
    titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,

    actions: isDrawerEnabled
        ? [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  tooltip: 'Menu',
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                );
              },
            ),
          ]
        : [],

  );
}
