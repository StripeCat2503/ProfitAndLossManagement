import 'package:intl/intl.dart';

class TextHelper {
  static String numberWithCommas(double number) {
    final numberFormat = NumberFormat('#,###');

    return numberFormat.format(number);
  }

  static String numberWithCommasAndCurrency(double number, String currency) {
    final numberFormat = NumberFormat('#,###');
    return currency + numberFormat.format(number);
  }

  static double toNumber(String numberWithCommas) {
    return double.parse(numberWithCommas.replaceAll(',', ''));
  }

  static String toReadableHumanNumber(double number, bool containCurrencySymbol) {
    return NumberFormat.compactCurrency(decimalDigits: 2, symbol: (containCurrencySymbol == true) ? 'đ' : '')
        .format(number);
  }
}
