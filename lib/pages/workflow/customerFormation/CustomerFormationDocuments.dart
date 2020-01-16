import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco_los/Utilities/Helper.dart';
import 'package:eco_los/Utilities/OpenCamera.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/main.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';

import '../../../translations.dart';

class CustomerFormationDocuments extends StatefulWidget {
  var cameras;

  CustomerFormationDocuments(this.cameras, {Key key}) : super(key: key);

  @override
  _CustomerFormationDocumentsState createState() =>
      new _CustomerFormationDocumentsState();
}

class _CustomerFormationDocumentsState
    extends State<CustomerFormationDocuments> {
  LookupBeanData id1;
  LookupBeanData id2;
  LookupBeanData id3;
  File _image;
  static final GlobalKey<FormState> _formKeyid1 = new GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKeyid2 = new GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKeyid3 = new GlobalKey<FormState>();



  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempId1IssueDate = "----/--/--";
  String tempId1IssueYear ;
  String tempId1IssueDay ;
  String tempId1IssueMonth;
  String tempId1ExpDate = "----/--/--";
  String tempId1ExpYear ;
  String tempId1ExpDay ;
  String tempId1ExpMonth;

  String tempId2IssueDate = "----/--/--";
  String tempId2IssueYear ;
  String tempId2IssueDay ;
  String tempId2IssueMonth;
  String tempId2ExpDate = "----/--/--";
  String tempId2ExpYear ;
  String tempId2ExpDay ;
  String tempId2ExpMonth;

  String tempId3IssueDate = "----/--/--";
  String tempId3IssueYear ;
  String tempId3IssueDay ;
  String tempId3IssueMonth;
  String tempId3ExpDate = "----/--/--";
  String tempId3ExpYear ;
  String tempId3ExpDay ;
  String tempId3ExpMonth;

  FocusNode monthid1IssueFocus;
  FocusNode yearid1IssueFocus;
  FocusNode monthid2IssueFocus;
  FocusNode yearid2IssueFocus;

  FocusNode monthid3IssueFocus;
  FocusNode yearid3issueFocus;
  FocusNode monthid3ExpFocus;
  FocusNode yearid3ExpFocus;

  FocusNode monthid1ExpFocus;
  FocusNode yearid1ExpFocus;
  FocusNode monthid2ExpFocus;
  FocusNode yearid2ExpFocus;



  DateTime date;
  TimeOfDay time;

  Future getImage(int no) async {

    if(CustomerFormationMasterTabsState.custListBean.imageMaster==null){
      CustomerFormationMasterTabsState.custListBean.imageMaster= new  List<ImageBean>();
      for(int i =0;i<23;i++){
        CustomerFormationMasterTabsState.custListBean.imageMaster.add(new ImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200.0, maxWidth: 200.0);
    String st = image.path;
    print("path" + st.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[no].imgString =
        image.path;
    if(no>1 && no<3){
      CustomerFormationMasterTabsState.custListBean.imageMaster[0].desc=  id1.mcodedesc;
    }else if(no>3 && no<7){
      CustomerFormationMasterTabsState.custListBean.imageMaster[0].desc=  id2.mcodedesc;
    }else if(no>7 && no<11){
      CustomerFormationMasterTabsState.custListBean.imageMaster[0].desc= id3.mcodedesc;
    }

    setState(() {
      _image = image;
    });
  }


  @override
  void initState() {
    super.initState();
if(CustomerFormationMasterTabsState.custListBean.mnationality=="KH"){
  CustomerFormationMasterTabsState.custListBean.mpanno=5;
}
else{
  CustomerFormationMasterTabsState.custListBean.mpanno=2;
}

    monthid1IssueFocus = new FocusNode();
    yearid1IssueFocus = new FocusNode();

    monthid2IssueFocus = new FocusNode();
    yearid2IssueFocus = new FocusNode();


    monthid1ExpFocus = new FocusNode();
    yearid1ExpFocus = new FocusNode();

    monthid2ExpFocus = new FocusNode();
    yearid2ExpFocus = new FocusNode();


     monthid3IssueFocus = new FocusNode();
     yearid3issueFocus = new FocusNode();
     monthid3ExpFocus = new FocusNode();
     yearid3ExpFocus = new FocusNode();

    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mpanno.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mTypeOfId.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mtypeofid3.toString());

    for (int k = 0; k < globals.dropdownCaptionsValuesKyc.length; k++) {
      for (int i = 0; i < globals.dropdownCaptionsValuesKyc[k].length; i++) {
        try{
        if (globals.dropdownCaptionsValuesKyc[k][i].mcode.toString().trim() ==
            tempDropDownValues[k].toString().trim()) {
          setValue(k, globals.dropdownCaptionsValuesKyc[k][i]);
        }
        }catch(_){
          print("Exception Occured");
        }
      }
    }


    if(!CustomerFormationMasterTabsState.id1IssueDate.contains("_")){
      try{
        print("inside try");

        String tempid1issuedate = CustomerFormationMasterTabsState.id1IssueDate;

        DateTime  formattedDate =  DateTime.parse(tempid1issuedate.substring(6)+"-"+tempid1issuedate.substring(3,5)+"-"+tempid1issuedate.substring(0,2));
        print(formattedDate);
        tempId1IssueDay = formattedDate.day.toString();
        print(tempId1IssueDay);
        tempId1IssueMonth = formattedDate.month.toString();
        print(tempId1IssueMonth);
        tempId1IssueYear = formattedDate.year.toString();
        print(tempId1IssueYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }


    if(!CustomerFormationMasterTabsState.id2IssueDate.contains("_")){
      try{
        print("inside try");

        String tempId2issuedate = CustomerFormationMasterTabsState.id2IssueDate;

        DateTime  formattedDate =  DateTime.parse(tempId2issuedate.substring(6)+"-"+tempId2issuedate.substring(3,5)+"-"+tempId2issuedate.substring(0,2));
        print(formattedDate);
        tempId2IssueDay = formattedDate.day.toString();
        print(tempId2IssueDay);
        tempId2IssueMonth = formattedDate.month.toString();
        print(tempId2IssueMonth);
        tempId2IssueYear = formattedDate.year.toString();
        print(tempId2IssueYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    if(!CustomerFormationMasterTabsState.id3IssueDate.contains("_")){
      try{
        print("inside try");

        String tempid3issuedate = CustomerFormationMasterTabsState.id3IssueDate;

        DateTime  formattedDate =  DateTime.parse(tempid3issuedate.substring(6)+"-"+tempid3issuedate.substring(3,5)+"-"+tempid3issuedate.substring(0,2));
        print(formattedDate);
        tempId3IssueDay = formattedDate.day.toString();
        print(tempId3IssueDay);
        tempId3IssueMonth = formattedDate.month.toString();
        print(tempId3IssueMonth);
        tempId3IssueYear = formattedDate.year.toString();
        print(tempId3IssueYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    if(!CustomerFormationMasterTabsState.id1ExpDate.contains("_")){
      try{
        print("inside try");

        String tempId1Expdate = CustomerFormationMasterTabsState.id1ExpDate;

        DateTime  formattedDate =  DateTime.parse(tempId1Expdate.substring(6)+"-"+tempId1Expdate.substring(3,5)+"-"+tempId1Expdate.substring(0,2));
        print(formattedDate);
        tempId1ExpDay = formattedDate.day.toString();
        print(tempId1ExpDay);
        tempId1ExpMonth = formattedDate.month.toString();
        print(tempId1ExpMonth);
        tempId1ExpYear = formattedDate.year.toString();
        print(tempId1ExpYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }


    if(!CustomerFormationMasterTabsState.id2ExpDate.contains("_")){
      try{
        print("inside try");

        String tempId2Expdate = CustomerFormationMasterTabsState.id2ExpDate;

        DateTime  formattedDate =  DateTime.parse(tempId2Expdate.substring(6)+"-"+tempId2Expdate.substring(3,5)+"-"+tempId2Expdate.substring(0,2));
        print(formattedDate);
        tempId2ExpDay = formattedDate.day.toString();
        print(tempId2ExpDay);
        tempId2ExpMonth = formattedDate.month.toString();
        print(tempId2ExpMonth);
        tempId2ExpYear = formattedDate.year.toString();
        print(tempId2ExpYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    if(!CustomerFormationMasterTabsState.id3ExpDate.contains("_")){
      try{
        print("inside try");

        String tempId3Expdate = CustomerFormationMasterTabsState.id3ExpDate;

        DateTime  formattedDate =  DateTime.parse(tempId3Expdate.substring(6)+"-"+tempId3Expdate.substring(3,5)+"-"+tempId3Expdate.substring(0,2));
        print(formattedDate);
        tempId3ExpDay = formattedDate.day.toString();
        print(tempId3ExpDay);
        tempId3ExpMonth = formattedDate.month.toString();
        print(tempId3ExpMonth);
        tempId3ExpYear = formattedDate.year.toString();
        print(tempId3ExpYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }



  }
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  showDropDown(LookupBeanData selectedObj, int no) {
    if(selectedObj.mcodedesc.isEmpty){

      switch (no) {

        case 0:
          id1 = blankBean;
          CustomerFormationMasterTabsState.custListBean.mpanno =0;
          break;
        case 1:
          id2 = blankBean;
          CustomerFormationMasterTabsState.custListBean.mTypeOfId = 0;
          break;
        case 2:
          id3 = blankBean;
          CustomerFormationMasterTabsState.custListBean.mtypeofid3 =0;
          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesKyc[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesKyc[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesKyc[no][k]);
        }
      }
    }

  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          id1 = value;
          if(CustomerFormationMasterTabsState.custListBean.mnationality!='KH'){
            CustomerFormationMasterTabsState.custListBean.mpanno=2;
          }
          CustomerFormationMasterTabsState.custListBean.mpanno = int.parse(value.mcode);
          break;
        case 1:
          id2 = value;
          CustomerFormationMasterTabsState.custListBean.mTypeOfId = int.parse(value.mcode);
          break;
        case 2:
          id3 = value;
          CustomerFormationMasterTabsState.custListBean.mtypeofid3 = int.parse(value.mcode);
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.captionIdType[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(bean);
    for (int k = 0; k < globals.dropdownCaptionsValuesKyc[no].length; k++) {
      mapData.add(globals.dropdownCaptionsValuesKyc[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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

  /*List<DropdownMenuItem<String>> generateDropDown(int no) {
    List<DropdownMenuItem<String>> _dropDownMenuItems1;
    int i = 0;
    List mapdata = List();
    globals.dropdownCaptionsValuesKyc[no].forEach((mapValue) {
      var keys = mapValue.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        var val = mapValue[keys[i]];
        mapdata.add(val);
      }
    });
    _dropDownMenuItems1 = mapdata.map((value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  void changedDropDownItem(String id, int position) {
    print("Selected Id  $id, we are going to refresh the UI");
    print(position);
    setState(() {
      // globals.dropdownCaptionsValuesKyc[position].forEach((f) {
      switch (position) {
        case 0:
          globals.idType1 = id;
          //  globals.idType1Key = iterateMap(f, id);
          break;
        case 1:
          globals.idType2 = id;
          // globals.idType2 = iterateMap(f, id);
          break;
        default:
          break;
      }
      //  });
    });
  }*/

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new Card(
              elevation: 5.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Card(
                    //color: Constant.mandatoryColor

                    child:
                    new IgnorePointer(
                      ignoring: true,
                      child:new DropdownButtonFormField(
                        value: id1,
                        items: generateDropDown(0),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 0);
                        },
                        validator: (args) {
                          print(args);
                        },
                        //  isExpanded: true,
                        //hint:Text("Select"),
                        decoration: InputDecoration(labelText: Translations.of(context).text('idtype1')),
                        // style: TextStyle(color: Colors.grey),
                      ),),),
                /*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButtonFormField(
                      value: id1,
                      items: generateDropDown(0),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 0);
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration:
                          InputDecoration(labelText: Translations.of(context).text('idtype1')),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ),*/
                  new Form(
                    key: _formKeyid1,
                    //autovalidate: CustomerFormationMasterTabsState.autoValidate,
                    onWillPop: () {
                      return Future(() => true);
                    }
                    ,onChanged: () {
                    final FormState form = _formKeyid1.currentState;
                    form.save();
                  },
                 child: new Column(
                    children: <Widget>[


                         Container(
                          color:  Constant.mandatoryColor,
                          child: new TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(

                              hintText: Translations.of(context).text('EntrID1No'),
                              labelText: Translations.of(context).text('ID1No'),
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
                            inputFormatters: [new LengthLimitingTextInputFormatter(9),globals.onlyAphaNumeric],
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.mpannodesc!= null&&
                                CustomerFormationMasterTabsState.custListBean.mpannodesc!="null" ?
                            CustomerFormationMasterTabsState.custListBean.mpannodesc : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mpannodesc = val,
                          ),
                        ),


                         Container(
                           color: Constant.mandatoryColor,
                           child: new TextFormField(
                             textCapitalization: TextCapitalization.characters,
                             keyboardType: TextInputType.text,
                             decoration:  InputDecoration(

                               hintText: Translations.of(context).text('EntrID1Isngauth'),
                               labelText: Translations.of(context).text('idtype1issuing'),
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
                             inputFormatters: [
                               new LengthLimitingTextInputFormatter(20),
                               //globals.onlyIntNumber
                             ],
                             //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
                             initialValue:
                             CustomerFormationMasterTabsState.custListBean.missngautryt1!= null&&
                                 CustomerFormationMasterTabsState.custListBean.missngautryt1!="null" ?
                             CustomerFormationMasterTabsState.custListBean.missngautryt1 : "",
                             onSaved: (val) => CustomerFormationMasterTabsState.custListBean.missngautryt1 = val,
                           ),
                         ),

                         SizedBox(height: 20.0,),
                         Container(
                           decoration: BoxDecoration(color: Constant.mandatoryColor),
                           child: new Row(

                             children: <Widget>[Text(Translations.of(context).text('id1Issue'))],
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
                                     controller: tempId1IssueDay == null?null:new TextEditingController(text: tempId1IssueDay),
                                     keyboardType: TextInputType.numberWithOptions(),

                                     onChanged: (val){

                                       if(val!="0"){
                                         tempId1IssueDay = val;


                                         if(int.parse(val)<=31&&int.parse(val)>0){



                                           if(val.length==2){
                                             CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(0, 2, val);
                                             FocusScope.of(context).requestFocus(monthid1IssueFocus);
                                           }
                                           else{
                                             CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(0, 2, "0"+val);
                                           }


                                         }
                                         else {
                                           setState(() {
                                             tempId1IssueDay ="";
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
                                   focusNode: monthid1IssueFocus,
                                   controller: tempId1IssueMonth == null?null:new TextEditingController(text: tempId1IssueMonth),
                                   onChanged: (val){
                                     if(val!="0"){
                                       tempId1IssueMonth = val;
                                       if(int.parse(val)<=12&&int.parse(val)>0){

                                         if(val.length==2){
                                           CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(3, 5, val);

                                           FocusScope.of(context).requestFocus(yearid1IssueFocus);
                                         }
                                         else{
                                           CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(3, 5, "0"+val);
                                         }
                                       }
                                       else {
                                         setState(() {
                                           tempId1IssueMonth ="";
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


                                   focusNode: yearid1IssueFocus,
                                   controller: tempId1IssueYear == null?null:new TextEditingController(text: tempId1IssueYear),
                                   onChanged: (val){
                                     tempId1IssueYear = val;
                                     if(val.length==4) CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(6, 10,val);

                                   },
                                 ),)
                               ,

                               SizedBox(
                                 width: 50.0,
                               ),

                               IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                 _selectId1IssueDate(context);
                               } )
                             ],


                           ),

                         ),




                         SizedBox(height: 20.0,),
                         Container(
                           decoration: BoxDecoration(color: Constant.mandatoryColor),
                           child: new Row(

                             children: <Widget>[Text(Translations.of(context).text('id1Exp'))],
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
                                     controller: tempId1ExpDay == null?null:new TextEditingController(text: tempId1ExpDay),
                                     keyboardType: TextInputType.numberWithOptions(),

                                     onChanged: (val){

                                       if(val!="0"){
                                         tempId1ExpDay = val;


                                         if(int.parse(val)<=31&&int.parse(val)>0){



                                           if(val.length==2){
                                             CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(0, 2, val);
                                             FocusScope.of(context).requestFocus(monthid1ExpFocus);
                                           }
                                           else{
                                             CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(0, 2, "0"+val);
                                           }


                                         }
                                         else {
                                           setState(() {
                                             tempId1ExpDay ="";
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
                                   focusNode: monthid1ExpFocus,
                                   controller: tempId1ExpMonth == null?null:new TextEditingController(text: tempId1ExpMonth),
                                   onChanged: (val){
                                     if(val!="0"){
                                       tempId1ExpMonth = val;
                                       if(int.parse(val)<=12&&int.parse(val)>0){

                                         if(val.length==2){
                                           CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(3, 5, val);

                                           FocusScope.of(context).requestFocus(yearid1ExpFocus);
                                         }
                                         else{
                                           CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(3, 5, "0"+val);
                                         }
                                       }
                                       else {
                                         setState(() {
                                           tempId1ExpMonth ="";
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


                                   focusNode: yearid1ExpFocus,
                                   controller: tempId1ExpYear == null?null:new TextEditingController(text: tempId1ExpYear),
                                   onChanged: (val){
                                     tempId1ExpYear = val;
                                     if(val.length==4) CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(6, 10,val);

                                   },
                                 ),)
                               ,

                               SizedBox(
                                 width: 50.0,
                               ),

                               IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                 _selectId1ExpDate(context);
                               } )
                             ],


                           ),

                         ),


                    ],
                  ),
          ),

                  new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: Text(
                      Translations.of(context).text('ClckBlwfrpic'),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                                .custListBean
                                                .imageMaster[1]
                                                .imgString !=
                                            null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                                .custListBean
                                                .imageMaster[1]
                                                .imgString !=
                                            ""
                                    ? new Image.file(
                                        File(CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[1]
                                            .imgString),
                                        height: 200.0,
                                        width: 200.0,
                                      )
                                    : new Icon(
                                        Icons.camera_alt,
                                        size: 40.0,
                                        color: Color(0xff07426A),
                                      ),
                                onTap: () async {
                                  _PickImage(1);

                                  /*        await getImage(1);
                                   if(CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState.custListBean
                                       .imageMaster[1]
                                       .imgString!=null&&
                                       CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState.custListBean
                                           .imageMaster[1]
                                           .imgString!=""
                                   ){
                                     _changed(CustomerFormationMasterTabsState
                                         .custListBean
                                         .imageMaster[1]
                                         .imgString,"");
                                   }
*/
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[2]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&& CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[2]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[2]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(2);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
          new Card(
              elevation: 5.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButtonFormField(
                      value: id2,
                      items: generateDropDown(1),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 1);
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration: InputDecoration(labelText: Translations.of(context).text('idtype2')),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ),


                  new Form(
                    key: _formKeyid2,
                    //autovalidate: CustomerFormationMasterTabsState.autoValidate,
                    onWillPop: () {
                      return Future(() => true);
                    }
                    ,onChanged: () {
                    final FormState form = _formKeyid2.currentState;
                    form.save();
                  },
                    child: new Column(
                      children: <Widget>[

                        Container(
                          color: Constant.mandatoryColor,
                          child: new TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(

                              hintText: Translations.of(context).text('EntrID2No'),
                              labelText: Translations.of(context).text('ID2No'),
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
                            inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyAphaNumeric],
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.mIdDesc!= null&&
                                CustomerFormationMasterTabsState.custListBean.mIdDesc!="null" ?
                            CustomerFormationMasterTabsState.custListBean.mIdDesc : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mIdDesc = val,
                          ),
                        ),

                        Container(
                          color: Constant.mandatoryColor,
                          child: new TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(

                              hintText: Translations.of(context).text('EntrID2Isngauth'),
                              labelText: Translations.of(context).text('ID2Issngauth'),
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
                            inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyAphaNumeric],
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.missngautryt2!= null&&
                                CustomerFormationMasterTabsState.custListBean.missngautryt2!="null" ?
                            CustomerFormationMasterTabsState.custListBean.missngautryt2 : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.missngautryt2 = val,
                          ),
                        ),



                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(color: Constant.mandatoryColor),
                          child: new Row(

                            children: <Widget>[Text(Translations.of(context).text('id2Issue'))],
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
                                    controller: tempId2IssueDay == null?null:new TextEditingController(text: tempId2IssueDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                    onChanged: (val){

                                      if(val!="0"){
                                        tempId2IssueDay = val;


                                        if(int.parse(val)<=31&&int.parse(val)>0){



                                          if(val.length==2){
                                            CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(0, 2, val);
                                            FocusScope.of(context).requestFocus(monthid2IssueFocus);
                                          }
                                          else{
                                            CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(0, 2, "0"+val);
                                          }


                                        }
                                        else {
                                          setState(() {
                                            tempId2IssueDay ="";
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
                                  focusNode: monthid2IssueFocus,
                                  controller: tempId2IssueMonth == null?null:new TextEditingController(text: tempId2IssueMonth),
                                  onChanged: (val){
                                    if(val!="0"){
                                      tempId2IssueMonth = val;
                                      if(int.parse(val)<=12&&int.parse(val)>0){

                                        if(val.length==2){
                                          CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(3, 5, val);

                                          FocusScope.of(context).requestFocus(yearid2IssueFocus);
                                        }
                                        else{
                                          CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(3, 5, "0"+val);
                                        }
                                      }
                                      else {
                                        setState(() {
                                          tempId2IssueMonth ="";
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


                                  focusNode: yearid2IssueFocus,
                                  controller: tempId2IssueYear == null?null:new TextEditingController(text: tempId2IssueYear),
                                  onChanged: (val){
                                    tempId2IssueYear = val;
                                    if(val.length==4) CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(6, 10,val);

                                  },
                                ),)
                              ,

                              SizedBox(
                                width: 50.0,
                              ),

                              IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                _selectId2IssueDate(context);
                              } )
                            ],


                          ),

                        ),




                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(color: Constant.mandatoryColor),
                          child: new Row(

                            children: <Widget>[Text(Translations.of(context).text('id2Exp'))],
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
                                    controller: tempId2ExpDay == null?null:new TextEditingController(text: tempId2ExpDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                    onChanged: (val){

                                      if(val!="0"){
                                        tempId2ExpDay = val;


                                        if(int.parse(val)<=31&&int.parse(val)>0){



                                          if(val.length==2){
                                            CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(0, 2, val);
                                            FocusScope.of(context).requestFocus(monthid2ExpFocus);
                                          }
                                          else{
                                            CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(0, 2, "0"+val);
                                          }


                                        }
                                        else {
                                          setState(() {
                                            tempId2ExpDay ="";
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
                                  focusNode: monthid2ExpFocus,
                                  controller: tempId2ExpMonth == null?null:new TextEditingController(text: tempId2ExpMonth),
                                  onChanged: (val){
                                    if(val!="0"){
                                      tempId2ExpMonth = val;
                                      if(int.parse(val)<=12&&int.parse(val)>0){

                                        if(val.length==2){
                                          CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(3, 5, val);

                                          FocusScope.of(context).requestFocus(yearid2ExpFocus);
                                        }
                                        else{
                                          CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(3, 5, "0"+val);
                                        }
                                      }
                                      else {
                                        setState(() {
                                          tempId2ExpMonth ="";
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


                                  focusNode: yearid2ExpFocus,
                                  controller: tempId2ExpYear == null?null:new TextEditingController(text: tempId2ExpYear),
                                  onChanged: (val){
                                    tempId2ExpYear = val;
                                    if(val.length==4) CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(6, 10,val);

                                  },
                                ),)
                              ,

                              SizedBox(
                                width: 50.0,
                              ),

                              IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                _selectId2ExpDate(context);
                              } )
                            ],


                          ),

                        ),



                      ],
                    ),
                  ),


                  new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: Text(
                      Translations.of(context).text('ClckBlwfrpic'),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[3]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[3]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[3]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {

                                  _PickImage(3);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[4]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[4]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[4]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(4);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title:CustomerFormationMasterTabsState.custListBean.imageMaster!=null&& CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[5]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[5]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[5]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(5);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[6]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[6]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[6]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(6);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),

          //here
          new Card(
              elevation: 5.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButtonFormField(
                      value: id3,
                      items: generateDropDown(2),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 2);
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration:
                      InputDecoration(labelText: Translations.of(context).text('idtype3')),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  new Form(
                    key: _formKeyid3,
                    //autovalidate: CustomerFormationMasterTabsState.autoValidate,
                    onWillPop: () {
                      return Future(() => true);
                    }
                    ,onChanged: () {
                    final FormState form = _formKeyid3.currentState;
                    form.save();
                  },
                    child: new Column(
                      children: <Widget>[


                        Container(
                          color:  Constant.mandatoryColor,
                          child: new TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(

                              hintText: Translations.of(context).text('EntrID3No'),
                              labelText: Translations.of(context).text('ID3No'),
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
                            inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyAphaNumeric],
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.middesc3!= null&&
                                CustomerFormationMasterTabsState.custListBean.middesc3!="null" ?
                            CustomerFormationMasterTabsState.custListBean.middesc3 : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.middesc3 = val,
                          ),
                        ),


                        Container(
                          color: Constant.mandatoryColor,
                          child: new TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(

                              hintText: Translations.of(context).text('EntrID3Isngauth'),
                              labelText: Translations.of(context).text('ID3Isngauth'),
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
                            inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyAphaNumeric],
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.missngautryt3!= null&&
                                CustomerFormationMasterTabsState.custListBean.missngautryt3!="null" ?
                            CustomerFormationMasterTabsState.custListBean.missngautryt3 : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.missngautryt3 = val,
                          ),
                        ),

                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(color: Constant.mandatoryColor),
                          child: new Row(

                            children: <Widget>[Text(Translations.of(context).text('id3Issue'))],
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
                                    controller: tempId3IssueDay == null?null:new TextEditingController(text: tempId3IssueDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                    onChanged: (val){

                                      if(val!="0"){
                                        tempId3IssueDay = val;


                                        if(int.parse(val)<=31&&int.parse(val)>0){



                                          if(val.length==2){
                                            CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(0, 2, val);
                                            FocusScope.of(context).requestFocus(monthid3IssueFocus);
                                          }
                                          else{
                                            CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(0, 2, "0"+val);
                                          }


                                        }
                                        else {
                                          setState(() {
                                            tempId3IssueDay ="";
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
                                  focusNode: monthid3IssueFocus,
                                  controller: tempId3IssueMonth == null?null:new TextEditingController(text: tempId3IssueMonth),
                                  onChanged: (val){
                                    if(val!="0"){
                                      tempId3IssueMonth = val;
                                      if(int.parse(val)<=12&&int.parse(val)>0){

                                        if(val.length==2){
                                          CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(3, 5, val);

                                            FocusScope.of(context).requestFocus(yearid3issueFocus);
                                        }
                                        else{
                                          CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(3, 5, "0"+val);
                                        }
                                      }
                                      else {
                                        setState(() {
                                          tempId3IssueMonth ="";
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


                                  focusNode: yearid3issueFocus,
                                  controller: tempId3IssueYear == null?null:new TextEditingController(text: tempId3IssueYear),
                                  onChanged: (val){
                                    tempId3IssueYear = val;
                                    if(val.length==4) CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(6, 10,val);

                                  },
                                ),)
                              ,

                              SizedBox(
                                width: 50.0,
                              ),

                              IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                _selectId3IssueDate(context);
                              } )
                            ],


                          ),

                        ),




                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(color: Constant.mandatoryColor),
                          child: new Row(

                            children: <Widget>[Text(Translations.of(context).text('id3Exp'))],
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
                                    controller: tempId3ExpDay == null?null:new TextEditingController(text: tempId3ExpDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                    onChanged: (val){

                                      if(val!="0"){
                                        tempId3ExpDay = val;


                                        if(int.parse(val)<=31&&int.parse(val)>0){



                                          if(val.length==2){
                                            CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(0, 2, val);
                                            FocusScope.of(context).requestFocus(monthid3ExpFocus);
                                          }
                                          else{
                                            CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(0, 2, "0"+val);
                                          }


                                        }
                                        else {
                                          setState(() {
                                            tempId3ExpDay ="";
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
                                  focusNode: monthid3ExpFocus,
                                  controller: tempId3ExpMonth == null?null:new TextEditingController(text: tempId3ExpMonth),
                                  onChanged: (val){
                                    if(val!="0"){
                                      tempId3ExpMonth = val;
                                      if(int.parse(val)<=12&&int.parse(val)>0){

                                        if(val.length==2){
                                          CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(3, 5, val);

                                          FocusScope.of(context).requestFocus(yearid3ExpFocus);
                                        }
                                        else{
                                          CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(3, 5, "0"+val);
                                        }
                                      }
                                      else {
                                        setState(() {
                                          tempId3ExpMonth ="";
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


                                  focusNode: yearid3ExpFocus,
                                  controller: tempId3ExpYear == null?null:new TextEditingController(text: tempId3ExpYear),
                                  onChanged: (val){
                                    tempId3ExpYear = val;
                                    if(val.length==4) CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(6, 10,val);

                                  },
                                ),)
                              ,

                              SizedBox(
                                width: 50.0,
                              ),

                              IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                _selectId3ExpDate(context);
                              } )
                            ],


                          ),

                        ),


                      ],
                    ),
                  ),

                  new Text(
                    Translations.of(context).text('IdType3'),
                    style: TextStyle(color: Colors.grey),
                  ),
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[7]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[7]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[7]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(7);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[8]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[8]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[8]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(8);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[9]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[9]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[9]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(9);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                    .custListBean
                                    .imageMaster[10]
                                    .imgString !=
                                    null &&
                                    CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState
                                        .custListBean
                                        .imageMaster[10]
                                        .imgString !=
                                        ""
                                    ? new Image.file(
                                  File(CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[10]
                                      .imgString),
                                  height: 200.0,
                                  width: 200.0,
                                )
                                    : new Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Color(0xff07426A),
                                ),
                                onTap: () {
                                  _PickImage(10);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
/*
  _navigateAndDisplaySelection(BuildContext context, String str) async {
    globals.imageType = str;
    if (widget.cameras == null) {
      //widget.cameras = await availableCameras();
    }
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new OpenCamera(),
          fullscreenDialog: true,
        )).then((onValue) {
      if (onValue != null) {
        setState(() {
          _changed(onValue, str);
        });
      }

      setState(() {});
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }*/

  void _changed(String filePath, String str) {
    setState(() {
      if (str == "id1") {
        globals.imageVisibilityKyc1AppId1TagCustomer = true;
        globals.kyc1AppId1PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgSubType = 'Kyc1Id1';
        imgBean.imgType = str;
        CustomerFormationMasterTabsState.custListBean.imageMaster.insert(1, imgBean);
        /*globals.listImgBean.add(imgBean);*/
        // globals.listImgBean.insert(1,imgBean);
      } else if (str == "id12") {
        globals.imageVisibilityKyc1AppId12TagCustomer = true;
        globals.kyc1AppId12PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id1';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(2,imgBean);
      } else if (str == "id2") {
        globals.imageVisibilityKyc1AppId2TagCustomer = true;
        globals.kyc1AppId2PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id2';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(3,imgBean);
      } else if (str == "id22") {
        globals.imageVisibilityKyc1AppId22TagCustomer = true;
        globals.kyc1AppId22PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id2';
        globals.listImgBean.add(imgBean);
        // globals.listImgBean.insert(4,imgBean);
      } else if (str == "id23") {
        globals.imageVisibilityKyc1AppId23TagCustomer = true;
        globals.kyc1AppId23PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id2';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(5,imgBean);
      } else if (str == "id24") {
        globals.imageVisibilityKyc1AppId24TagCustomer = true;
        globals.kyc1AppId24PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgSubType = 'Kyc1Id2';
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(6,imgBean);
      } else if (str == "passbook2") {
        globals.imageVisibilityKyc1PassBook2TagCustomer = true;
        globals.kyc1PassBook2TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        // globals.listImgBean.insert(7,imgBean);
      } else if (str == "passbook1") {
        globals.imageVisibilityKyc1PassBook1TagCustomer = true;
        globals.kyc1PassBook1TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(8,imgBean);
      } else if (str == "passbook3") {
        globals.imageVisibilityKyc1PassBook3TagCustomer = true;
        globals.kyc1PassBook3TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(9,imgBean);
      } else if (str == "passbook4") {
        globals.imageVisibilityKyc1PassBook4TagCustomer = true;
        globals.kyc1PassBook4TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(10,imgBean);
      }
    });
  }




  Future<Null> _selectId1IssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid1issuedate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid1issuedate= picked;
        tempId1IssueDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId1IssueDay = "0"+picked.day.toString();

        }
        else tempId1IssueDay = picked.day.toString();
        CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(0, 2, tempId1IssueDay);
        tempId1IssueYear = picked.year.toString();
        CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(6, 10,tempId1IssueYear);
        if(picked.month.toString().length==1){
          tempId1IssueMonth = "0"+picked.month.toString();
        }
        else
          tempId1IssueMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(3, 5, tempId1IssueMonth);

      });
  }


  Future<Null> _selectId1ExpDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid1expdate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid1expdate= picked;
        tempId1ExpDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId1ExpDay = "0"+picked.day.toString();

        }
        else tempId1ExpDay = picked.day.toString();
        CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(0, 2, tempId1ExpDay);
        tempId1ExpYear = picked.year.toString();
        CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(6, 10,tempId1ExpYear);
        if(picked.month.toString().length==1){
          tempId1ExpMonth = "0"+picked.month.toString();
        }
        else
          tempId1ExpMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(3, 5, tempId1ExpMonth);

      });
  }


  Future<Null> _selectId2ExpDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid2expdate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid2expdate= picked;
        tempId2ExpDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId2ExpDay = "0"+picked.day.toString();

        }
        else tempId2ExpDay = picked.day.toString();
        CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(0, 2, tempId2ExpDay);
        tempId2ExpYear = picked.year.toString();
        CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(6, 10,tempId2ExpYear);
        if(picked.month.toString().length==1){
          tempId2ExpMonth = "0"+picked.month.toString();
        }
        else
          tempId2ExpMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(3, 5, tempId2ExpMonth);

      });
  }

  Future<Null> _selectId2IssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid2issuedate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid2issuedate= picked;
        tempId2IssueDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId2IssueDay = "0"+picked.day.toString();

        }
        else tempId2IssueDay = picked.day.toString();
        CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(0, 2, tempId2IssueDay);
        tempId2IssueYear = picked.year.toString();
        CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(6, 10,tempId2IssueYear);
        if(picked.month.toString().length==1){
          tempId2IssueMonth = "0"+picked.month.toString();
        }
        else
          tempId2IssueMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(3, 5, tempId2IssueMonth);

      });
  }


  Future<Null> _selectId3IssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid3issuedate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid3issuedate= picked;
        tempId3IssueDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId3IssueDay = "0"+picked.day.toString();

        }
        else tempId3IssueDay = picked.day.toString();
        CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(0, 2, tempId3IssueDay);
        tempId3IssueYear = picked.year.toString();
        CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(6, 10,tempId3IssueYear);
        if(picked.month.toString().length==1){
          tempId3IssueMonth = "0"+picked.month.toString();
        }
        else
          tempId3IssueMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id3IssueDate = CustomerFormationMasterTabsState.id3IssueDate.replaceRange(3, 5, tempId3IssueMonth);

      });
  }


  Future<Null> _selectId3ExpDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid3expdate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid3expdate= picked;
        tempId3ExpDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId3ExpDay = "0"+picked.day.toString();

        }
        else tempId3ExpDay = picked.day.toString();
        CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(0, 2, tempId3ExpDay);
        tempId3ExpYear = picked.year.toString();
        CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(6, 10,tempId3ExpYear);
        if(picked.month.toString().length==1){
          tempId3ExpMonth = "0"+picked.month.toString();
        }
        else
          tempId3ExpMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id3ExpDate = CustomerFormationMasterTabsState.id3ExpDate.replaceRange(3, 5, tempId3ExpMonth);

      });
  }

  Future<void> _PickImage(int imageNo) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.touch_app,
              color: Colors.blue[800],
              size: 40.0,
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[

                  Card(
                    child: new ListTile(
                        title: new Text((Translations.of(context).text('TkPicFrmCam'))),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImage(imageNo);

                        }),),

                  Card(
                    child: new ListTile(
                        title: new Text((Translations.of(context).text('ChsFrmGllry'))),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImageFromGallery(imageNo);

                        }),),


                ],
              ),
            ),
          );
        });
  }

  Future getImageFromGallery(int imageNo) async {
    if (CustomerFormationMasterTabsState.custListBean.imageMaster == null) {
      CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
      for (int i = 0; i < 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster
            .add(new ImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 400.0, maxWidth: 400.0);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.5,
      maxWidth: 512,
      maxHeight: 512,
    );
    String st = croppedFile.path;
    print("path" +
        CustomerFormationMasterTabsState.custListBean.imageMaster.length
            .toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].imgString =
        croppedFile.path;
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].desc =
    "Customer Picture";

    setState(() {
      _image = croppedFile;
    });
  }


}
