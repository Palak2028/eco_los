import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/pages/workflow/termDeposit/NewTermDepositBean.dart';

class NewTermDeposit extends StatefulWidget {
  var onTapBean;

  NewTermDeposit({this.onTapBean});
  @override
  _TermDeposit createState() => _TermDeposit();
}

class _TermDeposit extends State<NewTermDeposit> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FocusNode monthFocus;
  FocusNode yearFocus;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');


  String tempDate = "----/--/--";
  String tempYear;
  String tempDay;
  String tempMonth;
  String certDt = "__-__-____";

  LookupBeanData modeofpayment;
  String productName;
  String productNo;
  String customerName;
  String customerNo;
  String selected_months;
  String selected_days;
  int selectedDuration = 0;
  int selectedMonths = 0;
  int selectedDays = 0;
  int branch;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  String loginTime;
  int usrGrpCode = 0;
  double tdRoi = 0.0;
  String username;
  SharedPreferences prefs;
  NewTermDepositBean _newTermDepositBean = null;
  TextEditingController amountController = new TextEditingController();
  int sysParam = 0;

  @override
  void initState() {
    super.initState();
    //select amout salb based on tier field from customer
    if(widget.onTapBean==null){
      _newTermDepositBean = new NewTermDepositBean();
      loadNewTDRequestPage();
    }else{
      _newTermDepositBean = widget.onTapBean;
      certDt = _newTermDepositBean.mcertdate.toString();
      customerNo = _newTermDepositBean.mcustno.toString();
      customerName = _newTermDepositBean.mlongname;
      productNo =  _newTermDepositBean.mprdcd.toString();
      productName = _newTermDepositBean.mprdcd;
      amountController.text = _newTermDepositBean.mmainbalfcy != null
          ? _newTermDepositBean.mmainbalfcy.toString()
          : "";
    }


    monthFocus = new FocusNode();
    yearFocus = new FocusNode();

    if (!certDt.contains("_")) {
      try {
        DateTime formattedDate = DateTime.parse(certDt);
        tempDay = formattedDate.day.toString();
        tempMonth = formattedDate.month.toString();
        tempYear = formattedDate.year.toString();
        certDt = tempDay.toString() +"-"+tempMonth.toString()+"-"+tempYear.toString();
        setState(() {});
      } catch (e) {
        print("Exception Occupred");
      }
    }

    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(_newTermDepositBean.mmodeofdeposit.toString());

    for (int k = 0;
    k < globals.dropdownCaptionsValuesModeOfPayout.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesModeOfPayout[k].length;
      i++) {
        if (globals.dropdownCaptionsValuesModeOfPayout[k][i].mcode ==
            tempDropDownValues[k]) {
          setValue(k, globals.dropdownCaptionsValuesModeOfPayout[k][i]);
        }
      }
    }

    getSessionVariables();

    getsharedPreferences();
  }

