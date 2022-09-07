import 'package:intl/intl.dart';

class Transaction{
  String id = DateTime.now().toString();
  double amount;
  String title;
  DateTime dt;
  Transaction(this.id,this.amount,this.title,this.dt);
}