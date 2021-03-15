// import 'package:flutter/material.dart';
// import 'package:pnL/helpers/text_helper.dart';
// import 'package:pnL/models/transaction_model.dart';
// import 'package:pnL/themes/color_scheme.dart';

// class TransactionCard extends StatelessWidget {
//   final Transaction transaction;
//   TransactionCard({this.transaction});

//   @override
//   Widget build(BuildContext context) {
//     Color color = this.transaction.transactionType.isDebit
//         ? Colors.green
//         : Colors.redAccent;

//     IconData icon =
//         this.transaction.transactionType.isDebit ? Icons.north : Icons.south;

//     return Container(
//       margin: EdgeInsets.only(top: 5),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(5),
//         ),
//         color: Colors.white,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: color,
//             size: 14,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Column(
//             children: [
//               // name of transaction
//               Text(
//                 transaction.name.toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 13,
//                 ),
//               ),
//             ],
//           ),
//           Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     TextHelper.numberWithCommas(transaction.totalBalance),
//                     style: TextStyle(fontSize: 14, color: color),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
