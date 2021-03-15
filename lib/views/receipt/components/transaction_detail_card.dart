import 'package:flutter/material.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/receipt_detail_new_model.dart';
import 'package:pnL/models/transaction_model.dart';

class TransactionDetailCard extends StatelessWidget {
  final Transaction transactionDetail;
  TransactionDetailCard({this.transactionDetail});

  @override
  Widget build(BuildContext context) {
    IconData statusIcon = this.transactionDetail.transactionCategory.isDebit
        ? Icons.north
        : Icons.south;

    Color color = this.transactionDetail.transactionCategory.isDebit
        ? Colors.green
        : Colors.redAccent;
    String sign =
        this.transactionDetail.transactionCategory.isDebit ? '+' : '-';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: color,
            size: 14,
          ),
          SizedBox(
            width: 10,
          ),
          Text(this.transactionDetail.description),
          Spacer(),
          Text(
            sign +
                ' ' +
                TextHelper.numberWithCommasAndCurrency(
                    this.transactionDetail.balance, ""),
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }
}
