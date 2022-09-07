import 'package:flutter/material.dart';
import 'package:personal_expenses/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_content.dart';

class WeekCard extends StatelessWidget {

  final List <Transaction> recentTransactions;
  WeekCard(this.recentTransactions);

  List <Map<String,Object>> get GroupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days:index),);
      var sum = 0.0;

      for(var i = 0;i<recentTransactions.length;i++){
        if(recentTransactions[i].dt.day == weekDay.day &&
          recentTransactions[i].dt.month == weekDay.month &&
          recentTransactions[i].dt.year == weekDay.year
         ) {
          sum = sum + recentTransactions[i].amount;
        }
      }
      return { 'day': DateFormat.E().format(weekDay),'amount' : sum};
    }).reversed.toList();
  }
  double get maxSpeding {
    return GroupedTransactionValues.fold(0.0, (sum, element){
        return sum + (element['amount'] as double);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: GroupedTransactionValues.map((e){
          return ChartColumn(e['day'].toString(),(e['amount']as double),maxSpeding == 0.0?0.0:((e['amount']as double)/maxSpeding)*100);
        }).toList(),
      )
      );
  }
}