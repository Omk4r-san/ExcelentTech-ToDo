import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/shared/styles.dart';

class FlatButtonHelper extends StatelessWidget {
  final String text;
  final Function onPressed;
  const FlatButtonHelper({Key key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primarySwatchColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  side: BorderSide(color: primarySwatchColor)))),
          child: Text(text,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: backgroundColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20))),
        ),
      ),
    );
  }
}
