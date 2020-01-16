import 'package:eco_los/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ESMSBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FinancialStmntBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/IncomeStatementBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/RiskRatingsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/SocialFinancialDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/TotalExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/syncingActivity/CheckExistingCustomerFromMiddleware.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/ThemeDesign.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_los/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/Bean/Verhoeff.dart';
import 'package:eco_los/pages/workflow/creditBereau/ProspectView.dart';
import 'package:eco_los/pages/workflow/creditBereau/SMSVerification.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationPersonalInfo.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';

import 'package:eco_los/pages/workflow/syncingActivity/SyncingCustomerToMiddleware.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerList extends StatefulWidget {
  final firstParms;

  //CustomerList(this.cameras);
  final String type;
  CustomerList(this.firstParms, this.type);

  @override
  _CustomerList createState() => new _CustomerList();
}

class _CustomerList extends State<CustomerList> {
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  DateTime lastSyncedToServerDaeTime = null;

  Future<bool> callDialog() {
    globals.Dialog.onPop(context, 'Are you sure?',
        'Do you want to Go To DashBoard', "CustomerList");
  }

  List<int> indicesList = new List<int>();
  List<CustomerListBean> customerBeanList = new List<CustomerListBean>();
  Widget appBarTitle = new Text("Customer List");
  Icon actionIcon = new Icon(Icons.search);
  Icon actionIconMic = new Icon(Icons.mic);
  int count = 1;
  int highmarkValidity = 0;
  int mIsProspectRepeatNeeded = 0;
  final String nidPaddingSpaces = "                              ";
  bool circInd = false;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";
  String resultTextSearch = "";

  @override
  void initState() {
    items.clear();
    super.initState();
   // initSpeechRecognizer();
    getsharedPreferences();
    setState(() {});
  }

  /*void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }*/

