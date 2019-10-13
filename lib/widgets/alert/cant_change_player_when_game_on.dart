import 'package:flutter/material.dart';


Future<Null> cantChangePlayerWhenGameOn(BuildContext context, String message) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          backgroundColor: Color(0xFFE35D5E),
          title: new Text(message,
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: new TextStyle(
                color: Colors.white
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 50.0,
                )
            )
          ],
        );
      }
  );
}