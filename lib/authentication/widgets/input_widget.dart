import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.isObscureText});

  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child:  TextField(
        obscureText: isObscureText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
  }
}
