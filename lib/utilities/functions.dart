import 'package:flutter/material.dart';

showBar(String message,BuildContext context){
  var snackBar = SnackBar(
        content: Text(message),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
}