import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const TextInputField(
      {Key? key,
      required this.controller,
      required this.icon,
      this.isObscure = false,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      cursorColor: purpleColor,
      decoration: InputDecoration(
        hintText: labelText,
        prefixIcon: Icon(
          icon,
          color: purpleColor,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
      ),
      obscureText: isObscure,
    );
  }
}
