import 'package:flutter/material.dart';
import 'package:pnL/themes/color_scheme.dart';

class FeedbackDialog extends StatelessWidget {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return AlertDialog(
      title: Row(
        children: [
          Text(
            'Send feedback',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(
            Icons.add_comment,
            color: primaryColor,
          )
        ],
      ),
      content: Container(
        child: TextField(
          maxLines: null,
          focusNode: focusNode,
          decoration: InputDecoration(
              hintText: 'Feedback Message...',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryLightColor, width: 1))),
        ),
      ),
      actions: [
        // button to confirm and send feedback
        FlatButton(
          onPressed: () {
            // handle send feedback action
          },
          child: Text(
            'send'.toUpperCase(),
            style: TextStyle(color: primaryColor),
          ),
        ),
        // button to cancel feedback
        FlatButton(
          onPressed: () {
            // handle cancel button
            Navigator.pop(context, false);
          },
          child: Text(
            'cancel'.toUpperCase(),
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
