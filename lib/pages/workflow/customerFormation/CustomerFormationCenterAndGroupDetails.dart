import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/pages/workflow/FPSPages/AgentFingureCapture.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_los/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../translations.dart';


var docListView=new List<PhotoViewGalleryPageOptions>();
class CustomerFormationCenterAndGroupDetails extends StatefulWidget {
  var cameras;
  CustomerListBean bean;
  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  CustomerFormationCenterAndGroupDetails(this.cameras, {Key key})
      : super(key: key);

  @override
  _CustomerFormationCenterAndGroupDetailsState createState() =>
      new _CustomerFormationCenterAndGroupDetailsState();
}

class _CustomerFormationCenterAndGroupDetailsState
    extends State<CustomerFormationCenterAndGroupDetails> {
  static const JsonCodec JSON = const JsonCodec();
  FullScreenDialogForCenterSelection _myCenterDialog =
      new FullScreenDialogForCenterSelection();
  FullScreenDialogForGroupSelection _myGroupDialog =
      new FullScreenDialogForGroupSelection();
  CenterDetailsBean centerBean = new CenterDetailsBean();
  LookupBeanData mcustcatgry;
  LookupBeanData mnationality;
  SystemParameterBean sysBean = new SystemParameterBean();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  File _image;
  File f;
  int isBiometricNeeded = 0;
  bool isCambodia=true;

  Future getImage(imageNo) async {
    if (CustomerFormationMasterTabsState.custListBean.imageMaster == null) {
      CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
      for (int i = 0; i < 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster
            .add(new ImageBean());
      }
    }
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
    print("path" +
        CustomerFormationMasterTabsState.custListBean.imageMaster.length
            .toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].imgString =
        croppedFile.path;
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].desc =
    "Customer Picture";


    f =   File(croppedFile.path);
    print("image picture is "+CustomerFormationMasterTabsState
        .custListBean.imageMaster[0].imgString);
    print("Custimage is  custImage");
    setState(() {
      _image = croppedFile;
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
  /*Future showImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
    String st = image.path;
    print("path"+st.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[0].imgPath= image.path;

    setState(() {
      return _image = image;m


    });
  }*/

  //final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  int branch = 0;
  String usrRole;
  ImageBean imgBean = new ImageBean();
  String _base64;

  @override
  void initState() {
    super.initState();
    imageCache.clear();


    if (mounted) {
      getSessionVariables();
    }

    if (CustomerFormationMasterTabsState.custListBean.mnationality == null ||
        CustomerFormationMasterTabsState.custListBean.mnationality == 'null' ||
        CustomerFormationMasterTabsState.custListBean.mnationality == '') {
      CustomerFormationMasterTabsState.custListBean.mnationality = 'KH';
    }
    List tempDropDownValues = new List();
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mcustcategory);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mnationality);
    print(CustomerFormationMasterTabsState.custListBean.mprofileind);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesProfileDetails.length;
        k++) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesProfileDetails[k].length;
          i++) {
        // print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesProfileDetails[k][i].mcode.length);

        try {
          if (globals.dropdownCaptionsValuesProfileDetails[k][i].mcode
                  .toString() ==
              tempDropDownValues[k].toString().trim()) {
            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesProfileDetails[k][i]);
          }
        } catch (_) {
          print("Exception in dropdown");
        }
      }
    }

    if (globals.applicationDate == null)
      globals.applicationDate = DateTime.now();

    if (CustomerFormationMasterTabsState.custListBean.mIsMbrGrp == null) {
      if (CustomerFormationMasterTabsState.custListBean.mgroupcd != null) {
        CustomerFormationMasterTabsState.custListBean.mIsMbrGrp = 0;
      }
    }
    setState(() {});
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          mcustcatgry = blankBean;
          CustomerFormationMasterTabsState.custListBean.mcustcategory =
              blankBean.mcode;
          break;
        case 1:
          mnationality = blankBean;
          CustomerFormationMasterTabsState.custListBean.mnationality =
              blankBean.mcode;
          break;

        default:
          break;
      }
      setState(() {});
    } else {
      for (int k = 0;
          k < globals.dropdownCaptionsValuesProfileDetails[no].length;
          k++) {
        if (globals.dropdownCaptionsValuesProfileDetails[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesProfileDetails[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          mcustcatgry = value;
          CustomerFormationMasterTabsState.custListBean.mcustcategory =
              value.mcode;
          break;
        case 1:
          mnationality = value;
          CustomerFormationMasterTabsState.custListBean.mnationality =
              value.mcode;
          if(CustomerFormationMasterTabsState.custListBean.mnationality=="KH"){
            isCambodia=true;
            print(isCambodia);
          }
          else{
            isCambodia=false;
            print(isCambodia);
          }
          break;

        default:
          break;
      }
    });
  }

  /* _changed(String filePath, String str) {
    if (filePath != null && !(filePath == "")) {
      globals.imageVisibilityDetalsTagCustomer = true;
      globals.imageFilePathGlobalCustomerprofilePic = filePath;
      imgBean.imgString = filePath;
      imgBean.imgSubType = 'customerPicture';
      imgBean.imgType = str;
      globals.listImgBean.add(imgBean);
      //globals.listImgBean.insert(0,imgBean);
    }
  }*/

  Widget otherLoan() => CustomerFormationCenterAndGroupDetails._get(new Row(
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
            groupValue: CustomerFormationMasterTabsState.custListBean.mIsMbrGrp,
            onChanged: (selection) {
              if (sysBean.mcodevalue != null &&
                  sysBean.mcodevalue.toUpperCase() == 'N') {
                return null;
              }
              return _onRadioSelected(selection, position);
            },
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
    setState(() => globals.isMemberOfGroupList[position] = selection);
    CustomerFormationMasterTabsState.custListBean.mIsMbrGrp = selection;
    if (position == 0) {
      globals.memberOfGroup =
          globals.radioCaptionValuesIsMemberOfGroup[selection];
      if (globals.memberOfGroup == 'Yes') {
        globals.isMemberOfGroup = true;
      } else {
        globals.isMemberOfGroup = false;
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

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();

    sysBean = await AppDatabase.get().getSystemParameter('11', 0);
    if (sysBean.mcodevalue != null &&
        sysBean.mcodevalue.trim().toUpperCase() == 'N') {
      globals.isMemberOfGroup = false;
    }

    setState(() {
      CustomerFormationMasterTabsState.custListBean.mlbrcode =
          prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      // CustomerFormationMasterTabsState.custListBean.mlbrcode = branch;
      globals.agentUserName = username;
    });
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesProfileDetails[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesProfileDetails[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(
          value.mcodedesc,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new ListTile(
              leading: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(Translations.of(context).text('brnchCd'),
                      style: TextStyle(color: Color(0xff795548))),
                  new Text(
                      CustomerFormationMasterTabsState.custListBean.mlbrcode
                          .toString(),
                      style: TextStyle(color: Color(0xff12D6F4)))
                ],
              ),
              trailing: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    Translations.of(context).text('CustNoofTab'),
                    style: TextStyle(color: Color(0xff795548)),
                  ),
                  new Text(
                    "${CustomerFormationMasterTabsState.custListBean.trefno}",
                    style: TextStyle(color: Color(0xff12D6F4)),
                  ),
                ],
              )
              // trailing: new Text("Customer Number of Tab : " + "123456789"),

              ),

          /*new MaterialButton(child: new Text("See Image"),onPressed: (){
       showImage();
    }),*/
          SizedBox(height: 10.0),
          new Card(
            elevation: 5.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 4.0),
             /*   new Text(
                  Translations.of(context).text('CustPic'),
                  textAlign: TextAlign.center,
                ),
                new Container(
                    color: Constant.mandatoryColor,
                    height: 250.0,
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: new ListTile(
                            title: CustomerFormationMasterTabsState
                                            .custListBean.imageMaster !=
                                        null &&
                                    CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[0]
                                            .imgString !=
                                        null &&
                                    CustomerFormationMasterTabsState
                                            .custListBean.imageMaster !=
                                        null &&
                                    CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[0]
                                            .imgString !=
                                        ""
                                ? new Image.file(
                                    File(CustomerFormationMasterTabsState
                                        .custListBean.imageMaster[0].imgString),
                                    height: 200.0,
                                    width: 200.0,
                                  )
                                : new Image(
                                    image:
                                        new AssetImage("assets/AddImage.png"),
                                    width: 100,
                                    height: 200.0),
                            subtitle: new Text(
                              Translations.of(context).text('Clcktkpic'),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              _PickImage(0);
                              *//*_navigateAndDisplaySelection(
                                  context, 'customer picture')*//*
                              ;
                            },
                          ),
                        ),
                      ],
                    )),*/
                isBiometricNeeded==0?new Container(): Container(
                    child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            height: 100.0, width: 100.00),
                        // for positioning of icon of scanner
                        child: FlatButton(
                            onPressed: () async {
                              /* Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    // builder: (context) => new BluetoothPair(),
                                    builder: (context) =>
                                    new AgentFingureCapture(),
                                  ), //When Authorized Navigate to the next screen
                                )*/
                              Navigator.push(context, SlideRightRoute(page: new AgentFingureCapture())).then((onVal) {
                                print("fpsdataaaa $onVal");
                                String strMain = onVal;
                                List<String> list = strMain.split("#");

                                if (list != null &&
                                    list.length == 2 &&
                                    !list.isEmpty) {
                                  //null length=2  isEmpty
                                  print("fingerrrr ${list[0]}");
                                  print("fdaaaaaaa ${list[1]}");

                                  if (list[1] != 'null') {
                                    print("list[1]"+list[1].toString());
                                    switch (list[0]) {
                                      case "LhThumb":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[13]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[13]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[13]
                                            .imgType = "FingerPrint";
                                        prefs.setString("LhThumb", list[1]);

                                        break;

                                      case "LhIndexFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[14]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[14]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[14]
                                            .imgType = "FingerPrint";
                                        prefs.setString(
                                            "LhIndexFinger", list[1]);

                                        break;
                                      case "LhMiddleFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[15]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[15]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[15]
                                            .imgType = "FingerPrint";
                                        /*  prefs.setString(
                                            "LhMiddleFinger", list[1]);*/

                                        break;

                                      case "LhRingFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[16]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[16]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[16]
                                            .imgType = "FingerPrint";
//                                        prefs.setString("LhRingFinger", list[1]);

                                        break;

                                      case "LhPinkyFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[17]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[17]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[17]
                                            .imgType = "FingerPrint";
//                                        prefs.setString("LhPinkyFinger", list[1]);
                                        break;

                                      case "RhThumb":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[18]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[18]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[18]
                                            .imgType = "FingerPrint";
//                                        prefs.setString("RhThumb", list[1]);

                                        break;

                                      case "RhIndexFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[19]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[19]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[19]
                                            .imgType = "FingerPrint";
//                                        prefs.setString("RhIndexFinger", list[1]);

                                        break;

                                      case "RhMiddleFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[20]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[20]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[20]
                                            .imgType = "FingerPrint";
                                        /* prefs.setString(
                                            "RhMiddleFinger", list[1]);*/
                                        break;

                                      case "RhRingFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[21]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[21]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[21]
                                            .imgType = "FingerPrint";
//                                        prefs.setString("RhRingFinger", list[1]);
                                        break;

                                      case "RhPinkyFinger":
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[22]
                                            .imgSubType = list[0];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[22]
                                            .imgString = list[1];
                                        CustomerFormationMasterTabsState
                                            .custListBean
                                            .imageMaster[22]
                                            .imgType = "FingerPrint";
//                                        prefs.setString("RhPinkyFinger", list[1]);
                                        break;
                                    }
                                  }

                                  setState(() {});
                                }
                              });
                            },
                            child:
                            Image.asset("assets/fpsImages/security_bnr_fp.gif")))),
                new Center(
                  child: new Stack(
                    children: <Widget>[
                      getCircleContainer(),

                      /*new Positioned(
                          child:

                          top: 200.0,
                         // left: 130.0,
                          right: 30.0,
                        ),*/


                      new Positioned(
                        child: new GestureDetector(
                          onTap: () {
                            _PickImage(0);
                          },
                          child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 80.0,),
                            /*onPressed: () {

                          }*/
                          ),
                        ),
                        top: 200.0,
                        left: 230.0,
                      ),
                    ],
                  ),
                ),

                Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 80.0, width: 60.00),
                    )),

                new Container(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: commentWidgets)),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            color: Constant.mandatoryColor,
            child: new DropdownButtonFormField(
              value: mcustcatgry,
              items: generateDropDown(0),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 0);
              },
              validator: (args) {
                print(args);
              },
              decoration: InputDecoration(labelText: Translations.of(context).text('AppTyp')),
              // style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            color: Constant.mandatoryColor,
            child: new DropdownButtonFormField(
              value: mnationality,
              items: generateDropDown(1),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 1);
              },
              validator: (args) {
                print(args);
              },
              decoration: InputDecoration(labelText: Translations.of(context).text('Ntnlty')),
              // style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
