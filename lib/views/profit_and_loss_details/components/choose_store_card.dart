import 'package:flutter/material.dart';
import 'package:pnL/themes/color_scheme.dart';

class ChooseStoreCard extends StatelessWidget {
  final Function onPressed;

  const ChooseStoreCard({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primaryLightColor),
          color: primaryColor.withOpacity(0.02),
          boxShadow: [
            BoxShadow(
                color: primaryColor.withOpacity(0.2),
                blurRadius: 0.5,
                spreadRadius: 0.2,
                offset: Offset(0, 0.2))
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Xem kỳ kế toán của'),
            Spacer(),
            Icon(
              Icons.store,
              color: primaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Tất cả cửa hàng',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.keyboard_arrow_right,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
