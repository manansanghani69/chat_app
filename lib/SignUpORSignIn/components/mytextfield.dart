import 'package:chat_app/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.hint, required this.controller, required this.obscureText});
  final bool obscureText;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.bebasNeue(
          color: kSecondary,
          fontWeight: FontWeight.w500,
          letterSpacing: 2),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.bebasNeue(
            color: kPrimary,
            fontWeight: FontWeight.w500,
            letterSpacing: 1),
        // enabled: ,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: kPrimary, width: 3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: kSecondary, width: 4)),
      ),
    );
  }
}
