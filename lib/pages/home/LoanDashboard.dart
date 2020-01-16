import 'package:flutter/material.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_los/pages/workflow/LoanUtilization/LoanUtilizationList.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/collection/DailyCollectionSearchScreen.dart';
import 'package:eco_los/pages/workflow/termDeposit/NewTermDeposit.dart';
import 'package:eco_los/pages/workflow/termDeposit/BluetoothPair.dart';
import 'package:eco_los/pages/workflow/FPSPages/AgentFingureCapture.dart';
import 'package:eco_los/pages/workflow/termDeposit/TermDepositList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoanDashboard extends StatefulWidget {
  @override
  _LoanDashboard createState() => _LoanDashboard();
}

class _LoanDashboard extends State<LoanDashboard> {

  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    getsharedPreferences();
  }

  getsharedPreferences()async {
    prefs = await SharedPreferences.getInstance();



  }





  GestureDetector gestureDetector(name, image) {
    return new GestureDetector(
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.white70,
          colorBrightness: Brightness.dark,
          color: Colors.white,
          onPressed: () {
            if (name == "Applications") {
              print("LoanLimit");
              // AppDatabase.get().deletSomeLoanUtil();
              // AppDatabase.get().getCustomerLoanDetails();

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    // new LoanLimitDetails()), //When Authorized Navigate to the next screen
                    new CustomerLoanDetailsList("Loan Application",null)),
              );
            } else if (name == "CGT1") {
              print("CGT1 --Send for Approval");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CustomerLoanDetailsList(
                        "Loan List for CGT1",null)), //When Authorized Navigate to the next screen
              );
            } else if (name == "CGT2") {
              print("CGT2 --Loan List for Loan Approval");
              if(prefs.getString(TablesColumnFile.isCGT2Needed)=='0'){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CustomerLoanDetailsList("Loan List for CGT2",null)),
                );
              }
              else{
                globals.Dialog.alertPopup(context, "This module is Not Needed",
                    "Please ask support team To open this", "LoanDashboard");
              }

            } else if (name == "GRT") {
              print("GRT --Disbursement");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CustomerLoanDetailsList("Loan List for GRT",null)), //When Authorized Navigate to the next screen
              );
            }else if (name == "Collection") {
              print("Collection");
              Navigator.push(
                context,
                new MaterialPageRoute(
                  // builder: (context) => new LoanCollectionFilteredList()),
                    builder: (context) => new DailyCollectionSearchScreen()),
              );
            }else if(name == "LUC"){
              print("Group Monitoring");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new LoanUtilizationList("Loan Utilization")), //When Authorized Navigate to the next screen
              );
            }
          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.none,
            child: new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage(image),
                ),
                SizedBox.fromSize(),
                new Center(
                  child: new Text(
                    name,
                    style: new TextStyle(color: Color(0xff07426A), fontSize: 11.0,),
                  ),
                    heightFactor: 2.0,
                )
              ],
            ),
          )),
    );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Loan Management",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,


      ),


      body:new GridView.count(
        primary: true,
        padding: const EdgeInsets.all(1.0),
        crossAxisCount: 3,
        //childAspectRatio: 0.80,
        mainAxisSpacing: 0.3,
        crossAxisSpacing: 0.3,
        children: <Widget>[
          gestureDetector("Applications", "assets/loanApplication.png"),
         // gestureDetector("CGT1", "assets/CGT1.png"),
          //gestureDetector("CGT2", "assets/CGT2.png"),
          //gestureDetector("GRT", "assets/loan_approval.png"),
          //gestureDetector("Collection", "assets/loanpayout.png"),
          //gestureDetector("LUC", "assets/loanUtilization.png"),
        ],
      ),
    );
  }


}
