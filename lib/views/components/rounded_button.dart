import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  Color bgColor;
  Color textColor;
  String text;
  Function onPress;
  RoundedButton({this.bgColor, this.textColor, this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: this.onPress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: this.bgColor,
        child: Text(
          this.text.toUpperCase(),
          style: TextStyle(color: this.textColor),
        ),
      ),
    );
  }
}
