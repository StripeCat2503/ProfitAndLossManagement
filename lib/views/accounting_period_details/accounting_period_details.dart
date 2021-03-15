import 'package:flutter/material.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/transaction_type.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/choose_store_screen/choose_store_screen.dart';
import 'package:pnL/views/components/go_back_button.dart';
import 'package:pnL/views/components/search_bar.dart';
import 'package:pnL/views/transactions/transaction_detail_screen.dart';

class AccountingPeriodDetailScreen extends StatefulWidget {
  Store store;
  AccountingPeriodDetailScreen({this.store});

  @override
  _AccountingPeriodDetailScreenState createState() =>
      _AccountingPeriodDetailScreenState();
}

class _AccountingPeriodDetailScreenState
    extends State<AccountingPeriodDetailScreen> {
  bool _isSearchBarShown = false;
  FocusNode _focusNode = FocusNode();
  String _currentSelectedAccountingPeriod;

  // Fake accounting period data for demo purpose
  List<TransactionType> _accountingPeriods = [
    TransactionType(
      id: '1',
      name: 'Transaction A',
      createdDate: DateTime.parse('2019-01-01'),
      modifiedDate: DateTime.parse('2019-06-30'),
    ),
    TransactionType(
      id: '2',
      name: 'Transaction B',
      createdDate: DateTime.parse('2019-01-01'),
      modifiedDate: DateTime.parse('2019-06-30'),
    ),
    TransactionType(
      id: '3',
      name: 'Transaction C',
      createdDate: DateTime.parse('2019-01-01'),
      modifiedDate: DateTime.parse('2019-06-30'),
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentSelectedAccountingPeriod = _accountingPeriods[0].id;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  Widget _buildAccountingPeriodCard(TransactionType accountingPeriod) {
    return InkWell(
      onTap: () {
        //RouteHelper.route(context, TransactionDetailScreen());
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
                    accountingPeriod.name,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Date create: ' +
                        DatetimeHelper.toDayMonthYearFormatString(
                            accountingPeriod.createdDate),
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  Text(
                    'Date modified: ' +
                        DatetimeHelper.toDayMonthYearFormatString(
                            accountingPeriod.modifiedDate),
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

  Widget _listOfTransactions() {
    return Column(
        children: List.generate(this._accountingPeriods.length, (index) {
      var period = _accountingPeriods[index];
      return _buildAccountingPeriodCard(period);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: !_isSearchBarShown
            ? Text('PERIOD DETAILS')
            : SearchBar(
                focusNode: _focusNode,
                hint: 'Enter a transaction...',
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
              }),
          IconButton(
              icon: Icon(
                Icons.filter_alt,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseStoreScreen(),
                    ));
              })
        ],
        leading: GoBackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(children: [Container(child: _listOfTransactions())]),
        ),
      ),
    );
  }
}
