import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_los/Utilities/app_constant.dart' as oonstant;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_los/Utilities/app_constant.dart'
as labels;
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_los/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_los/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_los/pages/workflow/Savings/SavingsCollection.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_los/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_los/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';

import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/pages/workflow/collection/list/DailyLoanCollectionList.dart';
import 'package:eco_los/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingsCollectionSearchScreen extends StatefulWidget {
  SavingsCollectionSearchScreen();

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _CollectionSearchScreen createState() => new _CollectionSearchScreen();
}

class _CollectionSearchScreen extends State<SavingsCollectionSearchScreen> {
  TextEditingController branchController = new TextEditingController();
  TextEditingController pagesRequiredForPagination = new TextEditingController(text: "5");
  TextEditingController loanOfficerController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SystemParameterBean sysBean = new SystemParameterBean();
  //AnimationController textInputAnimationController;
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection();
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection();
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  int branch = 0;
  String usrRole ="";
  String centerName="";
  String centerNo="";
  String groupName="";
  String groupNo="";
  String customerName="";
  String customerNo="";
  String productName="";
  String productNo="";
  String requiredPages="5";
  String mIsGroupNeeded = "Y";
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      if (prefs.getString(TablesColumnFile.mIsGroupNeeded) != null &&
          prefs.getString(TablesColumnFile.mIsGroupNeeded).trim() !=
              "") {
        mIsGroupNeeded =
            prefs.getString(TablesColumnFile.mIsGroupNeeded);

        if (mIsGroupNeeded != null &&
            mIsGroupNeeded.trim().toUpperCase() == 'N') {
          globals.isMemeberOfGroupForSvngColl = false;
        }
      }

