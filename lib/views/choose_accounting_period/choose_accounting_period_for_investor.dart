import 'package:flutter/material.dart';
import 'package:pnL/blocs/accounting_period_bloc.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/accounting_period_details/accounting_period_details.dart';
import 'package:pnL/views/choose_store_screen/choose_store_screen.dart';
import 'package:pnL/views/components/go_back_button.dart';
import 'package:pnL/views/components/search_bar.dart';
import 'package:pnL/views/dashboard/profit_and_loss_card.dart';
import 'package:pnL/views/profit_and_loss_details/profit_and_loss_details_screen.dart';

class ChooseAccountingPeriodForInvestorScreen extends StatefulWidget {
  Store store;
  ChooseAccountingPeriodForInvestorScreen({this.store});

  @override
  _ChooseAccountingPeriodForInvestorScreenState createState() =>
      _ChooseAccountingPeriodForInvestorScreenState();
}

class _ChooseAccountingPeriodForInvestorScreenState
    extends State<ChooseAccountingPeriodForInvestorScreen> {
  bool _isSearchBarShown = false;
  FocusNode _focusNode = FocusNode();
  String _currentSelectedAccountingPeriod;
  AccountingPeriodBloc bloc = new AccountingPeriodBloc();
  // Fake accounting period data for demo purpose
  List<AccountingPeriod> _accountingPeriods = [
    AccountingPeriod(
      id: '1',
      title: 'Kỳ kế toán đầu năm 2019',
      startDate: DateTime.parse('2019-01-01'),
      closeDate: DateTime.parse('2019-06-30'),
      status: 1,
    ),
    AccountingPeriod(
      id: '2',
      title: 'Kỳ kế toán cuối năm 2019',
      startDate: DateTime.parse('2019-07-01'),
      closeDate: DateTime.parse('2019-12-31'),
      status: 1,
    ),
    AccountingPeriod(
      id: '3',
      title: 'Kỳ kế toán đầu năm 2020',
      startDate: DateTime.parse('2020-01-01'),
      closeDate: DateTime.parse('2020-06-30'),
      status: 1,
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.loadAccountingPeriod();
    _currentSelectedAccountingPeriod = _accountingPeriods[0].id;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  Widget _buildAccountingPeriodCard(AccountingPeriod accountingPeriod) {
    return InkWell(
      onTap: () {
        // navigate to profit and loss screen
        RouteHelper.route(
            context,
            ProfitAndLossDetailsScreen(
              accoutingPeriodId: accountingPeriod.id,
            ));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          margin: EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            children: [
              Icon(
                Icons.pending_actions,
                color: primaryColor,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountingPeriod.title,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    DatetimeHelper.toDayMonthYearFormatString(
                            accountingPeriod.startDate) +
                        ' - ' +
                        DatetimeHelper.toDayMonthYearFormatString(
                            accountingPeriod.closeDate),
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_right,
                color: primaryColor,
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: !_isSearchBarShown
            ? Text(('chọn kỳ kế toán'.toUpperCase()))
            : SearchBar(
                focusNode: _focusNode,
                hint: 'Tìm kỳ kế toán...',
                onSearchDataChange: (searchData) {
                  // handle search action here!
                },
              ),
        actions: [
          IconButton(
              icon: Icon(
                _isSearchBarShown ? Icons.clear : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isSearchBarShown = !_isSearchBarShown;
                });
              })
        ],
        leading: GoBackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: StreamBuilder(
            stream: bloc.lstAccoutingPeriod,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AccountingPeriod> listAcc = snapshot.data;
                if (listAcc == null) listAcc = new List<AccountingPeriod>();
                return Column(
                  children: [
                    // list of accounting periods of store
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var period = listAcc[index];
                          return _buildAccountingPeriodCard(period);
                        },
                        itemCount: listAcc.length,
                      ),
                    )
                  ],
                );
              }
              return Column(
                children: [],
              );
            }),
      ),
    );
  }
}
