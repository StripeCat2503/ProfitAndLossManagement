import 'package:flutter/material.dart';
import 'package:pnL/enums/popup_menu_enum.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/accounting_period_details/accounting_period_details.dart';
import 'package:pnL/views/components/go_back_button.dart';
import 'package:pnL/views/components/search_bar.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class AccountingPeriodFilterScreen extends StatefulWidget {
  @override
  _AccountingPeriodFilterScreenState createState() =>
      _AccountingPeriodFilterScreenState();
}

class _AccountingPeriodFilterScreenState
    extends State<AccountingPeriodFilterScreen> {
  bool _isSearchBarShown = false;
  FocusNode _focusNode = FocusNode();
  Map<String, bool> _accountingPeriodChecks = {};

  AccountingPeriodFilterPopupMenuItem _accountingPeriodFilter;

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
    _accountingPeriods.forEach((element) {
      _accountingPeriodChecks[element.id] = false;
    });

    _accountingPeriodFilter = AccountingPeriodFilterPopupMenuItem.none;
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
        setState(() {
          _accountingPeriodChecks[accountingPeriod.id] =
              !_accountingPeriodChecks[accountingPeriod.id];
        });
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
              Checkbox(
                value: _accountingPeriodChecks[accountingPeriod.id],
                onChanged: (value) {
                  setState(() {
                    _accountingPeriodChecks[accountingPeriod.id] = value;
                  });
                },
                activeColor: primaryColor,
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
            ? Text(('kỳ kế toán'.toUpperCase()))
            : SearchBar(
                focusNode: _focusNode,
                hint: 'Tìm kỳ kế toán...',
                onSearchDataChange: (searchData) {
                  // handle search action here!
                },
              ),
        actions: [
          // button to show search bar
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
          // filter accounting period by picking date range
          PopupMenuButton(
            initialValue: _accountingPeriodFilter,
            onSelected: (value) async {
              if (value ==
                  AccountingPeriodFilterPopupMenuItem
                      .specificAccountingPeriod) {
                // show date time picker to pick a specific date range for accounting period
                DateTime firstDate = DateTime(1999, 3, 25);
                DateTime lastDate = DateTime.now();
                final List<DateTime> dateRange =
                    await DateRangePicker.showDatePicker(
                        context: context,
                        initialFirstDate:
                            DateTime.now().subtract(Duration(days: 3)),
                        initialLastDate:
                            DateTime.now().subtract(Duration(days: 1)),
                        firstDate: firstDate,
                        lastDate: lastDate);

                if (dateRange != null && dateRange.length == 2) {
                  print(dateRange);
                  setState(() {
                    _accountingPeriodFilter = value;
                  });
                }
              } else {
                setState(() {
                  _accountingPeriodFilter = value;
                });
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: AccountingPeriodFilterPopupMenuItem
                      .currentAccountingPeriod,
                  child: Row(
                    children: [
                      Visibility(
                        child: Icon(
                          Icons.check,
                          color: primaryColor,
                        ),
                        visible: _accountingPeriodFilter ==
                            AccountingPeriodFilterPopupMenuItem
                                .currentAccountingPeriod,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Kỳ hiện tại'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: AccountingPeriodFilterPopupMenuItem
                      .previousAccountingPeriod,
                  child: Row(
                    children: [
                      Visibility(
                        child: Icon(
                          Icons.check,
                          color: primaryColor,
                        ),
                        visible: _accountingPeriodFilter ==
                            AccountingPeriodFilterPopupMenuItem
                                .previousAccountingPeriod,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Kỳ trước'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: AccountingPeriodFilterPopupMenuItem
                      .specificAccountingPeriod,
                  child: Row(
                    children: [
                      Visibility(
                        child: Icon(
                          Icons.check,
                          color: primaryColor,
                        ),
                        visible: _accountingPeriodFilter ==
                            AccountingPeriodFilterPopupMenuItem
                                .specificAccountingPeriod,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Kỳ cụ thể'),
                    ],
                  ),
                ),
              ];
            },
            icon: Icon(Icons.date_range),
          )
        ],
        leading: GoBackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
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
