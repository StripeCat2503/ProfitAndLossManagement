import 'package:flutter/material.dart';
import 'package:pnL/resources/currency_number_formatter.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;

class CustomAmountInput extends StatefulWidget {
  String label;
  Function onChanged;
  Function onSubmited;

  CustomAmountInput({this.label, this.onChanged, this.onSubmited});

  @override
  _CustomAmountInputState createState() => _CustomAmountInputState();
}

class _CustomAmountInputState extends State<CustomAmountInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: TextField(
                inputFormatters: [CurrencyNumberFormatter()],
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmited,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorScheme.primaryLightColor)),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    focusColor: ColorScheme.primaryColor,
                    suffixIcon: Icon(
                      Icons.local_atm,
                      color: ColorScheme.primaryColor,
                    ),
                    suffix: Text(
                      'VND',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
