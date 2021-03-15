// import 'package:flutter/material.dart';
// import 'package:pnL/models/receipt_transaction_view_model.dart';
// import 'package:pnL/themes/color_scheme.dart';
// import 'package:pnL/views/transactions/components/transaction_card.dart';

// class TransactionOfReceiptWidget extends StatelessWidget {
//   const TransactionOfReceiptWidget({
//     Key key,
//     @required this.receiptTransactionListScreenViewModel,
//   }) : super(key: key);

//   final ReceiptTransactionViewModel receiptTransactionListScreenViewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             // name of receipt
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.receipt,
//                   color: primaryLightColor,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   receiptTransactionListScreenViewModel.receiptName,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           // list of transactions of a receipt
//           Container(
//             child: Column(
//               children: List.generate(
//                   receiptTransactionListScreenViewModel.transactions.length,
//                   (index) {
//                 var transaction =
//                     receiptTransactionListScreenViewModel.transactions[index];
//                 return TransactionCard(
//                   transaction: transaction,
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }