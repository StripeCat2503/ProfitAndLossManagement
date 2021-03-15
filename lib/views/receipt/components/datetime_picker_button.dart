import 'package:flutter/material.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/themes/color_scheme.dart';

class DatePickerButton extends StatefulWidget {
  DateTime selectedDate;
  String hintText;
  Function onPickedDate;

  DatePickerButton({this.selectedDate, this.hintText, this.onPickedDate});

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPickedDate,
      child: Row(
        children: [
          Icon(
            Icons.date_range,
            color: primaryColor,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            widget.selectedDate == null
                ? widget.hintText
                : DatetimeHelper.toDayMonthYearFormatString(
                    widget.selectedDate),
            style: TextStyle(color: Colors.grey[400]),
          )
        ],
      ),
    );
  }
}
