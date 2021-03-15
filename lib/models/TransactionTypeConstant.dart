import 'package:pnL/models/transaction_type.dart';

class TransactionTypeConstant {
  static TransactionType sales = TransactionType.fromJson({
    "name": "Sales",
    "code": "SAL",
    "is-debit": true,
    "id": "befe9e61-30c9-4594-8a26-5672d1d66e52",
  });
  static TransactionType revenues = TransactionType.fromJson({
    "name": "Revenues",
    "code": "REV",
    "is-debit": true,
    "id": "e4b06925-d89f-41ae-a495-5db8ab3dcfe9",
  });
  static TransactionType invoice = TransactionType.fromJson({
    "name": "Invoice",
    "code": "INV",
    "is-debit": false,
    "id": "c1684003-c94f-4c7e-af92-5fc31c4efa48",
  });
  static TransactionType expenses = TransactionType.fromJson({
    "name": "Expenses",
    "code": "EXP",
    "is-debit": false,
    "id": "d59d5f6c-5fc1-4977-8f17-a8f78556bf6e",
  });
}
