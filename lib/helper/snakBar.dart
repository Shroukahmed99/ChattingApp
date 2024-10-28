import 'package:flutter/material.dart';

void SnackBarMethod(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    )),
  );
}
