import 'dart:async';
import 'dart:io';
import 'package:eco_los/pages/workflow/BranchMaster/BranchMasterService.dart';
import 'package:eco_los/pages/workflow/Guarantor/SyncGuarantorToMiddleware.dart';
import 'package:eco_los/pages/workflow/LoanUtilization/SyncLoanUtilizationToMiddleware.dart';
import 'package:eco_los/pages/workflow/Savings/SyncSavingsCollectionListToMiddleware.dart';
import 'package:eco_los/pages/workflow/Savings/SyncSavingsListToMiddleware.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_los/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/syncingActivity/GetCustomerFromCenter.dart';
import 'package:eco_los/pages/workflow/syncingActivity/GetDailyCollectionFromMiddleware.dart';
import 'package:eco_los/pages/workflow/syncingActivity/GetSavingsListFromMiddleware.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingDailyCollectedToMiddleware.dart';
import 'package:eco_los/pages/workflow/termDeposit/SyncingNewTermDepositToMiddleware.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT1Services.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT2Services.dart';
import 'package:eco_los/pages/workflow/GRT/GRTServices.dart';
import 'package:eco_los/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_los/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_los/pages/workflow/SpeedoMeter/bean/SpeedoMeterServices.dart';
import 'package:eco_los/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/ProspectServices.dart';
import 'package:eco_los/pages/workflow/creditBereau/getProspectFormMiddleware.dart';
import 'package:eco_los/pages/workflow/qrScanner/QrScanner.dart';
import 'package:eco_los/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_los/pages/workflow/syncingActivity/GetLoanFromMiddleware.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingCountry.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingCustomerToMiddleware.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingProducts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:eco_los/Utilities/globals.dart';

import 'GetHbsUsers.dart';
import 'SyncingCollateralREMToMiddleware.dart';
import 'SyncingCollateralVehicleToMiddleware.dart';
import 'SyncingCollatralBasicDetailsToMiddleware.dart';
import 'SyncingDocumentsToMiddleware.dart';

class SyncingActivity extends StatefulWidget {
  @override
  SyncingActivityState createState() {
    return new SyncingActivityState();
  }
}

