import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.obscure = false});
  final String hintText;
  final Function(String)? onChanged;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'this field is required';
        }
      },
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF9DD0E1),
          ),
        ),
      ),
    );
  }
}
