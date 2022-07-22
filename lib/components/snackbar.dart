import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/functions/dark_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SnackBarStatus {
  success,
  error,
  info,
}

class AppSnackBar {
  AppSnackBar._({
    required this.messenger,
  });
  final ScaffoldMessengerState messenger;

  factory AppSnackBar.of({
    required ScaffoldMessengerState message,
  }) {
    return AppSnackBar._(
      messenger: message,
    );
  }

  void show(String title) {
    messenger.clearSnackBars();
    messenger.showSnackBar(
      customSnackBar(
        CustomSnackBar(
          title,
          messenger: messenger,
        ),
      ),
    );
  }
}

SnackBar customSnackBar(Widget content) {
  return SnackBar(
    content: content,
    backgroundColor: Colors.transparent,
  );
}

class CustomSnackBar extends ConsumerWidget {
  const CustomSnackBar(
      this.title, {
        Key? key,
        required this.messenger,
      }) : super(key: key);
  final String title;
  final ScaffoldMessengerState messenger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textTheme = Theme.of(context).textTheme;
    final backgroundColor = isDarkMode(context) ?
        Colors.black87 :
        Colors.white;
    var onColor = isDarkMode(context) ?
        Colors.white:
        Colors.black;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Icon(
              Icons.close,
              color: onColor,
            ),
            onTap: () => messenger.hideCurrentSnackBar(),
          ),
        ],
      ),
    );
  }
}