class SyncingActivityState extends State<SyncingActivity> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  FullScreenDialogForCenterSelection _myCenterDialog =
      new FullScreenDialogForCenterSelection();
  CenterDetailsBean centerBean = new CenterDetailsBean();
  var addProspect = "/ProspectCreationMaster/add";
  var addProspectResult = "/creditBereauResultData/addCreditBereauResult/";
  var addProspectLoanResult = "/creditBereauLoanData/addLoanDetails/";
  var urlGetNOCInfo = "/ProspectCreationMaster/getListByRoutedTo/";
  static final _headers = {'Content-Type': 'application/json'};

  static const JsonCodec JSON = const JsonCodec();
  static Utility obj = new Utility();
  var urlGetCenterInfo =
      "createCentersFoundations/getCenterDataByCreatedByAndMlbrCode/";
  var urlGetGroupInfo =
      "createGroupsFoundations/getGroupDataByCreatedByAndMlbrCode";
  var urlUpdateCustomerLoanMaster = "customerLoanData/add/";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  int branch = 0;
  String usrRole;
  QrScanner qr = new QrScanner();
  bool showAdvance = false;
  bool showAdvanceToServer = false;
  bool showAdvanceFromServer = false;
  String getAllCustomerOnId = "0";

  @override
  void initState() {
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      globals.branchCode = branch;
      globals.agentUserName = username;
    });

    SystemParameterBean sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('6', 0);
    getAllCustomerOnId =
        sysBean.mcodevalue != null ? sysBean.mcodevalue.trim() : "0";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Syncing activity'),
        backgroundColor: Color(0xff07426A),
      ),
      body: ModalProgressHUD(
        //  color: Colors.grey,
        inAsyncCall: circIndicatorIsDatSynced,
        //opacity: 10.5,
        color: Colors.white,
        //offset: ,
        // progressIndicator: FadingText('Loading...'),
        progressIndicator: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 10,
          animation: true,
          lineHeight: 50.0,
          animationDuration: 2500,
          //percent: 0.8,
          center: FadingText('Loading...'),
          linearStrokeCap: LinearStrokeCap.butt,
          progressColor: Colors.grey,
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (showAdvance == false) {
                      setState(() {
                        showAdvance = true;
                      });
                    } else if (showAdvance == true) {
                      setState(() {
                        showAdvance = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.sync),
                          onPressed: null,
                          iconSize: 30.0,
                          color: Colors.blueGrey,
                        ),
                        title: new Text(
                          "Sync ",
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: showAdvance == true
                            ? new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title:
                                          new Text(Constant.syncedLookupsLab),
                                      onTap: () async {
                                        syncLookupData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.syncedInterestSlabLab),
                                      onTap: () async {
                                        syncInterestSlabData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.syncedInterestOffsetLab),
                                      onTap: () async {
                                        syncInterestOffsetData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title:
                                          new Text(Constant.syncSubLookupLab),
                                      onTap: () async {
                                        _performSyncingSubLookup();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text(Constant.syncProductLab),
                                      onTap: () async {
                                        _performSyncingProduct();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text(Constant.syncBranchLab),
                                      onTap: () async {
                                        _performSyncingBranch();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text(Constant.syncAddress),
                                      onTap: () async {
                                        _performSyncingAddress();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(Constant
                                          .syncedLoanCycleParameterPrimaryLab),
                                      onTap: () async {
                                        syncLoanCycleParameterPrimaryData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(Constant
                                          .syncedLoanCycleSecondaryPrimaryLab),
                                      onTap: () async {
                                        syncLoanCycleParameterSecondaryData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.syncingLoanApprovalLimit),
                                      onTap: () async {
                                        syncsyncingLoanApprovalLimitData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.syncedSystemParameterLab),
                                      onTap: () async {
                                        syncSystemParameterData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(Constant.syncedTdROI),
                                      onTap: () async {
                                        _performSyncingTDRoiData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text(Constant.syncHbsUsers),
                                      onTap: () async {
                                        _performSyncingGetHbsUser();
                                      }),
                                ],
                              )
                            : null,
                        trailing: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 50.0,
                            onPressed: () {
                              syncFactory();
                            })),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (showAdvanceToServer == false) {
                      setState(() {
                        showAdvanceToServer = true;
                      });
                    } else if (showAdvanceToServer == true) {
                      setState(() {
                        showAdvanceToServer = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.file_upload),
                          onPressed: null,
                          iconSize: 30.0,
                          color: Colors.blueGrey,
                        ),
                        title: new Text(
                          Constant.syncToServerLab,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: showAdvanceToServer == false
                            ? null
                            : new Column(
                                children: <Widget>[
                                  /*new ListTile(
                              leading: new Icon(
                                Icons.sync,
                                color: Color(0xff01579b),
                              ),
                              title: new Text(
                                  Constant.uploadNOCCheckResultLab),
                              onTap: () async {
                                syncNOCCheckResult();
                              }),*/
                               /*   new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text(Constant.syncProspectLab),
                                      onTap: () async {
                                        _performSyncingProspect();
                                      }),*/
                                  new Container(
                                    child: new ListTile(
                                        leading: new Icon(
                                          Icons.sync,
                                          color: Color(0xff07426A),
                                        ),
                                        title: new Text(
                                            Constant.syncCustomerLoanAsLeadLab),
                                        onTap: () {
                                          syncedCustomerLoanAsLeadData();
                                        }),
                                  ),
                             /*     new Container(
                                    child: new ListTile(
                                        leading: new Icon(
                                          Icons.sync,
                                          color: Color(0xff07426A),
                                        ),
                                        title:
                                            new Text(Constant.syncSavingsLab),
                                        onTap: () {
                                          syncedSavingsData();
                                        }),
                                  ),*/
                                 /* new Container(
                                    child: new ListTile(
                                        leading: new Icon(
                                          Icons.sync,
                                          color: Color(0xff07426A),
                                        ),
                                        title: new Text(
                                            Constant.syncLoanUtilization),
                                        onTap: () {
                                          syncedLoanUtilizationData();
                                        }),
                                  ),*/
                             /*     new Container(
                                    child: new ListTile(
                                        leading: new Icon(
                                          Icons.sync,
                                          color: Color(0xff07426A),
                                        ),
                                        title: new Text(
                                            Constant.syncSavingsCollectionLab),
                                        onTap: () {
                                          syncedSavingsCollectionData();
                                        }),
                                  ),*/
                              /*    new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title:
                                          new Text(Constant.syncLoanDetailsLab),
                                      onTap: () async {
                                        try {
                                          await _performSyncingLoan();
                                        } catch (_) {}
                                      }),*/
                                  /*   new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(Constant.syncCGT1Lab),
                                onTap: () async {
                                  _performSyncingCGT1();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(Constant.syncCGT2Lab),
                                onTap: () async {
                                  _performSyncingCGT2();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(Constant.syncGRTLab),
                                onTap: () async {
                                  _performSyncingGRT();
                                }),*/
                               /*   new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text("Sync SpeedoMeter"),
                                      onTap: () async {
                                        _performSyncingSpeedoMeter();
                                      }),*/
                                  /*new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text(
                                          Constant.syncDailyLoanCollected),
                                      onTap: () async {
                                        _performSyncingDailyLoanCollected();
                                      }),*/
                                 /* new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title: new Text("Sync TermDeposit"),
                                      onTap: () async {
                                        //_performSyncingSpeedoMeter();
                                        _performSyncingTermDeposit();
                                      }),*/
                                ],
                              ),
                        trailing: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 50.0,
                            onPressed: () {
                              syncToServer();
                            })),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (showAdvanceFromServer == false) {
                      setState(() {
                        showAdvanceFromServer = true;
                      });
                    } else if (showAdvanceFromServer == true) {
                      setState(() {
                        showAdvanceFromServer = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.file_download),
                          onPressed: null,
                          iconSize: 30.0,
                          color: Colors.blueGrey,
                        ),
                        title: new Text(
                          Constant.syncFromServerLab,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: showAdvanceFromServer == false
                            ? null
                            : Column(
                                children: <Widget>[
                                  /*new ListTile(
                              leading: new Icon(
                                Icons.sync,
                                color: Color(0xff01579b),
                              ),
                              title: new Text(
                                  Constant.getNOCPendingDataLab),
                              onTap: () async {
                                getNOCPendingData();
                              }),*/
                                  /*new ListTile(
                              leading: new Icon(
                                Icons.sync,
                                color: Color(0xff01579b),
                              ),
                              title: new Text(
                                  Constant.getNOCCheckResultLab),
                              onTap: () async {
                                getNOCCheckResult();
                              }),*/
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff01579b),
                                      ),
                                      title:
                                          new Text(Constant.getWorkingLoanLab),
                                      onTap: () async {
                                        _performGetWorkingLoan();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.getWorkingCustomersLab),
                                      onTap: () async {
                                        SystemParameterBean sysBean =
                                            new SystemParameterBean();
                                        sysBean = await AppDatabase.get()
                                            .getSystemParameter('6', 0);
                                        if (getAllCustomerOnId != null &&
                                            getAllCustomerOnId.trim() == '1') {
                                          showMessageShortDuration(
                                              "This module is locked");
                                        } else {
                                          getSyncedCustomerData();
                                          print("working");
                                        }
                                        //getSyncedCustomerData();
                                      }),
                                 /* new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.getAllProspectDataLab),
                                      onTap: () async {
                                        getAllProspectData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.getDailyCollectionData),
                                      onTap: () async {
                                        getDailyCollectionData();
                                      }),
                                  new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(
                                          Constant.getAllSavingsListLab),
                                      onTap: () async {
                                        getSyncedSavingsListData();
                                      }),*/
                          /*        new ListTile(
                                      leading: new Icon(
                                        Icons.sync,
                                        color: Color(0xff07426A),
                                      ),
                                      title: new Text(Constant.getFromCenterId),
                                      onTap: () async {
                                        await Constant.setSystemVariables();

                                        SystemParameterBean sysBean =
                                            await AppDatabase.get()
                                                .getSystemParameter('11', 0);
                                        if (sysBean.mcodevalue != null &&
                                            sysBean.mcodevalue
                                                    .trim()
                                                    .toUpperCase() ==
                                                'N') {
                                          return;
                                        }
                                        getCustommerFromCenterId();
                                      }),*/
                                ],
                              ),
                        trailing: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 50.0,
                            onPressed: () {
                              syncFromServer();
                            })),
                  ),
                ),

                /*  new ListTile(
                        leading: new Icon(
                          Icons.sync,
                          color: Color(0xff01579b),
                        ),
                        title: new Text("Sync Sub Lookup"),
                        onTap: () async {
                          _performSyncingSubLookup();
                        }),
                    new ListTile(
                        leading: new Icon(
                          Icons.sync,
                          color: Color(0xff01579b),
                        ),
                        title: new Text("Sync Product"),
                        onTap: () async {
                          _performSyncingProduct();
                        }),

                    */
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onDatSyncedPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            actions: <Widget>[
              new Container(
                child: circIndicatorIsDatSynced == true
                    ? CircularProgressIndicator()
                    : Navigator.of(context).pop(true),
              )
            ],
          ),
        ) ??
        false;
  }

  Future<void> syncFactory() async {
    print("agent username " +
        username.toString() +
        " grp code " +
        usrGrpCode.toString());
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await Constant.setSystemVariables();

    SystemParameterBean sysBean =
        await AppDatabase.get().getSystemParameter('11', 0);
    if (sysBean.mcodevalue != null &&
        sysBean.mcodevalue.trim().toUpperCase() == 'N') {
    } else {

    }

    await syncLookupData();
    await syncSystemParameterData();
    await syncInterestSlabData();
    await syncInterestOffsetData();
    await _performSyncingSubLookup();
    //await _performSyncingTDRoiData();// getting data for the table Product wise Interest table and Offset interest Master
    await _performSyncingProduct();
    await _performSyncingBranch();
    await _performSyncingAddress();
    await syncLoanCycleParameterPrimaryData();
    await syncLoanCycleParameterSecondaryData();
    // generate dropdownrelated canges here
    await syncsyncingLoanApprovalLimitData();
    await Constant.getDropDownInitialize();
    await Constant.setSystemVariables();
    await syncsyncingLoanApprovalLimitData();
    await _performSyncingGetHbsUser();

    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> syncFromServer() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

   // await getAllProspectData();
    await _performGetWorkingLoan();
    SystemParameterBean sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('6', 0);
    if (getAllCustomerOnId != null && getAllCustomerOnId.trim() == '1') {
      showMessageShortDuration("This module is locked");
    } else {
      getSyncedCustomerData();
      print("working");
    }
    //getSyncedCustomerData();
    /*await getSyncedCustomerData();*/
    //  await getSyncedSavingsListData();
    //await getNOCPendingData();

    /*if (Constant.getAllProspectData.contains(usrGrpCode)) {
      _ChooseAction();
    }*/

    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> syncToServer() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    //await _performSyncingProspect();
    await syncedCustomerLoanAsLeadData();
    //await syncedSavingsData();
    //await syncedLoanUtilizationData();
    //await syncedSavingsCollectionData();
   // await _performSyncingDailyLoanCollected();

    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

 /* Future<void> syncedSavingsCollectionData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryPostSavingsCollectionList();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }*/

 /* Future<void> syncedLoanUtilizationData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryPostLoanUtilizationList();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }
*/
 /* Future<void> syncedSavingsData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryPostSavingsList();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }
*/
  Future<void> syncedCustomerLoanAsLeadData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryPost();
    await _performSyncingLoan();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

 /* Future<void> syncedData(String forWhat) async {
    if ((forWhat == "group" *//*&& Constant.syncGroup.contains(usrGrpCode)*//*) ||
        (forWhat == "center" *//*&& Constant.syncCenter.contains(usrGrpCode)*//*)) {
      setState(() {
        isDataSynced = true;
        circIndicatorIsDatSynced = true;
      });
      await _trySave(forWhat);

      setState(() {
        circIndicatorIsDatSynced = false;
      });
    }
  }
*/
  Future<void> getNOCPendingData() async {
    // if (Constant.getNOCPendingData.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingNOCPendingData);
    ProspectServices service = new ProspectServices();
    // await service.trySaveNOCPendingData(prefs);

    setState(() {
      circIndicatorIsDatSynced = false;
    });
    /*} else {
      showMessage("Not Autorised for ${usrGrpCode}");
    }*/
  }

  Future<void> getAllProspectData() async {
    /*if (Constant.getAllProspectData.contains(usrGrpCode)) {*/
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingALLProspect);
    GetProspectFromMiddleware getProspect = new GetProspectFromMiddleware();
    await getProspect.getProspect();

    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> getDailyCollectionData() async {
    /*if (Constant.getAllProspectData.contains(usrGrpCode)) {*/
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    GetDailyCollectionFromMiddleware getDailyCollectionFromMiddleware =
        new GetDailyCollectionFromMiddleware();
    showMessage(Constant.getDailyCollectionData);

    await getDailyCollectionFromMiddleware.trySave(branch, username);

    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> syncNOCCheckResult() async {
    /*if (Constant.uploadNOCCheckRes.contains(usrGrpCode)) {*/
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    ProspectServices service = new ProspectServices();
    //await service.trySaveNOCCheckResult(prefs);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> getNOCCheckResult() async {
    //if (Constant.getNOCCheckResult.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingNOCCheckResult);
    ProspectServices service = new ProspectServices();
    //await service.trySaveNOCFinalResult(prefs);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncedProspectResult(String userName) async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    ProspectServices services = new ProspectServices();
    //await services.trySaveProspectResult(userName, prefs);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> getSyncedCustomerData() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingWorkingCustomer);
    GetCustomerFromMiddleware getCustomerFromMiddleware =
        new GetCustomerFromMiddleware();
    await getCustomerFromMiddleware.trySave(username);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> getSyncedSavingsListData() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingSavingsList);
    GetSavingsListFromMiddleware getSavingsListFromMiddleware =
        new GetSavingsListFromMiddleware();
    await getSavingsListFromMiddleware.trySave(username);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> syncInterestSlabData() async {
    print("Inside interest slab data");
    //if(Constant.syncInterestSlab.contains(22)){
    print("Inside slab if condition");
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingInterestSlab);
    await AppDatabase.get().createInterestSlabInsert();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> syncInterestOffsetData() async {
    //if(Constant.syncInterestOffset.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingInterestOffset);
    await AppDatabase.get().createInterestOffsetInsert();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncLoanCycleParameterPrimaryData() async {
    //if(Constant.syncLoanCycleParameterPrimary.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingLoanCycleParameterPrimary);
    await AppDatabase.get().createLoanCycleParameterPrimaryInsert(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //  }
  }

  Future<void> syncLoanCycleParameterSecondaryData() async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingLoanCycleParameterSecondary);
    await AppDatabase.get().createLoanCycleParameterSecondaryInsert(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncsyncingLoanApprovalLimitData() async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingLoanApprovalLimit);
    await AppDatabase.get()
        .createLoanApprovalLimitInsert(branch, username, usrGrpCode);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncLookupData() async {
    //if (Constant.syncLookups.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingLookups);
    await AppDatabase.get().createLookupInsert();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingProduct() async {
    //if (Constant.syncProduct.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SyncingProducts syncingProducts = new SyncingProducts();
    showMessage(Constant.syncingProduct);
    await syncingProducts.trySave(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingBranch() async {
    //if (Constant.syncProduct.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    BranchMasterServices branchMasterServices = new BranchMasterServices();
    showMessage(Constant.syncingBranch);
    await branchMasterServices.trySave(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingAddress() async {
    //if (Constant.syncProduct.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SyncingCountry syncingCountry = new SyncingCountry();
    await syncingCountry.trySave();
    showMessage(Constant.syncingAddress);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingGetHbsUser() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    GetHbsUSers getHbsUSers = new GetHbsUSers();
    showMessage(Constant.syncHbsUsers);
    await getHbsUSers.trySave(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingLoan() async {

    try {
      CustomerLoanServices customerLoanServices = new CustomerLoanServices();
      await customerLoanServices.getAndSync(userCode);
    } catch (_) {}

    try{
      SyncingDocumentsToMiddleware syncingDocumentsToMiddleware = new SyncingDocumentsToMiddleware();
      await syncingDocumentsToMiddleware.getAndSync(userCode);

    }catch(_){

    }
    try {
      SyncGuarantorToMiddleware syncGuarantorToMiddleware =
          new SyncGuarantorToMiddleware();
      await syncGuarantorToMiddleware.getAndSync(userCode);
    } catch (_) {}
    try {
      SyncingCollatralBasicDetailsToMiddleware syncingCollatralBasicDetailsToMiddleware =
      new SyncingCollatralBasicDetailsToMiddleware();
      await syncingCollatralBasicDetailsToMiddleware.getAndSync();
    } catch (_) {}
    try {
      SyncingCollateralVehicleToMiddleware syncingCollateralVehicleToMiddleware =
      new SyncingCollateralVehicleToMiddleware();
      await syncingCollateralVehicleToMiddleware.getAndSync();
    } catch (_) {}

   // try {
      SyncingCollateralREMToMiddleware syncingCollateralREMToMiddleware =
      new SyncingCollateralREMToMiddleware();
      await syncingCollateralREMToMiddleware.getAndSync();
    //} catch (_) {}

   /* try {
      await _performSyncingCGT1();
    } catch (_) {}
    try {
      await _performSyncingCGT2();
    } catch (_) {}
    try {
      await _performSyncingGRT();
    } catch (_) {}*/
  }

  /*Future<void> _performSyncingLoan() async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
   // try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(6, false).then((onValue) async{
        await AppDatabase.get()
            .selectCustomerListIsDataSynced(onValue)
            .then((List<CustomerListBean> customerData) async {
          print("customerData.length  "+customerData.length.toString() );
          if (customerData.length > 0) {

            setState(() {
              circIndicatorIsDatSynced = false;
              showMessage("Please sync customer before Syncing Loan");
            });
          }else{
            CustomerLoanServices customerLoanServices = new CustomerLoanServices();
            await customerLoanServices.getAndSync(userCode);

            try{
              SyncGuarantorToMiddleware syncGuarantorToMiddleware = new SyncGuarantorToMiddleware();
              await syncGuarantorToMiddleware.getAndSync(userCode);
            }catch(_){
            }
            try{
              await _performSyncingCGT1();
            }catch(_){
            }
            try{
              await _performSyncingCGT2();
            }catch(_){

            }
            try{
              await  _performSyncingGRT();
            }catch(_){

            }
            setState(() {
              circIndicatorIsDatSynced = false;
            });
          }


        });



          });



    //}
  }
*/
  Future<void> _performSyncingCGT1() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    CGT1Services cgt1Services = new CGT1Services();
    await cgt1Services.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingCGT2() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingCGT1);
    CGT2Services cgt2Services = new CGT2Services();
    await cgt2Services.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performGetWorkingLoan() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingWorkingLoans);
    GetLoanFromMiddleware getLoanFromMiddleware = new GetLoanFromMiddleware();
    await getLoanFromMiddleware.trySave(username, branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> _performSyncingGRT() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    GRTServices grtServices = new GRTServices();
    await grtServices.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

 /* Future<void> _performSyncingSpeedoMeter() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SpeedoMeterServices smServices = new SpeedoMeterServices();
    await smServices.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }
*/
  /*Future<void> _performSyncingTermDeposit() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryTDPost();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }*/

  Future<void> _performSyncingSubLookup() async {
    //if (Constant.syncSubLookups.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingSubLookup);
    await AppDatabase.get().createSubLookupInsert();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingTDRoiData() async {
    //if (Constant.syncSubLookups.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingTDRoiTables);
    await AppDatabase.get().createTDRoiInsert(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

 /* Future<void> _performSyncingProspect() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingProspect);
    ProspectServices prospectService = new ProspectServices();
    String msg = await prospectService.uploadProspectData();

    showMessageShortDuration(msg);

    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //_scaffoldKey.currentState.hideCurrentSnackBar();
  }
*/
  /* Future<void> _syncingGuarantor() async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    // try {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(15, false).then((onValue) async{
      await AppDatabase.get()
          .getCustomerLoanDetailsNotSynced(onValue)
          .then((List<CustomerLoanDetailsBean> customerLoanData) async {
        print("customerLoanData.length  "+customerLoanData.length.toString() );
        if (customerLoanData.length > 0) {

          SyncGuarantorToMiddleware syncGuarantorToMiddleware = new SyncGuarantorToMiddleware();
          await syncGuarantorToMiddleware.getAndSync(userCode);

          setState(() {
            circIndicatorIsDatSynced = false;
          });

        }else{
          setState(() {
            circIndicatorIsDatSynced = false;
            showMessage("Please sync Loan before Syncing Guarantor");
          });
        }


      });



    });



    //}
  }*/
  Future<void> _tryPostSavingsCollectionList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      showMessage("Syncing Display Savings List");
      SyncingSavingsCollectionListtoMiddleware
          syncingSavingsCollectionListtoMiddleware =
          new SyncingSavingsCollectionListtoMiddleware();
      await syncingSavingsCollectionListtoMiddleware
          .saveSavingsCollectionlData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryPostLoanUtilizationList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      showMessage("Syncing Loan Utilization List");
      SyncLoanUtilizationToMiddleware syncLoanUtilizationToMiddleware =
          new SyncLoanUtilizationToMiddleware();
      await syncLoanUtilizationToMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryPostSavingsList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      showMessage("Syncing Savings List");
      SyncingSavingsListtoMiddleware syncingSavingsListtoMiddleware =
          new SyncingSavingsListtoMiddleware();
      await syncingSavingsListtoMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryTDPost() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      showMessage("Syncing TD List");
      SyncTDListToMiddleware syncTDListToMiddleware =
          new SyncTDListToMiddleware();
      await syncTDListToMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryPost() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      showMessage("Syncing Customer");
      SyncingCustomertoMiddleware syncingCustomerToMiddleware =
          new SyncingCustomertoMiddleware();
      await syncingCustomerToMiddleware.customerNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  void showInSnackBar(String value, [Color color]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color != null ? color : null,
    ));
  }

  Future<Null> _trySave(String forWhat) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      showMessage("Syncing ${forWhat}");
      print("agent username " +
          username.toString() +
          " grp code " +
          usrGrpCode.toString());
      if (forWhat == 'group') {
        await getMiddleWareData(forWhat, username, urlGetGroupInfo);
      } else if (forWhat == 'center') {
        await getMiddleWareData(forWhat, username, urlGetCenterInfo);
      }
    }
  }

  Future<Null> getMiddleWareData(
      String forWhat, String userName, String url) async {
    try {
      String json2 = _toJsonOfAgentUserName(userName);
      print(json2);
      String bodyValue = await NetworkUtil.callPostService(
          json2, Constant.apiURL.toString() + url.toString(), _headers);
      print("bodyValue ::" + bodyValue);
      if (bodyValue == "404") {
        return null;
      }
      final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
      if (forWhat == 'group') {
        List<GroupFoundationBean> obj = parsed
            .map<GroupFoundationBean>(
                (json) => GroupFoundationBean.fromMap(json))
            .toList();
        await AppDatabase.get().deletSomeSyncingActivityFromOmni('Group');
        for (GroupFoundationBean items in obj) {
          await AppDatabase.get().updateGroupFoundation(items);
        }
      } else if (forWhat == 'center') {
        List<CenterDetailsBean> obj = parsed
            .map<CenterDetailsBean>((json) => CenterDetailsBean.fromMap(json))
            .toList();
        await AppDatabase.get().deletSomeSyncingActivityFromOmni('Center');
        for (CenterDetailsBean items in obj) {
          await AppDatabase.get().updateCenterFoundation(items);
        }
      }
    } catch (e) {}
  }

  String _toJsonOfAgentUserName(agentUserNo) {
    var mapData = new Map();
    mapData[TablesColumnFile.mcreatedby] = agentUserNo.toString().trim();
    mapData[TablesColumnFile.mlbrcode] = branch;
    String json = JSON.encode(mapData);
    return json;
  }

  void showMessage(String message, [MaterialColor color = Colors.grey]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {
      print(e);
    }
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text(message),
        duration: Duration(seconds: 45)));
  }

  Future<void> _ChooseAction() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sync Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('What you want to save'),
                Text('Syncing whole result will take more time')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Whole Result'),
              onPressed: () async {
                Navigator.of(context).pop();
                await getAllProspectData();
              },
            ),
            FlatButton(
              child: Text('NOC Check Result'),
              onPressed: () async {
                Navigator.of(context).pop();
                await getNOCCheckResult();
              },
            ),
          ],
        );
      },
    );
  }

  void showMessageShortDuration(String message,
      [MaterialColor color = Colors.grey]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {
      print(e);
    }
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text("${message}"),
        duration: Duration(seconds: 6)));
  }

  Future<void> syncSystemParameterData() async {
    //if(Constant.syncSystemParameter.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.syncingSystemParameter);
    await AppDatabase.get().createSystemParameterInsert();
    await Constant.setSystemVariables();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

 /* Future<void> _performSyncingDailyLoanCollected() async {
    //if (Constant.syncLoanDetails.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SyncingDailyCollectedToMiddleware _syncingDailyCollectedToMiddleware =
        new SyncingDailyCollectedToMiddleware();
    await _syncingDailyCollectedToMiddleware.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }
*/
/*  Future<void> getCustommerFromCenterId() async {
    centerBean = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => _myCenterDialog,
          fullscreenDialog: true,
        ));
    if (centerBean != null) {
      setState(() {
        isDataSynced = true;
        circIndicatorIsDatSynced = true;
      });
      showMessage(Constant.gettingWorkingCustomer);
      GetCustomerFromCenter getCustomerFromMiddleware =
          new GetCustomerFromCenter();
      await getCustomerFromMiddleware.trySave(centerBean.mCenterId);
      setState(() {
        circIndicatorIsDatSynced = false;
      });
    }

    setState(() {});

    centerBean = new CenterDetailsBean();

    *//*setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingWorkingCustomer);
    GetCustomerFromCenter getCustomerFromMiddleware =
    new GetCustomerFromCenter();
    await getCustomerFromMiddleware.trySave(username);
    setState(() {
      circIndicatorIsDatSynced = false;
    });*//*
  }*/
}

class CustomerId {
  int customerNumberOfTab;
  String usrCode;
}
