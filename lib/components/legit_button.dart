import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegitButton extends StatelessWidget {
  LegitButton({this.click});
  final Function click;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Started',
                style: GoogleFonts.novaFlat(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                maxRadius: 20.0,
                child: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