/*
          new TextFormField(
            keyboardType: TextInputType.text,
            decoration:  InputDecoration(
              hintText: Translations.of(context).text('orgnamehint'),
              labelText: Translations.of(context).text('orgnamelabel'),
              hintStyle: TextStyle(color: Colors.grey),
              */ /*labelStyle: TextStyle(color: Colors.grey),*/ /*
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
            inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
            controller:  CustomerFormationMasterTabsState.custListBean.mbusinessname != null
                ? TextEditingController(text:  CustomerFormationMasterTabsState.custListBean.mbusinessname)
                : TextEditingController(text: ""),


            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mbusinessname= val,
          ),*/
isCambodia?
          new Form(
            key: _formKey,
            //autovalidate: CustomerFormationMasterTabsState.autoValidate,
            onWillPop: () {
              return Future(() => true);
            },
            onChanged: () {
              final FormState form = _formKey.currentState;
              form.save();
            },
            child: Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new Stack(
                  alignment: const Alignment(1.02, 0.0),
                  children: <Widget>[
                    new TextFormField(
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          hintText: Translations.of(context).text('NtID'),
                          labelText: Translations.of(context).text('NtID'),
                          hintStyle: TextStyle(
                              color: Colors.grey, decorationColor: Colors.grey),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.green,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                          contentPadding: EdgeInsets.all(20.0),
                          fillColor: Colors.red,
                        ),
                        controller: CustomerFormationMasterTabsState
                                    .custListBean.mdedupnationalid ==
                                null
                            ? TextEditingController(text: "")
                            : TextEditingController(
                                text: CustomerFormationMasterTabsState
                                    .custListBean.mdedupnationalid
                                    .toString()),
                        /*focusNode: _focusNode,*/
                        onSaved: (val) {
                          if (val == null || val == "") {
                          } else {
                            try {
                              CustomerFormationMasterTabsState
                                  .custListBean.mdedupnationalid = val;
                            } catch (e) {
                              print("Exception ");
                            }
                          }
                        }),
                    new RaisedButton(
                        color: Color(0xff01579b),
                        elevation: 20.0,
                        child: new Text(
                          "Dedup",
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.only(bottom: 0.0),
                        onPressed: () async {
                          await _DedupOnNationalID();
                        }),
                  ],
                )),
          ): new Form(
  key: _formKey,
  //autovalidate: CustomerFormationMasterTabsState.autoValidate,
  onWillPop: () {
    return Future(() => true);
  },
  onChanged: () {
    final FormState form = _formKey.currentState;
    form.save();
  },

  child: Container(
      decoration: BoxDecoration(color: Constant.mandatoryColor),
      child: new Stack(
        alignment: const Alignment(1.02, 0.0),
        children: <Widget>[
          new TextFormField(
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('PassNo'),
                labelText: Translations.of(context).text('PassNo'),
                hintStyle: TextStyle(
                    color: Colors.grey, decorationColor: Colors.grey),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
                contentPadding: EdgeInsets.all(20.0),
                fillColor: Colors.red,
              ),
              controller: CustomerFormationMasterTabsState
                  .custListBean.mdedupnationalid ==
                  null
                  ? TextEditingController(text: "")
                  : TextEditingController(
                  text: CustomerFormationMasterTabsState
                      .custListBean.mdedupnationalid
                      .toString()),
              /*focusNode: _focusNode,*/
              onSaved: (val) {
                if (val == null || val == "") {
                } else {
                  try {
                    CustomerFormationMasterTabsState
                        .custListBean.mdedupnationalid = val;
                  } catch (e) {
                    print("Exception ");
                  }
                }
              }),
          new RaisedButton(
              color: Color(0xff01579b),
              elevation: 20.0,
              child: new Text(
                "Dedup",
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.only(bottom: 0.0),
              onPressed: () async {
                await _DedupOnNationalID();
              }),
        ],
      )),
)
        ],
      ),
    );
  }

  _DedupOnNationalID() async {
    if (CustomerFormationMasterTabsState.custListBean.mdedupnationalid ==
            null ||
        CustomerFormationMasterTabsState.custListBean.mdedupnationalid == '') {
      _showAlert(
          Translations.of(context).text('fillNtlID'), Translations.of(context).text('MandDedup'));
    } else {
      bool isNetworkAvailable;
      bool isNetworkAvailablegoogle;
      isNetworkAvailable = await Utility.checkIntCon();
      //isNetworkAvailablegoogle = await Utility.checkIfIsconnectedToNetwork();
      //  isNetworkAvailable = true;
      if (isNetworkAvailable) {
        await getMiddleWareData();
      } else {
        _showAlert(Translations.of(context).text('PlschckyrNtwrk'), Translations.of(context).text('ThOnln'));
      }
    }
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
  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getMiddleWareData() async {
    Utility obj = new Utility();
    final _headers = {'Content-Type': 'application/json'};
    var urlGetCustomerDetails = "customerData/getCustomerDedup/";

    try {
      String json = _toJson();
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + urlGetCustomerDetails.toString(),
          _headers);
      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        //final parsed = JSON.decode(bodyValue).cast<String, dynamic>();
        Map<String, dynamic> map = JSON.decode(bodyValue);
        if(map==null){
          _showAlert(Translations.of(context).text('CustNtPrsntWthID'), "");
        }
        var obj =null;
     try{
        obj = CustomerListBean.fromMapMiddlewareDedup(map, true);
      } catch (_) {
      _showAlert(Translations.of(context).text('CustNtPrsntWthID'), "");
    }

        String message = obj.mfname.toString()+" "+obj.mmname.toString()+Translations.of(context).text('isAlrdyprsntwthCustNo')+obj.mcustno.toString() +Translations.of(context).text('CustBlngsusr')+obj.mcreatedby.toString();
        _showAlert(message, Translations.of(context).text('cnntcrtcustwththsid'));
      }
    } catch (_) {
      _showAlert(Translations.of(context).text('CustNtPrsntWthID'), "");
    }
  }
  var commentWidgets = List<Widget>();

  String _toJson() {

    var mapData = new Map();
    mapData["mnationalid"] =
        CustomerFormationMasterTabsState.custListBean.mdedupnationalid.trim();
    String json = JSON.encode(mapData);
    return json;
  }


  Future<void> _showImage() async {

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            ViewImageScreen()));
  }


  Widget getCircleContainer() {
    imageCache.clear();
    try {
      return
        new GestureDetector(
          onTap: () {
            print("Container clicked ${CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[0]
                .imgString}");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();

            if (CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[0]
                .imgString !=
                null &&
                CustomerFormationMasterTabsState
                    .custListBean.imageMaster !=
                    null &&
                CustomerFormationMasterTabsState
                    .custListBean
                    .imageMaster[0]
                    .imgString !=
                    "") {
              docListView = new List<PhotoViewGalleryPageOptions>();
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerFormationMasterTabsState
                          .custListBean.imageMaster[0].imgString)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(0);
            }
          },
          child:
          new Container(
            width: 300.0,
            height: 300.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff07426A), width: 0.5),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image:
                  CustomerFormationMasterTabsState
                      .custListBean.imageMaster !=
                      null &&
                      CustomerFormationMasterTabsState
                          .custListBean
                          .imageMaster[0]
                          .imgString !=
                          null &&
                      CustomerFormationMasterTabsState
                          .custListBean.imageMaster !=
                          null &&
                      CustomerFormationMasterTabsState
                          .custListBean
                          .imageMaster[0]
                          .imgString !=
                          ""
                      ?
                  MemoryImage(File(CustomerFormationMasterTabsState
                      .custListBean.imageMaster[0].imgString).readAsBytesSync())

                      : new ExactAssetImage('assets/AddImage.png'),

                )

            ),
          ),
        );
    }catch(_){
      return
        new GestureDetector(
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();
            print(
                "CustomerFormationMasterTabsState.custListBean.imageMaster[0].imgString ${CustomerFormationMasterTabsState
                    .custListBean.imageMaster[0].imgString}");
            if (CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[0]
                .imgString !=
                null &&
                CustomerFormationMasterTabsState
                    .custListBean.imageMaster !=
                    null &&
                CustomerFormationMasterTabsState
                    .custListBean
                    .imageMaster[0]
                    .imgString !=
                    "") {
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerFormationMasterTabsState
                          .custListBean.imageMaster[0].imgString)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(0);
            }
          },
          child:
          new Container(
            width: 300.0,
            height: 300.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff07426A), width: 0.5),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image: new ExactAssetImage('assets/AddImage.png'),

                )

            ),
          ),
        );
    }

  }





}
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}
class ViewImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.

      body: PhotoViewGallery( pageOptions:docListView),
    );
  }
}
