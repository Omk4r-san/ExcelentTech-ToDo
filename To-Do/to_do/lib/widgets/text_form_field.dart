import 'package:flutter/material.dart';
import 'package:to_do/shared/styles.dart';

class TextFormFieldHelper extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final TextInputType textInputType;
  final bool obscureText;
  final Function onChanged;
  const TextFormFieldHelper(
      {Key key,
      this.hintText,
      this.validator,
      this.textInputType,
      this.obscureText,
      this.onChanged,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
            obscureText: obscureText ?? false,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            decoration: inpurdecoration.copyWith(hintText: hintText)),
      ),
    );
  }
}

InputDecoration inpurdecoration = InputDecoration(
  contentPadding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
  fillColor: fillColor,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: backgroundColor, width: 1.0),
    borderRadius: BorderRadius.circular(15.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: backgroundColor, width: 0.0),
    borderRadius: BorderRadius.circular(15.0),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1.0, color: Colors.red)),
);
