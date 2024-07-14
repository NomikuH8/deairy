import 'package:flutter/material.dart';

class SnackbarUtil {
  static SnackBar getSimpleSnackBar(String text, String buttonText,
      {void Function()? onTap}) {
    var snackBar = SnackBar(
      backgroundColor: Colors.black87,
      content: Text(
        text,
        style: const TextStyle(color: Colors.white70),
      ),
      action: SnackBarAction(
        label: buttonText,
        onPressed: onTap ?? () {},
      ),
    );

    return snackBar;
  }
}
