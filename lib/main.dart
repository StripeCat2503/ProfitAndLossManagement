import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorTheme;
import 'package:pnL/views/choose_accounting_period/choose_accounting_period_for_investor.dart';
import 'package:pnL/views/dashboard/dashboard_screen.dart';

import 'package:pnL/views/home/menu_bottom_sheet.dart';
import 'package:pnL/views/login.dart';
import 'package:pnL/views/receipt/new_receipt_screen.dart';
import 'package:pnL/views/receipt/receipt_details_screen.dart';
import 'package:pnL/views/receipt/receipt_list_screen.dart';
import 'package:pnL/views/store_filter/store_filter.dart';
import 'package:pnL/views/transactions/transaction_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildShrineTheme(),
      // home: MyHomePage(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: LoginPage(),
        ),
//    home: Home(),
//    home: CalendarDetails(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  TokenLoginResponse userlogin = new TokenLoginResponse();
  MyHomePage({Key key, this.title, this.userlogin}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _appbarTitle = 'home';
  List<Widget> _screens = [
    DashboardScreen(),
    ReceiptListScreen(),
    ChooseAccountingPeriodForInvestorScreen(),
  ];
  int _currentScreenIndex = 0;

  TokenLoginResponse token;
  @override
  void initState() {
    token = widget.userlogin;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // home button
              IconButton(
                  icon: Icon(
                    Icons.home,
                    color: ColorTheme.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 0;
                      _appbarTitle = 'home';
                    });
                  }),

              // receipt list button
              IconButton(
                  icon:
                      Icon(Icons.receipt_long, color: ColorTheme.primaryColor),
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 1;
                      _appbarTitle = 'receipts';
                    });
                  }),

              // pnl report button
              IconButton(
                  icon: Icon(Icons.article, color: ColorTheme.primaryColor),
                  onPressed: () {
                    // navigate to choose accounting period screen
                    setState(() {
                      _currentScreenIndex = 2;
                      _appbarTitle = 'accounting periods';
                    });
                  }),

              // settings button
              IconButton(
                  icon: Icon(Icons.settings, color: ColorTheme.primaryColor),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return MenuBottomSheet();
                      },
                    );
                  }),
            ],
          ),
        ),
        floatingActionButton: _buildFloat(context, token),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: Text(_appbarTitle.toUpperCase()),
          actions: [],
          backgroundColor: ColorTheme.primaryColor,
        ),
        body: _screens[_currentScreenIndex]);
  }
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorTheme.themeColorScheme,
    textTheme: _buildShrineTextTheme(base.textTheme),
  );
}

Widget _buildFloat(BuildContext context, TokenLoginResponse token) {
  if (token != null) {
    if (token.role.toLowerCase() != 'investor') {
      return FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: ColorTheme.primaryLightColor,
          onPressed: () {
            // navigate to create receipt screen
            RouteHelper.route(context, NewReceiptScreen());
          });
    }
  }
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: ColorTheme.defaultLetterSpacing,
        ),
        button: base.button.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: ColorTheme.defaultLetterSpacing,
            color: ColorTheme.primaryColor),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: ColorTheme.primaryColor,
        bodyColor: ColorTheme.blueGray900,
      );
}
