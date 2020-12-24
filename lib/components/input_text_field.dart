import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextField extends StatelessWidget {
  InputTextField({this.icon, this.hint, this.obs, this.input});
  final IconData icon;
  final String hint;
  final bool obs;
  final Function input;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        onChanged: input,
        obscureText: obs,
        style: GoogleFonts.novaFlat(
          fontSize: 20,
          color: Colors.grey,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.novaFlat(
            fontSize: 20,
            color: Colors.grey,
          ),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
