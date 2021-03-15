import 'package:flutter/material.dart';
import 'package:pnL/blocs/dashboard_bloc.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/views/dashboard/profit_and_loss_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _accountingPeriodStartDate = DateTime.now();
  DateTime _accountingPeriodEndDate =
      DateTime.now().add(Duration(days: 30 * 2));
  DashboardBloc bloc = new DashboardBloc();
  @override
  void initState() {
    super.initState();
    bloc.initDashboard('');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: StreamBuilder(
          stream: bloc.profitAndLoss,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ProfitAndLossViewModel profitAndLost = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // profit and loss section
                  ProfitAndLossCard(
                    size: size,
                    profitAndLoss: profitAndLost,
                  )
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            );
          }),
    );
  }
}
