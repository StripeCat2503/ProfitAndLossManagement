import 'package:flutter/material.dart';
import 'package:pnL/blocs/dashboard_bloc.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/models/transaction_pnl_report_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/choose_accounting_period/accounting_period_filter.dart';
import 'package:pnL/views/choose_accounting_period/choose_accounting_period_for_investor.dart';
import 'package:pnL/views/dashboard/dashboard_screen.dart';
import 'package:pnL/views/profit_and_loss_details/profit_and_loss_graph.dart';
import 'package:pnL/views/profit_and_loss_details/profit_and_loss_report.dart';

class ProfitAndLossDetailsScreen extends StatefulWidget {
  ProfitAndLossViewModel profitAndLoss;
  String accoutingPeriodId = '';
  List<TransactionPnLReportModel> transactions;
  ProfitAndLossDetailsScreen(
      {Key key, this.transactions, this.profitAndLoss, this.accoutingPeriodId})
      : super(key: key);
  @override
  _ProfitAndLossDetailsScreenState createState() =>
      _ProfitAndLossDetailsScreenState();
}

class _ProfitAndLossDetailsScreenState
    extends State<ProfitAndLossDetailsScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _closeDate = DateTime.now();
  DashboardBloc bloc = new DashboardBloc();
  @override
  void initState() {
    super.initState();
    if (widget.profitAndLoss != null) {
      setState(() {
        _startDate = widget.profitAndLoss.startedDate;
        _closeDate = widget.profitAndLoss.closedDate;
      });
    }
    if (!(widget.accoutingPeriodId?.isEmpty ?? true)) {
      bloc.initDashboard(widget.accoutingPeriodId);
    }
    // _transaction.totalBalance
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: StreamBuilder(
          stream: bloc.profitAndLoss,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              widget.profitAndLoss = snapshot.data;
              _startDate = widget.profitAndLoss.startedDate;
              _closeDate = widget.profitAndLoss.closedDate;
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profit and Loss'),
                    Text(
                      '${DatetimeHelper.toDayMonthYearFormatString(_startDate)} - ${DatetimeHelper.toDayMonthYearFormatString(_closeDate)}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                actions: [
                  // button to filter accounting period
                  IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        RouteHelper.route(
                            context, AccountingPeriodFilterScreen());
                      })
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'graph'.toUpperCase(),
                    ),
                    Tab(
                      text: 'report'.toUpperCase(),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ProfitAndLossGraph(
                    profitAndLoss: widget.profitAndLoss,
                  ),
                  ProfitAndLossReport(
                    transactions: widget.transactions,
                    profitAndLoss: widget.profitAndLoss,
                  )
                ],
              ),
            );
          }),
    );
  }
}
