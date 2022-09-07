// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:personal_expenses/transaction.dart';
import 'package:personal_expenses/transactionlist.dart';
import 'package:personal_expenses/widgets/chart_widget.dart';
import 'package:intl/intl.dart';




void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Home(),
          ),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final List<Transaction> TransactionList = [];


  List<Transaction> get recentTransactions {
    return TransactionList.where((tx) {
      return tx.dt.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  TextEditingController AmountController = TextEditingController();
  TextEditingController TitleCotroller = TextEditingController();
  DateTime? date;
  

  void _addTransaction() {
    if (TitleCotroller.text.isEmpty ||
        AmountController.text.isEmpty ||
        date == null) {
      return;
    }
    setState(() {
      TransactionList.add(Transaction(
        (DateTime.now().toString()),
          double.parse(AmountController.text), TitleCotroller.text, date!));
    });
    Navigator.pop(context);
  }

  void editList(String id) {
    setState(() {
      TransactionList.removeWhere((element) => element.id == id);
    });
    
  }

  void showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          date = value;
        });
        
        
      }
    });
    
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            padding: EdgeInsets.all(10),
            width: 300,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    cursorColor: Colors.black,
                    controller: TitleCotroller,
                    decoration: InputDecoration(        
                      labelText: "Title",
                      labelStyle: TextStyle(color: Colors.black),  
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                           ),  
                        ),
                  ),

                  TextField(
                    cursorColor: Colors.black,
                    controller: AmountController,
                    decoration: InputDecoration(        
                      labelText: "Amount",
                      labelStyle: TextStyle(color: Colors.black),  
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                           ),  
                        ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _addTransaction(),
                  ),
                  Row(
                    children: [
                      Text((date == null)
                          ? "No date choosen"
                          : DateFormat.yMMMd().format(date!)),
                      TextButton( 
                        onPressed:showDate,
                        child: Text(
                          "Choose date",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                          onPressed: _addTransaction,
                          child: Text(
                            "Add transaction",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ]),
          );
        },
        elevation: 20);
  }

  void resetList(){
    setState(() {
      TransactionList.clear();
    });
    
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text("Personal Expenses"),
          backgroundColor: Colors.black,
          actions: [IconButton(onPressed: resetList,
          icon: Icon(Icons.replay))],), 
          body: Container(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                Text("Weekly Spending Percentage:",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5,textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                WeekCard(recentTransactions),
                ListTransaction(TransactionList, editList),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor : Colors.black,
            onPressed: () => startNewTransaction(context),
            child: Icon(Icons.add),
          ),
        ));
  }

}

