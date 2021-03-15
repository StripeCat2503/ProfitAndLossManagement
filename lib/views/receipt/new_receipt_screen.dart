import 'package:flutter/material.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;
import 'package:pnL/views/receipt/new_expense_receipt_screen.dart';
import 'package:pnL/views/receipt/new_income_receipt_screen.dart';

class NewReceiptScreen extends StatefulWidget {
  @override
  _NewReceiptScreenState createState() => _NewReceiptScreenState();
}

class _NewReceiptScreenState extends State<NewReceiptScreen> {
  bool _isIncomeSelected = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.primaryColor,
        title: Text(
          'new receipt'.toUpperCase(),
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(_isIncomeSelected
                ? 'Income'.toUpperCase()
                : 'expense'.toUpperCase()),
          ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // choose income or expense
              buildChooseIncomeOrExpenseWidget(),
              Container(
                child: _isIncomeSelected
                    ? NewIncomeReceiptScreen()
                    : NewExpenseReceiptScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildChooseIncomeOrExpenseWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: FlatButton(
                color:
                    _isIncomeSelected ? ColorScheme.primaryColor : Colors.white,
                child: Text(
                  'Income'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _isIncomeSelected
                        ? Colors.white
                        : ColorScheme.primaryColor,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: ColorScheme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  setState(() {
                    _isIncomeSelected = true;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: FlatButton(
                color: !_isIncomeSelected
                    ? ColorScheme.primaryColor
                    : Colors.white,
                child: Text(
                  'Expense'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: !_isIncomeSelected
                        ? Colors.white
                        : ColorScheme.primaryColor,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: ColorScheme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  setState(() {
                    _isIncomeSelected = false;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
