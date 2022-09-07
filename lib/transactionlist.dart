import 'package:flutter/material.dart';
import 'package:personal_expenses/transaction.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  List<Transaction> TransactionList = [];
  Function func;
  ListTransaction(this.TransactionList,this.func);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.63,
        child: TransactionList.isEmpty?
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height:  MediaQuery.of(context).size.width*0.05,),
              Text("No transactions added yet",textScaleFactor: 1.6,style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                height: MediaQuery.of(context).size.height*0.40,
                child: Image.asset("assets/images/lazyman.png",)),
            ],
          ),

        )
        :ListView.builder(
          itemBuilder: ((context, index){
            return Container(
      height: 78,
      // ignoreA=: prefer_const_constructors
      child: Card(
        elevation:10,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        // ignore: prefer_const_constructors
        child: ListTile(
          tileColor: Colors.white10,
            leading: Text('₹${TransactionList[index].amount}',style: TextStyle(color: Colors.grey),textScaleFactor: 1.7),
            title: Text(TransactionList[index].title,textScaleFactor: 1.2,),
            subtitle: Text(DateFormat.yMMMd().format(TransactionList[index].dt)),
            trailing: IconButton(icon: Icon(Icons.delete,color: Colors.grey,), onPressed: ()=>func(TransactionList[index].id)),
            ),
      ),
    );
          }),
          itemCount: TransactionList.length,
      ),
    );
  }
}