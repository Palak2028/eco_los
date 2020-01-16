import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/ReadXmlCost.dart';
import 'package:eco_los/Utilities/initializer.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/main.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';

import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/Utilities/initializer.dart'
    as initializer;
import 'package:shared_preferences/shared_preferences.dart';

class CGT1 extends StatefulWidget {
  final laonLimitPassedObject;
  CGT1({Key key, this.laonLimitPassedObject}) : super(key: key);

  @override
  _CGT1 createState() => new _CGT1();
}

class _CGT1 extends State<CGT1> {
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String mreportinguser;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";
  CGT1Bean cgt1bean = new CGT1Bean();
  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;
  final formKey = new GlobalKey<FormState>();
  bool isRouted = true;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  int isCGT2Needed = 0;
  //Position position;
  //var addresses;

  @override
  void initState() {
    super.initState();
    getSessionVariables();
    //String formattedDate =DateFormat("yyyy, mm, dd").format(startTime);
    //cgt1bean.startTime =  DateTime.parse(formattedDate);
    cgt1bean.mstarttime = DateTime.now();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(()  {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      mreportinguser = prefs.getString(TablesColumnFile.mreportinguser);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgroupcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      isCGT2Needed = int.parse(prefs.get(TablesColumnFile.isCGT2Needed));
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            'CGT 1 Check ',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () async {


    /* if(isRouted==false){
                await AppDatabase.get().getLoanApprovalLimit(widget.laonLimitPassedObject.mprdcd,username).then((onValue){

                  if(onValue==0.0){
                    showMessage("Try Syncing Loan limit approval");
                  }

                  else if(onValue >= widget.laonLimitPassedObject.mapprvdloanamt) {
                    _showAlert("Confirm",1);

                  }else {

                    _showAlert("LoanPrrovalLimitAlert",0);
                  }
               });
                }
                else if(isRouted==true){
*/
    _showAlert("Confirm",1);
    //}

              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new SafeArea(
            child: SingleChildScrollView(
                child: new Column(
          children: getCard(),
        ))));
  }

  List<Widget> getCard() {
    List<Widget> listCard = new List<Widget>();
    print(globals.questionCGT1.length);
    for (int i = 0; i < globals.questionCGT1.length; i++) {
      print("here");
      listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: globals.questionCGT1[i].manschecked == null ||
                          globals.questionCGT1[i].manschecked == 0
                      ? false
                      : true,
                  title: new Text(
                    globals.questionCGT1[i].mquestiondesc,
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (val) {
                    setState(() {
                      globals.questionCGT1[i].manschecked =
                          val == false ? 0 : 1;
                    });
                  })),
        ],
      ));
    }listCard.add(Container(
      child:isCGT2Needed==1?
      null:new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: isRouted,
                  title: new Text(
                    "Route to Super User",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight:FontWeight.bold),
                  ),
                  onChanged: (val) {
                    setState(() {
                      isRouted = !isRouted;
                      print("is Routed $isRouted");
                      print("is cgt2needed ${isCGT2Needed}");
                    });
                  })),
        ],
      ),
    ));
    listCard.add(
      new Form(
        key: formKey,
          onChanged: () {
    final FormState form = formKey.currentState;
    form.save();
    },
       child: new TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Enter Remarks here',
          labelText: 'Remarks',
          hintStyle: TextStyle(color: Colors.grey),
          /*labelStyle: TextStyle(color: Colors.grey),*/
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff5c6bc0),
              )),
          contentPadding: EdgeInsets.all(20.0),
        ),
       /* controller: cgt1bean.mremarks != null
            ? TextEditingController(text: cgt1bean.mremarks)
            : TextEditingController(text: ""),
       */ inputFormatters: [
          new LengthLimitingTextInputFormatter(60),
          globals.onlyAphaNumeric
        ],
           initialValue:
           cgt1bean.mremarks != null ? cgt1bean.mremarks : "",
           onSaved: (String value) {
             /*globals.firstName = value;*/
             cgt1bean.mremarks =
                 value;
           }
      ),),
      );

    return listCard;
  }

  Future<Null> _submitData() async {
    int loanTrefno = widget.laonLimitPassedObject.trefno;
    int loanMrefno = widget.laonLimitPassedObject.mrefno;
    int cgt1Trefno = widget.laonLimitPassedObject.trefno ;
    print("loanTrefno "+ loanTrefno.toString());
    print("loanMrefno "+ loanMrefno.toString());
   // print("loanTrefno "+loanTrefno.toString());
    for (int i = 0; i < globals.questionCGT1.length; i++) {
      int id = widget.laonLimitPassedObject.trefno + i;
      print("id hai yeh holi wali "+ id.toString());
      globals.questionCGT1[i].mleadsid= "0";
     // globals.questionCGT1[i].
      if( globals.questionCGT1[i].mrefno==null) {
        globals.questionCGT1[i].mrefno = 0;
      }
      if( globals.questionCGT1[i].mclcgt1refno==null) {
        globals.questionCGT1[i].mclcgt1refno = 0;
      }

      globals.questionCGT1[i].trefno = cgt1Trefno;
      globals.questionCGT1[i].mrefno  = widget.laonLimitPassedObject.mrefno;
      await AppDatabase.get().updateCgt1QaMaster(globals.questionCGT1[i], id);
    }
    print("remarks " + cgt1bean.mremarks.toString());
    cgt1bean.trefno = widget.laonLimitPassedObject.trefno;
    cgt1bean.mrefno = 0;
    cgt1bean.mcreatedby = username.trim();
    cgt1bean.mendtime = DateTime.now();
    cgt1bean.mlastupdatedt = DateTime.now();
    cgt1bean.mgeologd = geoLongitude;
    cgt1bean.mgeolatd = geoLatitude;
    cgt1bean.mgeolocation = geoLocation;
    cgt1bean.mcreateddt = DateTime.now();
    cgt1bean.mlastupdateby = username;
    if(isCGT2Needed==0){

      if(isRouted  == true){
        cgt1bean.mroutefrom = username;
        cgt1bean.mrouteto = mreportinguser;
      }
      else if(isRouted ==false){
        cgt1bean.mroutefrom = "";
        cgt1bean.mrouteto = "";
      }

    }else{
      cgt1bean.mroutefrom = username;
      cgt1bean.mrouteto = mreportinguser;
    }
/*
    cgt1bean.mroutefrom = username.trim();
    cgt1bean.mrouteto = mreportinguser.trim();*/

    cgt1bean.mleadsid = "0";
   cgt1bean.loanmrefno = loanMrefno;
    cgt1bean.loantrefno =loanTrefno;
    cgt1bean.mcgt1doneby = username;
    await AppDatabase.get().updateCGT1Master(cgt1bean);
    CustomerLoanDetailsBean custLoanBean = new CustomerLoanDetailsBean();
    //custLoanBean.distbursmentStatus = "CGT1";
    if(isCGT2Needed==0){
      custLoanBean.mleadstatus = 5;
    }
    else{
      custLoanBean.mleadstatus = 6;
    }

    custLoanBean.mapprovaldesc = cgt1bean.mremarks;
    custLoanBean.mcreatedby = username;
    await AppDatabase.get().updateLoanDetailsStatus(
        loanTrefno, loanMrefno,custLoanBean,DateTime.now(),cgt1bean.mrouteto,cgt1bean.mroutefrom,username);
    _showAlert("Submit",0);
  }

  Future<void> _showAlert(String alertType,int consfirmStatus) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:alertType== "Submit"? new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ):(alertType=="Confirm"?
            new Icon(
              Icons.info,
              color: Colors.yellow
              ,
              size: 60.0,):
            new Icon(
              Icons.warning,
              color: Colors.red,
              size: 60.0,)
            )
            ,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  alertType== "Submit"?
                  Text("Submitted Successfully !")
                  :(alertType=="Confirm"?
                  Text("Are You Sure You want to confirm!"):
              Text("Please Route it as your limit is above approval !")
                  ) ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  if(alertType =="Submit" ){

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                  else if(alertType =="Confirm" ){
                    Navigator.of(context).pop();
                    _submitData();
                  }
                  else{
                    Navigator.of(context).pop();
                  }
                },
              ),

              alertType!="Submit"?FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ):null
            ],
          );
        });
  }



  void showMessage(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
