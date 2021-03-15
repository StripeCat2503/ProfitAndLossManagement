import 'package:flutter/material.dart';
import 'package:pnL/chart_data/transaction_chart_data.dart';
import 'package:pnL/enums/transaction_type.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/models/transaction_pnl_report_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/charts/transaction_horizontal_bar_chart.dart';
import 'package:pnL/views/profit_and_loss_details/profit_and_loss_details_screen.dart';

class ProfitAndLossCard extends StatefulWidget {
  final Size size;
  ProfitAndLossViewModel profitAndLoss;
  ProfitAndLossCard({Key key, this.size, this.profitAndLoss}) : super(key: key);
  @override
  _ProfitAndLossCardState createState() => _ProfitAndLossCardState();
}

class _ProfitAndLossCardState extends State<ProfitAndLossCard> {
  double _expense = 0;
  double _revenue = 0;
  DateTime _startDate = DateTime.now();
  DateTime _closeDate = DateTime.now();
  // Fake data for demo purpose
  List<TransactionPnLReportModel> _transactions = [
    TransactionPnLReportModel(
        name: 'Chi phí điện',
        balance: 500000,
        transactionType: TransactionTypeEnum.Expenses),
    TransactionPnLReportModel(
        name: 'Chi phí nước',
        balance: 350000,
        transactionType: TransactionTypeEnum.Expenses),
    TransactionPnLReportModel(
        name: 'Chi phí sửa chữa',
        balance: 1250000,
        transactionType: TransactionTypeEnum.Expenses),
    TransactionPnLReportModel(
        name: 'Doanh thu bán hàng',
        balance: 8000000,
        transactionType: TransactionTypeEnum.Revenues),
    TransactionPnLReportModel(
        name: 'Doanh thu cung cấp dịch vụ',
        balance: 4560000,
        transactionType: TransactionTypeEnum.Revenues),
    TransactionPnLReportModel(
        name: 'Chi phí nhậu nhẹt',
        balance: 5000000,
        transactionType: TransactionTypeEnum.Expenses),
    TransactionPnLReportModel(
        name: 'Chi phí khấu hao',
        balance: 1100000,
        transactionType: TransactionTypeEnum.Expenses),
  ];
  @override
  void initState() {
    super.initState();
    if (widget.profitAndLoss != null) {
      setState(() {
        _revenue = widget.profitAndLoss.grossProfit;
        _expense = widget.profitAndLoss.expenses.totalAmount;
        _startDate = widget.profitAndLoss.startedDate;
        _closeDate = widget.profitAndLoss.closedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        // tap to navigate to profit and loss details screen
        onTap: () {
          RouteHelper.route(
              context,
              ProfitAndLossDetailsScreen(
                transactions: _transactions,
                profitAndLoss: widget.profitAndLoss,
                accoutingPeriodId: '',
              ));
        },
        child: Card(
          child: Container(
            width: widget.size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'profit & loss'.toUpperCase(),
                  style: TextStyle(
                    color: greyDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // date time
                Text(
                    '${DatetimeHelper.toDayMonthYearFormatString(_startDate)} - ${DatetimeHelper.toDayMonthYearFormatString(_closeDate)}'),
                // total profit balance
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'đ ${TextHelper.numberWithCommas(widget.profitAndLoss?.netProfit ?? 0)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Profit',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: widget.size.width * 0.9,
                  height: widget.size.height * 0.35,
                  child: TransactionChart(
                    data: [
                      TransactionChartData(
                          transactionType: TransactionTypeEnum.Expenses,
                          balance: _expense),
                      TransactionChartData(
                          transactionType: TransactionTypeEnum.Revenues,
                          balance: _revenue),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    RouteHelper.route(
                        context,
                        ProfitAndLossDetailsScreen(
                          transactions: _transactions,
                          profitAndLoss: widget.profitAndLoss,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View details',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
