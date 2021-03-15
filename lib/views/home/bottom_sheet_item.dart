import 'package:flutter/material.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;

class BottomSheetItem extends StatefulWidget {
  String title;
  IconData icon;
  Function onTap;

  BottomSheetItem({this.title, this.icon, this.onTap});

  @override
  _BottomSheetItemState createState() => _BottomSheetItemState();
}

class _BottomSheetItemState extends State<BottomSheetItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      trailing: Icon(
        widget.icon,
        color: ColorScheme.primaryColor
      ),
      onTap: widget.onTap,
    );
  }
}
