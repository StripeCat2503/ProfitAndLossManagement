import 'package:flutter/material.dart';

class GoBackButton extends StatefulWidget {
  Color color;
  double size;
  GoBackButton({this.color, this.size});

  @override
  _GoBackButtonState createState() => _GoBackButtonState();
}

class _GoBackButtonState extends State<GoBackButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.keyboard_backspace,
          color: widget.color,
          size: widget.size,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
