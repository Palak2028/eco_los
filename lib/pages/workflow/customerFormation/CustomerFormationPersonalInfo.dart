
import 'dart:async';
import 'dart:io';

import 'package:eco_los/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_los/pages/workflow/customerFormation/FullScreenDialogForMainOccupationSelection.dart';
import 'package:eco_los/pages/workflow/customerFormation/FullScreenDialogForSubOccupationSelection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/main.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

import '../../../translations.dart';

class CustomerFormationPersonalInfo extends StatefulWidget {
  CustomerFormationPersonalInfo();

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );



  @override
  _CustomerFormationPersonalInfoState createState() =>
      new _CustomerFormationPersonalInfoState();
}

class _CustomerFormationPersonalInfoState
    extends State<CustomerFormationPersonalInfo> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List testString = new List();

  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode monthFocusH;
  FocusNode yearFocusH;

  LookupBeanData title;
  //LookupBeanData title2;
  LookupBeanData ifYesThen;
  LookupBeanData relegion;
  LookupBeanData maritialStatus;
  LookupBeanData qualification;
  LookupBeanData occupation;
  LookupBeanData region;
  //LookupBeanData region;
  LookupBeanData motherTongue;
  LookupBeanData secondryOccuptn;
  LookupBeanData gender;
  LookupBeanData mtarget;
  LookupBeanData mownership;
  LookupBeanData mresstatus;
  LookupBeanData miscpemp;
  LookupBeanData mrankofemp;
  bool iscpemp=false;

  SubLookupForSubPurposeOfLoan mainOcc = new SubLookupForSubPurposeOfLoan();
  SubLookupForSubPurposeOfLoan subOcc = new SubLookupForSubPurposeOfLoan();

  List<LookupBeanData> onValueTitle = List<LookupBeanData>();

  DateTime selectedDate = DateTime.now();

  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  String tempDateH = "----/--/--";
  String tempYearH ;
  String tempDayH ;
  String tempMonthH;
  DateTime date;
  TimeOfDay time;
  bool boolValidate = false;

  bool ifNullCheck(String value) {
    bool isNull = false;
    try {
      if (value == null || value == 'null' || value.trim()=='') {
        isNull = true;
      }
    }catch(_){
      isNull =true;
    }
    return isNull;
  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
   //   print("inside  code Desc is null");
      switch (no) {
        case 0:
          ifYesThen = blankBean;
           break;
        case 1:
          relegion = blankBean;
          CustomerFormationMasterTabsState.custListBean.mrelegion = blankBean.mcode;
          break;
        case 2:
          maritialStatus = blankBean;
          CustomerFormationMasterTabsState.custListBean.mmaritialStatus= 0;
          setState(() {

          });
          break;
        case 3:
          qualification = blankBean;
          CustomerFormationMasterTabsState.custListBean.mqualification = blankBean.mcode;
          break;
        case 4:
          occupation = blankBean;
          CustomerFormationMasterTabsState.custListBean.moccupation =0;
          break;
        case 5:
          region = blankBean;
          CustomerFormationMasterTabsState.custListBean.mRuralUrban = blankBean.mcode;
          break;
        case 6:
          title = blankBean;
          CustomerFormationMasterTabsState.custListBean.mnametitle = blankBean.mcode;
         // title2 = blankBean;
          CustomerFormationMasterTabsState.custListBean.mnametitle2 = blankBean.mcode;
          break;
        case 7:
          secondryOccuptn = blankBean;
          CustomerFormationMasterTabsState.custListBean.msecoccupatn = 0;
          break;
        case 8:
          gender = blankBean;
          CustomerFormationMasterTabsState.custListBean.mgender = blankBean.mcode;
          break;
       case 9:

          break;
        case 10:
          motherTongue =  blankBean;
          CustomerFormationMasterTabsState.custListBean.mlangofcust = blankBean.mcode;
          break;
        case 11:
          mtarget =  blankBean;
          CustomerFormationMasterTabsState.custListBean.mtarget = blankBean.mcode;
          break;
        case 12:
          mownership =  blankBean;
          CustomerFormationMasterTabsState.custListBean.mownership = blankBean.mcode;
          break;
        case 13:
          mresstatus =  blankBean;
          CustomerFormationMasterTabsState.custListBean.mresstatus = blankBean.mcode;
          break;
        case 14:
          miscpemp =  blankBean;
          CustomerFormationMasterTabsState.custListBean.miscpemp = blankBean.mcode;
          break;
        case 15:
          mrankofemp =  blankBean;
          CustomerFormationMasterTabsState.custListBean.mrankofemp = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else{
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropdownCaptionsValuesPersonalInfo[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesPersonalInfo[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesPersonalInfo[no][k]);
          isBreak=true;
          break;
        }
        if(isBreak){
          break;
        }
      }

    }


  }

  setValue(int no, LookupBeanData value) {
    setState(() {
     // print("coming here");
      switch (no) {
        case 0:
            ifYesThen = value;
          break;
        case 1:
          relegion = value;
          CustomerFormationMasterTabsState.custListBean.mrelegion = value.mcode;
          break;
        case 2:
          maritialStatus = value;
          CustomerFormationMasterTabsState.custListBean.mmaritialStatus = int.parse(value.mcode);
          setState(() {

          });
          break;
        case 3:
          qualification = value;
          CustomerFormationMasterTabsState.custListBean.mqualification = value.mcode;
          break;
        case 4:
          occupation = value;
          CustomerFormationMasterTabsState.custListBean.moccupation = int.parse(value.mcode);
          break;
        case 5:
          region = value;
          CustomerFormationMasterTabsState.custListBean.mRuralUrban = value.mcode;
          break;
        case 6:
          title = value;
         // print(value);
          CustomerFormationMasterTabsState.custListBean.mnametitle = value.mcode;
         // title2 = value;
          CustomerFormationMasterTabsState.custListBean.mnametitle2 = value.mcode;
          break;
        case 7:
          secondryOccuptn = value;
          CustomerFormationMasterTabsState.custListBean.msecoccupatn = int.parse(value.mcode);
          break;
        case 8:
          gender = value;
          CustomerFormationMasterTabsState.custListBean.mgender = value.mcode;
          break;
        case 9:

          break;
        case 10:
          motherTongue =  value;
          CustomerFormationMasterTabsState.custListBean.mlangofcust = value.mcode;
          break;
        case 11:
          mtarget =  value;
          CustomerFormationMasterTabsState.custListBean.mtarget = value.mcode;
          break;
        case 12:
          mownership =  value;
          CustomerFormationMasterTabsState.custListBean.mownership = value.mcode;
          break;
        case 13:
          mresstatus =  value;
          CustomerFormationMasterTabsState.custListBean.mresstatus = value.mcode;
          break;
        case 14:
          miscpemp =  value;
          //print("VAr"+CustomerFormationMasterTabsState.custListBean.miscpemp );
          //print("Code"+value.mcode);
          if(value.mcode=="1"){
            iscpemp=true;
            CustomerFormationMasterTabsState.custListBean.mempid="";
            CustomerFormationMasterTabsState.custListBean.mrankofemp="";
            mrankofemp=blankBean;
          }

          else{
            iscpemp=false;
          }
          CustomerFormationMasterTabsState.custListBean.miscpemp = value.mcode;
          break;
        case 15:
          mrankofemp =  value;
          CustomerFormationMasterTabsState.custListBean.mrankofemp = value.mcode;
          break;
         default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesPersonalInfo[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesPersonalInfo[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
   //   print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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

  @override
  void initState() {


    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
  ////  print("Appllicant DOB is ${CustomerFormationMasterTabsState.applicantDob}");
    monthFocusH = new FocusNode();
    yearFocusH = new FocusNode();
   // print("Spouse DOB is ${CustomerFormationMasterTabsState.husDob}");

    for(int i = 0;i<CustomerFormationMasterTabsState.personalInfoRadios.length;i++){
      if(CustomerFormationMasterTabsState.personalInfoRadios[i]==null)CustomerFormationMasterTabsState.personalInfoRadios[i]= 0;
    }
    if(CustomerFormationMasterTabsState.custListBean.mLoanAgreed!=null)CustomerFormationMasterTabsState.personalInfoRadios[0] = CustomerFormationMasterTabsState.custListBean.mLoanAgreed;
    //if(CustomerFormationMasterTabsState.custListBean.mInsuranceCovYN!=null)CustomerFormationMasterTabsState.personalInfoRadios[1] = int.parse(CustomerFormationMasterTabsState.custListBean.mInsuranceCovYN);
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .mInsuranceCovYN)) {
      try{
        CustomerFormationMasterTabsState.personalInfoRadios[1] = int.parse(
            CustomerFormationMasterTabsState.custListBean
                .mInsuranceCovYN);
      }
     catch(_){

     }
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .mInsuranceCovYN = "0";
    }
    if(CustomerFormationMasterTabsState.custListBean.mGend!=null)CustomerFormationMasterTabsState.personalInfoRadios[2] = CustomerFormationMasterTabsState.custListBean.mGend;
    else {
      CustomerFormationMasterTabsState.custListBean.mGend = 0;
    }
      if(CustomerFormationMasterTabsState.custListBean.mTypeofCoverage!=null)CustomerFormationMasterTabsState.personalInfoRadios[4] = CustomerFormationMasterTabsState.custListBean.mTypeofCoverage;
    else {
      CustomerFormationMasterTabsState.custListBean.mTypeofCoverage = 0;
    }


    // TODO: implement initState
    super.initState();
    List<String> tempDropDownValues = new List<String>();

    print("CustomerFormationMasterTabsState.custListBean.mgender "+ CustomerFormationMasterTabsState.custListBean.mgender.toString());
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.ifYesThen);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mrelegion);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mmaritialStatus.toString());
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mqualification);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.moccupation.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mRuralUrban);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mnametitle);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.msecoccupatn.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mgender);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mnametitle2);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mlangofcust);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mtarget);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mownership);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mresstatus);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.miscpemp);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mrankofemp);
    if(!CustomerFormationMasterTabsState.applicantDob.contains("_")){
      try{
      //  print("inside try");

        String tempApplicantdob = CustomerFormationMasterTabsState.applicantDob;
        print(tempApplicantdob);
      //  print(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
        DateTime  formattedDate =  DateTime.parse(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
     //   print(formattedDate);
        tempDay = formattedDate.day.toString();
     //   print(tempDay);
        tempMonth = formattedDate.month.toString();
      ////  print(tempMonth);
        tempYear = formattedDate.year.toString();
     //   print(tempYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    if(!CustomerFormationMasterTabsState.husDob.contains("_")){
      try{
        print("inside try");

        String tempHusDob = CustomerFormationMasterTabsState.husDob;
        print(tempHusDob.substring(6)+"-"+tempHusDob.substring(3,5)+"-"+tempHusDob.substring(0,2));
        DateTime  formattedDate =  DateTime.parse(tempHusDob.substring(6)+"-"+tempHusDob.substring(3,5)+"-"+tempHusDob.substring(0,2));
        print(formattedDate);
        tempDayH = formattedDate.day.toString();
        print(tempDayH);
        tempMonthH = formattedDate.month.toString();
        print(tempMonthH);
        tempYearH = formattedDate.year.toString();
        print(tempYearH);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    for (int k = 0;
        k < globals.dropdownCaptionsValuesPersonalInfo.length;
        k++) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesPersonalInfo[k].length;
          i++) {

      //  print("tempDropDownValues[k].toString()"+tempDropDownValues[k].toString());
        try{
          if (globals.dropdownCaptionsValuesPersonalInfo[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {

            print("tempDropDownValues[k].toString()"+globals.dropdownCaptionsValuesPersonalInfo[k][i].mcode.toString());
            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesPersonalInfo[k][i]);
          }
        }catch(_){
          print("Exception Occured");

        }
      }
    }

  }


  Widget yesNo1() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[0], 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget yesNo2() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[1], 1),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget genderRadio() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[2], 2),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget regionRadio() => CustomerFormationPersonalInfo._get(new Row(
        children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[3], 3),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget yesInsurance() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[4], 4),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: new Row(
          children: <Widget>[
            new Text(
              textName[i],
              textAlign: TextAlign.right,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: 12.0,
              ),
            ),
            new Radio(
              value: i,
              groupValue: CustomerFormationMasterTabsState.personalInfoRadios[position],
              onChanged: (selection) => _onRadioSelected(selection, position),
              activeColor: Color(0xff07426A),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ));
    }
    return radios;
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


  _onRadioSelected(int selection, int position) {
    setState(() => CustomerFormationMasterTabsState.personalInfoRadios[position] = selection);
    if (position == 0) {
      CustomerFormationMasterTabsState.custListBean.mLoanAgreed = selection;
    } else if (position == 1) {
      CustomerFormationMasterTabsState.custListBean.mInsuranceCovYN = selection as String;

    } else if (position == 2) {
      CustomerFormationMasterTabsState.custListBean.mGend = selection;

    }  else if (position == 4) {
      CustomerFormationMasterTabsState.custListBean.mTypeofCoverage = selection;

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      //autovalidate: CustomerFormationMasterTabsState.autoValidate,
      onWillPop: () {
        return Future(() => true);
      }
      ,onChanged: () {
      final FormState form = _formKey.currentState;
      form.save();
    },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          SizedBox(height: 16.0),
          Center(
            child: new Column(children: [
              //occupationRadio(),

              Container(
                  color: Constant.mandatoryColor
                  ,child:new DropdownButtonFormField(
                value: title,
                items: generateDropDown(6),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 6);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text('Title')),
                // style: TextStyle(color: Colors.grey),
              ),)


            ]),
          ),

          SizedBox(height: 16.0),
          new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                textCapitalization: TextCapitalization.characters,
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('EntrFrstnm'),
                  labelText: Translations.of(context).text('Frstnm'),
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
                  contentPadding: EdgeInsets.all(20.0),
                ),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                  globals.onlyCharacter
                ],
                initialValue:
                CustomerFormationMasterTabsState.custListBean.mfname != null ? CustomerFormationMasterTabsState.custListBean.mfname : "",
                onSaved: (String value) {
                  /*globals.firstName = value;*/
                  CustomerFormationMasterTabsState.custListBean.mfname =
                      value;
                }),
          ),
          SizedBox(height: 16.0),

          new TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration:  InputDecoration(

                hintText: Translations.of(context).text('Entrmddlnm'),
                labelText: Translations.of(context).text('Mddlnm'),
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
              inputFormatters: [
                new LengthLimitingTextInputFormatter(50),
                globals.onlyCharacter
              ],
              initialValue:
              CustomerFormationMasterTabsState.custListBean.mmname != null ? CustomerFormationMasterTabsState.custListBean.mmname : "",
              validator: (arg) =>
                  Utility.validateOnlyCharacterFieldNotMandat(arg),
              onSaved: (String value) {
                CustomerFormationMasterTabsState.custListBean.mmname = value;
              }),
          SizedBox(height: 16.0),
          new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                textCapitalization: TextCapitalization.characters,
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('Entrlstnm'),
                  labelText: Translations.of(context).text('Lstnm'),
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
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                  globals.onlyCharacter
                ],
                initialValue: CustomerFormationMasterTabsState.custListBean.mlname != null ? CustomerFormationMasterTabsState.custListBean.mlname : "",
                onSaved: (String value) {
                  /*globals.lastName = value;*/
                  CustomerFormationMasterTabsState.custListBean.mlname = value;
                }),
          ),


          SizedBox(height: 16.0),
          Center(
            child: new Column(children: [
              //occupationRadio(),

              Container(
                color: Constant.mandatoryColor
                ,child:new DropdownButtonFormField(
                value: title,
                items: generateDropDown(6),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 6);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText:Translations.of(context).text('title2') ),
                // style: TextStyle(color: Colors.grey),
              ),)


            ]),
          ),

          SizedBox(height: 16.0),
          new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('fname2'),
                  labelText: Translations.of(context).text('fname2hint'),
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
                  contentPadding: EdgeInsets.all(20.0),
                ),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                  globals.onlyCharacter
                ],
                initialValue:
                CustomerFormationMasterTabsState.custListBean.mfname2 != null ? CustomerFormationMasterTabsState.custListBean.mfname2 : "",
                onSaved: (String value) {
                  /*globals.firstName = value;*/
                  CustomerFormationMasterTabsState.custListBean.mfname2 =
                      value;
                }),
          ),
          SizedBox(height: 16.0),

          new TextFormField(
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('mname2'),
                labelText: Translations.of(context).text('mname2hint'),
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
              inputFormatters: [
                new LengthLimitingTextInputFormatter(50),
                globals.onlyCharacter
              ],
              initialValue:
              CustomerFormationMasterTabsState.custListBean.mmname2 != null ? CustomerFormationMasterTabsState.custListBean.mmname2 : "",
              validator: (arg) =>
                  Utility.validateOnlyCharacterFieldNotMandat(arg),
              onSaved: (String value) {
                CustomerFormationMasterTabsState.custListBean.mmname2 = value;
              }),
          SizedBox(height: 16.0),
          new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('lname2'),
                  labelText: Translations.of(context).text('lname2hint'),
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
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                  globals.onlyCharacter
                ],
                initialValue: CustomerFormationMasterTabsState.custListBean.mlname2 != null ? CustomerFormationMasterTabsState.custListBean.mlname2 : "",
                onSaved: (String value) {
                  /*globals.lastName = value;*/
                  CustomerFormationMasterTabsState.custListBean.mlname2 = value;
                }),
          ),

          SizedBox(height: 20.0,),
          Container(
            decoration: BoxDecoration(color: Constant.mandatoryColor),
            child: new Row(

              children: <Widget>[Text(Translations.of(context).text('ApplDaOB'))],
            ),
          ),

          new Container(
            decoration: BoxDecoration(color: Constant.mandatoryColor,),



            child: new Row(
              children: <Widget>[
            new Container(
            width: 50.0,
                child: new TextField(
                  decoration:
                  InputDecoration(
                      hintText: Translations.of(context).text('DD')
                  ),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  controller: tempDay == null?null:new TextEditingController(text: tempDay),
                  keyboardType: TextInputType.numberWithOptions(),

                  onChanged: (val){

                    if(val!="0"){
                      tempDay = val;


                      if(int.parse(val)<=31&&int.parse(val)>0){



                        if(val.length==2){
                          CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, val);
                          FocusScope.of(context).requestFocus(monthFocus);
                        }
                        else{
                          CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, "0"+val);
                        }


                      }
                      else {
                        setState(() {
                          tempDay ="";
                        });

                      }


                    }
                    }

                ),

              )
               ,


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("/"),
                ),
                new Container(
                  width: 50.0,
                  child: new TextField(
                    decoration: InputDecoration(
                        hintText: Translations.of(context).text('MM'),


                    ),

                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(2),
                      globals.onlyIntNumber
                    ],
                    focusNode: monthFocus,
                    controller: tempMonth == null?null:new TextEditingController(text: tempMonth),
                    onChanged: (val){
                      if(val!="0"){
                        tempMonth = val;
                        if(int.parse(val)<=12&&int.parse(val)>0){

                          if(val.length==2){
                            CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, val);

                            FocusScope.of(context).requestFocus(yearFocus);
                          }
                          else{
                            CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, "0"+val);
                          }
                        }
                        else {
                          setState(() {
                            tempMonth ="";
                          });

                        }
                      }



                    },

                  ),
                )
                ,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("/"),
                ),

              Container(
                width:80,

                child:new TextField(


                  decoration: InputDecoration(
                      hintText: Translations.of(context).text('YYYY'),

                  ),

                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(4),
                    globals.onlyIntNumber
                  ],


                  focusNode: yearFocus,
                  controller: tempYear == null?null:new TextEditingController(text: tempYear),
                  onChanged: (val){
                    tempYear = val;
                    if(val.length==4) CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(6, 10,val);

                  },
                ),)
                ,

                SizedBox(
                  width: 50.0,
                ),

                IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                  _selectDate(context);
                } )
              ],


            ),

          ),

          Container(
            color: Constant.mandatoryColor
            ,child: new DropdownButtonFormField(
            value:gender==null?null: gender,
            items: generateDropDown(8),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 8);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('gender')),
            // style: TextStyle(color: Colors.grey),
          ),),


          new TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: Translations.of(context).text('fatfnamehint'),
                labelText: Translations.of(context).text('fatfnamlabel'),
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
              inputFormatters: [
                new LengthLimitingTextInputFormatter(50),
                globals.onlyCharacter
              ],
              initialValue: CustomerFormationMasterTabsState
                          .custListBean.mfatherfname !=
                      null
                  ? CustomerFormationMasterTabsState
                      .custListBean.mfatherfname
                  : " ",
              onSaved: (String value) {
                CustomerFormationMasterTabsState
                    .custListBean.mfatherfname = value;
              }),
          SizedBox(height: 16.0),
          new TextFormField(
              textCapitalization: TextCapitalization.characters,

              decoration: InputDecoration(
                hintText: Translations.of(context).text('fatmnamehint'),
                labelText: Translations.of(context).text('fatmnamelabel'),
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
              inputFormatters: [
                new LengthLimitingTextInputFormatter(50),
                globals.onlyCharacter
              ],
              initialValue: CustomerFormationMasterTabsState
                  .custListBean.mfathermname !=
                  null
                  ? CustomerFormationMasterTabsState
                  .custListBean.mfathermname
                  : " ",
              onSaved: (String value) {
                CustomerFormationMasterTabsState
                    .custListBean.mfathermname = value;
              }),
          SizedBox(height: 16.0),
          new TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: Translations.of(context).text('fatlnamehint'),
                labelText: Translations.of(context).text('fatlname2label'),
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
              inputFormatters: [
                new LengthLimitingTextInputFormatter(50),
                globals.onlyCharacter
              ],
              initialValue: CustomerFormationMasterTabsState
                  .custListBean.mfatherlname !=
                  null
                  ? CustomerFormationMasterTabsState
                  .custListBean.mfatherlname
                  : " ",
              onSaved: (String value) {
                CustomerFormationMasterTabsState
                    .custListBean.mfatherlname = value;
              }),
          SizedBox(height: 16.0),
          Container(
            color: Constant.mandatoryColor
            ,child:new DropdownButtonFormField(
            value:maritialStatus==null?null: maritialStatus,
            items: generateDropDown(2),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 2);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('Mrtlstts')),
            // style: TextStyle(color: Colors.grey),
          ),),
         /* SizedBox(height: 16.0),
          Container(
            color: maritialStatus!=null && maritialStatus.mcodedesc!=null &&maritialStatus.mcodedesc.toUpperCase().trim()=="MARRIED"?
            Constant.mandatoryColor:null,
            child:new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Spouse  Name',
                  labelText: 'Spouse Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  *//*labelStyle: TextStyle(color: Colors.grey),*//*
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
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(100),
                  globals.onlyCharacter
                ],
                initialValue: CustomerFormationMasterTabsState
                    .custListBean.mhusbandname !=
                    null
                    ? CustomerFormationMasterTabsState
                    .custListBean.mhusbandname
                    : " ",
                onSaved: (String value) {
                  CustomerFormationMasterTabsState
                      .custListBean.mhusbandname = value;
                }),
          ),

          SizedBox(height: 20.0,),
          Container(
            child: new Row(
              children: <Widget>[Text(Constant.husDob)],
            ),
          ),

          new Container(  child: new Row(
              children: <Widget>[
                new Container(
                  width: 50.0,
                  child: new TextField(
                      decoration:
                      InputDecoration(
                          hintText: "DD"
                      ),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(2),
                        globals.onlyIntNumber
                      ],
                      controller: tempDayH == null?null:new TextEditingController(text: tempDayH),
                      keyboardType: TextInputType.numberWithOptions(),

                      onChanged: (val){
                        if(val!="0"){
                          tempDayH = val;

                          if(int.parse(val)<=31&&int.parse(val)>0){

                            if(val.length==2){
                              CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(0, 2, val);
                              FocusScope.of(context).requestFocus(monthFocusH);
                            }
                            else{
                              CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(0, 2, "0"+val);
                            }
                          }
                          else {
                            setState(() {
                              tempDayH ="";
                            });
                          }
                        }
                      }
                  ),
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
                    focusNode: monthFocusH,
                    controller: tempMonthH == null?null:new TextEditingController(text: tempMonthH),
                    onChanged: (val){
                      if(val!="0"){
                        tempMonthH = val;
                        if(int.parse(val)<=12&&int.parse(val)>0){

                          if(val.length==2){
                            CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(3, 5, val);

                            FocusScope.of(context).requestFocus(yearFocusH);
                          }
                          else{
                            CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(3, 5, "0"+val);
                          }
                        }
                        else {
                          setState(() {
                            tempMonthH ="";
                          });
                        }
                      }
                    },
                  ),
                )
                ,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("/"),
                ),

                Container(
                  width:80,
                  child:new TextField(
                    decoration: InputDecoration(
                      hintText: "YYYY",
                    ),

                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(4),
                      globals.onlyIntNumber
                    ],
                    focusNode: yearFocusH,
                    controller: tempYearH == null?null:new TextEditingController(text: tempYearH),
                    onChanged: (val){
                      tempYearH = val;
                      if(val.length==4) CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(6, 10,val);

                    },
                  ),),

                SizedBox(
                  width: 50.0,
                ),

                IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                  _selectHusDate(context);
                } )
              ],
            ),
          ),
*/
      Container(
        color: Constant.mandatoryColor
        ,child:
          new DropdownButtonFormField(
            value: mresstatus,
            items: generateDropDown(13),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 13);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('rsdntstts')),
            // style: TextStyle(color: Colors.grey),
          ),
      ),


      Container(
        color: Constant.mandatoryColor
        ,child:
          new DropdownButtonFormField(
            value: relegion,
            items: generateDropDown(1),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 1);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('religion')),
            // style: TextStyle(color: Colors.grey),
          ),
      ),

          new DropdownButtonFormField(
            value: qualification==null?null: qualification,
            items: generateDropDown(3),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 3);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text('qualification')),
            // style: TextStyle(color: Colors.grey),
          ),

         /* new DropdownButtonFormField(
            value: region==null?null:region,
            items: generateDropDown(5),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 5);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: "Location Type"),
            // style: TextStyle(color: Colors.grey),
          ),*/



          Container(
            color: Constant.mandatoryColor,
            child:new DropdownButtonFormField(
            value: motherTongue,
            items: generateDropDown(10),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 10);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('lang')),
            // style: TextStyle(color: Colors.grey),
          ),),

          Container(
            color: Constant.mandatoryColor,
            child: new DropdownButtonFormField(
          value: occupation==null?null:occupation,
            items: generateDropDown(4),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 4);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('Occptn')),
            // style: TextStyle(color: Colors.grey),
          ),
          ),


          SizedBox(height: 16.0),
      Container(
        color: Constant.mandatoryColor
        ,child:
          new DropdownButtonFormField(
            value: miscpemp==null?null:miscpemp,
            items: generateDropDown(14),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 14);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText:
                Translations.of(context).text('IsBankEmp')),
            // style: TextStyle(color: Colors.grey),
          ),
      ),
          iscpemp?Card(
            //color: Constant.mandatoryColor

            child:
            new IgnorePointer(
              ignoring: true,
              child:new DropdownButtonFormField(
                value: mrankofemp,
                items: generateDropDown(15),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 15);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text('RnkOfEmp')),
                // style: TextStyle(color: Colors.grey),
              ),),):Card(
            //color: Constant.mandatoryColor
            child:new DropdownButtonFormField(
              value: mrankofemp,
              items: generateDropDown(15),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 15);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text('RnkOfEmp')),
              // style: TextStyle(color: Colors.grey),
            ),),
       /*   SizedBox(height: 16.0),
          new DropdownButtonFormField(
            value: mrankofemp==null?null:mrankofemp,
            items: generateDropDown(15),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 15);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: "Rank Of Employee"),
            // style: TextStyle(color: Colors.grey),
          ),*/
          iscpemp?
          Container(

            child: new TextFormField(
              enabled: false,
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('empidhint'),
                labelText: Translations.of(context).text('empidlable'),
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
              controller: CustomerFormationMasterTabsState.custListBean.mempid != null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.mempid)
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(30),
                globals.onlyAphaNumeric
              ],
              onSaved: (val) {
                //  if(val!=null) {
                CustomerFormationMasterTabsState.custListBean.mempid = val;
                // }
              },
            ),
          ):Container(

            child: new TextFormField(
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('empidhint'),
                labelText: Translations.of(context).text('empidlable'),
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
              controller: CustomerFormationMasterTabsState.custListBean.mempid != null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.mempid)
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(30),
                globals.onlyAphaNumeric
              ],
              onSaved: (val) {
                //  if(val!=null) {
                CustomerFormationMasterTabsState.custListBean.mempid = val;
                // }
              },
            ),
          ),
          Center(
            child: new Column(children: [
              //occupationRadio(),

              Container(
                color: Constant.mandatoryColor
                ,child:new DropdownButtonFormField(
                value: mtarget,
                items: generateDropDown(11),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 11);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text('target')),
                // style: TextStyle(color: Colors.grey),
              ),)


            ]),
          ),

          new Card(
              color: Constant.mandatoryColor,
            child: new ListTile(
                title: new Text(Translations.of(context).text('industry')),
                subtitle: CustomerFormationMasterTabsState.custListBean.mmainoccupn == null
                    ? new Text("")
                    : new Text("Industry : ${CustomerFormationMasterTabsState.custListBean.mmainoccupndesc}   And Code : ${CustomerFormationMasterTabsState.custListBean.mmainoccupn}"),
                onTap: () => getMainOccupation("Industry",occupation!=null ?int.parse(occupation.mcode!=null?occupation.mcode:"0"):0 )),
          ),
          new Card(
              color: Constant.mandatoryColor,
            child: new ListTile(
                title: new Text(Translations.of(context).text('sector')),
                subtitle: CustomerFormationMasterTabsState.custListBean.msuboccupn == null
                    ? new Text("")
                    : new Text("Sector : ${CustomerFormationMasterTabsState.custListBean.msuboccupndesc}   And Code : ${CustomerFormationMasterTabsState.custListBean.msuboccupn}"),
                onTap: () => getSubOccupation("Sector",
                    int.parse(CustomerFormationMasterTabsState.custListBean.mmainoccupn != null ? CustomerFormationMasterTabsState.custListBean.mmainoccupn : 0))),
          ),
          Center(
            child: new Column(children: [
              //occupationRadio(),

              Container(
                color: Constant.mandatoryColor
                ,child:new DropdownButtonFormField(
                value: mownership,
                items: generateDropDown(12),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 12);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text('ownership')),
                // style: TextStyle(color: Colors.grey),
              ),)


            ]),
          ),

          SizedBox(height: 16.0),
          new DropdownButtonFormField(
            value: secondryOccuptn==null?null:secondryOccuptn,
            items: generateDropDown(7),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 7);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text('SecOcc')),
            // style: TextStyle(color: Colors.grey),
          ),

          Container(

            child: new TextFormField(
              keyboardType: TextInputType.phone,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('iserngmembrBalhint'),
                labelText: Translations.of(context).text('iserngmembrlabel'),
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
              controller: CustomerFormationMasterTabsState.custListBean.misearngmembr != null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.misearngmembr.toString())
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
                globals.onlyIntNumber
              ],
              onSaved: (val) {
                //  if(val!=null) {
                CustomerFormationMasterTabsState.custListBean.misearngmembr = val;
                // }
              },
            ),
          ),

          Container(

            child: new TextFormField(
              keyboardType: TextInputType.phone,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('isstydngmemhint'),
                labelText: Translations.of(context).text('isstydngmemlabel'),
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
              controller: CustomerFormationMasterTabsState.custListBean.misstudyingmembr != null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.misstudyingmembr)
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
                globals.onlyIntNumber
              ],
              onSaved: (val) {
                //  if(val!=null) {
                CustomerFormationMasterTabsState.custListBean.misstudyingmembr = val;
                // }
              },
            ),
          ),


          Container(

            child: new TextFormField(
              keyboardType: TextInputType.phone,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('isdependnthint'),
                labelText: Translations.of(context).text('isdependntlabel'),
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
              controller: CustomerFormationMasterTabsState.custListBean.mmemberno != null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.mmemberno)
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
                globals.onlyIntNumber
              ],
              onSaved: (val) {
                //  if(val!=null) {
                CustomerFormationMasterTabsState.custListBean.mmemberno = val;
                // }
              },
            ),
          ),


          Container(

            child: new TextFormField(
              keyboardType: TextInputType.phone,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('ischldrnhint'),
                labelText: Translations.of(context).text('ischldrnlabel'),
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
              controller: CustomerFormationMasterTabsState.custListBean.mischldrn != null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.mischldrn)
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
                globals.onlyIntNumber
              ],
              onSaved: (val) {
                //  if(val!=null) {
                CustomerFormationMasterTabsState.custListBean.mischldrn = val;
                // }
              },
            ),
          ),

        ],
      ),
    );
  }


  Future getMainOccupation(String purposeMode, int selectedPosition) async {
    mainOcc = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForMainOccupationSelection(position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {

      //subPurposeName=purposeObjVal.codeDesc;
      //subPurposeId = purposeObjVal.code;
      CustomerFormationMasterTabsState.custListBean.mmainoccupndesc = purposeObjVal.codeDesc;
      CustomerFormationMasterTabsState.custListBean.mmainoccupn = (purposeObjVal.code.trim());
    });

  }

  Future getSubOccupation(String purposeMode, int selectedPosition) async {
    mainOcc = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForSubOccupationSelection(type: "Sector Selection List",basicCode: 1800000,position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {

      //subPurposeName=purposeObjVal.codeDesc;
      //subPurposeId = purposeObjVal.code;
      CustomerFormationMasterTabsState.custListBean.msuboccupndesc = purposeObjVal.codeDesc;
      CustomerFormationMasterTabsState.custListBean.msuboccupn = (purposeObjVal.code.trim());
    });
    /*  if (purposeMode == "subpurpose") {
//   if (purposeObj??  purposeObj.codeDesc??  purposeObj.code?? ) {
      subPurposeName = purposeObj.codeDesc ?? "";
      subPurposeId = purposeObj.code;
      // }
    }*/
  }


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mdob)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mdob= picked;
        tempDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
        tempMonth = picked.month.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, tempMonth);

      });
  }


  Future<Null> _selectHusDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState.custListBean.mhusdob)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mhusdob= picked;
        tempDateH = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDayH = "0"+picked.day.toString();

        }
        else tempDayH = picked.day.toString();
        CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(0, 2, tempDayH);
        tempYearH = picked.year.toString();
        CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(6, 10,tempYearH);
        if(picked.month.toString().length==1){
          tempMonthH = "0"+picked.month.toString();
        }
        else
          tempMonthH = picked.month.toString();
        CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(3, 5, tempMonthH);

      });
  }
}
