import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SnackBarStatus {
  success,
  error,
  info,
}

class AppSnackBar {
  AppSnackBar._({
    required this.message,
  });
  final ScaffoldMessengerState message;

  factory AppSnackBar.of({
    required ScaffoldMessengerState message,
  }) {
    return AppSnackBar._(
      message: message,
    );
  }

  void show(String title) {
    message.clearSnackBars();
    message.showSnackBar(
      customSnackBar(
        CustomSnackBar(
          title,
          messager: message,
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
        required this.messager,
      }) : super(key: key);
  final String title;
  final ScaffoldMessengerState messager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var backgroundColor = Colors.white;
    var onColor = Colors.black;

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
            onTap: () => messager.hideCurrentSnackBar(),
          ),
        ],
      ),
    );
  }
}