      branchController.value = TextEditingValue(text: branch.toString());
      loanOfficerController.value = TextEditingValue(
        text: username.toString(),
      );
      pagesRequiredForPagination.value =
          TextEditingValue(text: requiredPages.toString());
    });
  }


  Widget otherLoan() => SavingsCollectionSearchScreen._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesIsMemberOfGroup, 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontSize: 10.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: globals.isMemberOfGroupListSvngColl[position],
            onChanged: (selection) {

              if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.toUpperCase() == 'N'){
                return null;
              }
              return _onRadioSelected(selection, position);

            } ,
            activeColor: Color(0xff07426A),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection, int position) {
    setState(() => globals.isMemberOfGroupListSvngColl[position] = selection);
    if (position == 0) {
      globals.memberOfGroupSvngColl =
      globals.radioCaptionValuesIsMemberOfGroup[selection];
      if (globals.memberOfGroupSvngColl == 'Yes') {
        globals.isMemeberOfGroupForSvngColl = true;
      } else {
        centerName = "";
        centerNo = "";
        groupName = "";
        groupNo = "";
        globals.isMemeberOfGroupForSvngColl = false;
      }
    }
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    TextEditingController(text: "5");
    globals.isMemeberOfGroupForSvngColl =true;
    globals.memberOfGroupSvngColl = 'Yes';
    globals.isMemberOfGroupListSvngColl = [0];
    if (mounted) {
      getSessionVariables();
    }
    /*textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));*/
  }

  @override
  void dispose() {
    //textInputAnimationController.dispose();
    super.dispose();
  }
  Widget appBarTitle = new Text("Savings Collection Search");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        /*actions: <Widget>[
            new IconButton(
             // icon: actionIcon,
              onPressed: () {
                setState(() {
                  *//*if (this.actionIcon.icon == Icons.search) {
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
                        *//**//*items = new List<CustomerListBean>();
                        items.clear();
                        filterList(val.toLowerCase());*//**//*
                      },
                    );
                  } else {
                  *//**//*  this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Customer List");
                    items = new List<CustomerListBean>();
                    items.clear();
                    storedItems.forEach((val) {
                      items.add(val);
                    });*//**//*
                  }*//*
                });
              },
            ),

          ]*/),
      body: Form(
        key: _formKey,
        /*onWillPop: () {
            return Future(() => true);
          },*/
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: TextFormField(
                        controller: branchController,
                        //initialValue: branch.toString(),
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.codeBranch,
                            color: Colors.amber.shade500,),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.BRANCH,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: TextFormField(
                        controller: loanOfficerController,
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.centercode,
                            color: Colors.amber.shade500,),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.LOANOFFICER,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              mIsGroupNeeded == "Y"
                  ? new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(
                          globals.radioCaptionCenterGroupDetails[0]),
                      otherLoan(),
                    ]),
              ])
                  : Container(),

           /*   new TextFormField(
                  decoration: const InputDecoration(
                    hintText:  "Enter number of records you want to see in one page",
                    labelText:  "Number of records you want to see in one page",
                    hintStyle: TextStyle(color: Colors.grey),
                    *//*labelStyle: TextStyle(color: Colors.grey),*//*
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(1.0),
                  ),
                  controller: pagesRequiredForPagination,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  onSaved: (String value) {
                    requiredPages =
                        value;
                  }),*/
              /*globals.isMemberOfGroup*/
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForSvngColl && mIsGroupNeeded == "Y"
                  ? Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text("Center Name/No"),
                    subtitle:
                    new Text("${centerName} ${centerNo}"),
                    onTap: getCenter/*() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  _myCenterDialog,
                              fullscreenDialog: true,
                            ));
                      },*/
                ),
              )
                  : Container(),
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForSvngColl && mIsGroupNeeded == "Y"
                  ? Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text("Group Name/No"),
                    subtitle:
                    new Text("${groupName} ${groupNo}"),
                    onTap: getGroup/*() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => _myGroupDialog,
                              fullscreenDialog: true,
                            ));
                      },*/
                ),
              )
                  : Container(),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text("Cutomer Name/No"),
                    subtitle:
                    new Text("${customerName} ${customerNo}"),
                    onTap: () => getCustomerNumber()),
              ),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text("Product Name/No"),
                    subtitle:
                    new Text("${productName} ${productNo}"),
                    onTap: () => getProduct()),
              ),
              SizedBox(height: 5.0),
              new TextFormField(
                  decoration: const InputDecoration(
                    hintText: labels.ENTERPAGESCOUNT,
                    labelText:  labels.PAGESCOUNT,
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  controller: pagesRequiredForPagination,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  onSaved: (String value) {
                    requiredPages = value;
                  }),

              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: Text(oonstant.searchList),
                            textColor: Colors.amber.shade500,
                            onPressed: () {
                              int mcenterid;
                              int mgroupid ;
                              int custNo;
                              int prcdNo;
                              int paginationCount;

                        try{
                          mcenterid =  centerNo!=null && centerNo.trim()!='null'&& centerNo.trim()!=''?int.parse(centerNo.trim()):0;
                          mgroupid =groupNo!=null && groupNo.trim()!='null'&& groupNo.trim()!=''?int.parse(groupNo.trim()):0;
                          custNo =customerNo!=null && customerNo.trim()!='null'&& customerNo.trim()!=''?int.parse(customerNo.trim()):0;
                          prcdNo =productNo!=null && productNo.trim()!='null'&& productNo.trim()!=''?int.parse(productNo.trim()):0;
                          paginationCount =requiredPages!=null && requiredPages.trim()!='null'&& requiredPages.trim()!=''?int.parse(requiredPages.trim()):0;

                        }catch(_){
                          print("Exception while parsing int in serach screen crieteria");
                        }

                              if (/*globals.isMemberOfGroup*/ globals.isMemeberOfGroupForSvngColl= /*true*/false) {
                                mcenterid=0;
                                mgroupid=0;

                        }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SavingsCollectionList(mcenterid,mgroupid,custNo,prcdNo,paginationCount)));
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: Text(oonstant.viewList),
                            textColor: Colors.amber.shade500,
                       /*     onPressed: () {
                              int mcenterid;
                              int mgroupid;
                              DateTime toDate;
                              DateTime fromDate;
                              int custNo;
                              int prcdNo;
                              int paginationCount;

                              try {
                                mcenterid = centerNo != null &&
                                    centerNo.trim() != 'null' &&
                                    centerNo.trim() != ''
                                    ? int.parse(centerNo.trim())
                                    : 0;
                                mgroupid = groupNo != null &&
                                    groupNo.trim() != 'null' &&
                                    groupNo.trim() != ''
                                    ? int.parse(groupNo.trim())
                                    : 0;
                                toDate = DateTime.now();
                                fromDate = DateTime.now();
                                custNo = customerNo != null &&
                                    customerNo.trim() != 'null' &&
                                    customerNo.trim() != ''
                                    ? int.parse(customerNo.trim())
                                    : 0;
                                prcdNo = productNo != null &&
                                    productNo.trim() != 'null' &&
                                    productNo.trim() != ''
                                    ? int.parse(productNo.trim())
                                    : 0;
                                paginationCount = requiredPages != null &&
                                    requiredPages.trim() != 'null' &&
                                    requiredPages.trim() != ''
                                    ? int.parse(requiredPages.trim())
                                    : 0;
                              } catch (_) {
                                print(
                                    "Exception while parsing int in serach screen crieteria");
                              }

                              if (globals.isMemeberOfGroupForSvngColl == false) {
                                mcenterid = 0;
                                mgroupid = 0;
                              }

                              AppDatabase.get()
                                  .selectSavingsList(
                                  mcenterid,
                                  mgroupid,
                                  custNo,
                                  prcdNo)
                                  .then((List<SavingsListBean>
                              savingsListBean) {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SavingsCollectionList(mcenterid,mgroupid,custNo,prcdNo,paginationCount)));
                              });


                            },*/
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }



  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(/*globals.isMemberOfGroup*/globals.isMemeberOfGroupForSvngColl,"Loan collection")));
    if (customerdata != null) {
      customerNo =
      customerdata.mcustno != null ? customerdata.mcustno.toString() : "0";
      customerName = customerdata.mlongname;

    }
  }

  Future getProduct() async {
    ProductBean prodObj =    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(11,0),
          fullscreenDialog: true,
        ));

    productName = prodObj.mname;
    productNo = prodObj.mprdCd.toString();

  }
  Future getCenter() async{
    CenterDetailsBean getCenterFoundationList = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          _myCenterDialog,
          fullscreenDialog: true,
        ))/*.then<CenterDetailsBean>((onValue){
    centerName = onValue.centerName;
    centerNo = onValue.id.toString();
  });*/;
    centerName = getCenterFoundationList!=null && getCenterFoundationList.mcentername!=null?getCenterFoundationList.mcentername:"";
    centerNo = getCenterFoundationList!=null && getCenterFoundationList.mCenterId!=null?getCenterFoundationList.mCenterId.toString():"";
  }

  Future getGroup() async{
    GroupFoundationBean groupFoundationBean = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          _myGroupDialog,
          fullscreenDialog: true,
        ))/*.then<GroupFoundationBean>((onValue){
      groupName = onValue.groupName;
      groupNo = onValue.groupNumber.toString();
    })*/;
    groupName = groupFoundationBean!=null && groupFoundationBean.mgroupname !=null ?  groupFoundationBean.mgroupname:"";
    groupNo = groupFoundationBean!=null && groupFoundationBean.mgroupid !=null ?  groupFoundationBean.mgroupid.toString():"";
  }

}
