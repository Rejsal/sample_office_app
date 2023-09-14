import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

enum ConfirmAction { cancel, accept }

//info dialog with out title
Future<ConfirmAction?> infoDialog(
    BuildContext context, final String description, final String okAction) {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: true, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(description),
// backgroundColor: Color.fromRGBO(1, 64, 81, .8),
        actions: <Widget>[
          TextButton(
            child:
                Text(okAction, style: Theme.of(context).textTheme.titleSmall),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.accept);
            },
          )
        ],
      );
    },
  );
}
