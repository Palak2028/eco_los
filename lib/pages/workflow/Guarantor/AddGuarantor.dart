

import 'dart:async';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ESMSBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FinancialStmntBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/IncomeStatementBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/RiskRatingsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/SocialFinancialDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/TotalExpenditureDetailsBean.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../../translations.dart';

class AddGuarantor extends StatefulWidget {
  final gaurantorDetailsPassedObject;
  final String mleadsId;
  final int mrefno;
  final int trefno;
  AddGuarantor(
      {Key key,
        this.gaurantorDetailsPassedObject,
        this.mleadsId,
        this.mrefno,
        this.trefno})
      : super(key: key);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _AddGuarantorState createState() => new _AddGuarantorState();
}

class _AddGuarantorState extends State<AddGuarantor> {
  static final GlobalKey<FormState> _formKeyNationalId =
  new GlobalKey<FormState>();
  SystemParameterBean sysBean = new SystemParameterBean();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  static String applicantDob = "__-__-____";
  final formatDouble = new NumberFormat("#,##0.00", "en_US");
  String tempYear;
  String tempDay;
  String tempMonth;
  String tempDateH = "----/--/--";
  String tempYearH;
  String tempDayH;
  String tempMonthH;
  DateTime date;
  TimeOfDay time;
  int selectedPosition = 0;
  String customerName;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  LookupBeanData NationalId;
  GuarantorDetailsBean guarantorobj = new GuarantorDetailsBean();
  LookupBeanData ApplicantType;
  LookupBeanData RelationWithApplicant;
  LookupBeanData HouseType;
  LookupBeanData OccupationType;
  LookupBeanData MainOccupation;
  LookupBeanData Gender;
  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode monthFocusH;
  FocusNode yearFocusH;
  bool isExistingCustomerY = true;
  bool AgeNotPresent = true;
  bool GrntrNameNotPresent = true;
  bool Add1NotPresent = true;
  bool Add2NotPresent = true;
  bool NationalIDNotPresent = true;
  bool MobileNotPresent = true;
  bool isSelectedAsguranter = false;

