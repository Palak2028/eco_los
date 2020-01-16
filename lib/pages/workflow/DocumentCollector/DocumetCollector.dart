import 'dart:io';

import 'package:eco_los/Utilities/GetSubLookupAsMis.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/DocumentCollector/ViewDocuments.dart';
import 'package:eco_los/pages/workflow/GRT/Photo_view.dart';
import 'package:eco_los/pages/workflow/Guarantor/GuarantorDetailsForSelection.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../translations.dart';
import '../LookupMasterBean.dart';
import 'DocumentCollectorBean.dart';

class DocumetCollector extends StatefulWidget {
  final String mleadsId;
  final int mrefno;
  final int trefno;
  final String custname;
  final int cusmref;
  final int custref;
  final int cusno;

  DocumetCollector(this.mleadsId,this.mrefno,this.trefno,this.custname,this.cusmref,this.custref,this.cusno);


  @override
  _DocumetCollectorState createState() => new _DocumetCollectorState();
}

class _DocumetCollectorState extends State<DocumetCollector> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DocumentCollectorBean> documentCollectorBeanList = new List<DocumentCollectorBean>();
  DocumentCollectorBean documentCollectorBean = new DocumentCollectorBean();
  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  LookupBeanData documenttype;
  LookupBeanData customerType;
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
  bool isTypeSelected=false;
  String imgtyp;
  String custtyp;

  var formatter = new DateFormat('dd-MM-yyyy');
  String tempIssueDateYear;
  String tempIssueDateDay;
  String tempIssueDateMonth;
  String tempIssueDateDate = "----/--/--";

  String issueDate = "__-__-____";
  FocusNode monthIssueDateFocus;
  FocusNode yearIssueDateFocus;



  String tempExecutionDateYear;
  String tempExecutionDateDay;
  String tempExecutionDateMonth;
  String tempExecutionDateDate = "----/--/--";

  String ExecutionDate = DateTime.now().toString();
  FocusNode monthExecutionDateFocus;
  FocusNode yearExecutionDateFocus;


  String tempExpDateYear;
  String tempExpDateDay;
  String tempExpDateMonth;
  String tempExpDateDate = "----/--/--";

  String expDate = "__-__-____";
  FocusNode monthExpDateFocus;
  FocusNode yearExpDateFocus;


  @override
  void initState() {

    monthIssueDateFocus = new FocusNode();
    yearIssueDateFocus = new FocusNode();
    monthExecutionDateFocus=new FocusNode();
    yearExecutionDateFocus=new FocusNode();
    monthExpDateFocus = new FocusNode();
    yearExpDateFocus = new FocusNode();

      if (widget.mleadsId != null &&
          widget.mleadsId != "null" &&
          widget.mleadsId != "") {
        documentCollectorBean.mforeignindicator = widget.mleadsId;
      }
      if (widget.mrefno != null &&
          widget.mrefno != "null" &&
          widget.mrefno != "") {
        documentCollectorBean.loanmrefno = widget.mrefno;
      }
      if (widget.trefno != "null" &&
          widget.trefno != "" &&
          widget.trefno != null) {
        documentCollectorBean.loantrefno = widget.trefno;
      }
/*    if (widget.custname != null &&
        widget.custname != "null" &&
        widget.custname != "") {
      documentCollectorBean.mcustname = widget.custname;
    }
    if (widget.custref != null &&
        widget.custref != "null" &&
        widget.custref != "") {
      documentCollectorBean.custtrefno = widget.custref;
    }
    if (widget.cusmref != null &&
        widget.cusmref != "null" &&
        widget.cusmref != "") {
      documentCollectorBean.custmrefno = widget.cusmref;
    }
    if (widget.cusno != null &&
        widget.cusno != "null" &&
        widget.cusno != "") {
      documentCollectorBean.mcustno = widget.cusno;
    }*/

    getSessionVariables();


   }


  Future<Null> getSessionVariables() async {
    setState(() {});
    prefs = await SharedPreferences.getInstance();
    await AppDatabase.get().getDocuments(widget.trefno,widget.mrefno).then((List<DocumentCollectorBean> documentCollectorBean) async{
      print("onValue.toString()"+documentCollectorBean.toString());
      if(documentCollectorBean!=null && documentCollectorBean.length>0) {
          print("onValue.toString()1"+documentCollectorBean.toString());
        documentCollectorBeanList = documentCollectorBean;
      }
    });
    if (documentCollectorBean.trefno == "" ||
        documentCollectorBean.trefno == null ||
        documentCollectorBean.trefno == "null") {
      print("documentCollectorBean.trefno"+documentCollectorBean.trefno.toString());
      await AppDatabase.get().generateTrefnoForDocuments().then((onValue) {
        print("onValue"+onValue.toString());
        documentCollectorBean.trefno = onValue;
      });
    }
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

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      //   print("inside  code Desc is null");
      switch (no) {
        case 0:
          documenttype = blankBean;
          documentCollectorBean.mimgtype = blankBean.mcode;
          break;
        case 1:
          customerType = blankBean;
          documentCollectorBean.mcustomertype = blankBean.mcode;
          setState(() {
            documentCollectorBean=new DocumentCollectorBean();
          });
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropDownCaptionDocumentCollecter[no].length;
          k++) {
        if (globals.dropDownCaptionDocumentCollecter[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropDownCaptionDocumentCollecter[no][k]);
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
      // print("coming here");
      switch (no) {
        case 0:
          documenttype = value;
          documentCollectorBean.mimgtype = value.mcode;
          documentCollectorBean.mimgtypedesc = value.mcodedesc;
           imgtyp=documentCollectorBean.mimgtype;


          break;
        case 1:
          customerType = value;
          documentCollectorBean.mcustomertype = value.mcode;
           custtyp=documentCollectorBean.mcustomertype;
           print("imgtyp"+imgtyp.toString());
           print("custtyp"+custtyp.toString());
           if(custtyp=="101"){
             print("inside");
             setState(() {
               if (widget.custname != null &&
                   widget.custname != "null" &&
                   widget.custname != "") {
                 documentCollectorBean.mcustname = widget.custname;
               }
               if (widget.custref != null &&
                   widget.custref != "null" &&
                   widget.custref != "") {
                 documentCollectorBean.custtrefno = widget.custref;
               }
               if (widget.cusmref != null &&
                   widget.cusmref != "null" &&
                   widget.cusmref != "") {
                 documentCollectorBean.custmrefno = widget.cusmref;
               }
               if (widget.cusno != null &&
                   widget.cusno != "null" &&
                   widget.cusno != "") {
                 documentCollectorBean.mcustno = widget.cusno;
               }
             });

           }
          if(custtyp=="101"){

            AppDatabase.get().isThisTypeOfDocPresentcust(custtyp,imgtyp,documentCollectorBean.custtrefno,documentCollectorBean.custmrefno).then((DocumentCollectorBean documentCollectorBeanList) async{
            print("onValue.toString()"+documentCollectorBeanList.toString());
            if(documentCollectorBeanList!=null ) {
              print("onValue.toString()1"+documentCollectorBean.toString());
              setState(() {
                documentCollectorBean.mdoctno  = documentCollectorBeanList.mdoctno!="null"&&documentCollectorBeanList.mdoctno!=null&&documentCollectorBeanList.mdoctno!=""?documentCollectorBeanList.mdoctno:"";
                documentCollectorBean.missuingauth  = documentCollectorBeanList.missuingauth!="null"&&documentCollectorBeanList.missuingauth!=null&&documentCollectorBeanList.missuingauth!=""?documentCollectorBeanList.missuingauth:"";
                documentCollectorBean.mremarks  = documentCollectorBeanList.mremarks!="null"&&documentCollectorBeanList.mremarks!=null&&documentCollectorBeanList.mremarks!=""?documentCollectorBeanList.mremarks:"";

            //    documentCollectorBean.custtrefno  = documentCollectorBeanList.custtrefno!="null"&&documentCollectorBeanList.custtrefno!=null&&documentCollectorBeanList.custtrefno!=""?documentCollectorBeanList.custtrefno:"";
              //  documentCollectorBean.custmrefno  = documentCollectorBeanList.custmrefno!="null"&&documentCollectorBeanList.custmrefno!=null&&documentCollectorBeanList.custmrefno!=""?documentCollectorBeanList.custmrefno:"";
                //documentCollectorBean.mcustno  = documentCollectorBeanList.mcustno!="null"&&documentCollectorBeanList.mcustno!=null&&documentCollectorBeanList.mcustno!=""?documentCollectorBeanList.mcustno:"";
                //documentCollectorBean.mcustname  = documentCollectorBeanList.mcustname!="null"&&documentCollectorBeanList.mcustname!=null&&documentCollectorBeanList.mcustname!=""?documentCollectorBeanList.mcustname:"";



                if(documentCollectorBeanList.missuedate!="null"&&documentCollectorBeanList.missuedate!=null&&documentCollectorBeanList.missuedate!="") {
                  documentCollectorBean.missuedate=documentCollectorBeanList.missuedate;
                  setState(() {
                    if (documentCollectorBeanList.missuedate.day
                        .toString()
                        .length == 1) {
                      tempIssueDateDay = "0" +
                          documentCollectorBeanList.missuedate
                              .day.toString();
                    }
                    else
                      tempIssueDateDay =
                          documentCollectorBeanList.missuedate
                              .day.toString();
                    tempIssueDateYear =
                        documentCollectorBeanList.missuedate
                            .year.toString();
                    if (documentCollectorBeanList.missuedate
                        .month
                        .toString()
                        .length == 1) {
                      tempIssueDateMonth = "0" +
                          documentCollectorBeanList.missuedate
                              .month.toString();
                    }
                    else
                      tempIssueDateMonth =
                          documentCollectorBeanList.missuedate
                              .month.toString();
                  });
              }

                if(documentCollectorBeanList.mexpdate!="null"&&documentCollectorBeanList.mexpdate!=null&&documentCollectorBeanList.mexpdate!="") {
                  documentCollectorBean.mexpdate=documentCollectorBeanList.mexpdate;

                  setState(() {
                    if (documentCollectorBeanList.mexpdate.day
                        .toString()
                        .length == 1) {
                      tempExpDateDay = "0" +
                          documentCollectorBeanList.mexpdate
                              .day.toString();
                    }
                    else
                      tempExpDateDay =
                          documentCollectorBeanList.mexpdate
                              .day.toString();
                    tempExpDateYear =
                        documentCollectorBeanList.mexpdate
                            .year.toString();
                    if (documentCollectorBeanList.mexpdate
                        .month
                        .toString()
                        .length == 1) {
                      tempExpDateMonth = "0" +
                          documentCollectorBeanList.mexpdate
                              .month.toString();
                    }
                    else
                      tempExpDateMonth =
                          documentCollectorBeanList.mexpdate
                              .month.toString();
                  });
                }

              }
              );

            }
            else{
              setState(() {
                documentCollectorBean.mdoctno  ="";
                documentCollectorBean.missuingauth  = "";
                documentCollectorBean.mremarks  = "";

                tempExpDateDay="";
                tempExpDateYear="";
                tempExpDateMonth="";
                tempIssueDateDay="";
                tempIssueDateMonth="";
                tempIssueDateYear="";

              });
            }
          }

          );}
          else{
            print("Inside else");
            setState(() {
              documentCollectorBean.mdoctno  ="";
              documentCollectorBean.missuingauth  = "";
              documentCollectorBean.mremarks  = "";
                documentCollectorBean.custtrefno  = 0;
                documentCollectorBean.custmrefno  = 0;
                documentCollectorBean.mcustno  =0;
                documentCollectorBean.mcustname  ="";
              tempExpDateDay="";
              tempExpDateYear="";
              tempExpDateMonth="";
              tempIssueDateDay="";
              tempIssueDateMonth="";
              tempIssueDateYear="";

            });
          }

          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropDownCaptionDocumentCollecter[no].length;
        k++) {
      mapData.add(globals.dropDownCaptionDocumentCollecter[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();

    return _dropDownMenuItems1;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          // callDialog();
        },
        child: new Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
              elevation: 1.0,
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //  callDialog();
                  }),
              backgroundColor: Color(0xff07426A),
              brightness: Brightness.light,
              title: new Text(
                'Document Collector',
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
                    Navigator.of(context).pop();

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
                form.save();
                //await calculate();
              },
              child:  ListView(
                  shrinkWrap: true,
                  //padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    Card(
                      color: Constant.mandatoryColor,
                      child: new DropdownButtonFormField(
                        value: documenttype,
                        items: generateDropDown(0),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 0);
                        },
                        decoration: InputDecoration(labelText: Translations.of(context).text('DocTyp')),
                      ),
                    ),


                    Card(
                      color: Constant.mandatoryColor,
                      child: new DropdownButtonFormField(
                        value: customerType,
                        items: generateDropDown(1),
                        onChanged: (LookupBeanData newValue) {
                          isTypeSelected=true;
                          showDropDown(newValue, 1);
                        },
                        decoration: InputDecoration(labelText: Translations.of(context).text('CustTyp')),
                      ),
                    ),

isTypeSelected?
                    new Card(
                      child: new ListTile(
                          title: new Text(Translations.of(context).text('customer_number_and_name')  ),
                          subtitle: documentCollectorBean.mcustno == null
                              ? new Text("")
                              : new Text(
                              "${documentCollectorBean.mcustno.toString() + " " + documentCollectorBean.mcustname.toString()}"),
                          onTap: () => getCustomerNumber(documentCollectorBean.mcustomertype,documentCollectorBean.loantrefno,documentCollectorBean.loanmrefno,documentCollectorBean.mcustname,documentCollectorBean.custtrefno,documentCollectorBean.custmrefno,documentCollectorBean.mcustno)),
                    ): Container(),




                    SizedBox(height: 10.0,),

                    Container(
                      color:  Constant.mandatoryColor,
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(

                          hintText: Translations.of(context).text('IDNo'),
                          labelText: Translations.of(context).text('IDNo'),
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
                        inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                        controller:  documentCollectorBean.mdoctno != null
                            ? TextEditingController(text:  documentCollectorBean.mdoctno)
                            : TextEditingController(text: ""),
                        onSaved: (val) => documentCollectorBean.mdoctno = val,
                      ),
                    ),


                    Container(
                      color: Constant.mandatoryColor,
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(

                          hintText: Translations.of(context).text('Issuauth'),
                          labelText: Translations.of(context).text('Issuauth'),
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
                        inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                        controller:  documentCollectorBean.missuingauth != null
                            ? TextEditingController(text:  documentCollectorBean.missuingauth)
                            : TextEditingController(text: ""),
                        onSaved: (val) => documentCollectorBean.missuingauth = val,
                      ),
                    ),


                    Container(
                      color: Constant.mandatoryColor,
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(

                          hintText: Translations.of(context).text('Remarks'),
                          labelText: Translations.of(context).text('Remarks'),
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
                        //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
                        controller:  documentCollectorBean.mremarks != null
                            ? TextEditingController(text:  documentCollectorBean.mremarks)
                            : TextEditingController(text: ""),
                        onSaved: (val) => documentCollectorBean.mremarks = val,
                      ),
                    ),

                      SizedBox(height: 10.0,),
                    new Container(
                        height: 250.0,
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              title: new ListTile(
                                title: documentCollectorBean.imgstring !=
                                    null &&
                                    documentCollectorBean.imgstring !=
                                        null &&
                                    documentCollectorBean.imgstring !=
                                        null &&
                                    documentCollectorBean.imgstring !=
                                        ""
                                    ? new Image.file(
                                  File(documentCollectorBean.imgstring),
                                  height: 200.0,
                                  width: 200.0,
                                )

                                    :  new Icon(
                                          Icons.camera_alt,
                                          size: 200.0,
                                          color: Color(0xff07426A),
                             ),
                                subtitle: new Text(
                                  Translations.of(context)
                                      .text("Click_Here_To_Take_A_Picture"),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                 /* if(documentCollectorBean.mimgtype==null *//*|| documentCollectorBean.mimgtype ==""*//*) {
                                    showMessageWithoutProgress("Please Select Type");
                                    return ;
                                  }*/
                                  _PickImage(0);
                                  /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                                  ;
                                },
                              ),
                            ),
                          ],
                        )),



                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(),
                      child: new Row(
                        children: <Widget>[Text(Translations.of(context).text('ExcDt'))],
                      ),
                    ),
                    new Container(
                      decoration: BoxDecoration(),
                      child: new Row(
                        children: <Widget>[
                          new Container(

                            width: 50.0,
                            child: new TextField(
                              enabled: false,
                                decoration: InputDecoration(hintText: "DD"),
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(2),
                                  globals.onlyIntNumber
                                ],
                                controller:  new TextEditingController(text: DateTime.now().day.toString()),
                                keyboardType: TextInputType.numberWithOptions(),
                               ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text("/"),
                          ),
                          new Container(
                            width: 50.0,
                            child: new TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "MM",
                              ),
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                                globals.onlyIntNumber
                              ],
                              focusNode: monthExecutionDateFocus,
                              controller:  new TextEditingController(text: DateTime.now().month.toString()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text("/"),
                          ),
                          Container(
                            width: 80,
                            child: new TextField(
                              enabled:  false,
                              decoration: InputDecoration(
                                hintText: "YYYY",
                              ),
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4),
                                globals.onlyIntNumber
                              ],
                              focusNode: yearExecutionDateFocus,
                              controller: new TextEditingController(text: DateTime.now().year.toString()),


                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),

                        ],
                      ),
                    ),







                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(),
                      child: new Row(
                        children: <Widget>[Text(Translations.of(context).text('IssuDt'))],
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
                                controller: tempIssueDateDay == null
                                    ? null
                                    : new TextEditingController(text: tempIssueDateDay),
                                keyboardType: TextInputType.numberWithOptions(),
                                onChanged: (val) {
                                  if (val != "0") {
                                    tempIssueDateDay = val;

                                    if (int.parse(val) <= 31 && int.parse(val) > 0) {
                                      if (val.length == 2) {
                                        issueDate = issueDate.replaceRange(0, 2, val);
                                        FocusScope.of(context).requestFocus(monthIssueDateFocus);
                                      } else {
                                        issueDate =
                                            issueDate.replaceRange(0, 2, "0" + val);
                                      }
                                    } else {
                                      setState(() {
                                        tempIssueDateDay = "";
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
                              focusNode: monthIssueDateFocus,
                              controller: tempIssueDateMonth == null
                                  ? null
                                  : new TextEditingController(text: tempIssueDateMonth),
                              onChanged: (val) {
                                if (val != "0") {
                                  tempIssueDateMonth = val;
                                  if (int.parse(val) <= 12 && int.parse(val) > 0) {
                                    if (val.length == 2) {
                                      issueDate = issueDate.replaceRange(3, 5, val);

                                      FocusScope.of(context).requestFocus(yearIssueDateFocus);
                                    } else {
                                      issueDate =
                                          issueDate.replaceRange(3, 5, "0" + val);
                                    }
                                  } else {
                                    setState(() {
                                      tempIssueDateMonth = "";
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
                              focusNode: yearIssueDateFocus,
                              controller: tempIssueDateYear == null
                                  ? null
                                  : new TextEditingController(text: tempIssueDateYear),
                              onChanged: (val) {
                                tempIssueDateYear = val;
                                if (val.length == 4)
                                  issueDate =  issueDate.replaceRange(6, 10, val);

                              },

                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectIssueDtDate(context);
                              })
                        ],
                      ),
            ),




            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(),
              child: new Row(
                children: <Widget>[Text(Translations.of(context).text('ExpDt'))],
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
                        controller: tempExpDateDay == null
                            ? null
                            : new TextEditingController(text: tempExpDateDay),
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (val) {
                          if (val != "0") {
                            tempExpDateDay = val;

                            if (int.parse(val) <= 31 && int.parse(val) > 0) {
                              if (val.length == 2) {
                                expDate = expDate.replaceRange(0, 2, val);
                                FocusScope.of(context).requestFocus(monthExpDateFocus);
                              } else {
                                expDate =
                                    expDate.replaceRange(0, 2, "0" + val);
                              }
                            } else {
                              setState(() {
                                tempExpDateDay = "";
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
                      focusNode: monthExpDateFocus,
                      controller: tempExpDateMonth == null
                          ? null
                          : new TextEditingController(text: tempExpDateMonth),
                      onChanged: (val) {
                        if (val != "0") {
                          tempExpDateMonth = val;
                          if (int.parse(val) <= 12 && int.parse(val) > 0) {
                            if (val.length == 2) {
                              expDate = expDate.replaceRange(3, 5, val);

                              FocusScope.of(context).requestFocus(yearExpDateFocus);
                            } else {
                              expDate =
                                  expDate.replaceRange(3, 5, "0" + val);
                            }
                          } else {
                            setState(() {
                              tempExpDateMonth = "";
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
                      focusNode: yearExpDateFocus,
                      controller: tempExpDateYear == null
                          ? null
                          : new TextEditingController(text: tempExpDateYear),
                      onChanged: (val) {
                        tempExpDateYear = val;
                        if (val.length == 4)
                          expDate =  expDate.replaceRange(6, 10, val);

                      },

                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectExpDtDate(context);
                      })
                ],
              ),
            ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: new IconButton(
                            icon: new Icon(
                              Icons.format_list_bulleted,
                              color: Color(0xff07426A),
                              size: 50.0,
                            ),
                            onPressed: () {
                             getDocumentsList(widget.mrefno,widget.trefno);                            },
                          ),
                        ),
                        Flexible(
                            child: new IconButton(
                                padding: EdgeInsets.only(right: 30.0),
                                icon: new Icon(
                                  Icons.add,
                                  color: Color(0xff07426A),
                                  size: 50.0,
                                ),
                                splashColor: Colors.red,
                                onPressed: () {
                                  proceed();

                                 /* else {
                                    addToList();
                                  }*/
                                })),
                      ],
                    ),

                          ]
              ),
            )));
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
                        title: new Text(('Take Picture From Camera')),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImage(imageNo);

                        }),),

                  Card(
                    child: new ListTile(
                        title: new Text(('Choose From Gallery')),
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

    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 400.0, maxWidth: 400.0);


    /*final croppedFile = await ImageCrop.cropImage(
      file: image.path,
      area: image.area,
    );

*/
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.5,
      maxWidth: 512,
      maxHeight: 512,
    );
    String st = croppedFile.path;
    documentCollectorBean.imgstring= croppedFile.path;
    setState(() {

    });
     }


  Future getImage(imageNo) async {
    File f;
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.5,
      maxWidth: 512,
      maxHeight: 512,
    );
    //String st = croppedFile.path;


    f =   File(croppedFile.path);
    documentCollectorBean.imgstring= croppedFile.path;

    setState(() {

    });
  }

