import 'package:flutter/material.dart';

const kPrimary = Color(0xff171717);
const kSecondary = Color(0xffFF9800);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  hintStyle: TextStyle(color: Colors.white54),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white60, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);
