import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pnL/blocs/receipt_bloc.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/receipt/components/receipt_card.dart';
import 'package:pnL/views/transactions/transaction_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/search_model.dart';
import 'dart:convert' as json;

class ReceiptListScreen extends StatefulWidget {
  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  TextEditingController _txtSearchController;
  ReceiptNewRepository _receiptNewRepository;
  ReceiptBloc bloc = ReceiptBloc();
  SearchModel search;

  // fake receipt data for demo purpose
  List<ReceiptNew> _receipts = [
    ReceiptNew(
        code: 'RE-001',
        name: 'receipt 1',
        createdDate: DateTime(2020, 1, 5),
        status: 0),
    ReceiptNew(
        code: 'RE-002',
        name: 'receipt 2',
        createdDate: DateTime(2020, 1, 6),
        status: 1),
    ReceiptNew(
        code: 'RE-003',
        name: 'receipt 3',
        createdDate: DateTime(2020, 1, 7),
        status: 0),
    ReceiptNew(
        code: 'RE-004',
        name: 'receipt 4',
        createdDate: DateTime(2020, 1, 8),
        status: 1),
    ReceiptNew(
        code: 'RE-005',
        name: 'receipt 5',
        createdDate: DateTime(2020, 1, 9),
        status: 1),
    ReceiptNew(
        code: 'RE-006',
        name: 'receipt 6',
        createdDate: DateTime(2020, 1, 10),
        status: 1),
    ReceiptNew(
        code: 'RE-007',
        name: 'receipt 7',
        createdDate: DateTime(2020, 1, 11),
        status: 0),
  ];

  @override
  void initState() {
    super.initState();
    _txtSearchController = TextEditingController();
    _receiptNewRepository = ReceiptNewRepository();
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
        title: Text('receipt list'.toUpperCase()),
      ),
      // body: GestureDetector(
      //   onTap: () {
      //     FocusScope.of(context).unfocus();
      //   },
      //   child: CustomScrollView(
      //     slivers: [
      //       SliverList(
      //         delegate: SliverChildListDelegate([
      //           StreamBuilder(
      //             stream: bloc.lstTransaction,
      //             builder: (context, snapshot) {
      //               if (!snapshot.hasData) {
      //                 return Container(
      //                     height: size.height * 0.5,
      //                     child: Center(
      //                       child: CircularProgressIndicator(
      //                         backgroundColor: primaryLightColor,
      //                         valueColor: AlwaysStoppedAnimation<Color>(
      //                             Colors.grey[100]),
      //                       ),
      //                     ));
      //               } else {
      //                 List<Transaction> listTransaction = snapshot.data;
      //                 List<Widget> children = [];
      //                 children.add(
      //                   Padding(
      //                     padding: const EdgeInsets.only(
      //                       left: 20,
      //                       top: 20,
      //                       right: 20,
      //                     ),
      //                     child: Text(
      //                       'Receipts',
      //                       style: TextStyle(
      //                           fontWeight: FontWeight.w600, fontSize: 16.0),
      //                     ),
      //                   ),
      //                 );
      //                 listTransaction.forEach((transaction) {
      //                   children.add(_buildTransaction(transaction));
      //                 });
      //                 return Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: children,
      //                 );
      //               }
      //             },
      //           ),
      //         ]),
      //       ),
      //     ],
      //   ),
      // ),

      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: bloc.lstReceipts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ReceiptNew> listReceipt = snapshot.data;
                if (listReceipt == null) listReceipt = new List<ReceiptNew>();
                return Column(
                  children: List.generate(listReceipt.length, (index) {
                    var receipt = listReceipt[index];
                    return ReceiptCard(
                      receipt: receipt,
                    );
                  }),
                );
              }
              return Column(children: []);
            }),
      ),
    );
  }
}
