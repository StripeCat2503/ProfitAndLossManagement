// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pnL/blocs/receipt_bloc.dart';
// import 'package:pnL/blocs/receipt_detail_bloc.dart';
// import 'package:pnL/helpers/datetime_helper.dart';
// import 'package:pnL/helpers/route_helper.dart';
// import 'package:pnL/helpers/text_helper.dart';
// import 'package:pnL/models/receipt_new_model.dart';
// import 'package:pnL/models/receipt_detail_new_model.dart';
// import 'package:pnL/models/transaction_model.dart';
// import 'package:pnL/models/transaction_type.dart';
// import 'package:pnL/repositories/receipt_new_repository.dart';
// import 'package:pnL/themes/color_scheme.dart' as ColorScheme;
// import 'package:pnL/views/components/go_back_button.dart';
// import 'package:pnL/views/photo_viewer/photo_view_screen.dart';

// class TransactionDetailScreen extends StatefulWidget {
//   String transactionId;
//   TransactionDetailScreen({Key key, this.transactionId}) : super(key: key);
//   @override
//   _TransactionDetailScreenState createState() =>
//       _TransactionDetailScreenState();
// }

// class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
//   TextEditingController _txtSearchController;
//   ReceiptNewRepository _transactionRepository;
//   ReceiptDetailBloc bloc = ReceiptDetailBloc();

// // Fake data for demo purpose
//   // List<Transaction> transactions = [
//   //   Transaction(totalBalance: 70000, name: 'Tiền sữa'),
//   //   Transaction(totalBalance: 1000000, name: 'Tiền ăn nhậu'),
//   //   Transaction(totalBalance: 200000, name: 'Tiền mừng tuổi'),
//   //   Transaction(totalBalance: 20000, name: 'Tiền cafe'),
//   //   Transaction(totalBalance: 8000000, name: 'Tiền mượn của thằng bạn'),
//   //   Transaction(totalBalance: 50000, name: 'Tiền bán rau'),
//   //   Transaction(totalBalance: 4200000000, name: 'Tiền bán nhà'),
//   // ];
//   @override
//   void initState() {
//     super.initState();
//     if (!widget.transactionId.isEmpty) {
//       bloc.initReceipt(widget.transactionId);
//     }
//   }

//   Widget _transactionTitleSection(Transaction transaction) {
//     return Container(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 TextHelper.toReadableHumanNumber(
//                     transaction.totalBalance, true),
//                 style: TextStyle(fontSize: 40, color: Colors.green),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'created date: ${DatetimeHelper.toDayMonthYearFormatString(transaction.createdDate)}'
//                     .toUpperCase(),
//               ),
//             ],
//           ),

//           Spacer(),
//           // type of receipt
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.receipt_long),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     transaction.transactionType.name.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: ColorScheme.primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _paymentMethodSection() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20.0),
//       margin: EdgeInsets.only(top: 5.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.payment),
//               SizedBox(
//                 width: 5.0,
//               ),
//               Text(
//                 'Payment Method',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           // list of payment methods
//           Container(
//             padding: EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: Row(
//               children: [
//                 Text('Master card'),
//                 Spacer(),
//                 Icon(
//                   Icons.payment,
//                   color: ColorScheme.primaryColor,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _transactionDetailCard(
//       String transactionName, double amount, bool isDebit) {
//     Color color = isDebit ? Colors.green : Colors.redAccent;

//     String sign = isDebit ? '+' : '-';

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//       margin: EdgeInsets.only(top: 5.0),
//       decoration: BoxDecoration(
//           color: ColorScheme.themeColorScheme.background,
//           borderRadius: BorderRadius.circular(5.0)),
//       child: Row(
//         children: [
//           Text(transactionName),
//           Spacer(),
//           Text(
//             sign + ' ' + TextHelper.numberWithCommasAndCurrency(amount, ""),
//             style: TextStyle(color: color),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _transactions(List<TransactionDetail> transactionDetails) {
//     // split transaction detail list into 2 sub list based on debit or credit
//     List<TransactionDetail> debitTransactionDetails = transactionDetails
//         .where((element) => element.transactionCategory.isDebit)
//         .toList();

