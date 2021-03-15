import 'package:flutter/material.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/transaction_pnl_report_model.dart';

class TransactionRowItem extends StatefulWidget {
  String name;
  double balance;
  TransactionRowItem({Key key, this.name, this.balance}) : super(key: key);
  @override
  _TransactionRowItemState createState() => _TransactionRowItemState();
}

class _TransactionRowItemState extends State<TransactionRowItem> {
  String _name;
  double _balance = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      _name = widget.name;
      _balance = widget.balance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        children: [
          Text(_name),
          Spacer(),
          Text(TextHelper.toReadableHumanNumber(_balance, false))
        ],
      ),
    );
  }
}
