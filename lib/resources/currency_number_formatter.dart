import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    RegExp regExp = RegExp('[0-9]+');

    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      String newValueString =
          !regExp.hasMatch(newValue.text[newValue.text.length - 1])
              ? newValue.text.substring(0, newValue.text.length - 1)
              : newValue.text;
      final f = NumberFormat("#,###");
      final number =
          int.parse(newValueString.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