//     List<TransactionDetail> creditTransactionDetails = transactionDetails
//         .where((element) => !element.transactionCategory.isDebit)
//         .toList();

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             children: [
//               Icon(Icons.receipt),
//               SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 'Details',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             ],
//           ),
//         ),
//         // debit details
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Text('Add',
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green)),
//               SizedBox(
//                 width: 10,
//               ),
//               Icon(
//                 Icons.north,
//                 size: 14,
//                 color: Colors.green,
//               )
//             ],
//           ),
//         ),
//         Column(
//             children: debitTransactionDetails.length > 0
//                 ? List.generate(debitTransactionDetails.length, (index) {
//                     var details = debitTransactionDetails[index];
//                     return _transactionDetailCard(
//                         details.transactionCategory.name,
//                         details.balance,
//                         true);
//                   })
//                 : <Widget>[
//                     Center(
//                       child: Text('There\'s no details'),
//                     )
//                   ]),
//         SizedBox(
//           height: 10,
//         ),
//         // credit details
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Text('Less',
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.redAccent)),
//               SizedBox(
//                 width: 10,
//               ),
//               Icon(
//                 Icons.south,
//                 size: 14,
//                 color: Colors.redAccent,
//               )
//             ],
//           ),
//         ),
//         Column(
//             children: creditTransactionDetails.length > 0
//                 ? List.generate(creditTransactionDetails.length, (index) {
//                     var details = creditTransactionDetails[index];
//                     return _transactionDetailCard(
//                         details.transactionCategory.name,
//                         details.balance,
//                         false);
//                   })
//                 : <Widget>[
//                     Center(
//                       child: Text('There\'s no details'),
//                     )
//                   ]),
//       ],
//     );
//   }

//   Widget _summarySection(Transaction transaction) {
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//         margin: EdgeInsets.only(top: 5.0),
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text('Sub Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   Spacer(),
//                   Text(
//                       TextHelper.toReadableHumanNumber(
//                           transaction.subTotal, true),
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Text('Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   Spacer(),
//                   Text(
//                       TextHelper.toReadableHumanNumber(
//                           transaction.totalBalance, true),
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ));
//   }

//   Widget _invoiceSection(Transaction transaction) {
//     return Container(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             children: [
//               Icon(Icons.receipt_long),
//               SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 'Receipts Attachments',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         ),
//         // receipt images here!
//         Container(
//           padding: EdgeInsets.all(10.0),
//           child: GridView.count(
//             shrinkWrap: true,
//             crossAxisCount: 4,
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//             children: List.generate(transaction.listImage.length, (index) {
//               String imageUrl = transaction.listImage[index];
//               return GestureDetector(
//                 onTap: () {
//                   // view image in full screen
//                   RouteHelper.route(
//                       context,
//                       PhotoViewScreen(
//                         imageUrl: imageUrl,
//                       ));
//                 },
//                 child: Image.network(imageUrl),
//               );
//             }),
//           ),
//         ),
//       ],
//     ));
//   }

//   Widget _messageSection(String msg) {
//     return Container(
//       margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
//       padding: EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.sms),
//               SizedBox(
//                 width: 5.0,
//               ),
//               Text(
//                 'Note',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//             child: Row(
//               children: [Text(msg)],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorScheme.primaryColor,
//         title: Text("Transaction Details"),
//         leading: GoBackButton(
//           color: Colors.white,
//         ),
//       ),
//       body: StreamBuilder<ReceiptNew>(
//           stream: bloc.receipt,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               var transaction = snapshot.data;
//               print(transaction.code);
//               return Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: SingleChildScrollView(
//                       child: Column(children: [
//                     SizedBox(
//                       height: 30.0,
//                     ),
//                     // _transactionTitleSection(transaction),
//                     // SizedBox(height: 10),
//                     // _paymentMethodSection(),
//                     // Container(
//                     //     child: _transactions(transaction.lstTransactionDetail)),
//                     // SizedBox(height: 10),
//                     // _summarySection(transaction),
//                     // SizedBox(height: 10),
//                     // _invoiceSection(transaction),
//                     _messageSection(transaction.noteMessage ?? '')
//                   ])));
//             } else if (snapshot.hasError) {
//               Fluttertoast.showToast(
//                   msg: "Added new transaction",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.CENTER,
//                   timeInSecForIosWeb: 1);
//               Navigator.pop(context);
//             } else {
//               print('does not have data');
//               return Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: SingleChildScrollView(
//                       child: Column(children: [
//                     SizedBox(
//                       height: 30.0,
//                     ),
//                     SizedBox(height: 10),
//                     SizedBox(height: 10),
//                     SizedBox(height: 10),
//                   ])));
//             }
//           }),
//     );
//   }
// }
