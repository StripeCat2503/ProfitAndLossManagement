import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/receipt_new_enum.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/receipt/receipt_details_screen.dart';

class ReceiptCard extends StatelessWidget {
  final ReceiptNew receipt;

  ReceiptCard({this.receipt});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // navigate to receipt details screen
        RouteHelper.route(context, ReceiptDetailsScreen(receiptId: receipt.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white,
        ),
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
                      SizedBox(
                        height: 5,
                      ),
                      // transaction type + transaction code
                      Text(
                        (receipt.code.toString()).toUpperCase(),
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
                          Text(
                            receipt.supplier?.name == null
                                ? '(Unknown Supplier)'
                                : 'Supplier: ' + receipt.supplier.name,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
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
                            TextHelper.numberWithCommas(receipt.totalBalance) +
                                ' đ',
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
            // receipt status
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // issue date (ngay xuat hoa don)
                  Icon(
                    Icons.date_range_outlined,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Issue at 01/05/2020',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Spacer(),
                  Icon(
                    Icons.info_outline,
                    color: primaryLightColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    EnumToString.convertToString(
                        ReceiptStatusEnum.values[receipt.status]),
                    style: TextStyle(
                        color: this.receipt.status == 0
                            ? Colors.grey[400]
                            : Colors.green),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