// getting system parameter for the logic of Rate of Interest
  getsharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TablesColumnFile.mTdparam) != null &&
        prefs.getString(TablesColumnFile.mTdparam).trim() != "")
      sysParam = int.parse(prefs.getString(TablesColumnFile.mTdparam).trim());
    print(sysParam);
  }

  void loadNewTDRequestPage() async {
    await AppDatabase.get().generateTDNumber().then((onValue) {
      if (onValue != null) {
        _newTermDepositBean.trefno = onValue;
      }
    });
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();

      print("branch " + branch.toString());
      print("reportingUser " + reportingUser.toString());
      print("usre code " + username.toString());
      print("usrRole " + usrRole.toString());
      print("usrGrpCode " + usrGrpCode.toString());
      print("loginTime " + loginTime.toString());
      print("geoLocation" + geoLocation.toString());
      print("geoLatitude " + geoLatitude.toString());
      print("geoLongitude " + geoLongitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      // backgroundColor: Colors.white70,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(
          Constant.appBarLabelNewTermDeposit,
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
              if (!validateSubmit()) {
              } else {
                proceed();
              }
              // proceed();
              // Navigator.of(context).pop();
              /*  globals.Dialog.alertPopup(
                  context, "Sucess", "Data Saved Sucessfully!!!", "Dashboard");*/
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
          await calculate();
          setState(() {

          });
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Card(
              elevation: 4.0,
              //color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text(Constant.labelCustName),
                  subtitle: new Text(
                      "${customerName != null ? customerName : ""} ${customerNo != null ? customerNo : ""}"),
                  onTap: () => getCustomerNumber()),
            ),
            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text(Constant.labelProdName),
                  subtitle: new Text(
                      "${productName != null ? productName : ""} ${productNo != null ? productNo : ""}"),
                  onTap: () => getProduct()),
            ),
            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child:    new Container(
                padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  //color: Constant.mandatoryColor,
                  ),
                child: new Column(
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.only(left: 15.0),
                      // decoration: BoxDecoration(color: Constant.mandatoryColor),
                      child: new Row(
                        children: <Widget>[
                          Text(
                            Constant.certificateDate,
                            style: TextStyle(fontSize: 16.0),
                            )
                        ],
                        ),
                      ),
                    new Container(
                      decoration: BoxDecoration(),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            width: 50.0,
                            child: new TextField(
                                decoration: InputDecoration(hintText: "DD"),
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(2),
                                  globals.onlyIntNumber
                                ],
                                controller: tempDay == null
                                    ? null
                                    : new TextEditingController(text: tempDay),
                                keyboardType: TextInputType.numberWithOptions(),
                                onChanged: (val) {
                                  if (val != "0") {
                                    tempDay = val;

                                    if (int.parse(val) <= 31 && int.parse(val) > 0) {
                                      if (val.length == 2) {
                                        certDt = certDt.replaceRange(0, 2, val);
                                        FocusScope.of(context).requestFocus(monthFocus);
                                      } else {
                                        certDt =
                                            certDt.replaceRange(0, 2, "0" + val);
                                      }
                                    } else {
                                      setState(() {
                                        tempDay = "";
                                      });
                                    }
                                  }
                                }),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text("/"),
                            ),
                          new Container(
                            width: 50.0,
                            child: new TextField(
                              decoration: InputDecoration(
                                hintText: "MM",
                                ),
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                                globals.onlyIntNumber
                              ],
                              focusNode: monthFocus,
                              controller: tempMonth == null
                                  ? null
                                  : new TextEditingController(text: tempMonth),
                              onChanged: (val) {
                                if (val != "0") {
                                  tempMonth = val;
                                  if (int.parse(val) <= 12 && int.parse(val) > 0) {
                                    if (val.length == 2) {
                                      certDt = certDt.replaceRange(3, 5, val);

                                      FocusScope.of(context).requestFocus(yearFocus);
                                    } else {
                                      certDt =
                                          certDt.replaceRange(3, 5, "0" + val);
                                    }
                                  } else {
                                    setState(() {
                                      tempMonth = "";
                                    });
                                  }
                                }
                              },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text("/"),
                            ),
                          Container(
                            width: 80,
                            child: new TextField(
                              decoration: InputDecoration(
                                hintText: "YYYY",
                                ),
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4),
                                globals.onlyIntNumber
                              ],
                              focusNode: yearFocus,
                              controller: tempYear == null
                                  ? null
                                  : new TextEditingController(text: tempYear),
                              onChanged: (val) {
                                tempYear = val;
                                if (val.length == 4)
                                  certDt = certDt.replaceRange(6, 10, val);
                              },
                              ),
                            ),
                          SizedBox(
                            width: 30.0,
                          ),
                          IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectCertDtDate(context);
                              })
                        ],
                        ),
                      ),
                  ],
                  ),
                ),
            ),
            Card(
                elevation: 4.0,
                // color: Constant.mandatoryColor,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  // decoration: BoxDecoration(color: Constant.mandatoryColor),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        Constant.tenure,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: 100.0,
                        child: new TextFormField(
                          controller:_newTermDepositBean.mnoofmonths != null
                              ? TextEditingController(
                              text: _newTermDepositBean.mnoofmonths.toString())
                              : TextEditingController(text: ""),

                          onSaved: (String value) {
                            try {
                              // selectedMonths = int.parse(value);
                              _newTermDepositBean.mnoofmonths = int.parse(value);
                            } catch (_) {}
                          },
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                new BorderSide(color: Colors.teal)),
                            hintText: 'Months',
                            labelText: 'Months',
                          ),
                        ),
                      ),
                      new Container(
                        width: 100.0,
                        margin: EdgeInsets.only(left: 20.0),
                        child:  new TextFormField(
                          controller:_newTermDepositBean.mnoofdays != null
                              ? TextEditingController(
                              text: _newTermDepositBean.mnoofdays.toString())
                              : TextEditingController(text: ""),

                          onSaved: (String value) {
                            try {
                              //selectedDays = int.parse(value);
                              _newTermDepositBean.mnoofdays = int.parse(value);

                            } catch (_) {}
                          },
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                new BorderSide(color: Colors.teal)),
                            hintText: 'Days',
                            labelText: 'Days',
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Constant.labelMaturityDate),
                subtitle:
