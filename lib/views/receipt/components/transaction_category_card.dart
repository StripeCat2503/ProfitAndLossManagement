import 'package:flutter/material.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/themes/color_scheme.dart';

class TransactionCategoryCard extends StatelessWidget {
  const TransactionCategoryCard(
      {Key key, @required this.transactionCategory, this.onSelected})
      : super(key: key);

  final TransactionCategory transactionCategory;
  final Function onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onSelected,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: primaryLightColor.withOpacity(0.2),
            border: Border.all(color: primaryColor)),
        child: Center(
          child: Text(
            transactionCategory.name,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}