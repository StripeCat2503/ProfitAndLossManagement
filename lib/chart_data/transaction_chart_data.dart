import 'package:pnL/enums/transaction_type.dart';

class TransactionChartData {
  TransactionTypeEnum transactionType;
  double balance;
  DateTime createdDate;

  TransactionChartData({this.transactionType, this.balance, this.createdDate});
}
