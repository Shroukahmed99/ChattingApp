import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWedge extends StatelessWidget {
  ButtonWedge({super.key, required this.buttonName, this.onTap});
  final String buttonName;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
