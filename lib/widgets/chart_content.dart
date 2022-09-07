import 'package:flutter/material.dart';

class ChartColumn extends StatelessWidget {
  double amount;
  String day;
  double PercentageAmount;
  ChartColumn(this.day,this.amount,this.PercentageAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text("${PercentageAmount.toStringAsFixed(1)}%"),
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          Container(
            height: MediaQuery.of(context).size.height*0.17,
            width: MediaQuery.of(context).size.width*0.03,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 130,),
                FractionallySizedBox(heightFactor: PercentageAmount/100,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 1.0),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10) ),
                    ), 
                    ),
                ]
                
                ),
          ),
          SizedBox(height: 10,),
          Text(day)
      ]);
  }
}