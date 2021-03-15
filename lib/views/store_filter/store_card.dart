import 'package:flutter/material.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;

class StoreCard extends StatefulWidget {
  Store store;
  Function onSelected;

  StoreCard({this.store, this.onSelected});

  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5.0),
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: CheckboxListTile(
          value: false,
          activeColor: ColorScheme.primaryLightColor,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.store.name),
          onChanged: widget.onSelected,
        ));
  }
}
