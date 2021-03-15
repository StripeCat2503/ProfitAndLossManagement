import 'package:flutter/material.dart';
import 'package:pnL/enums/transaction_type.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/models/transaction_pnl_report_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/choose_store_screen/choose_store_screen.dart';
import 'package:pnL/views/profit_and_loss_details/components/account_header.dart';
import 'package:pnL/views/profit_and_loss_details/components/choose_store_card.dart';
import 'package:pnL/views/profit_and_loss_details/components/feedback_dialog.dart';
import 'package:pnL/views/profit_and_loss_details/components/transaction_balance_indicator.dart';
import 'package:pnL/views/profit_and_loss_details/components/transaction_row_item.dart';
import 'package:pnL/views/transactions/accounting_period_transaction_list_screen.dart';

class ProfitAndLossReport extends StatefulWidget {
  ProfitAndLossViewModel profitAndLoss;
  List<TransactionPnLReportModel> transactions;
  ProfitAndLossReport({Key key, this.transactions, this.profitAndLoss})
      : super(key: key);
  @override
  _ProfitAndLossReportState createState() => _ProfitAndLossReportState();
}

class _ProfitAndLossReportState extends State<ProfitAndLossReport> {
  DateTime _startDate;
  DateTime _closeDate;
  List<TransactionPnLReportModel> _expenseTrans = [];
  List<TransactionPnLReportModel> _revenueTrans = [];
  double _grossProfit = 0;
  double _totalExpense = 0;
  double _totalRevenue = 0;
  double _netIncome = 0;
  @override
  void initState() {
    super.initState();
    if (widget.profitAndLoss != null) {
      setState(() {
        _startDate = widget.profitAndLoss.startedDate;
        _closeDate = widget.profitAndLoss.closedDate;
        _grossProfit = widget.profitAndLoss.grossProfit;
        _totalExpense = widget.profitAndLoss.expenses.totalAmount;
        _netIncome = widget.profitAndLoss.netProfit;
      });
    }
    // _transaction.totalBalance
  }

  List<TransactionPnLReportModel> transactions;

  @override
  Widget build(BuildContext context) {
    // if (this.transactions != null) {
    //   // split transaction list into 2 sub list, expense list and revenue list
    //   _expenseTrans = this
    //       .transactions
    //       .where((element) =>
    //           element.transactionType == TransactionTypeEnum.Expenses)
    //       .toList();
    //   _revenueTrans = this
    //       .transactions
    //       .where((element) =>
    //           element.transactionType == TransactionTypeEnum.Revenues)
    //       .toList();

    //   // calculate total expense
    //   _expenseTrans.forEach((element) {
    //     _totalExpense += element.balance;
    //   });

    //   // calculate total revenue
    //   _revenueTrans.forEach((element) {
    //     _totalRevenue += element.balance;
    //   });

    //   // calculate total gross profit
    //   // gross profit = total expenses + total revenue
    //   _grossProfit = _totalRevenue + _totalExpense;

    //   // calculate net income
    //   _netIncome = _totalRevenue - _totalExpense;
    // }
    if (widget.profitAndLoss == null) {
      return Column(children: [
        // choose store section
        ChooseStoreCard(
          onPressed: () {
            // navigate to choose store screen
            RouteHelper.route(context, ChooseStoreScreen());
          },
        ),
      ]);
    }
    return Column(
      children: [
        // choose store section
        ChooseStoreCard(
          onPressed: () {
            // navigate to choose store screen
            RouteHelper.route(context, ChooseStoreScreen());
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  // overview section
                  Column(
                    children: [
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
                                  balance: _grossProfit,
                                  subTitle: 'Income',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // expense balance
                                TransactionBalanceIndicator(
                                  sideColor: Colors.blue,
                                  balance: _totalExpense,
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
                                  TextHelper.toReadableHumanNumber(
                                      _netIncome, true),
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // view transaction list of specific accounting period
                      InkWell(
                        onTap: () {
                          RouteHelper.route(
                              context, AccountingPeriodTransactionListScreen());
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View transactions',
                                style: TextStyle(
                                  color: primaryLightColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // view transaction details

                  // income section
                  AccountHeader(
                    title: widget.profitAndLoss.incomes.title == null
                        ? ''
                        : widget.profitAndLoss.incomes.title,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      children: List.generate(
                          widget.profitAndLoss?.incomes?.listCategory?.length ??
                              0, (index) {
                        var pnlItem =
                            widget.profitAndLoss.incomes.listCategory[index];
                        return TransactionRowItem(
                          name: pnlItem.name,
                          balance: pnlItem.balance,
                        );
                      }),
                    ),
                  ),

                  // total income
                  buildTotalBalanceRow(
                      widget.profitAndLoss.incomes.endTitle == null
                          ? ''
                          : widget.profitAndLoss.incomes.endTitle,
                      widget.profitAndLoss.incomes.totalAmount),

                  // gross profit section
                  AccountHeader(
                    title: widget.profitAndLoss.costOfGoodsSold.title == null
                        ? ''
                        : widget.profitAndLoss.costOfGoodsSold.title,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      children: List.generate(
                          widget.profitAndLoss.costOfGoodsSold.listCategory
                              .length, (index) {
                        var pnlItem = widget
                            .profitAndLoss.costOfGoodsSold.listCategory[index];
                        return TransactionRowItem(
                          name: pnlItem.name,
                          balance: pnlItem.balance,
                        );
                      }),
                    ),
                  ),

                  // total income
                  buildTotalBalanceRow(
                      widget.profitAndLoss.costOfGoodsSold.endTitle == null
                          ? ''
                          : widget.profitAndLoss.costOfGoodsSold.endTitle,
                      widget.profitAndLoss.costOfGoodsSold.totalAmount),

                  // expenses section
                  AccountHeader(
                    title: widget.profitAndLoss.expenses.title == null
                        ? ''
                        : widget.profitAndLoss.expenses.title,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      children: List.generate(
                          widget.profitAndLoss.expenses.listCategory.length,
                          (index) {
                        var pnlItem =
                            widget.profitAndLoss.expenses.listCategory[index];
                        return TransactionRowItem(
                          name: pnlItem.name,
                          balance: pnlItem.balance,
                        );
                      }),
                    ),
                  ),

                  // total income
                  buildTotalBalanceRow(
                      widget.profitAndLoss.expenses.endTitle == null
                          ? ''
                          : widget.profitAndLoss.expenses.endTitle,
                      widget.profitAndLoss.expenses.totalAmount),

                  // net income section
                  AccountHeader(
                    title: 'Net Income',
                  ),
                  buildTotalBalanceRow(
                      'Net Income', widget.profitAndLoss.netProfit),
                  // approve / reject section
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          // approve button
                          child: RaisedButton(
                            color: primaryColor,
                            onPressed: () {
                              // handle approve action of investor
                            },
                            child: Text(
                              'Approve',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          // reject button
                          child: RaisedButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              // handle reject action of investor
                              // show dialog to send feedback
                              showDialog(
                                context: context,
                                builder: (context) => FeedbackDialog(),
                              );
                            },
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding buildTotalBalanceRow(String account, double balance) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(
            account,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Spacer(),
          Text(
            TextHelper.toReadableHumanNumber(balance, true),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
