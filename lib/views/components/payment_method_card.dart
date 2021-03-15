
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pnL/resources/currency_number_formatter.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;

class PaymentMethodCard extends StatefulWidget {
  Function onDeleted;
  String paymentMethodText;
  bool isCashPaymentMethod;
  Function onChanged;

  PaymentMethodCard(
      {this.paymentMethodText,
      this.onDeleted,
      this.isCashPaymentMethod,
      this.onChanged});

  @override
  _PaymentMethodCardState createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
   
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorScheme.primaryLightColor),
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.paymentMethodText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                // button to delete payment method
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                  ),
                  onPressed: widget.onDeleted,
                )
              ],
            ),
            Container(
              child: Center(
                child: TextField(
                  inputFormatters: [CurrencyNumberFormatter()],
                  onChanged: widget.onChanged,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      prefix: Text('VND'),
                      hintText: 'Enter amount...',
                      suffixIcon: Icon(
                        Icons.monetization_on,
                        color: ColorScheme.primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorScheme.primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorScheme.primaryColor.withOpacity(0.5)))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
