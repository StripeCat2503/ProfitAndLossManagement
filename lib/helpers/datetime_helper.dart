import 'package:intl/intl.dart';

class DatetimeHelper {
  static String toDayMonthYearFormatString(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
