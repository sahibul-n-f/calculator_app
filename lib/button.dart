import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String textButton;
  final buttonTap;
  final double mar;
  final double font;

  MyButtons(
      {this.color,
      this.textButton,
      this.textColor,
      this.buttonTap,
      this.mar,
      this.font = 18
      });

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: buttonTap,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(20),
  //         child: Container(
  //           color: color,
  //           child: Center(
  //             child: Text(
  //               textButton,
  //               style: TextStyle(color: textColor, fontSize: 18),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(mar),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white,
          onTap: buttonTap,
          child: Center(
            child: Text(
              textButton,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: font,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