  @override
  void initState() {
    print(" guarantorobj.mrevsrc1" + guarantorobj.mrevsrc1.toString());

    if (widget.gaurantorDetailsPassedObject != null) {
      guarantorobj = widget.gaurantorDetailsPassedObject;
    } else {
      if (widget.mleadsId != null &&
          widget.mleadsId != "null" &&
          widget.mleadsId != "") {
        guarantorobj.mleadsid = widget.mleadsId;
      }
      if (widget.mrefno != null &&
          widget.mrefno != "null" &&
          widget.mrefno != "") {
        guarantorobj.loanmrefno = widget.mrefno;
      }
      if (widget.trefno != "null" &&
          widget.trefno != "" &&
          widget.trefno != null) {
        guarantorobj.loantrefno = widget.trefno;
      }
    }

    getSessionVariables();

    if (guarantorobj.mcreateddt == "null" || guarantorobj.mcreateddt == null) {
      guarantorobj.mcreateddt = DateTime.now();
    }

    super.initState();
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(guarantorobj.mnationalidtype.toString());
    tempDropDownValues.add(guarantorobj.mapplicanttype.toString());
    tempDropDownValues.add(guarantorobj.mgender.toString());
    tempDropDownValues.add(guarantorobj.mrelationwithcust.toString());
    tempDropDownValues.add(guarantorobj.mhousetype.toString());
    tempDropDownValues.add(guarantorobj.moccupationtype.toString());
    tempDropDownValues.add(guarantorobj.mmainoccupation.toString());

    for (int k = 0;
    k < globals.dropdownCaptionsValuesGuarantorInfo.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesGuarantorInfo[k].length;
      i++) {
        try {
          if (globals.dropdownCaptionsValuesGuarantorInfo[k][i].mcode
              .toString()
              .trim() ==
              tempDropDownValues[k].toString().trim()) {
            //   print("Matched");

            setValue(k, globals.dropdownCaptionsValuesGuarantorInfo[k][i]);
          }
        } catch (_) {
          print("Exception Occured in dropdown");
        }
      }
    }
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      // print("inside  code Desc is null");
      switch (no) {
        case 0:
          NationalId = blankBean;
          guarantorobj.mnationalidtype = 0;

          break;
        case 1:
          ApplicantType = blankBean;
          guarantorobj.mapplicanttype = 0;
          break;
        case 2:
          Gender = blankBean;
          guarantorobj.mgender = blankBean.mcode;
          break;

        case 3:
          RelationWithApplicant = blankBean;
          guarantorobj.mrelationwithcust = blankBean.mcode;
          break;

        case 4:
          HouseType = blankBean;
          guarantorobj.mhousetype = 0;
          break;

        case 5:
          OccupationType = blankBean;
          guarantorobj.moccupationtype = 0;
          break;

        case 6:
          MainOccupation = blankBean;
          guarantorobj.mmainoccupation = 0;
          break;

        default:
          break;
      }

      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropdownCaptionsValuesGuarantorInfo[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesGuarantorInfo[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesGuarantorInfo[no][k]);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      //   print("coming here");
      switch (no) {
        case 0:
          NationalId = value;
          guarantorobj.mnationalidtype = int.parse(value.mcode);
          break;
        case 1:
          ApplicantType = value;
          guarantorobj.mapplicanttype = int.parse(value.mcode);
          if (guarantorobj.mapplicanttype == 103 ||
              guarantorobj.mapplicanttype == 106) {
            isSelectedAsguranter = true;
          } else {
            isSelectedAsguranter = false;
          }
          break;
        case 2:
          Gender = value;
          guarantorobj.mgender = value.mcode;
          break;

        case 3:
          RelationWithApplicant = value;
          guarantorobj.mrelationwithcust = value.mcode;
          break;

        case 4:
          HouseType = value;
          guarantorobj.mhousetype = int.parse(value.mcode);
          break;

        case 5:
          OccupationType = value;
          guarantorobj.moccupationtype = int.parse(value.mcode);
          break;

        case 6:
          MainOccupation = value;
          guarantorobj.mmainoccupation = int.parse(value.mcode);
          break;

        default:
          break;
      }
    });
  }

  LookupBeanData blankBean =
  new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    // print("caption value : " + globals.dropdownCaptionsValuesGuarantorInfo[no].toString());

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesGuarantorInfo[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesGuarantorInfo[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //   print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();

    return _dropDownMenuItems1;
  }

  Future<Null> getSessionVariables() async {
    if (guarantorobj.trefno == "" ||
        guarantorobj.trefno == null ||
        guarantorobj.trefno == "null") {
      await AppDatabase.get().generateTrefnoForGuarantor().then((onValue) {
        guarantorobj.trefno = onValue;
      });
    }
    setState(() {});
    prefs = await SharedPreferences.getInstance();

    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser = prefs.getString(TablesColumnFile.reportingUser);
    });
  }

  Widget isExistingCustomer() => AddGuarantor._get(new Row(
    children:
    _makeRadios(2, globals.radioCaptionValuesIsExistingCustomer, 0),
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
            groupValue: globals.isExistingCustomerYN[position],
            onChanged: (selection) => _onRadioSelected(selection, position),
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
    setState(() => globals.isExistingCustomerYN[position] = selection);
    if (position == 0) {
      globals.existingCustomer =
      globals.radioCaptionValuesIsExistingCustomer[selection];
      if (globals.existingCustomer == 'Yes') {
        isExistingCustomerY = true;
      } else {
        isExistingCustomerY = false;
      }
      guarantorobj.mexistingcustyn = selection.toString();
      /*   if (globals.existingCustomer == 'Yes') {
        globals.isExistingCustomerY = true;
      } else {
        globals.isExistingCustomerY= false;
      }*/
    }
  }

  calculate() {
    guarantorobj.mrevtotal = 0.0;
    guarantorobj.mexptotal = 0.0;
    guarantorobj.minctotal = 0.0;
    guarantorobj.mcollvaluetotal = 0.0;

    if (guarantorobj != null) {
      if (guarantorobj.mrev1 != null) {
        guarantorobj.mrevtotal = guarantorobj.mrevtotal + guarantorobj.mrev1;
      }
      if (guarantorobj.mrev2 != null) {
        guarantorobj.mrevtotal = guarantorobj.mrevtotal + guarantorobj.mrev2;
      }

      if (guarantorobj.minc1 != null) {
        guarantorobj.minctotal = guarantorobj.minctotal + guarantorobj.minc1;
      }

      if (guarantorobj.minc2 != null) {
        guarantorobj.minctotal = guarantorobj.minctotal + guarantorobj.minc2;
      }

      if (guarantorobj.mexp1 != null) {
        guarantorobj.mexptotal = guarantorobj.mexptotal + guarantorobj.mexp1;
      }

      if (guarantorobj.mexp2 != null) {
        guarantorobj.mexptotal = guarantorobj.mexptotal + guarantorobj.mexp2;
      }

      if (guarantorobj.mcollvalue1 != null) {
        guarantorobj.mcollvaluetotal =
            guarantorobj.mcollvaluetotal + guarantorobj.mcollvalue1;
      }
      if (guarantorobj.mcollvalue2 != null) {
        guarantorobj.mcollvaluetotal =
            guarantorobj.mcollvaluetotal + guarantorobj.mcollvalue2;
      }
      if (guarantorobj.mcollvalue3 != null) {
        guarantorobj.mcollvaluetotal =
            guarantorobj.mcollvaluetotal + guarantorobj.mcollvalue3;
      }
    }
  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(context, Translations.of(context).text('rusre'),
        Translations.of(context).text('gogrn'), "gggggg");
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
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          callDialog();
        },
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            elevation: 1.0,
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  callDialog();
                }),
            backgroundColor: Color(0xff07426A),
            brightness: Brightness.light,
            title: new Text(
              'Guarantor/Co-applicant/Spouse - Details',
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
            onChanged: () async {
              final FormState form = _formKey.currentState;
              calculate();
              form.save();
              //await calculate();
            },
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                Card(
                  color: Constant.mandatoryColor,
                  child: new ListTile(
                      title: new Text(Translations.of(context).text('CUSTOMERNUMBER')),
                      subtitle: guarantorobj.mcustno == null
                          ? new Text("")
                          : new Text(
                          "${guarantorobj.mcustno != null && guarantorobj.mcustno.toString() != null && guarantorobj.mcustno.toString() != 'null' ? guarantorobj.mcustno : ""} ${guarantorobj.mnameofguar != null && guarantorobj.mnameofguar.toString() != null && guarantorobj.mnameofguar.toString() != 'null' ? guarantorobj.mnameofguar : ""}"),
                      onTap: () => getCustomerId()),
                ),

                //TODO
                Card(
                  color: Constant.mandatoryColor,
                  child: new ListTile(
                      title: new Text(Translations.of(context).text('Ldrfno')),
                      subtitle: guarantorobj.mleadsid == null
                          ? new Text("")
                          : new Text(
                          "${guarantorobj.mleadsid != null && guarantorobj.mleadsid.toString() != null && guarantorobj.mleadsid.toString() != 'null' ? guarantorobj.mleadsid.toUpperCase() : ""}/${guarantorobj.loantrefno.toString()} - ${guarantorobj.loanmrefno != null && guarantorobj.loanmrefno.toString() != null && guarantorobj.loanmrefno.toString() != 'null' ? guarantorobj.loanmrefno : ""}")),
                ),
                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: ApplicantType,
                    items: generateDropDown(1),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 1);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('CustTyp')),
                  ),
                ),

                isSelectedAsguranter == true
                    ? new Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        decoration:
                        BoxDecoration(color: Constant.mandatoryColor),
                        child: new Row(
                          children: <Widget>[
                            Text(
                              Translations.of(context).text('AvgRvnueandExp'),
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 25.0),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*    new Container(
                              width: 150.0,
                              child: new Text("Land",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0)),
                            ),*/
                          new Container(
                            width: 150.0,
                            child: new Text("1",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18.0)),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          new Container(
                            width: 150.0,
                            child: new Text("2",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18.0)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*    new Container(
                              width: 150.0,
                              child: new Text("Land",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0)),
                            ),*/
                          //SizedBox(height: 10.0,),
                          new Container(
                            width: 250.0,
                            child: new TextFormField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(50),
                              ],
                              controller: guarantorobj != null &&
                                  guarantorobj.mrevsrc1 != null
                                  ? TextEditingController(
                                  text: guarantorobj.mrevsrc1)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mrevsrc1 = value;
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('ReveSurce'),
                                  labelText: Translations.of(context).text('ReveSurce'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            width: 250.0,
                            child: new TextFormField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(50),
                              ],
                              controller: guarantorobj.mrevsrc2 != null &&
                                  guarantorobj.mrevsrc2 != null
                                  ? TextEditingController(
                                  text: guarantorobj.mrevsrc2)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mrevsrc2 = value;
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('RevSr2'),
                                  labelText: Translations.of(context).text('RevSr2'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*    new Container(
                              width: 150.0,
                              child: new Text("Land",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0)),
                            ),*/
                          new Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.mnamesrc1 != null
                                  ? TextEditingController(
                                  text: guarantorobj.mnamesrc1)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mnamesrc1 = value;
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText:
                                  Translations.of(context).text('NmIncMkr'),
                                  labelText: Translations.of(context).text('NmIncMkr'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj.mnamesrc2 != null
                                  ? TextEditingController(
                                  text: guarantorobj.mnamesrc2)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mnamesrc2 = value;
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText:
                                  Translations.of(context).text('NmIncMkr2'),
                                  labelText: Translations.of(context).text('NmIncMkr2'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*    new Container(
                              width: 150.0,
                              child: new Text("Land",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0)),
                            ),*/
                          new Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.mrev1 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.mrev1))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mrev1 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('revenue'),
                                  labelText: Translations.of(context).text('revenue'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj.mrev2 != null &&
                                  guarantorobj.mrev2 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.mrev2))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mrev2 =
                                      double.parse(value);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('revenue'),
                                  labelText: Translations.of(context).text('revenue'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*  new Container(
                              width: 150.0,
                              child: new Text("Expense",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0)),
                            ),*/
                          new Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.mexp1 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.mexp1))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mexp1 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('expense'),
                                  labelText: Translations.of(context).text('expense'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj.mrev2 != null &&
                                  guarantorobj.mexp2 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.mexp2))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mexp2 =
                                      double.parse(value);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('expense'),
                                  labelText: Translations.of(context).text('expense'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*new Container(
                              width: 150.0,
                              child: new Text("Land",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0)),
                            ),*/
                          new Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.minc1 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.minc1))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.minc1 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('Incme'),
                                  labelText: Translations.of(context).text('Incme'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            width: 250.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.minc2 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.minc2))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.minc2 =
                                      double.parse(value);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('Incme'),
                                  labelText: Translations.of(context).text('Incme'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          )
                        ],
                      ),
                      new ListTile(
                        title: new Text(
                            Translations.of(context).text('mrevtotal')),
                        subtitle: guarantorobj == null ||
                            guarantorobj.mrevtotal == null
                            ? new Text("")
                            : new Text("${guarantorobj.mrevtotal}"),
                      ),
                      SizedBox(height: 16.0),
                      new ListTile(
                        title: new Text(
                            Translations.of(context).text('mexptotal')),
                        subtitle: guarantorobj == null ||
                            guarantorobj.mexptotal == null
                            ? new Text("")
                            : new Text("${guarantorobj.mexptotal}"),
                      ),
                      SizedBox(height: 16.0),
                      new ListTile(
                        title: new Text(
                            Translations.of(context).text('minctotal')),
                        subtitle: guarantorobj == null ||
                            guarantorobj.minctotal == null
                            ? new Text("")
                            : new Text("${guarantorobj.minctotal}"),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                )
                    : new Container(),
                // ),

                isSelectedAsguranter == true
                    ? Container(
                  decoration:
                  BoxDecoration(color: Constant.mandatoryColor),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        Translations.of(context).text('PropOfGrntr'),
                        style:
                        TextStyle(color: Colors.blue, fontSize: 25.0),
                      )
                    ],
                  ),
                )
                    : Container(),
                isSelectedAsguranter == true
                    ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowHeight: 100.0,
                    rows: [
                      new DataRow(cells: [
                        new DataCell(
                          new Text(
                            "1 ",
                            style: TextStyle(),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(50),
                              ],
                              controller: guarantorobj != null &&
                                  guarantorobj.minc1 != null
                                  ? TextEditingController(
                                  text: guarantorobj.mpldggurproprty1)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mpldggurproprty1 = value;
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('Descr'),
                                  labelText: Translations.of(context).text('Descr'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.msize1 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.msize1))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.msize1 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('sz'),
                                  labelText: Translations.of(context).text('sz'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.mcollvalue1 != null
                                  ? TextEditingController(
                                  text: formatDouble.format(
                                      guarantorobj.mcollvalue1))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mcollvalue1 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('val'),
                                  labelText: Translations.of(context).text('val'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                      ]),
                      new DataRow(cells: [
                        new DataCell(
                          new Text(
                            "2 ",
                            style: TextStyle(),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(50),
                              ],
                              controller: guarantorobj != null &&
                                  guarantorobj.mpldggurproprty2 !=
                                      null
                                  ? TextEditingController(
                                  text: guarantorobj.mpldggurproprty2)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mpldggurproprty2 = value;
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('Descr'),
                                  labelText: Translations.of(context).text('Descr'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.msize2 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.msize2))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.msize2 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('sz'),
                                  labelText: Translations.of(context).text('sz'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.mcollvalue2 != null
                                  ? TextEditingController(
                                  text: formatDouble.format(
                                      guarantorobj.mcollvalue2))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mcollvalue2 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('val'),
                                  labelText: Translations.of(context).text('val'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                      ]),
                      new DataRow(cells: [
                        new DataCell(
                          new Text(
                            "3 ",
                            style: TextStyle(),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(50),
                              ],
                              controller: guarantorobj != null &&
                                  guarantorobj.mpldggurproprty3 !=
                                      null
                                  ? TextEditingController(
                                  text: guarantorobj.mpldggurproprty3)
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mpldggurproprty3 = value;
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('Descr'),
                                  labelText: Translations.of(context).text('Descr'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.msize3 != null
                                  ? TextEditingController(
                                  text: formatDouble
                                      .format(guarantorobj.msize3))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.msize3 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('sz'),
                                  labelText: Translations.of(context).text('sz'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                        new DataCell(
                          new Container(
                            width: 150.0,
                            child: new TextFormField(
                              controller: guarantorobj != null &&
                                  guarantorobj.mcollvalue3 != null
                                  ? TextEditingController(
                                  text: formatDouble.format(
                                      guarantorobj.mcollvalue3))
                                  : TextEditingController(text: ""),
                              onSaved: (String value) {
                                try {
                                  guarantorobj.mcollvalue3 =
                                      double.parse(value);
                                  //addToList(context,0);
                                } catch (_) {}
                              },
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal)),
                                  hintText: Translations.of(context).text('val'),
                                  labelText: Translations.of(context).text('val'),
                                  prefixText: '',
                                  suffixText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.green)),
                            ),
                          ),
                        ),
                      ]),
                      new DataRow(cells: [
                        new DataCell(
                          new Text(
                            "",
                            style: TextStyle(),
                          ),
                        ),
                        new DataCell(
                          new Text(
                            "",
                            style: TextStyle(),
                          ),
                        ),
                        new DataCell(
                          new Text(
                            "",
                            style: TextStyle(),
                          ),
                        ),
                        new DataCell(
                          new ListTile(
                            title: new Text(Translations.of(context)
                                .text('mcollvaluetotal')),
                            subtitle: guarantorobj == null ||
                                guarantorobj.mcollvaluetotal == null
                                ? new Text("")
                                : new Text(
                                "${guarantorobj.mcollvaluetotal}"),
                          ),
                        ),
                      ]),
                    ],
                    columns: [
                      new DataColumn(
                        label: const Text('Sr No'),
                      ),
                      new DataColumn(
                        label: const Text(
                            'Description Of Property Of Guarantor'),
                      ),
                      new DataColumn(
                        label: const Text('Size(M2)'),
                      ),
                      new DataColumn(
                        label: const Text('Collateral Value'),
                      ),
                    ],
                  ),
                )
                    : new Container(),
              ],
            ),
          ),
        ));
  }

  proceed() async {
    if (!validateSubmit()) {
      return;
    }
    guarantorobj.mcreatedby = username;
    if (guarantorobj.mrefno == null) {
      guarantorobj.mrefno = 0;
    }

    print("guarantorobj.mnamesrc2.toString()" +
        guarantorobj.mnamesrc1.toString());
    await AppDatabase.get().updateGaurantorMaster(guarantorobj).then((val) {
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
                CustomerList(null, "Loan Application")));
    await getChildEntitys(customerdata);
    bool isValidated = await validateTabs(customerdata);
    if (customerdata != null && isValidated) {
      print("customerdata" + customerdata.toString());

      guarantorobj.mcustno =
      customerdata.mcustno != null && customerdata.mcustno > 0
          ? customerdata.mcustno
          : 0;
      guarantorobj.custmrefno = customerdata.mrefno;
      guarantorobj.custtrefno = customerdata.trefno;
      guarantorobj.mnameofguar =
          customerdata.mfname.toString() + " " + customerdata.mlname.toString();
    }
    /*
      guarantorobj.maddress2 = customerdata.mAdd1;
      guarantorobj.maddress3 = customerdata.mAdd2;
      guarantorobj.mdob = customerdata.mdob;
      guarantorobj.mgender=customerdata.mgender;
      guarantorobj.mage=customerdata.mage;
      if(guarantorobj.mage!=null&&guarantorobj.mage!=""&&guarantorobj.mage!="null"){
        AgeNotPresent=false;
      }
      if(guarantorobj.mnameofguar!=null&&guarantorobj.mnameofguar.trim()!=""&&guarantorobj.mnameofguar.trim()!="null"){
        GrntrNameNotPresent=false;
      }
      if(guarantorobj.maddress2!=null&&guarantorobj.maddress2.trim()!=""&&guarantorobj.maddress2.trim()!="null"){
        Add1NotPresent=false;
      }
      if(guarantorobj.maddress3!=null&&guarantorobj.maddress3.trim()!=""&&guarantorobj.maddress3.trim()!="null"){
        Add2NotPresent=false;
      }
      if( (guarantorobj.mnationaliddesc!=null &&guarantorobj.mnationaliddesc.trim()!="null" &&guarantorobj.mnationaliddesc.trim()!="")){
        NationalIDNotPresent=false;
      }
      if((guarantorobj.mmobile!=null&&guarantorobj.mmobile.trim()!=''&&guarantorobj.mmobile.trim()!="null")){
        MobileNotPresent=false;
      }
      guarantorobj.mnationalidtype=customerdata.mTypeOfId;*/

/*      if((guarantorobj.mnationalidtype!=null&&guarantorobj.mnationalidtype!=''&&guarantorobj.mnationalidtype!="null")) {
        for (int k = 0;
        k < globals.dropdownCaptionsValuesGuarantorInfo.length;
        k++) {
          List<String> tempDropDownValues = new List<String>();
          tempDropDownValues
              .add(guarantorobj.mnationalidtype.toString());
          for (int i = 0;
          i < globals.dropdownCaptionsValuesGuarantorInfo[k].length;
          i++) {
            try {
              if (
                  globals.dropdownCaptionsValuesGuarantorInfo[k][i].mcode
                  .toString()
                  .trim() ==
                  tempDropDownValues[k].toString().trim()) {
                //   print("Matched");
                setValue(k, globals.dropdownCaptionsValuesGuarantorInfo[k][i]);
              }
            } catch (_) {
              //  print("Exception Occured");

            }
          }
        }
      }*/

    /* applicantDob=customerdata.mdob.toString();
      tempYear=customerdata.mdob.toString().substring(0, 4).trim();
      tempMonth=customerdata.mdob.toString().substring(5, 7).trim();
      tempDay=customerdata.mdob.toString().substring(8, 10).trim();

      guarantorobj.mmobile = customerdata.mmobno;
    // guarantorobj.mphone=customerdata.addressDetails.mtel1;

      guarantorobj.mnationaliddesc=customerdata.mIdDesc;

      // guarantorobj.mcenterid = customerdata.mcenterid;
      // guarantorobj.mgroupcd = customerdata.mgroupcd;
      print("inside cus");
      print(customerdata.mdob);
      print(customerdata.mTypeOfId);
      print(customerdata.mmobno);
      print(customerdata.mgender);
      print(customerdata.mcustno);
      print(customerdata.mIdDesc);
      print(customerdata.mage);

      print(guarantorobj.mnationaliddesc);}*/
    setState(() {});
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
    if (isExistingCustomerY) {
      if (guarantorobj.custtrefno == "" || guarantorobj.custtrefno == null) {
        _showAlert("Please select Customemer", "It is Mandatory");
        return false;
      }
    }
    if (guarantorobj.mapplicanttype == "" ||
        guarantorobj.mapplicanttype == null) {
      _showAlert("Applicant Type ", "It is Mandatory");
      return false;
    }
    /*if (guarantorobj.mnameofguar == "" || guarantorobj.mnameofguar== null) {
      _showAlert("Guarantor Name ", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mgender == "" || guarantorobj.mgender== null) {
      _showAlert("Gender", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mrelationwithcust == "" || guarantorobj.mrelationwithcust== null) {
      _showAlert("Relation With Customer", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mdob == "" || guarantorobj.mdob== null) {
      _showAlert("Date Of Birth", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mhousetype == "" || guarantorobj.mhousetype== null) {
      _showAlert("House Type", "It is Mandatory");
      return false;
    }
    if (guarantorobj.maddress2 == "" || guarantorobj.maddress2== null) {
      _showAlert("Address", "It is Mandatory");
      return false;
    }
    if (guarantorobj.moccupationtype == "" || guarantorobj.moccupationtype== null) {
      _showAlert("Occupation Type", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mmainoccupation == "" || guarantorobj.mmainoccupation== null) {
      _showAlert("Main Occupation", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mmonthlyincome == "" || guarantorobj.mmonthlyincome== null) {
      _showAlert("Monthly Sales / Revenue", "It is Mandatory");
      return false;
    }
    if (guarantorobj.mincomeothsources == "" || guarantorobj.mincomeothsources== null) {
      _showAlert("Income From Other Sources", "It is Mandatory");
      return false;
    }*/
    return true;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != guarantorobj.mdob)
      setState(() {
        guarantorobj.mdob = picked;
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        applicantDob = applicantDob.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        applicantDob = applicantDob.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        applicantDob = applicantDob.replaceRange(3, 5, tempMonth);
      });
  }

  getChildEntitys(CustomerListBean bean)async{


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
      print("socialFinancialDetailsBean"+socialFinancialDetailsBean.toString());
      for (int i = 0; i < socialFinancialDetailsBean.length; i++) {
        bean.socialFinancialList.add(socialFinancialDetailsBean[i]);
      }
      // print("Family Details list is ${bean.familyDetailsList}");
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
  }

  Future<bool> validateTabs(CustomerListBean custListBean) async {
    String error = "";
    bool isMaxLengthExceed = false;

    /*if (custListBean.imageMaster == null) {
      custListBean.imageMaster =
      new List<ImageBean>();
      for (int i = 0; i < 23; i++) {
        custListBean.imageMaster
            .add(new ImageBean());
      }
    }*/


    if (custListBean.imageMaster[0].imgString == "" ||
        custListBean.imageMaster[0].imgString == null) {
      _showAlert("Customer Picture", "It is Mandatory");
      return false;
    }
    if (custListBean.mcustcategory == "" || custListBean.mcustcategory == null) {

      _showAlert("Applicant Type", "Field is mandatory");
      return false;
    }
    if (custListBean.mnationality == "" || custListBean.mnationality == null) {

      _showAlert("Nationality", "Field is mandatory");
      return false;
    }
    if (custListBean.mnametitle == "" || custListBean.mnametitle == null) {

      _showAlert("Title", "Field is mandatory");
      return false;
    }
    Utility ut = new Utility();
    error = ut.validateOnlyCharacterField(custListBean.mfname);
    if (error != null) {
      _showAlert("First Name", error);

      return false;
    }
    error = ut.validateOnlyCharacterField(custListBean.mlname);
    if (error != null) {
      //showInSnackBar("Last name has $error ",context);
      _showAlert("Last Name", error);

      return false;
    }
    error = ut.validateOnlyCharacterFieldKhmer(custListBean.mfname2);
    if (error != null) {
      _showAlert("First Name Khmer", error);

      return false;
    }

    error = ut.validateOnlyCharacterFieldKhmer(custListBean.mlname2);
    if (error != null) {
      _showAlert("Last Name Khmer", error);

      return false;
    }
    try {


      int age = DateTime.now().year-custListBean.mdob.year;
      print("custListBean.mdob.year"+age.toString());
      if (age < 18) {
        _showAlert("Date Of birth", "It should be greater than 18");

        return false;
      }
    } catch (e) {
      _showAlert("Applicant DOB", "It is Mandatory");

      return false;
    }
    if (custListBean.mgender == "" || custListBean.mgender == null) {

      _showAlert("Gender", "Field is mandatory");
      return false;
    }

    if (custListBean.mmaritialStatus == "" ||
        custListBean.mmaritialStatus == null) {

      _showAlert("Marital Status", "Field is mandatory");
      return false;
    }
    if(custListBean.mmaritialStatus!=null &&custListBean.mmaritialStatus=="2"){
      _showAlert("Spouse Name", "It is Mandatory");

      return false;
    }
    if (custListBean.mresstatus == "" ||
        custListBean.mresstatus == null) {

      _showAlert("Resedence Status", "Field is mandatory");
      return false;
    }
    if (custListBean.mrelegion == "" || custListBean.mrelegion == null) {

      _showAlert("Religion", "Field is mandatory");
      return false;
    }
    if (custListBean.mlangofcust == "" || custListBean.mlangofcust == null) {

      _showAlert("Language", "Field is mandatory");
      return false;
    }
    if (custListBean.moccupation == "" || custListBean.moccupation == null) {

      _showAlert("Occupation", "Field is mandatory");
      return false;
    }
    if (custListBean.miscpemp == "" || custListBean.miscpemp == null) {

      _showAlert("Is Bank Employee", "Field is mandatory");
      return false;
    }

    if (custListBean.mtarget == "" || custListBean.mtarget == null) {

      _showAlert("Target", "Field is mandatory");
      return false;
    }
    //TODO undone this

    if (custListBean.mownership == "" || custListBean.mownership == null) {

      _showAlert("Ownership", "Field is mandatory");
      return false;
    }
    if (custListBean.addressDetails == null ||
        custListBean.addressDetails == [] ||
        custListBean.addressDetails.length == 0) {

      _showAlert("Adress Detail", "Atleast one address is mandatory");

      return false;
    }
    bool isContain5 =false;
    for (int i = 0; i < custListBean.addressDetails.length; i++) {
      if(custListBean.addressDetails[i].maddrType ==5){
        isContain5 =true;
        break;
      }
    }

    if(!isContain5){

      _showAlert("Place Of Birth", "Place Of Birth Address Type is mandatory");
      isContain5 =false;
      return false;
    }
    bool isContain6 =false;
    for (int i = 0; i < custListBean.addressDetails.length; i++) {
      if(custListBean.addressDetails[i].maddrType ==6){
        isContain6 =true;
        break;
      }
    }

    if(!isContain6){

      _showAlert("NID Address", "NID Address is mandatory");
      isContain6 =false;
      return false;
    }
    bool isContain1 =false;
    for (int i = 0; i < custListBean.addressDetails.length; i++) {
      if(custListBean.addressDetails[i].maddrType ==1){
        isContain1 =true;
        break;
      }
    }

    if(!isContain1){
      _showAlert("Residential Address", "Residential Address Type is mandatory");
      isContain1 =false;
      return false;
    }
/*    if (custListBean.mbankacno == "" || custListBean.mbankacno == null) {

      _showAlert("Account number", "Field is mandatory");
      return false;
    }
    if (custListBean.mbanknamelk == "" || custListBean.mbanknamelk == null) {

      _showAlert("Bank Name", "Field is mandatory");
      return false;
    }
    if(custListBean.macctbal==null||custListBean.macctbal.toString().trim()==""){

      _showAlert("Account Balance", "Field is mandatory");
      return  false;
    }
    if (custListBean.mbankacyn == "" || custListBean.mbankacyn == null) {

      _showAlert("Is Use For Disbursment", "Field is mandatory");
      return false;
    }*/
    if (custListBean.customerBusinessDetailsBean == null ||
        custListBean.customerBusinessDetailsBean == [] ||
        custListBean.customerBusinessDetailsBean.length == 0) {

      _showAlert("Employment/Business Detail", "Atleast one Employment/Business is mandatory");

      return false;
    }
    if (custListBean.mpanno == "" || custListBean.mpanno == null) {

      _showAlert(Translations.of(context).text('idtype1'), "Field is mandatory");
      return false;
    }
    if (custListBean.mpannodesc == "" || custListBean.mpannodesc == null) {

      _showAlert(Translations.of(context).text('idtype1desc'), "Field is mandatory");
      return false;
    }else   if (custListBean.mpannodesc.length<8 ) {

      _showAlert(Translations.of(context).text('idtype1desc'), "Should not be less than 9 Char");
      return false;
    }
    if (custListBean.missngautryt1 == "" || custListBean.missngautryt1 == null) {

      _showAlert(Translations.of(context).text('idtype1issuing'), "Field is mandatory");
      return false;
    }


    try {

      try {
        if (DateTime.now().isBefore(custListBean.mid1issuedate)) {
          _showAlert("Id 1 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 1 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 1 Issue Date", "It is Mandatory");

      return false;
    }


    try {

      if (custListBean.mid1expdate==DateTime.now() || custListBean.mid1expdate.isBefore(DateTime.now())) {
        _showAlert("Id 1 Expiry Date", "It should be greater than Current Date");

        return false;
      }
    } catch (e) {
      _showAlert("Id 1 Expiry Date", "It is Mandatory");

      return false;
    }

    if (custListBean.mTypeOfId == "" || custListBean.mTypeOfId == null) {

      _showAlert(Translations.of(context).text('idtype2'), "Field is mandatory");
      return false;
    }


    if (custListBean.mIdDesc == "" || custListBean.mIdDesc == null) {

      _showAlert(Translations.of(context).text('idtype2desc'), "Field is mandatory");
      return false;
    }


    if (custListBean.missngautryt2 == "" || custListBean.missngautryt2 == null) {

      _showAlert(Translations.of(context).text('idtype2issuing'), "Field is mandatory");
      return false;
    }

    try {

      try {
        if (DateTime.now().isBefore(custListBean.mid2issuedate)) {
          _showAlert("Id 2 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 2 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 2 Issue Date", "It is Mandatory");

      return false;
    }

    try {

      if (custListBean.mid2expdate==DateTime.now() || custListBean.mid2expdate.isBefore(DateTime.now())) {
        _showAlert("Id 2 Expiry Date", "It should be greater than Current Date");

        return false;
      }
    } catch (e) {
      _showAlert("Id 2 Expiry Date", "It is Mandatory");

      return false;
    }

    if (custListBean.mtypeofid3 == "" || custListBean.mtypeofid3 == null) {

      _showAlert(Translations.of(context).text('idtype3'), "Field is mandatory");
      return false;
    }

    if (custListBean.middesc3 == "" || custListBean.middesc3 == null) {

      _showAlert(Translations.of(context).text('idtype3desc'), "Field is mandatory");
      return false;
    }

    if (custListBean.missngautryt3 == "" || custListBean.missngautryt3 == null) {

      _showAlert(Translations.of(context).text('idtype3issuing'), "Field is mandatory");
      return false;
    }

    try {

      try {
        if (DateTime.now().isBefore(custListBean.mid3issuedate)) {
          _showAlert("Id 3 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 3 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 3 Issue Date", "It is Mandatory");

      return false;
    }
    if(custListBean.mid3expdate!=null) {

      try {

        if (custListBean.mid3expdate==DateTime.now() || custListBean.mid3expdate.isBefore(DateTime.now())) {
          _showAlert("Id 3 Expiry Date", "It should be greater than Current Date");

          return false;
        }

      } catch (e) {
        //  _showAlert("Id 3 Expiry Date", "It is Mandatory");

        return false;
      }}
    SystemParameterBean sysBean =
    await AppDatabase.get().getSystemParameter('11', 0);


    if (custListBean.imageMaster[11].imgString == null ||
        custListBean.imageMaster[11].imgString == "" ) {
      _showAlert("Customer Signature",
          "It is Mandatory");

      return false;
    }
    if (custListBean.imageMaster[12].imgString == null ||
        custListBean.imageMaster[12].imgString == "" ) {
      _showAlert("Spouse Signature",
          "It is Mandatory");

      return false;
    }


    return true;
  }}
