import 'package:flutter/material.dart';
import 'package:pnL/chart_data/transaction_chart_data.dart';
import 'package:pnL/enums/transaction_type.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/views/charts/pnl_line_chart.dart';
import 'package:pnL/views/choose_store_screen/choose_store_screen.dart';
import 'package:pnL/views/profit_and_loss_details/components/choose_store_card.dart';
import 'package:pnL/views/profit_and_loss_details/components/transaction_balance_indicator.dart';

class ProfitAndLossGraph extends StatefulWidget {
  ProfitAndLossViewModel profitAndLoss;
  ProfitAndLossGraph({Key key, this.profitAndLoss}) : super(key: key);
  @override
  _ProfitAndLossGraphState createState() => _ProfitAndLossGraphState();
}

class _ProfitAndLossGraphState extends State<ProfitAndLossGraph> {
  double _expense = 0;
  double _revenue = 0;

  @override
  void initState() {
    super.initState();
    if (widget.profitAndLoss != null) {
      setState(() {
        _revenue = widget.profitAndLoss.grossProfit;
        _expense = widget.profitAndLoss.expenses.totalAmount;
      });
    }
    // _transaction.totalBalance
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChooseStoreCard(
          onPressed: () {
            RouteHelper.route(context, ChooseStoreScreen());
          },
        ),
        // overview section
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.white,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // income balance
                  TransactionBalanceIndicator(
                    sideColor: Colors.green,
                    balance: _revenue,
                    subTitle: 'Income',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // expense balance
                  TransactionBalanceIndicator(
                    sideColor: Colors.blue,
                    balance: _expense,
                    subTitle: 'Expenses',
                  )
                ],
              ),
              Spacer(),
              // total net income
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('net income'.toUpperCase()),
                  Text(
                    'đ ${TextHelper.numberWithCommas(widget.profitAndLoss?.netProfit ?? 0)}',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              )
            ],
          ),
        ),

        // chart section
        Expanded(
          child: Container(
            color: Colors.white,
            child: PnlLineChart(
              data: [
                TransactionChartData(
                  transactionType: TransactionTypeEnum.Expenses,
                  balance: 100000,
                  createdDate: DateTime(2020, 1, 1),
                ),
                TransactionChartData(
                  transactionType: TransactionTypeEnum.Expenses,
                  balance: 300000,
                  createdDate: DateTime(2020, 5, 1),
                ),
                TransactionChartData(
                  transactionType: TransactionTypeEnum.Expenses,
                  balance: 900000,
                  createdDate: DateTime(2020, 6, 5),
                ),
                TransactionChartData(
                  transactionType: TransactionTypeEnum.Revenues,
                  balance: 2960000,
                  createdDate: DateTime(2020, 7, 8),
                ),
                TransactionChartData(
                  transactionType: TransactionTypeEnum.Revenues,
                  balance: 8560000,
                  createdDate: DateTime(2020, 1, 1),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
