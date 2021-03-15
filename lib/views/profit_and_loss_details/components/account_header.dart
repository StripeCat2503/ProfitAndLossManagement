import 'package:flutter/material.dart';
import 'package:pnL/themes/color_scheme.dart';

class AccountHeader extends StatelessWidget {
  String title;

  AccountHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.15),
            border: Border.all(width: 1, color: primaryColor),
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Text(
              this.title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