//                  new Text("${customerName} ${customerNo}"),

                    new Text(
                  maturityDateCalculator(selectedDuration),
                  style: TextStyle(color: Colors.redAccent),
                ),
                // _newTermDepositBean.mmatdate = maturityDateCalculator(selectedDuration);
                //                    new Text(maturityDateCalculator(0)),
                //                onTap: () => getCustomerNumber()
              ),
            ),
            Card(
              elevation: 4.0,
              //  color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Constant.labelRateOfInterest),
                subtitle:
//
                new Text(tdRoi!=null?tdRoi.toString():"0.0"),
                /* _newTermDepositBean.mintrate == null
                    ? new Text("")
                    : new Text("${_newTermDepositBean.mintrate}"),*/ //TODO for Rate of Interest
                //                  onTap: () => getCustomerNumber()
              ),
            ),
            Card(
              elevation: 4.0,
              //  color: Constant.mandatoryColor,
              child: new Container(
                margin: EdgeInsets.only(
                    left: 20.0, bottom: 10.0, top: 10.0, right: 10.0),
                width: 100.0,
                child: new DropdownButtonFormField(
                  items: generateDropDown(0),
                  value: modeofpayment,
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 0);
                    _newTermDepositBean.mmodeofdeposit =
                        modeofpayment.mcodedesc.toString();
                  },
                  decoration: InputDecoration(
                      labelText: globals.dropdownCaptionsModeOfPayout[0]),
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child: new TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Please Enter Amount',
                  labelText: 'Amount',
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xff07426A),
                  )),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onSaved: (String value) {
                  print("value is " + value);
                  if (value.isNotEmpty &&
                      value != "" &&
                      value != null &&
                      value != 'null') {
                    _newTermDepositBean.mmainbalfcy =
                        double.parse(amountController.text);
                  }
                },
                /* inputFormatters: [
                    new LengthLimitingTextInputFormatter(50),
                    globals.onlyCharacter
                  ],*/
                //validator: (arg) =>
                // Utility.validateOnlyCharacterFieldNotMandat(arg),
                //onSaved: (String value) {
                // CustomerFormationMasterTabsState.custListBean.mmname = value;
              ),
            ),
          ],
        ),
      ),
    );
  }

  proceed() async {



    _newTermDepositBean.mlbrcode = branch;
    if (_newTermDepositBean.mrefno == null ||
        _newTermDepositBean.mrefno == 'null') {
      _newTermDepositBean.mrefno = 0;
    }

    _newTermDepositBean.mintrate = 6.5; // TODO from DB

    _newTermDepositBean.mlastrepaydate = DateTime.now();

    _newTermDepositBean.mcreateddt = DateTime.now();
    _newTermDepositBean.mcreatedby = username;
    _newTermDepositBean.mlastupdatedt = DateTime.now();
    _newTermDepositBean.mlastupdateby = username;
    _newTermDepositBean.mgeolocation = geoLocation;
    _newTermDepositBean.mgeolatd = geoLatitude;
    _newTermDepositBean.mgeologd = geoLongitude;
    _newTermDepositBean.mlastsynsdate = DateTime.now();
    _newTermDepositBean.mlongname = customerName;
    // --------------------------------------------------

    await AppDatabase.get()
        .updateTermDepositMaster(_newTermDepositBean)
        .then((val) {
      print("val here is " + val.toString());
    });
    _successfulSubmit();
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
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future getCustomerNumber() async {

    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => CustomerList(
                /*globals.isMemberOfGroup*/
                globals.isMemeberOfGroupForColl,
                "Loan collection")));
    if (customerdata != null) {
      customerNo =
          customerdata.mcustno != null ? customerdata.mcustno.toString() : "0";
      customerName = customerdata.mlongname;
      _newTermDepositBean.mcustno = int.parse(customerNo);
      _newTermDepositBean.mnametitle = customerdata.mnametitle;
    }
  }

  Future getProduct() async {
    ProductBean prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(20,0),
          // TODO for merging passing 30
          fullscreenDialog: true,
        ));

    productName = prodObj.mname;
    productNo = prodObj.mprdCd.toString();
    _newTermDepositBean.mprdcd = productNo;
  }


  showDropDown(LookupBeanData selectedObj, int no) {
    print("selected Obj is ${selectedObj}");
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          modeofpayment = blankBean;
          // CustomerFormationMasterTabsState.fdb.meducation = selectedObj.mcode;
          //termdepobean.mop=  selectpbj.mcode
          break;

        default:
          break;
      }
      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropdownCaptionsValuesModeOfPayout[no].length;
          k++) {
        if (globals.dropdownCaptionsValuesModeOfPayout[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesModeOfPayout[no][k]);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);

  setValue(int no, LookupBeanData value) {
    print("value is ${value}");
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          modeofpayment = value;
          //CustomerFormationMasterTabsState.fdb.meducation = value.mcode;
          /*CustomerFormationMasterTabsState.custListBean.familyDetailsList.last.education = value.code;*/

          break;

        default:
          break;
      }
    });
  }

  String maturityDateCalculator(int selectedDays) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');

    var maturityDate =
        now.add(new Duration(days: selectedDays != null ? selectedDays : 0));
    _newTermDepositBean.mmatdate = maturityDate;
    String formatted = formatter.format(maturityDate);
    return formatted;
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    print("caption value : " + globals.dropdownCaptionsModeOfPayout[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    bean.mcode = "";
    bean.mcodetype = 0;
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesModeOfPayout[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesModeOfPayout[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
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

// for validation in text field for mandatory check
  bool validateSubmit() {

    String error = "";
    print("inside validate" + _newTermDepositBean.mcertdate.toString());
    if (_newTermDepositBean.mmainbalfcy == "" ||
        _newTermDepositBean.mmainbalfcy == null) {
      _showAlert("Please Enter Amount", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mmodeofdeposit == "" ||
        _newTermDepositBean.mmodeofdeposit == null) {
      _showAlert("Please select Mode of Payment", "It is Mandatory");
      return false;
    }

    if (_newTermDepositBean.mcustno == "" ||
        _newTermDepositBean.mcustno == null) {
      _showAlert("Please Select Customer", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mprdcd == "" ||
        _newTermDepositBean.mprdcd == null) {
      _showAlert("Please select Product", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mnoofmonths == "" ||
        _newTermDepositBean.mnoofmonths == null) {
      _showAlert("Please select Months", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mnoofdays == "" ||
        _newTermDepositBean.mnoofdays == null) {
      _showAlert("Please select Days", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mcertdate == "" ||
        _newTermDepositBean.mcertdate == null) {
      _showAlert("Please select Certificate Date", "It is Mandatory");
      return false;
    }
    return true;
  }


  Future<Null> _selectCertDtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _newTermDepositBean.mcertdate)
      setState(() {
        _newTermDepositBean.mcertdate = picked;
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        certDt = certDt.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        certDt = certDt.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        certDt = certDt.replaceRange(3, 5, tempMonth);
      });
  }

  // the logic of getting Rate of Interest according to the value of system parameter
  // if the value of system parameter is "1" then the value is coming from....
  // if the value of system parameter is "0" then the vlaue is coming from....
  calculate() async {

    selectedMonths = selectedMonths * 30;
    selectedDuration = selectedMonths + selectedDays;


    try {
      DateTime formattedLoanDisbDtDate = DateTime.parse(certDt.substring(6) +
          "-" +
          certDt.substring(3, 5) +
          "-" +
          certDt.substring(0, 2));
      _newTermDepositBean.mcertdate=formattedLoanDisbDtDate;


    } catch (e) {
      print("date Exception");
    }



    if (sysParam == 0) {
      if (_newTermDepositBean.mnoofdays != null &&
              _newTermDepositBean.mnoofdays > 0 ||
          (_newTermDepositBean.mnoofmonths != null &&
              _newTermDepositBean.mnoofmonths > 0)) {
        await AppDatabase.get()
            .getTDRateOfInterestTenure(
                _newTermDepositBean.mnoofdays, _newTermDepositBean.mnoofmonths)
            .then((onValue) {
              print(onValue);
          tdRoi = onValue;

        });
      }
    } else {
      if (_newTermDepositBean.mnoofdays != null &&
              _newTermDepositBean.mnoofdays > 0 ||
          (_newTermDepositBean.mnoofmonths != null &&
              _newTermDepositBean.mnoofmonths > 0) ||
          (_newTermDepositBean.mmainbalfcy != null &&
              _newTermDepositBean.mmainbalfcy > 0)) {
        await AppDatabase.get()
            .getTDRateOfInterestTenureAndAmount(
            _newTermDepositBean.mnoofdays,
            _newTermDepositBean.mnoofmonths,
            _newTermDepositBean.mmainbalfcy)
            .then((onValue) {
          print(onValue);
          tdRoi = onValue;


        });
      }
    }
  }
}
