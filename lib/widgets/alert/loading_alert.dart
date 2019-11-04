import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


Future<Null> loadingAlert(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          backgroundColor: Colors.transparent,
          title: Center(
            child: SpinKitFoldingCube(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        );
      }
  );
}