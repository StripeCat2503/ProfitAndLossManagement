import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorTheme;

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  bool isPassword = false;
  final Function(String) onChange;
  final TextStyle style;
  final TextEditingController controller;
  InputWithIcon(
      {this.icon,
      this.hint,
      this.isPassword,
      this.onChange,
      this.style,
      this.controller});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: ColorTheme.themeColorScheme.secondary,
              )),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChange,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint),
              style: widget.style,
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final String router;
  PrimaryButton({this.btnText, this.router});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorTheme.primaryColor,
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorTheme.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: ColorTheme.primaryColor, fontSize: 16),
        ),
      ),
    );
  }
}