  getsharedPreferences() async {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1, false)
        .then((onValue) async {
      lastSyncedToServerDaeTime = onValue;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TablesColumnFile.mValidity) != null &&
        prefs.getString(TablesColumnFile.mValidity).trim() != "")
      highmarkValidity = int.parse(prefs.getString(TablesColumnFile.mValidity));
    if (prefs.getString(TablesColumnFile.mIsProspectRepeatNeeded) != null &&
        prefs.getString(TablesColumnFile.mIsProspectRepeatNeeded).trim() != "")
      mIsProspectRepeatNeeded =
          int.parse(prefs.getString(TablesColumnFile.mIsProspectRepeatNeeded));
    /*SystemParameterBean  sysBean = await AppDatabase.get().getSystemParameter(1,101);*/
    // print(highmarkValidity);
  }

  List<CustomerListBean> items = new List<CustomerListBean>();
  List<CustomerListBean> storedItems = new List<CustomerListBean>();

  /* void filterList(String val) async{
    print("inside filterList");
    items.clear();
    items = new List<CustomerListBean>();


    storedItems.forEach((obj) {
      if (obj.mmobno.toString().contains(val) |
          obj.trefno.toString().toLowerCase().contains(val) |
          obj.mcenterid.toString().contains(val) |
          obj.mgroupcd.toString().contains(val) |
          obj.mlongname.toString().contains(val) |
          //obj.mmobno.toString().contains(val) |
          obj.mcustno.toString().contains(val)*/ /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/ /* ) {
        print("inside contains");
        print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }*/

  void filterList(String val) async {
    // print("inside filterList");
    items.clear();
    items = new List<CustomerListBean>();

    storedItems.forEach((obj) {
      if (obj.mmobno.toString().contains(val) |
          obj.trefno.toString().toLowerCase().contains(val) |
          obj.mcenterid.toString().contains(val) |
          obj.mgroupcd.toString().contains(val) |
          obj.mlongname.toString().toUpperCase().contains(val.toUpperCase()) |
          obj.mpannodesc.toString().toUpperCase().contains(val.toUpperCase()) |
          obj.mIdDesc.toString().toUpperCase().contains(val.toUpperCase()) |
          //obj.mmobno.toString().contains(val) |
          obj.mcustno.toString().contains(
              val) /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/) {
        //  print("inside contains");
        //  print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    //print(items);
    double c_width = MediaQuery.of(context).size.width * 10;
    String longName = items[index].mlongname.toString() != null &&
            items[index].mlongname.toString() != 'null'
        ? items[index].mlongname.toString()
        : "";
     String firstName = items[index].mfname.toString() != null &&
            items[index].mfname.toString() != 'null'
        ? items[index].mfname.toString()
        : "";
    String middleName = items[index].mmname.toString() != null &&
            items[index].mmname.toString() != 'null'
        ? items[index].mmname.toString()
        : "";
    String lastName = items[index].mlname.toString() != null &&
            items[index].mlname.toString() != 'null'
        ? items[index].mlname.toString()
        : "";
    bool isSyncedIndex = false;

    /*if(lastSyncedToServerDaeTime!=null){
     if(items[index].mcreateddt != null && items[index].mcreateddt != 'null' && items[index].mcreateddt.isAfter(lastSyncedToServerDaeTime)||
         ( items[index].mlastupdatedt != null && items[index].mlastupdatedt != 'null' && items[index].mlastupdatedt.isAfter(lastSyncedToServerDaeTime)) || (items[index].mrefno ==null && items[index].mrefno==0)){
       isSyncedIndex=false;
     }




     if(items[index].mcreateddt != null && items[index].mcreateddt != 'null' && items[index].mcreateddt.isAfter(lastSyncedToServerDaeTime)){
       isSyncedIndex=true;
     }

   }*/

    if (items[index].mlastsynsdate == null ||
        items[index].mlastsynsdate == 'null' ||
        (items[index].mcreateddt != null &&
            items[index].mcreateddt != 'null' &&
            items[index].mcreateddt.isAfter(items[index].mlastsynsdate)) ||
        (items[index].mlastupdatedt != null &&
            items[index].mlastupdatedt != 'null' &&
            items[index].mlastupdatedt.isAfter(items[index].mlastsynsdate)) ||
        (items[index].mrefno == null && items[index].mrefno == 0)) {
      isSyncedIndex = true;
    }

    //TODO applicant DOB hai bhai created dt nahi
    DateTime applicantDob =
        items[index].mcreateddt != null && items[index].mcreateddt != 'null'
            ? items[index].mcreateddt
            : DateTime.now();
    String centerNumber = items[index].mcenterid.toString() != null &&
            items[index].mcenterid.toString() != 'null'
        ? items[index].mcenterid.toString()
        : "";
    String groupNumber = items[index].mgroupcd.toString() != null &&
            items[index].mgroupcd.toString() != 'null'
        ? items[index].mgroupcd.toString()
        : "";
    String errorMsg = items[index].merrormessage.toString() != null &&
            items[index].merrormessage.toString() != 'null'
        ? items[index].merrormessage.toString()
        : "";
    bool showErrMsg = true;
    if (errorMsg == "null" || errorMsg == "" || errorMsg == null) {
      showErrMsg = false;
    }
    /*
    Color color;
    if (index % 2 == 1) {
      color = Colors.brown[50];
    } else {
      color = Colors.white;
    }
*/
    return new GestureDetector(
      onTap: () {
        globals.customerNumber = items[index].trefno.toString();
        _onTapItem(context, items[index]);
      },
      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),

                // width: c_width,
                child: Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          ThemeDesign.loginGradientEnd,
                          ThemeDesign.loginGradientStart,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        longName==null || longName=='null' ||  longName==''?firstName+" "+middleName+" "+lastName:longName,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Trefno:" +
                                    items[index].trefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Text(
                                "Mrefno:" + items[index].mrefno.toString() !=
                                        null
                                    ? items[index].mrefno.toString()
                                    : "Sync To get Mrefno",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                /*  new IconButton(
                      icon: new Icon(Icons.delete_forever, color: Colors.red),
                      onPressed: () => {_deleteIt(items[index].trefno,items[index].mrefno)},
                ),*/
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    new Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                    Text(
                                      items[index].mcustno.toString() != null &&
                                              items[index].mcustno.toString() !=
                                                  'null'
                                          ? items[index].mcustno.toString()
                                          : "",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container(
                child: new Row(
                  children: [
                    new Expanded(
                      child: new Text(
                        items[index].merrormessage.toString() != null &&
                                items[index].merrormessage.toString() != "" &&
                                items[index].merrormessage.toString() != "null"
                            ? items[index].merrormessage.toString()
                            : '',
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.red[500]),
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration(
                    // backgroundColor: Colors.grey[300],
                    ),
                width: 400.0,
              ),
              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                items[index].mpannodesc.toString() != null ||
                                        items[index].mpannodesc.toString() != ""
                                    ? Text(
                                        "NID :" +
                                            items[index].mpannodesc.toString(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[500],
                                        ),
                                      )
                                    : Text(
                                        "NID :" + nidPaddingSpaces.toString(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                Padding(
                                  padding: new EdgeInsets.only(
                                      left: 10.0, right: 8.0),
                                  child: new Text(
                                    DateFormat("yyyy, MM, dd")
                                        .format(applicantDob),
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                  /*   top: 1.0,
                                  bottom: 1.0,*/
                                  ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  Text(
                                    "   GNO: ${groupNumber}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "CNO: ${centerNumber}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  items[index].mtier != null &&
                                          items[index].mtier != 'null'
                                      ? Text(
                                          "    Cycle:" +
                                              items[index].mtier.toString() +
                                              "   ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[500]),
                                        )
                                      : Text(
                                          "    Cycle:" + "1" + "   ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[500]),
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                  /* top: 1.0,
                                  bottom: 1.0,*/
                                  ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                //crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new Icon(Icons.phone,
                                      color: Colors.green, size: 18.0),
                                  new Text(
                                    items[index].mmobno.toString(),
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    new ButtonTheme.bar(
                      padding: new EdgeInsets.all(2.0),
                      child: new ButtonBar(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          widget.type == "Loan Application" ||
                                  widget.type == "Loan collection" ||
                                  mIsProspectRepeatNeeded == 0
                              ? null
                              : new IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.clipboardCheck,
                                    color: (items[index].misCbCheckDone == 1 ||
                                                items[index].misCbCheckDone ==
                                                    2) &&
                                            DateTime.now().difference(
                                                    items[index]
                                                        .mcbcheckrprtdt) <=
                                                Duration(days: highmarkValidity)
                                        ? Colors.grey
                                        : Colors.green,
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    if ((items[index].misCbCheckDone == 1 ||
                                            items[index].misCbCheckDone == 2) &&
                                        DateTime.now().difference(
                                                items[index].mcbcheckrprtdt) <
                                            Duration(days: highmarkValidity)) {
                                      showMessageWithoutProgress(
                                          "Highmark Result is "
                                          "${items[index].misCbCheckDone == 1 ? 'Pass' : 'Fail'}");
                                    } else {
                                      _cnfrmCreateProspect(items[index]);
                                    }
                                  },
                                ),
                          widget.type == "Loan Application" ||
                                  widget.type == "Loan collection"
                              ? null
                              : new Container()
                          /*IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.chartPie,
                                    color: Colors.orange[400],
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    showMessageWithoutProgress(
                                        "Customer 360 will be devloped lateron");
                                  },
                                ),*/
                          /* widget.type == "Loan Application" ||
                                  widget.type == "Loan collection"
                              ? null
                              : isSyncedIndex
                                  ? new IconButton(
                                      icon: new Icon(
                                        FontAwesomeIcons.sync,
                                        color: Colors.orange[400],
                                        size: 25.0,
                                      ),
                                      onPressed: () async {
                                        _syncCustomerToMiddleware(items[index]);
                                      },
                                    )
                                  : new IconButton(
                                      icon: new Icon(
                                        FontAwesomeIcons.sync,
                                        color: Colors.grey,
                                        size: 25.0,
                                      ),
                                      onPressed: () async {
                                        showMessageWithoutProgress(
                                            "Customer Already Synced");
                                      },
                                    ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilderNotSynced;
    if (count == 1) {
      count++;
      try {
        //print(CustomerListBean);
        futureBuilderNotSynced = new FutureBuilder(
            future: AppDatabase.get()
                .selectCustomerList()
                .then((List<CustomerListBean> customerData) {
              items.clear();
              storedItems.clear();
              customerData.forEach((f) {
                if (widget.type == "Loan Application") {
                  if (f.misCbCheckDone == 1) {
                    items.add(f);
                    storedItems.add(f);
                  } else if (mIsProspectRepeatNeeded == 0) {
                    items.add(f);
                    storedItems.add(f);
                  }
                } else if (widget.type == "Loan collection") {
                  if (f.mcustno !=null && f.mcustno > 0) {
                    if (widget.firstParms == false) {
                      if (f.mcenterid == 0) {
                        items.add(f);
                        storedItems.add(f);
                      }
                    } else {
                      items.add(f);
                      storedItems.add(f);
                    }
                  }
                } else {
                  items.add(f);
                  storedItems.add(f);
                }
              });
              return storedItems;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Press button to start');
                case ConnectionState.waiting:
                  return new Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child:
                          new CircularProgressIndicator()); // new Text('Awaiting result...');
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return getHomePageBody2(context, snapshot);
              }
            });
      } catch (e) {
        futureBuilderNotSynced = new Text("Nothing To display");
      }
    } else if (items != null) {
      futureBuilderNotSynced = ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: items.length,
        // A callback that will return a widget.
        itemBuilder: (context, position) {
          /*      Color color;
          if (position % 2 == 1) {
            // color = Color(0xffe8eaf6);
            color = Colors.brown[50];
          } else {
            color = Colors.white;
          }*/
          double c_width = MediaQuery.of(context).size.width * 10;
          String longName = items[position].mlongname.toString() != null &&
                  items[position].mlongname.toString() != 'null'
              ? items[position].mlongname.toString()
              : "";
          String firstName = items[position].mfname.toString() != null &&
                  items[position].mfname.toString() != 'null'
              ? items[position].mfname.toString()
              : "";
          String middleName = items[position].mmname.toString() != null &&
                  items[position].mmname.toString() != 'null'
              ? items[position].mmname.toString()
              : "";
          String lastName = items[position].mlname.toString() != null &&
                  items[position].mlname.toString() != 'null'
              ? items[position].mlname.toString()
              : "";
          DateTime applicantDob = items[position].mcreateddt != null &&
                  items[position].mcreateddt != 'null'
              ? items[position].mcreateddt
              : DateTime.now();
          String centerNumber = items[position].mcenterid.toString() != null &&
                  items[position].mcenterid.toString() != 'null'
              ? items[position].mcenterid.toString()
              : "";
          String groupNumber = items[position].mgroupcd.toString() != null &&
                  items[position].mgroupcd.toString() != 'null'
              ? items[position].mgroupcd.toString()
              : "";
          String errorMsg = items[position].merrormessage.toString() != null &&
                  items[position].merrormessage.toString() != 'null'
              ? items[position].merrormessage.toString()
              : "";
          bool showErrMsg = true;
          if (errorMsg == "null" || errorMsg == "" || errorMsg == null) {
            showErrMsg = false;
          }

          bool isSyncedPosition = false;

          if (items[position].mlastsynsdate == null ||
              items[position].mlastsynsdate == 'null' ||
              (items[position].mcreateddt != null &&
                  items[position].mcreateddt != 'null' &&
                  items[position]
                      .mcreateddt
                      .isAfter(items[position].mlastsynsdate)) ||
              (items[position].mlastupdatedt != null &&
                  items[position].mlastupdatedt != 'null' &&
                  items[position]
                      .mlastupdatedt
                      .isAfter(items[position].mlastsynsdate)) ||
              (items[position].mrefno == null && items[position].mrefno == 0)) {
            isSyncedPosition = true;
          }

          // In our case, a DogCard for each doggo.
          return new GestureDetector(
            onTap: () {
              globals.customerNumber = items[position].trefno.toString();
              _onTapItem(context, items[position]);
            },
            child: new Card(
              //color Color(0xff2f1f4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 25.0,
              child: new Padding(
                padding: new EdgeInsets.only(
                  left: 3.0,
                  right: 3.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 3.0),

                      // width: c_width,
                      child: Container(
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                ThemeDesign.loginGradientEnd,
                                ThemeDesign.loginGradientStart,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        //color: color,
                        child: Column(
                          children: <Widget>[
                            new Text(
                              longName==null || longName=='null' || longName==''?firstName+" "+middleName+" "+lastName:longName,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Container(
                                padding: EdgeInsets.only(left: 5.0),
                                //color: Colors.green,
                                child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      "Trefno:" +
                                          items[position].trefno.toString() +
                                          "  ",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    Text(
                                      "Mrefno:" +
                                                  items[position]
                                                      .mrefno
                                                      .toString() !=
                                              null
                                          ? items[position].mrefno.toString()
                                          : "Sync To get Mrefno",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                      /*  new IconButton(
                            icon: new Icon(Icons.delete_forever, color: Colors.red),
                            onPressed: () => {_deleteIt(items[position].trefno,items[position].mrefno)},
                      ),*/
                                    Padding(
                                      padding: new EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Icon(
                                            FontAwesomeIcons.user,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                          Text(
                                            items[position]
                                                            .mcustno
                                                            .toString() !=
                                                        null &&
                                                    items[position]
                                                            .mcustno
                                                            .toString() !=
                                                        'null'
                                                ? items[position]
                                                    .mcustno
                                                    .toString()
                                                : "",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: new Row(
                        children: [
                          new Expanded(
                            child: new Text(
                              items[position].merrormessage != null &&
                                      items[position]
                                              .merrormessage
                                              .toString() !=
                                          "" &&
                                      items[position]
                                              .merrormessage
                                              .toString() !=
                                          "null"
                                  ? items[position].merrormessage.toString()
                                  : '',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.red[500]),
                            ),
                          ),
                        ],
                      ),
                      decoration: new BoxDecoration(
                          // backgroundColor: Colors.grey[300],
                          ),
                      width: 400.0,
                    ),
                    new Container(
                      width: c_width,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      items[position].mpannodesc.toString() !=
                                                  null ||
                                              items[position]
                                                      .mpannodesc
                                                      .toString() !=
                                                  ""
                                          ? Text(
                                              "NID :" +
                                                  items[position]
                                                      .mpannodesc
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500],
                                              ),
                                            )
                                          : Text(
                                              "NID :" +
                                                  nidPaddingSpaces.toString(),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 10.0, right: 8.0),
                                        child: new Text(
                                          DateFormat("yyyy, MM, dd")
                                              .format(applicantDob),
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.only(
                                        /*   top: 1.0,
                                  bottom: 1.0,*/
                                        ),
                                    child: new Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      children: <Widget>[
                                        Text(
                                          "   GNO: ${groupNumber}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "CNO: ${centerNumber}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        items[position].mtier != null &&
                                                items[position].mtier != 'null'
                                            ? Text(
                                                "    Cycle:" +
                                                    items[position]
                                                        .mtier
                                                        .toString() +
                                                    "   ",
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey[500]),
                                              )
                                            : Text(
                                                "    Cycle:" + "1" + "   ",
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey[500]),
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.only(
                                        /* top: 1.0,
                                  bottom: 1.0,*/
                                        ),
                                    child: new Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: <Widget>[
                                        new Icon(Icons.phone,
                                            color: Colors.green, size: 18.0),
                                        new Text(
                                          items[position].mmobno.toString(),
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          new ButtonTheme.bar(
                            padding: new EdgeInsets.all(2.0),
                            child: new ButtonBar(
                              children: <Widget>[
                                widget.type == "Loan Application" ||
                                        widget.type == "Loan collection" ||
                                        mIsProspectRepeatNeeded == 0
                                    ? null
                                    : new IconButton(
                                        icon: new Icon(
                                          FontAwesomeIcons.clipboardCheck,
                                          color: (items[position]
                                                              .misCbCheckDone ==
                                                          1 ||
                                                      items[position]
                                                              .misCbCheckDone ==
                                                          2) &&
                                                  DateTime.now().difference(
                                                          items[position]
                                                              .mcbcheckrprtdt) <=
                                                      Duration(
                                                          days:
                                                              highmarkValidity)
                                              ? Colors.grey
                                              : Colors.green,
                                          size: 25.0,
                                        ),
                                        onPressed: () async {
                                          if ((items[position].misCbCheckDone ==
                                                      1 ||
                                                  items[position]
                                                          .misCbCheckDone ==
                                                      2) &&
                                              DateTime.now().difference(
                                                      items[position]
                                                          .mcbcheckrprtdt) <
                                                  Duration(
                                                      days: highmarkValidity)) {
                                            showMessageWithoutProgress(
                                                "Highmark Result is "
                                                "${items[position].misCbCheckDone == 1 ? 'Pass' : 'Fail'}");
                                          } else {
                                            _cnfrmCreateProspect(
                                                items[position]);
                                          }
                                        },
                                      ),
                                widget.type == "Loan Application" ||
                                        widget.type == "Loan collection"
                                    ? null
                                    : new Container()
                                /*IconButton(
                                        icon: new Icon(
                                          FontAwesomeIcons.chartPie,
                                          color: Colors.orange[400],
                                          size: 25.0,
                                        ),
                                        onPressed: () async {
                                          showMessageWithoutProgress(
                                              "Customer 360 will be devloped lateron");
                                        },
                                      ),*/
                                /* widget.type == "Loan Application" ||
                                        widget.type == "Loan collection"
                                    ? null
                                    : isSyncedPosition
                                        ? new IconButton(
                                            icon: new Icon(
                                              FontAwesomeIcons.sync,
                                              color: Colors.orange[400],
                                              size: 25.0,
                                            ),
                                            onPressed: () async {
                                              _syncCustomerToMiddleware(
                                                  items[position]);
                                            },
                                          )
                                        : new IconButton(
                                            icon: new Icon(
                                              FontAwesomeIcons.sync,
                                              color: Colors.grey,
                                              size: 25.0,
                                            ),
                                            onPressed: () async {
                                              showMessageWithoutProgress(
                                                  "Customer Already Synced");
                                            },
                                          ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else
      futureBuilderNotSynced = new Text("nothing to display");
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldHomeState,
          appBar: new AppBar(
              elevation: 3.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff07426A),
              brightness: Brightness.light,
              title: appBarTitle,
              actions: <Widget>[
                new IconButton(
                  icon: actionIcon,
                  onPressed: () {
                    setState(() {
                      if (this.actionIcon.icon == Icons.search) {
                        this.actionIcon = new Icon(Icons.close);
                        this.appBarTitle = new TextField(
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                          decoration: new InputDecoration(
                              prefixIcon:
                                  new Icon(Icons.search, color: Colors.white),
                              hintText: "Search...",
                              hintStyle: new TextStyle(color: Colors.white)),
                          onChanged: (val) {
                            filterList(val.toLowerCase());
                          },
                        );
                      } else {
                        String custListLeng = storedItems != null &&
                                storedItems.length != null &&
                                storedItems.length > 0
                            ? "/" + storedItems.length.toString()
                            : "";
                        this.actionIcon = new Icon(Icons.search);
                        this.appBarTitle =
                            new Text("Customer List" + custListLeng);
                        items = new List<CustomerListBean>();
                        items.clear();
                        storedItems.forEach((val) {
                          items.add(val);
                        });
                      }
                    });
                  },
                ),
              /*  new IconButton(
                  icon: actionIconMic,
                  onPressed: () async{
                    setState(() {
                      if (this.actionIconMic.icon == Icons.mic) {
                        this.actionIconMic = new Icon(Icons.close);
                        if (_isAvailable && !_isListening) {
                         _speechRecognition.listen(locale: "en_US").then(
                              (result) async{
                                 _speechRecognition.setRecognitionResultHandler(
                                      (String speech) => setState(() {
                                        this.appBarTitle = new ListTile(
                                          title: new Text(
                                              "Record.."),
                                          subtitle: speech ==
                                              null
                                              ? new Text("")
                                              : new Text(
                                              "${speech}"),
                                        );
                                        filterList(speech!=null?speech.toLowerCase():"");
                                      }),
                                );

                              }
                              );

                        }
                      } else {
                        String custListLeng = storedItems != null &&
                                storedItems.length != null &&
                                storedItems.length > 0
                            ? "/" + storedItems.length.toString()
                            : "";
                        this.actionIcon = new Icon(Icons.mic);
                        this.appBarTitle =
                            new Text("Customer List" + custListLeng);
                        items = new List<CustomerListBean>();
                        items.clear();
                        storedItems.forEach((val) {
                          items.add(val);
                        });
                      }

                    });
                  },
                ),*/
              ]),
          floatingActionButton: widget.type == "Loan Application" ||
                  widget.type == "Loan Utilization" ||
                  widget.type == "Loan collection"
              ? null
              : new FloatingActionButton(
                  child: new Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  //backgroundColor: Color(0xff07426A),
                  backgroundColor: Colors.green,
                  onPressed: //_insertDummies
                      loadNewCustomerRequestPage),
          body: new Container(
              color: const Color(0xff07426A), child: futureBuilderNotSynced),
        ));
  }

  void loadNewCustomerRequestPage() async {
    await AppDatabase.get().generateCustomerNumber().then((onValue) {
      //  print("Setting Customer Number ${onValue}");
      CustomerFormationMasterTabsState.custListBean.trefno = onValue;
      globals.customerType = "new customer";
      /*ImageBean img = new ImageBean();
      CustomerFormationMasterTabsState.custListBean.imageMaster =  new List<ImageBean>();
      CustomerFormationMasterTabsState.custListBean.imageMaster.add(img);*/
      /*CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
*/
    });
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CustomerFormationMasterTabs(
              widget.firstParms,
              null)), //When Authorized Navigate to the next screen
    );
  }

  IconData getIcon(bool isNegative) {
    IconData icon;
    isNegative ? icon = Icons.arrow_drop_down : icon = Icons.arrow_drop_up;
    return icon;
  }

  void printIt(String ab) {
    // print(ab);
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 20),
    ));
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _onTapItem(BuildContext context, CustomerListBean bean) async {
    if (widget.type == "Loan Application" || widget.type == "Loan collection") {
      Navigator.of(context).pop(bean);
    } else if (widget.type == "Loan Utilization") {
      Navigator.of(context).pop(bean);
    } else if (widget.type == "Savings List") {
      Navigator.of(context).pop(bean);
    } else {
      //check later if cb is done
      await AppDatabase.get().getCenterName(bean.mcenterid).then((val) async {
        bean.mcentername = val;
      });
      // print(bean.mcentername);
      await AppDatabase.get().getGroupName(bean.mgroupcd).then((val) async {
        bean.mgroupname = val;
      });
      //   print(bean.mgroupname);
      //bean.misCbCheckDone =1;
      bean.addressDetails = new List<AddressDetailsBean>();
      bean.familyDetailsList = new List<FamilyDetailsBean>();
      bean.customerBusinessDetailsBean =
          new List<CustomerBusinessDetailsBean>();
      // bean.pPIMasterBean = new List<PPIMasterBean>();
      bean.borrowingDetailsBean = new List<BorrowingDetailsBean>();
      bean.socialFinancialList = new List<SocialFinancialDetailsBean>();

      bean.imageMaster = new List<ImageBean>();
      bean.businessExpendDetailsList =
          new List<BusinessExpenditureDetailsBean>();
      bean.householdExpendDetailsList =
          new List<HouseholdExpenditureDetailsBean>();
      bean.esmsentity = new ESMSBean();
      bean.riskratingsentity = new RiskRatingsBean();

      for (int i = 0; i < 23; i++) {
        bean.imageMaster.add(new ImageBean());
      }

      await AppDatabase.get()
          .selectCustomerFamilyDetailsListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<FamilyDetailsBean> familyDetailsBean) async {
        for (int i = 0; i < familyDetailsBean.length; i++) {
          bean.familyDetailsList.add(familyDetailsBean[i]);
        }
        // print("Family Details list is ${bean.familyDetailsList}");
      });

      await AppDatabase.get()
          .selectCustomerBankDetailsListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<SocialFinancialDetailsBean> socialFinancialDetailsBean) async {
        for (int i = 0; i < socialFinancialDetailsBean.length; i++) {
          bean.socialFinancialList.add(socialFinancialDetailsBean[i]);
        }
      });

      await AppDatabase.get()
          .selectCustomerBussinessDetailsListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((List<CustomerBusinessDetailsBean>
              customerBusinessDetailsBean) async {
        for (int i = 0; i < customerBusinessDetailsBean.length; i++) {
          bean.customerBusinessDetailsBean.add(customerBusinessDetailsBean[i]);
        }
        // print("Family Details list is ${bean.familyDetailsList}");
      });
      await AppDatabase.get()
          .selectCustomerBorrowingDetailsListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((List<BorrowingDetailsBean> borrowingDetailsBean) async {
        for (int i = 0; i < borrowingDetailsBean.length; i++) {
          bean.borrowingDetailsBean.add(borrowingDetailsBean[i]);
        }

        //  print("Borrowing  Details list is ${bean.borrowingDetailsBean}");
      });

      await AppDatabase.get()
          .selectCustomerAddressDetailsListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((List<AddressDetailsBean> addressDetails) async {
        for (int i = 0; i < addressDetails.length; i++) {
          bean.addressDetails.add(addressDetails[i]);
        }

        // print("Addres  Details list is ${bean.addressDetails}");
      });

      await AppDatabase.get()
          .selectImagesListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<ImageBean> imageBean) async {
        for (int i = 0; i < imageBean.length; i++) {
          bean.imageMaster[imageBean[i].tImgrefno] = imageBean[i];

          /*     print(
              "for bean ${imageBean[i].tImgrefno} is ${bean.imageMaster[imageBean[i].tImgrefno]}");*/
        }
      });

      /*   await AppDatabase.get()
          .selectCustomerBusinessExpenseListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then(
              (List<BusinessExpenditureDetailsBean> businessExpenseBean) async {
        for (int i = 0; i < businessExpenseBean.length; i++) {
          bean.businessExpendDetailsList.add(businessExpenseBean[i]);
        }
       // print("business expenditure list is ${bean.businessExpendDetailsList}");
      });*/

      /*   await AppDatabase.get()
          .selectCustomerHouseholdExpenseListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((List<HouseholdExpenditureDetailsBean>
              householdExpenseBean) async {
        for (int i = 0; i < householdExpenseBean.length; i++) {
          bean.householdExpendDetailsList.add(householdExpenseBean[i]);
        }
        */ /*print(
            "household expenditure list is ${bean.householdExpendDetailsList}");*/ /*
      });*/

      await AppDatabase.get()
          .selectCustomerAssetDetailListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<AssetDetailsBean> assetDetailsBean) async {
        for (int i = 0; i < assetDetailsBean.length; i++) {
          bean.assetDetailsList.add(assetDetailsBean[i]);
        }
        //  print("asset detail list is ${bean.assetDetailsList}");
      });

      await AppDatabase.get()
          .selectCustomerFixedAssetListIsDataSynced(bean.trefno, bean.mrefno)
          .then((FixedAssetsBean fixedAssetsBean) async {
        bean.fixedAssetsList = fixedAssetsBean;
      });

      await AppDatabase.get()
          .selectCustomerCurrentAssetListIsDataSynced(bean.trefno, bean.mrefno)
          .then((CurrentAssetsBean currentAssetsBean) async {
        bean.currentAssetsList = currentAssetsBean;
      });

      await AppDatabase.get()
          .selectCustomerCurrentAssetListIsDataSynced(bean.trefno, bean.mrefno)
          .then((CurrentAssetsBean currentAssetsBean) async {
        bean.currentAssetsList = currentAssetsBean;
      });

      await AppDatabase.get()
          .selectCustomerLongTermLiabilitiesListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((LongTermLiabilitiesBean longTermLiabilitiesBean) async {
        bean.longTermLiabilitiesList = longTermLiabilitiesBean;
      });

      await AppDatabase.get()
          .selectCustomerShortTermLiabilitiesListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((ShortTermLiabilitiesBean shortTermLiabilitiesBean) async {
        bean.shortTermLiabilitiesList = shortTermLiabilitiesBean;
      });

      await AppDatabase.get()
          .selectCustomerEquityListIsDataSynced(bean.trefno, bean.mrefno)
          .then((EquityBean equityBean) async {
        bean.equityList = equityBean;
      });

      await AppDatabase.get()
          .selectCustomerIncomeStatementListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((IncomeStatementBean incomeStatementBean) async {
        bean.incomeStatementList = incomeStatementBean;
      });

      await AppDatabase.get()
          .selectCustomerTotalExpndtrListIsDataSynced(bean.trefno, bean.mrefno)
          .then(
              (TotalExpenditureDetailsBean totalExpenditureDetailsBean) async {
        bean.totalExpenditureDetailsBean = totalExpenditureDetailsBean;
      });

      await AppDatabase.get()
          .selectCustomerFinancialStatementListIsDataSynced(
              bean.trefno, bean.mrefno)
          .then((FinancialStmntBean financialStmntBean) async {
        bean.financialStmntList = financialStmntBean;
      });

      await AppDatabase.get()
          .selectCustomerESMSDetails(bean.trefno, bean.mrefno)
          .then((ESMSBean customerESMSBean) async {
        // print("returned esms entity dust ${customerESMSBean.mdust}");
        bean.esmsentity = customerESMSBean;
      });

      await AppDatabase.get()
          .selectCustomerRiskRatingsDetails(
          bean.trefno, bean.mrefno)
          .then((RiskRatingsBean riskRatingsBean) async {
        bean.riskratingsentity = riskRatingsBean;
      });

      // print("esms entity   "+bean.esmsentity.mdust.toString());
      await routeToCustomerScreenForModificationOfData(bean);
    }
  }

  routeToCustomerScreenForModificationOfData(CustomerListBean bean) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              new CustomerFormationMasterTabs(widget.firstParms, bean),
        ));
  }

/*
  Future getUsrCodeBranchCode() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      beanObj.mlbrcode = globals.branchId;
      beanObj.mcreatedby = globals.agentUserName;
      beanObj.mcreateddt = DateTime.now();
      beanObj.mlastupdateby = prefs.get("${TablesColumnFile.usrCode}");
      beanObj.mlastupdatedt = DateTime.now();

    });
  }
*/
  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }

  void submitProspectForCustomer(CustomerListBean item) async {
    CreditBereauBean cbbObj = await AppDatabase.get()
        .getLastProspectFromId(item.mpannodesc, item.mIdDesc);
    if (cbbObj != null) {
      if (item.misCbCheckDone == 1 || item.misCbCheckDone == 2) {
        if (DateTime.now().difference(cbbObj.mcreateddt) <
            Duration(days: highmarkValidity)) {
          showConfrmAlrt(cbbObj, item);
        } else {
          await createNewProspect(item);
        }
      } else {
        await createNewProspect(item);
      }
    } else {
      await createNewProspect(item);
    }
  }

  Future<void> createNewProspect(CustomerListBean item) async {
    CreditBereauBean beanObj = new CreditBereauBean();
    item.addressDetails = new List<AddressDetailsBean>();
    await AppDatabase.get()
        .selectCustomerAddressDetailsListIsDataSynced(item.trefno, item.mrefno)
        .then((List<AddressDetailsBean> addressDetails) async {
      for (int i = 0; i < addressDetails.length; i++) {
        item.addressDetails.add(addressDetails[i]);
      }

      if (addressDetails.isEmpty) {
        showMessageWithoutProgress("Add atleast 1 contact details ");
        return;
      }

      //  print("Addres  Details list is ${item.addressDetails}");
    });

    if (item.addressDetails.isNotEmpty) {
      beanObj.mhouse = item.addressDetails.last.maddr1;

      beanObj.mstreet = item.addressDetails.last.maddr2;

      beanObj.mpincode = item.addressDetails.last.mpinCd;
      StateDropDownList stateBean =
          await AppDatabase.get().getState(item.addressDetails.last.mState);
      DistrictDropDownList distBean =
          await AppDatabase.get().getdist(item.addressDetails.last.mDistCd);
      if (distBean != null && distBean != "null" && distBean != "") {
        beanObj.mcity = distBean.distDesc.trim();
      }
      beanObj.mstate = stateBean.stateDesc;

      // print(item.addressDetails.last.mstatedesc);
      beanObj.mmobno = int.parse(item.addressDetails.last.mMobile);
    }

    try {
      if (item.mpannodesc != null && item.mpannodesc.trim != "") {
        Verhoeff vObj = new Verhoeff();
        bool result = vObj.validateVerhoeff(item.mpannodesc.trim());
        if (result == false) {
          showMessageWithoutProgress("Adhaar Not valid");
          return;
        }
      } else {
        showMessageWithoutProgress("Adhaar Not valid");
        return;
      }
    } catch (_) {
      showMessageWithoutProgress("Adhaar Not valid");
      return;
    }

    await AppDatabase.get().getMaxTrefNo().then((val) async {
      beanObj.trefno = val;
    });
    if (beanObj.mmobno != null && beanObj.mmobno == item.motpvrfdno) {
      beanObj.motpverified = 1;
    } else
      beanObj.motpverified = 0;
    beanObj.mrefno = 0;
    beanObj.missynctocoresys = 0;
    beanObj.mprospectstatus = 0;
    beanObj.miscustcreated = 1;
    beanObj.misuploaded = 0;
    beanObj.mprospectname = ifNullCheck(item.mfname) +
        " " +
        ifNullCheck(item.mmname) +
        ifNullCheck(item.mlname);

    beanObj.mlbrcode = item.mlbrcode;
    beanObj.mprospectdt = null;
    beanObj.mdob = item.mdob;
    beanObj.mcbcheckstatus = "";
    beanObj.mprospectstatus = 0;
    beanObj.madd1 = item.mAdd1;
    beanObj.madd2 = item.mAdd2;
    beanObj.madd3 = item.mAdd3;
    beanObj.mhomeloc = item.mHouse;
    beanObj.mareacd = item.mArea;
    beanObj.mpanno = item.mpannodesc;
    beanObj.mspousename = item.mhusbandname;
    beanObj.mid1 = item.mTypeOfId.toString();
    beanObj.mid1desc = item.mIdDesc;
    beanObj.mnomineename = item.mhusbandname;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.get("${TablesColumnFile.musrcode}") == null ||
          prefs.get("${TablesColumnFile.musrcode}").toString().trim() == "")
        showMessageWithoutProgress("User Code not valid");
      beanObj.mcreatedby = prefs.get("${TablesColumnFile.musrcode}");
    } catch (_) {
      // print("Exception");
      showMessageWithoutProgress("User Code not valid");
    }

    beanObj.mcreateddt = DateTime.now();
    beanObj.mlastupdatedt = DateTime.now();
    beanObj.mlastupdateby = item.mlastupdateby;
    beanObj.mgeolocation = item.mgeolocation;
    beanObj.mgeolatd = item.mgeolatd;
    beanObj.mgeologd = item.mgeologd;
    beanObj.missynctocoresys = item.missynctocoresys;
    beanObj.mlastsynsdate = item.mlastsynsdate;
    beanObj.mtier = item.mtier;
    beanObj.mcustno = item.mcustno;

    //  print(beanObj);
    if (beanObj.mprospectname == null || beanObj.mprospectname.trim() == "") {
      showMessageWithoutProgress("Add a valid name");
      return;
    }
    if (beanObj.mmobno == null || beanObj.mmobno.toString().length != 10) {
      showMessageWithoutProgress("Add  a valid mobile number");
      return;
    }

    if (item.mIdDesc == null ||
        item.mIdDesc.trim() == "" ||
        item.mIdDesc.trim() == "null") {
      showMessageWithoutProgress("Add  a valid ID 2");
      return;
    }
    if (item.mTypeOfId == null || item.mTypeOfId == 0) {
      showMessageWithoutProgress("Add  a valid ID 2 Type ");
      return;
    }

    await AppDatabase.get().updateCreditBereauMaster(beanObj).then((value) {});

    _successfulSubmit(beanObj.mprospectname, beanObj.motpverified);
  }

  Future<void> _successfulSubmit(String applicantName, int otpVerified) async {
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
                  Text('Prospect Created  Named: ${applicantName}')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  globals.OTP = null;
                  if (otpVerified == 0) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SMSVerification()));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ProspectView()));
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> showConfrmAlrt(
      CreditBereauBean cbObj, CustomerListBean item) async {
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
                  Text('Prospect Alredy  Created  on : ${cbObj.mcreateddt}'),
                  Text('Name is: ${cbObj.mprospectname}')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Create New'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await createNewProspect(item);
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _cnfrmCreateProspect(CustomerListBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Prospect'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want create new prospect')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                submitProspectForCustomer(item);
              },
            ),
            FlatButton(
              child: Text(
                'No',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _syncCustomerToMiddleware(CustomerListBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('CustomerSync'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want Sync this Customer')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                circInd = true;
                Navigator.of(context).pop();
                syncCustomerToMiddleware(item);
                _ShowCircInd(item);
              },
            ),
            FlatButton(
              child: Text(
                'No',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ShowCircInd(CustomerListBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('CustomerSync'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
  }

  void syncCustomerToMiddleware(CustomerListBean item) async {
    try {
      SyncingCustomertoMiddleware syncingCustomerToMiddleware =
          new SyncingCustomertoMiddleware();
      await syncingCustomerToMiddleware.SyncSingleCustomerToMiddleware(
              item, lastSyncedToServerDaeTime)
          .then((onValue) {
        /*setState(() {
          circInd == false;
        });*/

        Navigator.of(context).pop();
        //Navigator.of(context).pop();

        if (onValue != null) {
          _successfulSinglecustomerSyncedToServer(onValue);
        } else {
          showMessageWithoutProgress("SomeThing wentWrong Syncing Customer");
        }
      });
    } catch (_) {
      showMessageWithoutProgress("Server Exception");
    }
  }

  Future<void> _successfulSinglecustomerSyncedToServer(
      CustomerCheckBean custCheckBean) async {
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
                  Text(
                      'Customer Synced to server for mrefno : ${custCheckBean.mrefno} And trefno : ${custCheckBean.trefno},'),
                  Text('Customer No : ${custCheckBean.mcustno} '),
                  Text('error Message : ${custCheckBean.merrormessage} ')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    count = 1;
                  });
                },
              ),
            ],
          );
        });
  }

  _deleteIt(int trefno, int mrefno) async{
    Navigator.of(context).pop();
    await AppDatabase.get().deleCustMaster(mrefno,trefno);
    await AppDatabase.get().deleAddDetails(mrefno,trefno);
    await AppDatabase.get().deleFamDetails(mrefno,trefno);
    await AppDatabase.get().deleBankDetails(mrefno,trefno);
    await AppDatabase.get().deleBorrowDetails(mrefno,trefno);
    await AppDatabase.get().deleBussDetails(mrefno,trefno);
    await AppDatabase.get().deleImageMaster(mrefno,trefno);
    await AppDatabase.get().deleAssetDetails(mrefno,trefno);
    await AppDatabase.get().deleFixedAssetDetails(mrefno,trefno);
    await AppDatabase.get().deleCurrentAssetDetails(mrefno,trefno);
    await AppDatabase.get().deleLongTermLiability(mrefno,trefno);
    await AppDatabase.get().deleShortTermLiability(mrefno,trefno);
    await AppDatabase.get().deleEquity(mrefno,trefno);
    await AppDatabase.get().deleincmStatement(mrefno,trefno);
    await AppDatabase.get().delefinStatement(mrefno,trefno);
    await AppDatabase.get().deleESMS(mrefno,trefno);
    await AppDatabase.get().deleriskrating(mrefno,trefno);
    await AppDatabase.get().deletotalexp(mrefno,trefno);




















  }
}
