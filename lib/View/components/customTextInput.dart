import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomTextInput({ required hint, required controller,
    required String? Function(String?)? validate,
    TextInputAction? textInputAction = TextInputAction.next}) {
  return Card(
    color: Colors.green[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: TextFormField(
      controller: controller,
      autofocus: false,
      cursorColor: Colors.green,
      validator: validate,
      style: GoogleFonts.roboto(fontSize: 20, color: Colors.green),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.green),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      ),
    ),
  );
}