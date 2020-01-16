import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/Helper.dart';
import 'package:eco_los/Utilities/OpenCamera.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/app_constant.dart' as constant1;
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_los/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_los/pages/workflow/LoanApplication/FullScreenDialogForPurposeSelection.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_los/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/RepaymentFrequency.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/TransactionMode.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';

import 'package:eco_los/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';
import 'package:eco_los/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanUtilization extends StatefulWidget {
  final laonUtilizationPassedObject;
  LoanUtilization({Key key, this.laonUtilizationPassedObject}) : super(key: key);

  @override
  _LoanUtilizationState createState() => new _LoanUtilizationState();
}

class _LoanUtilizationState extends State<LoanUtilization> {
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection();
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String ActualUtilization  = "";
  String Remarks  = "";
  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat("dd,MM,yyyy");
  DateTime date;
  TimeOfDay time;
  int customerId;
  int selectedPosition = 0;
  String customerName;
  String groupName;
  String centerName;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;

  LoanUtilizationBean cusLoanUtilObj = new LoanUtilizationBean();
  @override
  void initState() {
    super.initState();
    if(widget.laonUtilizationPassedObject!=null){
      cusLoanUtilObj=widget.laonUtilizationPassedObject;
      print("cusLoanUtilObj");
      print(widget.laonUtilizationPassedObject);
      print(cusLoanUtilObj);
      print("obj is ${cusLoanUtilObj}");
    }
    if (cusLoanUtilObj.mcreateddt =="null" ||cusLoanUtilObj.mcreateddt ==null) {
      cusLoanUtilObj.mcreateddt = DateTime.now();
    }
    getSessionVariables();
    if (globals.applicationDate == null) {
      globals.applicationDate = DateTime.now();
    }
  }
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation=  prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude  = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser= prefs.getString(TablesColumnFile.reportingUser);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(
          'Loan Utilization',
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.save,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              proceed();
            },
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async {
          final FormState form = _formKey.currentState;
          form.save();
          //await calculate();
          setState(() {});
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new Card(color: Constant.readonlyColor,
              child: new ListTile(
                  title: new Text("Customer Number"),
                  subtitle: cusLoanUtilObj.mcustno == null
                      ? new Text("")
                      : new Text(
                      "${cusLoanUtilObj.mcustno.toString()}"),
                  onTap: () => getCustomerId()),
            ),
            new Card(color: Constant.readonlyColor,
              child: new ListTile(
                title: new Text("Customer Name"),
                subtitle: cusLoanUtilObj.mcustname == null
                    ? new Text("")
                    : new Text("${cusLoanUtilObj.mcustname}"),
              ),
            ),
            new Card(color: Constant.readonlyColor,
              child: new ListTile(
                  title: new Text("Selected Loan Number"),
                  subtitle: cusLoanUtilObj.mprdacctid == null
                      ? new Text("")
                      : new Text(
                      "${cusLoanUtilObj.mprdacctid.toString() + " core Solution loan Number :  " + cusLoanUtilObj.mprdacctid.toString()}"),
                  onTap: () => getLoanData()),
            ),
            new Card(color: Constant.readonlyColor,
              child: new ListTile(
                title: new Text("Group Code"),
                subtitle: cusLoanUtilObj.mgroupcd == null
                    ? new Text("")
                    : new Text("${cusLoanUtilObj.mgroupcd}"),
              ),
            ),
            new Card(color: Constant.readonlyColor,
              child: new ListTile(
                title: new Text("Centre Code"),
                subtitle: cusLoanUtilObj.mcenterid == null
                    ? new Text("")
                    : new Text("${cusLoanUtilObj.mcenterid}"),
              ),
            ),
            new Card(color: Constant.readonlyColor,
              child: new ListTile(
                title: new Text("Purpose Of Loan"),
                subtitle: cusLoanUtilObj.mpurposeofloan == null
                    ? new Text("")
                    : new Text("${cusLoanUtilObj.mpurposeofloan}"),

              ),
            ),

            new Card(color: Constant.readonlyColor,
                child: new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Actual Utilization ',
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  controller: cusLoanUtilObj.mactualutilization  == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: "${cusLoanUtilObj.mactualutilization }"),
                  onSaved: (val) {
                    cusLoanUtilObj.mactualutilization  = val;
                  },
                )
            ),
            new Card(
                child: new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Remarks ',
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  controller: cusLoanUtilObj.mremarks  == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: "${cusLoanUtilObj.mremarks }"),
                  onSaved: (val) {
                    cusLoanUtilObj.mremarks  = val;
                  },
                )

            ),


          ],
        ),
      ),
    );
  }


  proceed()  async{
    if (!validateSubmit()) {
      return;
    }
    cusLoanUtilObj.musrname = username;
    print("cusLoanUtilObj.musrname"+cusLoanUtilObj.musrname.toString());
    print("username"+username.toString());

    await AppDatabase.get()
        .updateCustomerLoanUtilizationMaster(cusLoanUtilObj)
        .then((val) {
      print("val here is " + val.toString());
    });
    _successfulSubmit();
  }

  Future getCustomerId() async {
    CustomerListBean customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null, "Loan Utilization")));
    if (customerdata != null) {
      print("customerdata"+customerdata.toString());

      cusLoanUtilObj.mcustno = customerdata.mcustno;
      cusLoanUtilObj.mcustname = customerdata.mfname.toString()+" "+customerdata.mlname.toString();
      cusLoanUtilObj.mcenterid = customerdata.mcenterid;
      cusLoanUtilObj.mgroupcd = customerdata.mgroupcd;
      print("inside cus");
      print(customerdata.mcenterid);
      print(customerdata.mcenterid);

      print(customerdata.mcustno);


    }
  }


  Future getLoanData() async {
    print("getLoanData");
    print("cusLoanUtilObj.customerNumber"+cusLoanUtilObj.mcustno.toString());

    CustomerLoanDetailsBean customerLoanDetails= new CustomerLoanDetailsBean();
    //print("customerLoanDetails"+customerLoanDetails.toString());
    customerLoanDetails = await Navigator.push(
        context,
        new MaterialPageRoute(

            builder: (BuildContext context) =>
                CustomerLoanDetailsList("Loan Utilization",cusLoanUtilObj.mcustno.toString())));
    print("cusLoanUtilObj.customerNumber"+cusLoanUtilObj.mcustno.toString());
    print("customerLoanDetails"+customerLoanDetails.toString());

    if (customerLoanDetails != null) {
      print("bgvdhcfh");
      cusLoanUtilObj.mprdacctid = customerLoanDetails.mprdacctid !=null && customerLoanDetails.mprdacctid!='null' && customerLoanDetails.mprdacctid!=''?customerLoanDetails.mprdacctid:"";

      AppDatabase.get().getLookupDataPurposeOfLoanFromLocalDb(909022,customerLoanDetails.mpurposeofLoan.toString()).then((onValue){
        cusLoanUtilObj.mpurposeofloan = onValue.mcodedesc;
      });
    }
  }

  Future<void> _successfulSubmit() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Done'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool validateSubmit() {
    String error = "";
    print("inside validate");
    if (cusLoanUtilObj.mcustno == "" || cusLoanUtilObj.mcustno== null) {
      _showAlert("Customer Number", "It is Mandatory");
      return false;
    }
    if (cusLoanUtilObj.mprdacctid == "" || cusLoanUtilObj.mprdacctid== null) {
      _showAlert("Loan Number", "It is Mandatory");
      return false;
    }
    if (cusLoanUtilObj.mactualutilization == "" || cusLoanUtilObj.mactualutilization== null) {
      _showAlert("Actual Utilization", "It is Mandatory");
      return false;
    }
    return true;

  }


}
