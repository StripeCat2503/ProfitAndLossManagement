import 'package:flutter/material.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/components/go_back_button.dart';
import 'package:pnL/views/components/search_bar.dart';

class ChooseAccountingPeriodForStaffScreen extends StatefulWidget {
  Store store;
  ChooseAccountingPeriodForStaffScreen({this.store});

  @override
  _ChooseAccountingPeriodForStaffScreenState createState() =>
      _ChooseAccountingPeriodForStaffScreenState();
}

class _ChooseAccountingPeriodForStaffScreenState
    extends State<ChooseAccountingPeriodForStaffScreen> {
  bool _isSearchBarShown = false;
  FocusNode _focusNode = FocusNode();
  String _currentSelectedAccountingPeriod;

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
    _currentSelectedAccountingPeriod = _accountingPeriods[0].id;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  Widget _buildAccountingPeriodCard(AccountingPeriod accountingPeriod) {
    return Container(
        margin: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: RadioListTile(
          onChanged: (value) {
            setState(() {
              _currentSelectedAccountingPeriod = value;
            });
          },
          value: accountingPeriod.id,
          groupValue: _currentSelectedAccountingPeriod,
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: primaryColor,
          title: Text(
            accountingPeriod.title,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            DatetimeHelper.toDayMonthYearFormatString(
                    accountingPeriod.startDate) +
                ' - ' +
                DatetimeHelper.toDayMonthYearFormatString(
                    accountingPeriod.closeDate),
            style: TextStyle(color: Colors.grey[500]),
          ),
        ));
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
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // name of the store
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store,
                    color: primaryColor,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'cửa hàng 711'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )
                ],
              ),
            ),
            // list of accounting periods of store
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var period = _accountingPeriods[index];
                  return _buildAccountingPeriodCard(period);
                },
                itemCount: _accountingPeriods.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
