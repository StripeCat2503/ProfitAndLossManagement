import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnL/models/pnl_model.dart';

class TransactionBalanceIndicator extends StatefulWidget {
  double balance = 0;
  Color sideColor;
  String subTitle;
  TransactionBalanceIndicator(
      {Key key, this.balance, this.sideColor, this.subTitle})
      : super(key: key);
  @override
  _TransactionBalanceIndicatorState createState() =>
      _TransactionBalanceIndicatorState();
}

class _TransactionBalanceIndicatorState
    extends State<TransactionBalanceIndicator> {
  @override
  void initState() {
    super.initState();
    setState(() {
      balance = widget.balance.toString();
    });
  }

  String balance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 50,
          color: widget.sideColor,
        ),
        SizedBox(
          width: 5.0,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 26),
            children: [
              TextSpan(
                text: 'đ',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: this.balance,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              TextSpan(
                text: '\n${widget.subTitle}',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }
}