_navigateAndDisplaySelection(BuildContext context) async {
    print("documentCollectorBeanList"+documentCollectorBeanList.toString());

  final result = Navigator.push(
      context,
      new MaterialPageRoute(

        builder: (BuildContext context) =>
        new ViewDocuments(documentCollectorBeanList),
        fullscreenDialog: true,
      )).then((onValue) {
    setState(() {});
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
  });
}



  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }


  Future<Null> _selectIssueDtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != documentCollectorBean.missuedate)
      setState(() {
        documentCollectorBean.missuedate = picked;
        tempIssueDateDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempIssueDateDay = "0" + picked.day.toString();
        } else
          tempIssueDateDay = picked.day.toString();
        issueDate = issueDate.replaceRange(0, 2, tempIssueDateDay);
        tempIssueDateYear = picked.year.toString();
        issueDate = issueDate.replaceRange(6, 10, tempIssueDateYear);
        if (picked.month.toString().length == 1) {
          tempIssueDateMonth = "0" + picked.month.toString();
        } else
          tempIssueDateMonth = picked.month.toString();
        issueDate = issueDate.replaceRange(3, 5, tempIssueDateMonth);
      });
    setState(() {

    });
  }


  Future<Null> _selectExpDtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != documentCollectorBean.mexpdate)
      setState(() {
        documentCollectorBean.mexpdate = picked;
        tempExpDateDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempExpDateDay = "0" + picked.day.toString();
        } else
          tempExpDateDay = picked.day.toString();
        expDate = expDate.replaceRange(0, 2, tempExpDateDay);
        tempExpDateYear = picked.year.toString();
        expDate = expDate.replaceRange(6, 10, tempExpDateYear);
        if (picked.month.toString().length == 1) {
          tempExpDateMonth = "0" + picked.month.toString();
        } else
          tempExpDateMonth = picked.month.toString();
        expDate = expDate.replaceRange(3, 5, tempExpDateMonth);
      });
    setState(() {

    });
  }

  Future<int> updateRecordsOnQueue(List<DocumentCollectorBean> beanList) async {
      int id;
    for (DocumentCollectorBean item in beanList) {
      id = await AppDatabase.get().updateDocumentsMasters(item);
    }
    return id;
  }



  void addToList() async{
    if(documentCollectorBeanList==null){
      documentCollectorBeanList= new  List<DocumentCollectorBean>();
    }
      proceed();

       if (widget.mleadsId != null &&
        widget.mleadsId != "null" &&
        widget.mleadsId != "") {
      documentCollectorBean.mforeignindicator = widget.mleadsId;
    }
    if (widget.mrefno != null &&
        widget.mrefno != "null" &&
        widget.mrefno != "") {
      documentCollectorBean.loanmrefno = widget.mrefno;
    }
    if (widget.trefno != "null" &&
        widget.trefno != "" &&
        widget.trefno != null) {
      documentCollectorBean.loantrefno = widget.trefno;
    }

       if (documentCollectorBean.trefno == "" ||
           documentCollectorBean.trefno == null ||
           documentCollectorBean.trefno == "null") {
         await AppDatabase.get().generateTrefnoForDocuments().then((onValue) {
           documentCollectorBean.trefno = onValue;
         });
       }


       documentCollectorBean.mlastupdatedt = DateTime.now();
       if (documentCollectorBean.mcreateddt == null) {
         documentCollectorBean.mcreatedby = username;
         documentCollectorBean.mcreateddt = DateTime.now();
       }
       documentCollectorBean.mlastupdateby = username;
       documentCollectorBean.mlastupdatedt = DateTime.now();
       documentCollectorBean.mrefno = documentCollectorBean.mrefno != null ? documentCollectorBean.mrefno : 0;
       if (documentCollectorBean.mcreatedby == null ||
           documentCollectorBean.mcreatedby == '' ||
           documentCollectorBean.mcreatedby == 'null') {
         documentCollectorBean.mcreatedby = username;
       }


       documentCollectorBean.mgeolocation = geoLocation;
       documentCollectorBean.mgeologd = geoLongitude;
       documentCollectorBean.mgeolatd = geoLatitude;
       documentCollectorBeanList.add(documentCollectorBean);
       setState(() {
         documentCollectorBean  =new DocumentCollectorBean();

         tempIssueDateYear="";
         tempIssueDateDay="";
         tempIssueDateMonth="";
         tempExpDateYear="";
         tempExpDateDay="";
         tempExpDateMonth="";
         issueDate= "__-__-____";
         expDate= "__-__-____";
         documenttype= blankBean;
         customerType= blankBean;

       });
  }




  proceed() async {
    if (!validateSubmit()) {
      return;
    }
    DocumentCollectorBean documentCollectorBeanList;
    documentCollectorBean.mcreatedby = username;
    documentCollectorBean.mexecutiondate = DateTime.now();
    if (widget.mleadsId != null &&
        widget.mleadsId != "null" &&
        widget.mleadsId != "") {
      documentCollectorBean.mforeignindicator = widget.mleadsId;
    }
    if (documentCollectorBean.trefno == "" ||
        documentCollectorBean.trefno == null ||
        documentCollectorBean.trefno == "null") {
      print("documentCollectorBean.trefno"+documentCollectorBean.trefno.toString());
      await AppDatabase.get().generateTrefnoForDocuments().then((onValue) {
        print("onValue"+onValue.toString());
        documentCollectorBean.trefno = onValue;
      });
    }
    if (widget.mrefno != null &&
        widget.mrefno != "null" &&
        widget.mrefno != "") {
      documentCollectorBean.loanmrefno = widget.mrefno;
    }
    if (widget.trefno != "null" &&
        widget.trefno != "" &&
        widget.trefno != null) {
      documentCollectorBean.loantrefno = widget.trefno;
    }

    if (documentCollectorBean.mcustomertype == "null" ||
        documentCollectorBean.mcustomertype == "" ||
        documentCollectorBean.mcustomertype == null) {
      //Khuda ka kahuf karo allah ki bandi yeh static kyun dala hai yaha
      documentCollectorBean.mcustomertype = '101';
    }


    if (documentCollectorBean.custtrefno == "null" ||
        documentCollectorBean.custtrefno == "" ||
        documentCollectorBean.custtrefno == null) {
      documentCollectorBean.custtrefno = widget.custref;
    }

    if (documentCollectorBean.custmrefno == "null" ||
        documentCollectorBean.custmrefno == "" ||
        documentCollectorBean.custmrefno == null) {
      documentCollectorBean.custmrefno = widget.cusmref;
    }


    if (documentCollectorBean.mcustno == "null" ||
        documentCollectorBean.mcustno == "" ||
        documentCollectorBean.mcustno == null) {
      documentCollectorBean.mcustno = widget.cusno;
    }

    if (documentCollectorBean.mcustname == "null" ||
        documentCollectorBean.mcustname == "" ||
        documentCollectorBean.mcustname == null) {
      documentCollectorBean.mcustname = widget.custname;
    }

    documentCollectorBean.mlastupdateby = username;
    documentCollectorBean.mlastupdatedt = DateTime.now();

    if (documentCollectorBean.mcreateddt == null) {
      documentCollectorBean.mcreatedby = username;
      documentCollectorBean.mcreateddt = DateTime.now();
    }

    documentCollectorBean.mrefno = documentCollectorBean.mrefno != null ? documentCollectorBean.mrefno : 0;



    documentCollectorBean.mgeolocation = geoLocation;
    documentCollectorBean.mgeologd = geoLongitude;
    documentCollectorBean.mgeolatd = geoLatitude;




    if (documentCollectorBean.mrefno == null) {
      documentCollectorBean.mrefno = 0;
    }
    if (documentCollectorBean != null) {
      documentCollectorBeanList = documentCollectorBean;
    }

    await AppDatabase.get().updateDocumentsMasters(documentCollectorBeanList).then((val) {

    });
    _successfulSubmit();
    setState(() {
      documentCollectorBean  =new DocumentCollectorBean();
      documentCollectorBean.loanmrefno = widget.mrefno;
      documentCollectorBean.loantrefno = widget.trefno;

      tempIssueDateYear="";
      tempIssueDateDay="";
      tempIssueDateMonth="";
      tempExpDateYear="";
      tempExpDateDay="";
      tempExpDateMonth="";
      issueDate= "__-__-____";
      expDate= "__-__-____";
      documenttype= blankBean;
      customerType=blankBean;
    });

    }

  bool validateSubmit() {
    String error = "";



    if(documentCollectorBean.mimgtype==null||documentCollectorBean.mimgtype.toString().trim()==""){
      _showAlert("Document Type", "Cannot be Empty");
      return false;

    }
    if(documentCollectorBean.mcustomertype==null||documentCollectorBean.mcustomertype.toString().trim()==""){
      _showAlert("Customer Type", "Cannot be Empty");
      return false;

    }
    if(documentCollectorBean.mcustname==null||documentCollectorBean.mcustname.toString().trim()==""){
      _showAlert("Customer Name And Number", "Cannot be Empty");
      return false;

    }
    if(documentCollectorBean.imgstring==null||documentCollectorBean.imgstring.toString().trim()==""){
      _showAlert("Image", "Cannot be Empty");
      return false;

    }
/*
    try {

      try {
        if (DateTime.now().isBefore(documentCollectorBean.missuedate)) {
          _showAlert("Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Issue Date", "It is Mandatory");

      return false;
    }

    try {

      if (documentCollectorBean.mexpdate==DateTime.now() || documentCollectorBean.mexpdate.isBefore(DateTime.now())) {
        _showAlert("Expiry Date", "It should be greater than Current Date");

        return false;
      }
    } catch (e) {
      _showAlert("Expiry Date", "It is Mandatory");

      return false;
    }*/

 /*
    if( documentCollectorBean.missuedate!=null){
          print("documentCollectorBean.missuedate"+documentCollectorBean.missuedate.toString());
        if (DateTime.now().isBefore(documentCollectorBean.missuedate)) {
          _showAlert("Issue Date", "Cannot be Future Date");
          return false;
        }}

      if( documentCollectorBean.mexpdate!=null){

      if (documentCollectorBean.mexpdate==DateTime.now() || documentCollectorBean.mexpdate.isBefore(DateTime.now())) {
        _showAlert("Expiry Date", "It should be greater than Current Date");

        return false;
      }}*/
  /*  } catch (e) {
      //   _showAlert("Id 2 Expiry Date", "It is Mandatory");

      return false;
    }*/

    return true;
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
              //    Navigator.of(context).pop();
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

  void getDocumentsList(int mrefno, int trefno) {
    AppDatabase.get().getDocumentListonTrefno(trefno).then(
            (List<DocumentCollectorBean> DocumentCollectorData){
          //this.documentCollectorBeanList=DocumentCollectorData;
          print(trefno.toString());
          print(mrefno.toString());
          print("DocumentCollectorData"+DocumentCollectorData.toString());
          Navigator.of(context).pop();
          if(DocumentCollectorData.isEmpty){
            _CheckIfThere();
          }
          else{
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ViewDocuments(DocumentCollectorData)), //
              // When Authorized Navigate to the next screen
            );}

        });
  }

  Future<void> _CheckIfThere() async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          "            No Records Found "),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future getCustomerNumber(String custtype, int loantrefno, int loanmrefno, String custname, int custref, int cusmref, int cusno) async {
    print("Inside Cust Select");
    print("custtype"+custtype);
    print("loantrefno"+loantrefno.toString());
    print("loanmrefno"+loanmrefno.toString());
    if(custtype!=101&&custtype!=""){

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GuarantorDetailsForSelection(custtype,loantrefno,loanmrefno))).then((onValue){
        if (onValue != null) {
          documentCollectorBean.custtrefno =
          onValue.custtrefno != null ? onValue.custtrefno : 0;
          documentCollectorBean.custmrefno =
          onValue.custmrefno != null ? onValue.custmrefno : 0;
          documentCollectorBean.mcustname=onValue.mnameofguar;
          documentCollectorBean.mcustno =
          onValue.mcustno != null ? onValue.mcustno : 0;

          if(documentCollectorBean.custtrefno!="null"&&documentCollectorBean.custtrefno!=null&&documentCollectorBean.custtrefno!=""){
            AppDatabase.get().isThisTypeOfDocPresentcust(custtyp,imgtyp,onValue.custtrefno,onValue.custmrefno).then((DocumentCollectorBean documentCollectorBeanList) async{
              print("onValue.toString()"+documentCollectorBeanList.toString());
              if(documentCollectorBeanList!=null ) {
                print("onValue.toString()1"+documentCollectorBean.toString());
                setState(() {
                  documentCollectorBean.mdoctno  = documentCollectorBeanList.mdoctno!="null"&&documentCollectorBeanList.mdoctno!=null&&documentCollectorBeanList.mdoctno!=""?documentCollectorBeanList.mdoctno:"";
                  documentCollectorBean.missuingauth  = documentCollectorBeanList.missuingauth!="null"&&documentCollectorBeanList.missuingauth!=null&&documentCollectorBeanList.missuingauth!=""?documentCollectorBeanList.missuingauth:"";
                  documentCollectorBean.mremarks  = documentCollectorBeanList.mremarks!="null"&&documentCollectorBeanList.mremarks!=null&&documentCollectorBeanList.mremarks!=""?documentCollectorBeanList.mremarks:"";

               //   documentCollectorBean.custtrefno  = documentCollectorBeanList.custtrefno!="null"&&documentCollectorBeanList.custtrefno!=null&&documentCollectorBeanList.custtrefno!=""?documentCollectorBeanList.custtrefno:"";
              //    documentCollectorBean.custmrefno  = documentCollectorBeanList.custmrefno!="null"&&documentCollectorBeanList.custmrefno!=null&&documentCollectorBeanList.custmrefno!=""?documentCollectorBeanList.custmrefno:"";
              //    documentCollectorBean.mcustno  = documentCollectorBeanList.mcustno!="null"&&documentCollectorBeanList.mcustno!=null&&documentCollectorBeanList.mcustno!=""?documentCollectorBeanList.mcustno:"";
                //  documentCollectorBean.mcustname  = documentCollectorBeanList.mcustname!="null"&&documentCollectorBeanList.mcustname!=null&&documentCollectorBeanList.mcustname!=""?documentCollectorBeanList.mcustname:"";



                  if(documentCollectorBeanList.missuedate!="null"&&documentCollectorBeanList.missuedate!=null&&documentCollectorBeanList.missuedate!="") {
                    documentCollectorBean.missuedate=documentCollectorBeanList.missuedate;
                    setState(() {
                      if (documentCollectorBeanList.missuedate.day
                          .toString()
                          .length == 1) {
                        tempIssueDateDay = "0" +
                            documentCollectorBeanList.missuedate
                                .day.toString();
                      }
                      else
                        tempIssueDateDay =
                            documentCollectorBeanList.missuedate
                                .day.toString();
                      tempIssueDateYear =
                          documentCollectorBeanList.missuedate
                              .year.toString();
                      if (documentCollectorBeanList.missuedate
                          .month
                          .toString()
                          .length == 1) {
                        tempIssueDateMonth = "0" +
                            documentCollectorBeanList.missuedate
                                .month.toString();
                      }
                      else
                        tempIssueDateMonth =
                            documentCollectorBeanList.missuedate
                                .month.toString();
                    });
                  }

                  if(documentCollectorBeanList.mexpdate!="null"&&documentCollectorBeanList.mexpdate!=null&&documentCollectorBeanList.mexpdate!="") {
                    documentCollectorBean.mexpdate=documentCollectorBeanList.mexpdate;

                    setState(() {
                      if (documentCollectorBeanList.mexpdate.day
                          .toString()
                          .length == 1) {
                        tempExpDateDay = "0" +
                            documentCollectorBeanList.mexpdate
                                .day.toString();
                      }
                      else
                        tempExpDateDay =
                            documentCollectorBeanList.mexpdate
                                .day.toString();
                      tempExpDateYear =
                          documentCollectorBeanList.mexpdate
                              .year.toString();
                      if (documentCollectorBeanList.mexpdate
                          .month
                          .toString()
                          .length == 1) {
                        tempExpDateMonth = "0" +
                            documentCollectorBeanList.mexpdate
                                .month.toString();
                      }
                      else
                        tempExpDateMonth =
                            documentCollectorBeanList.mexpdate
                                .month.toString();
                    });
                  }

                }
                );

              }
              else{
                print("Inside else");
                setState(() {
                  documentCollectorBean.mdoctno  ="";
                  documentCollectorBean.missuingauth  = "";
                  documentCollectorBean.mremarks  = "";

                  tempExpDateDay="";
                  tempExpDateYear="";
                  tempExpDateMonth="";
                  tempIssueDateDay="";
                  tempIssueDateMonth="";
                  tempIssueDateYear="";

                });
              }
            }

            ); }
        }

      });
    }
  /*  else{
      documentCollectorBean.custtrefno =
      custref!= null ? custref : 0;
      documentCollectorBean.custmrefno =
      cusmref!= null ? cusmref : 0;
      documentCollectorBean.mcustname=custname;
      documentCollectorBean.mcustno =
      cusno!= null ? cusno : 0;



    }*/


  }

}
