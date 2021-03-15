// import 'package:flutter/material.dart';
// import 'package:pnL/models/receipt_category_model.dart';
// import 'package:pnL/themes/color_scheme.dart';

// class ReceiptCategoryCard extends StatelessWidget {
//   const ReceiptCategoryCard(
//       {Key key, @required this.receiptCategory, this.onSelected})
//       : super(key: key);

//   final ReceiptCategory receiptCategory;
//   final Function onSelected;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: this.onSelected,
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: primaryLightColor.withOpacity(0.1),
//             border: Border.all(color: primaryColor)),
//         child: Center(
//           child: Text(
//             receiptCategory.name,
//             style: TextStyle(fontSize: 12),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
