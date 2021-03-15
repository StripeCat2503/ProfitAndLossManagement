import 'package:flutter/material.dart';
import 'package:pnL/blocs/receipt_bloc.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/search_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/transactions/transaction_detail_screen.dart';

class AccountingPeriodTransactionListScreen extends StatefulWidget {
  String accountingPeriodId;

  AccountingPeriodTransactionListScreen({this.accountingPeriodId});

  @override
  _AccountingPeriodTransactionListScreenState createState() =>
      _AccountingPeriodTransactionListScreenState();
}

class _AccountingPeriodTransactionListScreenState
    extends State<AccountingPeriodTransactionListScreen> {
  ReceiptBloc bloc = ReceiptBloc();

  SearchModel search;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search = SearchModel(
      status: 0,
      page: 0,
      pageSize: 20,
    );
    bloc.loadTransaction(search);
  }

  @override
  Widget build(BuildContext context) {
    // get the width and height of deivce screen
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('transaction list'.toUpperCase()),
            Text(
              '01/01/2020 - 01/06/2020',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                StreamBuilder(
                  stream: bloc.lstReceipts,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: size.height * 0.5,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryLightColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey[100]),
                            ),
                          ));
                    }
                    if (snapshot.hasError) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      );
                    }
                    List<Transaction> listTransaction = snapshot.data;
                    List<Widget> children = [];
                    children.add(
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 20,
                          right: 20,
                        ),
                        child: Text(
                          'Transaction List',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                      ),
                    );
                    listTransaction.forEach((transaction) {
                      children.add(_buildTransaction(transaction));
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransaction(Transaction transaction) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: primaryColor.withOpacity(0.2),
              offset: Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 1),
        ],
      ),
      child: FlatButton(
        onPressed: () => {},
        //  Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           TransactionDetailScreen(transactionId: transaction.id),
        //     )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset('assets/toshi-lySzv_cqxH8-unsplash.jpg'),
                      SizedBox(
                        height: 5,
                      ),
                      // transaction type + transaction code
                      Text(
                        (transaction.transactionCategory.name.toString())
                            .toUpperCase(),
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // supplier name
                      Row(
                        children: [
                          Icon(Icons.supervisor_account),
                          SizedBox(
                            width: 5.0,
                          ),
                          // Text(
                          //   transaction.supplier?.name == null
                          //       ? '(Unknown Supplier)'
                          //       : 'Supplier: ' + transaction.supplier.name,
                          //   style: TextStyle(
                          //     color: Colors.grey[600],
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            TextHelper.numberWithCommas(transaction.balance) +
                                ' VND',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
              child: FlatButton(
                onPressed: () =>
                    print('You have pressed event_available button'),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
