import 'package:eco_los/pages/workflow/customerFormation/CustomerTotalExpenditureDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/SocialFinancialDetailsBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/home/Home_Dashboard.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';

import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationBusinessCashFlow3.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationBusinessDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationCenterAndGroupDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationContactDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationDeclarationForm.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationDocuments.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationExpenditureDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationFamilyDetails.dart';

import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationLoanDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationPersonalInfo.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_los/pages/workflow/customerFormation/PPI.dart';

import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../translations.dart';
import 'CustomerFormationRiskRatings.dart';
import 'ESMS.dart';
import 'ESMS2.dart';
import 'bean/ESMSBean.dart';
import 'bean/FinancialStmntBean.dart';
import 'bean/IncomeStatementBean.dart';
import 'bean/TotalExpenditureDetailsBean.dart';

/*import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';*/

class CustomerFormationMasterTabs extends StatefulWidget {
  var cameras;
  final CustomerListBean customerObject;

  CustomerFormationMasterTabs(this.cameras, this.customerObject);

  @override
  CustomerFormationMasterTabsState createState() =>
      new CustomerFormationMasterTabsState();
}

class CustomerFormationMasterTabsState
    extends State<CustomerFormationMasterTabs>
    with SingleTickerProviderStateMixin {
  static CustomerListBean custListBean = new CustomerListBean();
  //static CustomerBusinessDetailsBean bussBean = new CustomerBusinessDetailsBean();
  static AddressDetailsBean addressBean = new AddressDetailsBean();
  static FamilyDetailsBean fdb = new FamilyDetailsBean();
  static SocialFinancialDetailsBean sfb = new SocialFinancialDetailsBean();
  static CustomerBusinessDetailsBean cbdb = new CustomerBusinessDetailsBean();
  static BorrowingDetailsBean borrowingDetailsBean = new BorrowingDetailsBean();
  static BusinessExpenditureDetailsBean busiExpnBean =
  new BusinessExpenditureDetailsBean();
  static HouseholdExpenditureDetailsBean hhExpnBean =
  new HouseholdExpenditureDetailsBean();
  static AssetDetailsBean assetBean = new AssetDetailsBean();

  // static FixedAssetsBean fixedAssetBean = new FixedAssetsBean();
  // static CurrentAssetsBean currentAssetsBean = new CurrentAssetsBean();
  //static LongTermLiabilitiesBean longTermLiabilitiesBean = new LongTermLiabilitiesBean();
  //static ShortTermLiabilitiesBean shortTermLiabilitiesBean = new ShortTermLiabilitiesBean();
  //static EquityBean equityBean = new EquityBean();
  static IncomeStatementBean incomeStatementBean = new IncomeStatementBean();
  static FinancialStmntBean financialStmntBean = new FinancialStmntBean();
  static String applicantDob = "__-__-____";
  static String loanDate = "__-__-____";
  static String famDob = "__-__-____";
  static String repaymentDate = "__-__-____";
  static String husDob = "__-__-____";
  static String id1IssueDate = "__-__-____";
  static String id1ExpDate = "__-__-____";
  static String id2IssueDate = "__-__-____";
  static String id2ExpDate = "__-__-____";
  static String id3IssueDate = "__-__-____";
  static String id3ExpDate = "__-__-____";
  static String EmpFromDate = "__-__-____";
  static String EmpToDate = "__-__-____";
  static String signDate = "__-__-____";
  static String EmpDateOfImcorp = "__-__-____";
  static List<int> personalInfoRadios = new List<int>(5);
  static List<int> socialFinancialRadios = new List<int>(1);
  static List<int> businessDetailRadios = new List<int>(4);
  static List<int> businessCashFlowRadios = new List<int>(12);
  static List<int> familyDependantRadio = new List<int>(4);
  String maxLengthExceedFieldName = "";
  String globError = "";
  TabController _tabController;
  int tabState = 14;
  SharedPreferences prefs;
  String username;
  String usrGrpCode;
  String isWasasa;
  String resedencyCode;
  /* static final GlobalKey<ScaffoldState> _scaffoldKeyMaster =
      new GlobalKey<ScaffoldState>();*/
  /*static  GlobalKey scaffoldKeyMaster =
  new GlobalKey();*/
  static const List<String> tabNames = const <String>[
    'Profile',
    'Personal Information',
    'Contact details',
    "Family Details",
    // "Expenditure Detail",
    'Social Financial',
    'Loan Details',
    'Employment Details',
    "Expenditure Details",
    'Documents',
    "ESMS",
    "ESMS Details",
    "Risk Ratings",
    "Declaration Form"
  ];

  @override
  void initState() {
    print("custListBean"+custListBean.toString());
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(
        vsync: this, initialIndex: 0, length: tabNames.length);
    getSessionVariables();

    // if (widget.customerObject == null || widget.customerObject.misCbCheckDone==1) {
    if (custListBean.familyDetailsList == null) {
      custListBean.familyDetailsList = new List<FamilyDetailsBean>();
    }
    if (custListBean.socialFinancialList == null) {
      custListBean.socialFinancialList = new List<SocialFinancialDetailsBean>();
    }
    if (custListBean.borrowingDetailsBean == null) {
      custListBean.borrowingDetailsBean = new List<BorrowingDetailsBean>();
    }

    if (custListBean.addressDetails == null) {
      custListBean.addressDetails = new List<AddressDetailsBean>();
    }
    if (custListBean.customerBusinessDetailsBean == null) {
      custListBean.customerBusinessDetailsBean =  new List<CustomerBusinessDetailsBean>();

    }


    // print("custbean "+custListBean.imageMaster.length.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster =
    new List<ImageBean>();
    if (CustomerFormationMasterTabsState.custListBean.imageMaster != null &&
        CustomerFormationMasterTabsState.custListBean.imageMaster.length !=
            23) {
      for (int i = 0; i <= 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster
            .add(ImageBean());

      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mdob != null &&
          widget.customerObject.mdob != 'null' &&
          widget.customerObject.mdob != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mdob.day.toString().length == 1)
          tempDay = "0" + widget.customerObject.mdob.day.toString();
        else
          tempDay = widget.customerObject.mdob.day.toString();

        if (widget.customerObject.mdob.month.toString().length == 1)
          tempMonth = "0" + widget.customerObject.mdob.month.toString();
        else
          tempMonth = widget.customerObject.mdob.month.toString();

        CustomerFormationMasterTabsState.applicantDob =
            CustomerFormationMasterTabsState.applicantDob
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.applicantDob =
            CustomerFormationMasterTabsState.applicantDob
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.applicantDob =
            CustomerFormationMasterTabsState.applicantDob.replaceRange(
                6, 10, widget.customerObject.mdob.year.toString());
      }

      if (widget.customerObject.mhusdob != null &&
          widget.customerObject.mhusdob != 'null' &&
          widget.customerObject.mhusdob != '') {
        String tempDayH;
        String tempMonthH;
        if (widget.customerObject.mhusdob.day.toString().length == 1)
          tempDayH = "0" + widget.customerObject.mhusdob.day.toString();
        else
          tempDayH = widget.customerObject.mhusdob.day.toString();

        if (widget.customerObject.mhusdob.month.toString().length == 1)
          tempMonthH = "0" + widget.customerObject.mhusdob.month.toString();
        else
          tempMonthH = widget.customerObject.mhusdob.month.toString();

        CustomerFormationMasterTabsState.husDob =
            CustomerFormationMasterTabsState.husDob
                .replaceRange(0, 2, tempDayH);

        CustomerFormationMasterTabsState.husDob
            .replaceRange(3, 5, tempMonthH);

        CustomerFormationMasterTabsState.husDob =
            CustomerFormationMasterTabsState.husDob.replaceRange(
                6, 10, widget.customerObject.mhusdob.year.toString());
      }
    }


    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid1issuedate != null &&
          widget.customerObject.mid1issuedate != 'null' &&
          widget.customerObject.mid1issuedate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid1issuedate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid1issuedate.day.toString();
        else
          tempDay = widget.customerObject.mid1issuedate.day.toString();

        if (widget.customerObject.mid1issuedate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid1issuedate.month.toString();
        else
          tempMonth = widget.customerObject.mid1issuedate.month.toString();

        CustomerFormationMasterTabsState.id1IssueDate =
            CustomerFormationMasterTabsState.id1IssueDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id1IssueDate =
            CustomerFormationMasterTabsState.id1IssueDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id1IssueDate =
            CustomerFormationMasterTabsState.id1IssueDate.replaceRange(
                6, 10, widget.customerObject.mid1issuedate.year.toString());
      }
    }


    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid1expdate != null &&
          widget.customerObject.mid1expdate != 'null' &&
          widget.customerObject.mid1expdate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid1expdate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid1expdate.day.toString();
        else
          tempDay = widget.customerObject.mid1expdate.day.toString();

        if (widget.customerObject.mid1expdate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid1expdate.month.toString();
        else
          tempMonth = widget.customerObject.mid1expdate.month.toString();

        CustomerFormationMasterTabsState.id1ExpDate =
            CustomerFormationMasterTabsState.id1ExpDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id1ExpDate =
            CustomerFormationMasterTabsState.id1ExpDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id1ExpDate =
            CustomerFormationMasterTabsState.id1ExpDate.replaceRange(
                6, 10, widget.customerObject.mid1expdate.year.toString());
      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid2issuedate != null &&
          widget.customerObject.mid2issuedate != 'null' &&
          widget.customerObject.mid2issuedate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid2issuedate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid2issuedate.day.toString();
        else
          tempDay = widget.customerObject.mid2issuedate.day.toString();

        if (widget.customerObject.mid2issuedate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid2issuedate.month.toString();
        else
          tempMonth = widget.customerObject.mid2issuedate.month.toString();

        CustomerFormationMasterTabsState.id2IssueDate =
            CustomerFormationMasterTabsState.id2IssueDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id2IssueDate =
            CustomerFormationMasterTabsState.id2IssueDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id2IssueDate =
            CustomerFormationMasterTabsState.id2IssueDate.replaceRange(
                6, 10, widget.customerObject.mid2issuedate.year.toString());
      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid2expdate != null &&
          widget.customerObject.mid2expdate != 'null' &&
          widget.customerObject.mid2expdate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid2expdate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid2expdate.day.toString();
        else
          tempDay = widget.customerObject.mid2expdate.day.toString();

        if (widget.customerObject.mid2expdate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid2expdate.month.toString();
        else
          tempMonth = widget.customerObject.mid2expdate.month.toString();

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate.replaceRange(
                6, 10, widget.customerObject.mid2expdate.year.toString());
      }
    }



    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid3issuedate != null &&
          widget.customerObject.mid3issuedate != 'null' &&
          widget.customerObject.mid3issuedate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid3issuedate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid3issuedate.day.toString();
        else
          tempDay = widget.customerObject.mid3issuedate.day.toString();

        if (widget.customerObject.mid3issuedate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid3issuedate.month.toString();
        else
          tempMonth = widget.customerObject.mid3issuedate.month.toString();

        CustomerFormationMasterTabsState.id3IssueDate =
            CustomerFormationMasterTabsState.id3IssueDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id3IssueDate =
            CustomerFormationMasterTabsState.id3IssueDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id3IssueDate =
            CustomerFormationMasterTabsState.id3IssueDate.replaceRange(
                6, 10, widget.customerObject.mid3issuedate.year.toString());
      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid3expdate != null &&
          widget.customerObject.mid3expdate != 'null' &&
          widget.customerObject.mid3expdate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid3expdate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid3expdate.day.toString();
        else
          tempDay = widget.customerObject.mid3expdate.day.toString();

        if (widget.customerObject.mid3expdate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid3expdate.month.toString();
        else
          tempMonth = widget.customerObject.mid3expdate.month.toString();

        CustomerFormationMasterTabsState.id3ExpDate =
            CustomerFormationMasterTabsState.id3ExpDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id3ExpDate =
            CustomerFormationMasterTabsState.id3ExpDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id3ExpDate =
            CustomerFormationMasterTabsState.id3ExpDate.replaceRange(
                6, 10, widget.customerObject.mid3expdate.year.toString());
      }
    }
    if (widget.customerObject != null) {
      if (widget.customerObject.esmsentity != null &&
          widget.customerObject.esmsentity.date != null &&
          widget.customerObject.esmsentity.date!= 'null' &&
          widget.customerObject.esmsentity.date != '') {
        String tempDay;
        String tempMonth;
        try{


          if (widget.customerObject.esmsentity.date.day
              .toString()
              .length == 1)
            tempDay = "0" + widget.customerObject.esmsentity.date.day.toString();
          else
            tempDay = widget.customerObject.esmsentity.date.day.toString();

          if (widget.customerObject.esmsentity.date.month
              .toString()
              .length == 1)
            tempMonth = "0" + widget.customerObject.esmsentity.date.month.toString();
          else
            tempMonth = widget.customerObject.esmsentity.date.month.toString();

          CustomerFormationMasterTabsState.signDate =
              CustomerFormationMasterTabsState.signDate
                  .replaceRange(0, 2, tempDay);

          CustomerFormationMasterTabsState.signDate =
              CustomerFormationMasterTabsState.signDate
                  .replaceRange(3, 5, tempMonth);

          CustomerFormationMasterTabsState.signDate =
              CustomerFormationMasterTabsState.signDate.replaceRange(
                  6, 10, widget.customerObject.mid2expdate.year.toString());
        }catch(_){

        }
      }
      custListBean = widget.customerObject;
    }
    getsharedPreferences();
  }

  getsharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TablesColumnFile.mIsWasasa) != null &&
        prefs.getString(TablesColumnFile.mIsWasasa).trim() != "")
      isWasasa = prefs.getString(TablesColumnFile.mIsWasasa).trim();



    if (prefs.getString(TablesColumnFile.RESEDENCYADDRESSMCODE) != null &&
        prefs.getString(TablesColumnFile.RESEDENCYADDRESSMCODE).trim() != "")
      resedencyCode = prefs.getString(TablesColumnFile.RESEDENCYADDRESSMCODE).trim();

  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);


    });
  }

  void setRadios() {}

  void _handleTabSelection() {

  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        Translations.of(context).text('rusre'),
        Translations.of(context).text('Custgoback'),
        "CustomerFormationMaster");
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        callDialog();
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Customer Information",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              callDialog();
              //Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: new List.generate(tabNames.length, (index) {
              return new Tab(text: tabNames[index].toUpperCase());
            }),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () async {
                /* CustomerFormationDeclarationFormState obj = new CustomerFormationDeclarationFormState();
                obj.submit();*/
                submit();
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            new CustomerFormationCenterAndGroupDetails(widget.cameras),
            new CustomerFormationPersonalInfo(),
            new CustomerFormationContactDetails(),
            new CustomerFormationFamilyDetails(),
            //new CustomerFormationExpenditureDetails(),
            new CustomerFormationSocialFinancialDetails(),
            new CustomerFormationLoanDetails(),
            new CustomerFormationBusinessDetails(),
            new CustomerTotalExpenditureDetails(),
            new CustomerFormationDocuments(widget.cameras),
            new ESMS(),
            new ESMS2(),
            new CustomerFormationRiskRatings(),
            new CustomerFormationDeclarationForm(),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value, context, [Color color]) {
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
  }

  submit() async {
    int customerNumberValue;
    if (!globals.accepted) {
      globals.Dialog.alertPopup(
          context, "Alert", "Please select Terms and condtion", "Same");
      _tabController.animateTo(12);
    } else {
      bool isValidated = await validateTabs();
      if (isValidated) {
        int id;
        CustomerListBean bean = new CustomerListBean();



        if (custListBean.mcreateddt == null) {
          custListBean.mcreatedby = username;
          custListBean.mcreateddt = DateTime.now();
        }
        custListBean.mlastupdateby = username;
        custListBean.mlastupdatedt = DateTime.now();
        if (custListBean.mrefno == null) custListBean.mrefno = 0;

        try {
          custListBean.mdob = DateTime.parse(applicantDob.substring(6) +
              "-" +
              applicantDob.substring(3, 5) +
              "-" +
              applicantDob.substring(0, 2));
        } catch (e) {
          print("date Exception");
        }

        try {
          custListBean.mhusdob = DateTime.parse(husDob.substring(6) +
              "-" +
              husDob.substring(3, 5) +
              "-" +
              husDob.substring(0, 2));
        } catch (e) {
          print("date Exception");
        }
        try {
          custListBean.mmobno = custListBean.addressDetails[0].mMobile;
          custListBean.mlongname = custListBean.mfname.toString() +
              " " +
              custListBean.mmname.toString() +
              " " +
              custListBean.mlname.toString();
        } catch (_) {}

        //print(custListBean.mlastupdatedt.toString() +" ys ssssssssssssss" );

        try {
          try {
            CustomerFormationMasterTabsState.custListBean.esmsentity.date= DateTime.parse(signDate.substring(6) +
                "-" +
                signDate.substring(3, 5) +
                "-" +
                signDate.substring(0, 2));
          } catch (e) {
            print("Sign date expdate Exception");
          }
          await AppDatabase.get()
              .updateCustomerFoundationMasterDetailsTable(custListBean, true)
              .then((onValue) {
            customerNumberValue = onValue;
          });
        } catch (_) {}

        try {
          print("Customer Mater Update Complete");
          if (custListBean.addressDetails != null) {
            await AppDatabase.get()
                .updateCustomerFoundationAddressDetailsListTable(custListBean)
                .then((onValue) {
              id = onValue;
            });
          }
        } catch (_) {}
        print("Customer adress Update Complete");
        try {
          if (custListBean.familyDetailsList != null) {
            await AppDatabase.get()
                .updateCustomerFoundationFamilyDetailsListTable(custListBean)
                .then((onValue) {
              id = onValue;
            });
          }
        } catch (_) {}

        print("Customer family Update Complete");


        try {
          if (custListBean.socialFinancialList != null) {
            await AppDatabase.get()
                .updateCustomerFoundationBankDetailsListTable(custListBean)
                .then((onValue) {
              id = onValue;
            });
          }
        } catch (_) {}

        print("Customer bank Update Complete");


        try {
          if (custListBean.borrowingDetailsBean != null) {
            print("Customer borrowing Update Started" +custListBean.borrowingDetailsBean.length.toString());
            await AppDatabase.get()
                .updateCustomerFoundationBorrowingDetailsListTable(custListBean)
                .then((onValue) {
              id = onValue;
            });
          }
        } catch (_) {}
        print("Customer borrowing Update Complete");



        try {
          if (custListBean.customerBusinessDetailsBean != null) {


          await AppDatabase.get()
              .updateCustomerFoundationBusinessDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
          print("Customer business details Update Complete");
        }} catch (_) {print("Customer business details Update Complete");}

        try {
          custListBean.totalExpenditureDetailsBean.trefno = custListBean.trefno;
          custListBean.totalExpenditureDetailsBean.mrefno = custListBean.mrefno;
          custListBean.totalExpenditureDetailsBean.ttotlexpntrefno = 1;
          custListBean.totalExpenditureDetailsBean.mtotlexpnmrefno = 0;

          await AppDatabase.get()
              .updateCustomerTotalExpendtrBeanTable(custListBean)
              .then((onValue) {
            id = onValue;
          });

        } catch (_) {}
        print("Customer totalExpenditureDetailsBean  detail update complete");

        try {
          if (custListBean.assetDetailsList != null) {
            await AppDatabase.get()
                .updateCustomerAssetDetailsListTable(custListBean)
                .then((onValue) {
              id = onValue;
            });
          }
          print("Customer asset detail Update Complete");
        } catch (_) {}


        for (int i = 0; i < 23; i++) {
          if (custListBean.imageMaster[i].imgString != "" &&
              custListBean.imageMaster[i].imgString != null) {
            custListBean.imageMaster[i].trefno = custListBean.trefno;

            custListBean.imageMaster[i].mrefno = custListBean.mrefno;

            AppDatabase.get().updateImageMaster(custListBean.imageMaster[i], i);
          }
        }

      /*  await AppDatabase.get().updateCreditBereauMasterisCuCrtd(
            custListBean.mpannodesc,
            custListBean.mIdDesc,
            1,
            custListBean.mcustno);*/

      try {
        if (custListBean.esmsentity != null) {
          CustomerFormationMasterTabsState.custListBean.esmsentity.trefno =
              custListBean.trefno;
          CustomerFormationMasterTabsState.custListBean.esmsentity.mrefno =
              custListBean.mrefno;
          CustomerFormationMasterTabsState.custListBean.esmsentity.tesmsrefno =
          1;
          CustomerFormationMasterTabsState.custListBean.esmsentity.mesmsrefno =
          0;
          await AppDatabase.get().updateESMSMaster(
              CustomerFormationMasterTabsState.custListBean.esmsentity);
        }
      }catch(_){

        }

        //try {
          if (custListBean.riskratingsentity != null) {
            CustomerFormationMasterTabsState.custListBean.riskratingsentity.trefno =
                custListBean.trefno;
            CustomerFormationMasterTabsState.custListBean.riskratingsentity.mrefno =
                custListBean.mrefno;
            CustomerFormationMasterTabsState.custListBean.riskratingsentity.triskratingsrefno =
            1;
            CustomerFormationMasterTabsState.custListBean.riskratingsentity.mriskratingsrefno =
            0;
            await AppDatabase.get().updateRiskRatingsMaster(
                CustomerFormationMasterTabsState.custListBean.riskratingsentity);
          }
        /*}catch(_){

        }*/
        success(
            'Customer is created sucessfully'
                'Table refrence Number is :  ${custListBean.trefno.toString()} for getting Core ',
            context);
      }
    }
  }

  List<CustomModel> getKeyOrValueForMultiSelect(
      int multiSelectDropdownCaptionSocialFinancial) {
    List<CustomModel> beanList;
    if (multiSelectDropdownCaptionSocialFinancial == 0) {
      beanList = globals.customModelsAssetsDetails;
    } else if (multiSelectDropdownCaptionSocialFinancial == 1) {
      beanList = globals.customModelsSavingsDetails;
    }
    return beanList;
  }

  Future<bool> validateTabs() async {
    String error = "";
    bool isMaxLengthExceed = false;

    if (CustomerFormationMasterTabsState.custListBean.imageMaster == null) {
      CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
      for (int i = 0; i < 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster
            .add(new ImageBean());
      }
    }


     /*if(custListBean.macctbal==null||custListBean.macctbal.toString().trim()==""){
      _showAlert("Account Balance", "Cannot be Empty");
      return false;
    }



     if(custListBean.macctbal==null||custListBean.macctbal.toString().trim()==""){
      _showAlert("Account Balance", "Cannot be Empty");
      return false;
    }*/


    if (custListBean.imageMaster[0].imgString == "" ||
        custListBean.imageMaster[0].imgString == null) {
      _showAlert("Customer Picture", "It is Mandatory");
      _tabController.animateTo(0);
      return false;
    }
    if (custListBean.mcustcategory == "" || custListBean.mcustcategory == null) {
      _tabController.animateTo(0);
      _showAlert("Applicant Type", "Field is mandatory");
      return false;
    }
    if (custListBean.mnationality == "" || custListBean.mnationality == null) {
      _tabController.animateTo(0);
      _showAlert("Nationality", "Field is mandatory");
      return false;
    }
    if (custListBean.mnametitle == "" || custListBean.mnametitle == null) {
      _tabController.animateTo(1);
      _showAlert("Title", "Field is mandatory");
      return false;
    }
    Utility ut = new Utility();
    error = ut.validateOnlyCharacterField(custListBean.mfname);
    if (error != null) {
      _showAlert("First Name", error);
      _tabController.animateTo(1);
      return false;
    }
    error = ut.validateOnlyCharacterField(custListBean.mlname);
    if (error != null) {
      //showInSnackBar("Last name has $error ",context);
      _showAlert("Last Name", error);
      _tabController.animateTo(1);
      return false;
    }
    error = ut.validateOnlyCharacterFieldKhmer(custListBean.mfname2);
    if (error != null) {
      _showAlert("First Name Khmer", error);
      _tabController.animateTo(1);
      return false;
    }

    error = ut.validateOnlyCharacterFieldKhmer(custListBean.mlname2);
    if (error != null) {
      _showAlert("Last Name Khmer", error);
      _tabController.animateTo(1);
      return false;
    }
    try {
      custListBean.mdob = DateTime.parse(applicantDob.substring(6) +
          "-" +
          applicantDob.substring(3, 5) +
          "-" +
          applicantDob.substring(0, 2));

      int age = DateTime.now().year-custListBean.mdob.year;
      print("custListBean.mdob.year"+age.toString());
      if (age < 18) {
        _showAlert("Date Of birth", "It should be greater than 18");
        _tabController.animateTo(1);
        return false;
      }
    } catch (e) {
      _showAlert("Applicant DOB", "It is Mandatory");
      _tabController.animateTo(1);
      return false;
    }
    if (custListBean.mgender == "" || custListBean.mgender == null) {
      _tabController.animateTo(1);
      _showAlert("Gender", "Field is mandatory");
      return false;
    }

    if (custListBean.mmaritialStatus == "" ||
        custListBean.mmaritialStatus == null) {
      _tabController.animateTo(1);
      _showAlert("Marital Status", "Field is mandatory");
      return false;
    }
    if(custListBean.mmaritialStatus!=null &&custListBean.mmaritialStatus=="2"){
      _showAlert("Spouse Name", "It is Mandatory");
      _tabController.animateTo(1);
      return false;
    }
    if (custListBean.mresstatus == "" ||
        custListBean.mresstatus == null) {
      _tabController.animateTo(1);
      _showAlert("Resedence Status", "Field is mandatory");
      return false;
    }
    if (custListBean.mrelegion == "" || custListBean.mrelegion == null) {
      _tabController.animateTo(1);
      _showAlert("Religion", "Field is mandatory");
      return false;
    }
    if (custListBean.mlangofcust == "" || custListBean.mlangofcust == null) {
      _tabController.animateTo(1);
      _showAlert("Language", "Field is mandatory");
      return false;
    }
    if (custListBean.moccupation == "" || custListBean.moccupation == null) {
      _tabController.animateTo(1);
      _showAlert("Occupation", "Field is mandatory");
      return false;
    }
    if (custListBean.miscpemp == "" || custListBean.miscpemp == null) {
      _tabController.animateTo(1);
      _showAlert("Is Bank Employee", "Field is mandatory");
      return false;
    }

    if (custListBean.mtarget == "" || custListBean.mtarget == null) {
      _tabController.animateTo(1);
      _showAlert("Target", "Field is mandatory");
      return false;
    }
    //TODO undone this
   /* if (custListBean.mmainoccupn == "" || custListBean.mmainoccupn == null) {
      _tabController.animateTo(1);
      _showAlert("Industry", "Field is mandatory");
      return false;
    }
    if (custListBean.msuboccupn == "" || custListBean.msuboccupn == null) {
      _tabController.animateTo(1);
      _showAlert("Sector", "Field is mandatory");
      return false;
    }*/
    if (custListBean.mownership == "" || custListBean.mownership == null) {
      _tabController.animateTo(1);
      _showAlert("Ownership", "Field is mandatory");
      return false;
    }
    if (custListBean.addressDetails == null ||
        custListBean.addressDetails == [] ||
        custListBean.addressDetails.length == 0) {
      _tabController.animateTo(2);
      _showAlert("Adress Detail", "Atleast one address is mandatory");

      return false;
    }


    for(int addressRecedence=0;addressRecedence<custListBean.addressDetails.length;addressRecedence++){
      if (custListBean.addressDetails == resedencyCode) {
        _tabController.animateTo(2);
        _showAlert("Adress Detail", "Resedent address is mandatory");

        return false;
      }
    }

    bool isContain1 =false;
    for (int i = 0; i < custListBean.addressDetails.length; i++) {
      if(custListBean.addressDetails[i].maddrType ==1){
        isContain1 =true;
        break;
      }
    }

    if(!isContain1){
      _tabController.animateTo(2);
      _showAlert("Residential Address", "Residential Address Type is mandatory");
      isContain1 =false;
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
      _tabController.animateTo(2);
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
      _tabController.animateTo(2);
      _showAlert("NID Address", "NID Address is mandatory");
      isContain6 =false;
      return false;
    }
/*    if (custListBean.mbankacno == "" || custListBean.mbankacno == null) {
      _tabController.animateTo(4);
      _showAlert("Account number", "Field is mandatory");
      return false;
    }
    if (custListBean.mbanknamelk == "" || custListBean.mbanknamelk == null) {
      _tabController.animateTo(4);
      _showAlert("Bank Name", "Field is mandatory");
      return false;
    }
    if(custListBean.macctbal==null||custListBean.macctbal.toString().trim()==""){
      _tabController.animateTo(4);
      _showAlert("Account Balance", "Field is mandatory");
      return  false;
    }
    if (custListBean.mbankacyn == "" || custListBean.mbankacyn == null) {
      _tabController.animateTo(4);
      _showAlert("Is Use For Disbursment", "Field is mandatory");
      return false;
    }*/
    if (custListBean.customerBusinessDetailsBean == null ||
        custListBean.customerBusinessDetailsBean == [] ||
        custListBean.customerBusinessDetailsBean.length == 0) {
      _tabController.animateTo(6);
      _showAlert("Employment/Business Detail", "Atleast one Employment/Business is mandatory");

      return false;
    }
    if (custListBean.mpanno == "" || custListBean.mpanno == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype1'), "Field is mandatory");
      return false;
    }
    if (custListBean.mpannodesc == "" || custListBean.mpannodesc == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype1desc'), "Field is mandatory");
      return false;
    }else   if (custListBean.mpannodesc.length<9 ) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype1desc'), "Should not be less than 9 Char");
      return false;
    }
    if (custListBean.missngautryt1 == "" || custListBean.missngautryt1 == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype1issuing'), "Field is mandatory");
      return false;
    }


    try {
      custListBean.mid1issuedate = DateTime.parse(id1IssueDate.substring(6) +
          "-" +
          id1IssueDate.substring(3, 5) +
          "-" +
          id1IssueDate.substring(0, 2));
      try {
        if (DateTime.now().isBefore(custListBean.mid1issuedate)) {
          _showAlert("Id 1 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 1 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 1 Issue Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }

    /*try {
      custListBean.mid1issuedate = DateTime.parse(id1IssueDate.substring(6) +
          "-" +
          id1IssueDate.substring(3, 5) +
          "-" +
          id1IssueDate.substring(0, 2));
      int diff = DateTime.now().day-custListBean.mid1issuedate.day;
      if (diff < 0) {
        _showAlert("Id 1 Issue Date", "Cannot be Future Date");
        _tabController.animateTo(8);
        return false;
      }

    } catch (e) {
      _showAlert("Id 1 Issue Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }*/

    /*try {
      custListBean.mid1issuedate = DateTime.parse(id1IssueDate.substring(6) +
          "-" +
          id1IssueDate.substring(3, 5) +
          "-" +
          id1IssueDate.substring(0, 2));
      try {
        if (DateTime.now().isBefore(custListBean.mid1issuedate)) {
          _showAlert("Id 1 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 1 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 1 Issue Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }*/

    try {
      custListBean.mid1expdate = DateTime.parse(id1ExpDate.substring(6) +
          "-" +
          id1ExpDate.substring(3, 5) +
          "-" +
          id1ExpDate.substring(0, 2));


      // print("custListBean.mdob.year"+age.toString());
      if (custListBean.mid1expdate==DateTime.now() || custListBean.mid1expdate.isBefore(DateTime.now())) {
        _showAlert("Id 1 Expiry Date", "It should be greater than Current Date");
        _tabController.animateTo(8);
        return false;
      }
    } catch (e) {
      _showAlert("Id 1 Expiry Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }

    if (custListBean.mTypeOfId == "" || custListBean.mTypeOfId == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype2'), "Field is mandatory");
      return false;
    }


    if (custListBean.mIdDesc == "" || custListBean.mIdDesc == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype2desc'), "Field is mandatory");
      return false;
    }


    if (custListBean.missngautryt2 == "" || custListBean.missngautryt2 == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype2issuing'), "Field is mandatory");
      return false;
    }

    try {
      custListBean.mid2issuedate = DateTime.parse(id2IssueDate.substring(6) +
          "-" +
          id2IssueDate.substring(3, 5) +
          "-" +
          id2IssueDate.substring(0, 2));
      try {
        if (DateTime.now().isBefore(custListBean.mid2issuedate)) {
          _showAlert("Id 2 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 2 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 2 Issue Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }

    try {
      custListBean.mid2expdate = DateTime.parse(id2ExpDate.substring(6) +
          "-" +
          id2ExpDate.substring(3, 5) +
          "-" +
          id2ExpDate.substring(0, 2));
      if (custListBean.mid2expdate==DateTime.now() || custListBean.mid2expdate.isBefore(DateTime.now())) {
        _showAlert("Id 2 Expiry Date", "It should be greater than Current Date");
        _tabController.animateTo(8);
        return false;
      }
    } catch (e) {
      _showAlert("Id 2 Expiry Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }

    if (custListBean.mtypeofid3 == "" || custListBean.mtypeofid3 == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype3'), "Field is mandatory");
      return false;
    }

    if (custListBean.middesc3 == "" || custListBean.middesc3 == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype3desc'), "Field is mandatory");
      return false;
    }

    if (custListBean.missngautryt3 == "" || custListBean.missngautryt3 == null) {
      _tabController.animateTo(8);
      _showAlert(Translations.of(context).text('idtype3issuing'), "Field is mandatory");
      return false;
    }

    try {
      custListBean.mid3issuedate = DateTime.parse(id3IssueDate.substring(6) +
          "-" +
          id3IssueDate.substring(3, 5) +
          "-" +
          id3IssueDate.substring(0, 2));
      try {
        if (DateTime.now().isBefore(custListBean.mid3issuedate)) {
          _showAlert("Id 3 Issue Date", "Cannot be Future Date");
        }
      }catch(_){
        _showAlert("Id 3 Issue Date", "Cannot be Future Date");
      }
    } catch (e) {
      _showAlert("Id 3 Issue Date", "It is Mandatory");
      _tabController.animateTo(8);
      return false;
    }
if(custListBean.mid3expdate!=null) {
  try {
    custListBean.mid3expdate = DateTime.parse(id3ExpDate.substring(6) +
        "-" +
        id3ExpDate.substring(3, 5) +
        "-" +
        id3ExpDate.substring(0, 2));
    if (custListBean.mid3expdate == DateTime.now() ||
        custListBean.mid3expdate.isBefore(DateTime.now())) {
      _showAlert("Id 3 Expiry Date", "It should be greater than Current Date");
      _tabController.animateTo(8);
      return false;
    }
  } catch (e) {
    //_showAlert("Id 3 Expiry Date", "It is Mandatory");
    _tabController.animateTo(8);
    return false;
  }
}
    SystemParameterBean sysBean =
    await AppDatabase.get().getSystemParameter('11', 0);


    if (custListBean.imageMaster[11].imgString == null ||
        custListBean.imageMaster[11].imgString == "" ) {
      _showAlert("Customer Signature",
          "It is Mandatory");
      _tabController.animateTo(12);
      return false;
    }
    if (custListBean.imageMaster[12].imgString == null ||
        custListBean.imageMaster[12].imgString == "" ) {
      _showAlert("Spouse Signature",
          "It is Mandatory");
      _tabController.animateTo(12);
      return false;
    }
    if (globals.accepted == false) {
      _tabController.animateTo(12);
      _showAlert("Declaration Check Box", "Select to Create a Customer");
      return false;
    }

print("custListBean.esmsentity "+custListBean.esmsentity .toString());

   /* if(custListBean.esmsentity != null ||
        custListBean.esmsentity != []||custListBean.esmsentity != ""){
      if (custListBean.esmsentity.mexclistchecked == "" || custListBean.esmsentity.mexclistchecked == null) {
        _tabController.animateTo(9);
        _showAlert("Exclusion list checked", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.misbrwrinlist == "" || custListBean.esmsentity.misbrwrinlist == null) {
        _tabController.animateTo(9);
        _showAlert("Is Borrowing in exclusion List", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.mnontrgtcust == "" || custListBean.esmsentity.mnontrgtcust == null) {
        _tabController.animateTo(9);
        _showAlert("Non Target Customer List Checked", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.misbrwrinnontrgt == "" || custListBean.esmsentity.misbrwrinnontrgt == null) {
        _tabController.animateTo(9);
        _showAlert("Is Borrowing in Non Target Customer List", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.mairemssn == "" || custListBean.esmsentity.mairemssn == null) {
        _tabController.animateTo(9);
        _showAlert("Air Emissions Y/N", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.mwastewater == "" || custListBean.esmsentity.mwastewater == null) {
        _tabController.animateTo(9);
        _showAlert("Waste Water Y/N", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.msolidnhrdauswaste == "" || custListBean.esmsentity.msolidnhrdauswaste == null) {
        _tabController.animateTo(9);
        _showAlert("Solid and Hazardous Wastes Y/N", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.mhrdzchemnfule == "" || custListBean.esmsentity.mhrdzchemnfule == null) {
        _tabController.animateTo(9);
        _showAlert("Hazardous chemicals, fuels, and pesticides Y/N", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.mrescnsmpt == "" || custListBean.esmsentity.mrescnsmpt == null) {
        _tabController.animateTo(9);
        _showAlert("Resource Consumption  Y/N", "Field is mandatory");
        return false;
      }
      if (custListBean.esmsentity.mnuisance == "" || custListBean.esmsentity.mnuisance == null) {
        _tabController.animateTo(9);
        _showAlert("Nuisance Y/N", "Field is mandatory");
        return false;
      }
    }*/








    /* if (custListBean.imageMaster[12].imgString == null || custListBean.imageMaster[12].imgString == ""){
      _tabController.animateTo(10);
      _showAlert("Spouse Signature", "This field is Mandatory");
      return false;
    }*/


    return true;
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

  success(String message, BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  custListBean = new CustomerListBean();
                  addressBean = new AddressDetailsBean();
                  fdb = new FamilyDetailsBean();
                  sfb=new SocialFinancialDetailsBean();
                  borrowingDetailsBean = new BorrowingDetailsBean();
                  cbdb = new CustomerBusinessDetailsBean();
                  busiExpnBean = new BusinessExpenditureDetailsBean();
                  hhExpnBean = new HouseholdExpenditureDetailsBean();
                  applicantDob = "__-__-____";
                  loanDate = "__-__-____";
                  famDob = "__-__-____";
                  repaymentDate = "__-__-____";
                  EmpFromDate = "__-__-____";
                  EmpToDate = "__-__-____";
                  EmpDateOfImcorp= "__-__-____";
                  husDob = "__-__-____";
                  id1IssueDate ="__-__-____";
                  id1ExpDate ="__-__-____";
                  id2IssueDate ="__-__-____";
                  id2ExpDate ="__-__-____";
                  id3IssueDate ="__-__-____";
                  id3ExpDate ="__-__-____";
                  personalInfoRadios = new List<int>(5);
                  socialFinancialRadios = new List<int>(3);
                  businessDetailRadios = new List<int>(4);
                  businessCashFlowRadios = new List<int>(12);
                  familyDependantRadio = new List<int>(4);
                  socialFinancialRadios= new List<int>(1);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new HomeDashboard()), //When Authorized Navigate to the next screen
                  );
                },
              ),
            ],
          );
        });
  }
/*

  bool validateFamilyMaxLength(FamilyDetailsBean familyDetailsBean,int position) {
    String error = null;
    Utility ut = new Utility();
    if(familyDetailsBean.mname!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.mname, 50);
      maxLengthExceedFieldName="${Constant.errorFamName } ${position}";
    }
    if(familyDetailsBean.mnicno!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.mnicno, 25);
      maxLengthExceedFieldName="${Constant.errorFamNIC } ${position}";
    }
    if(familyDetailsBean.mage!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.mage.toString(), 2);
      maxLengthExceedFieldName="${Constant.errorFamAge } ${position}";
    }
    if(familyDetailsBean.meducation!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.meducation, 15);
      maxLengthExceedFieldName="${Constant.errorFamEducation } ${position}";
    }
    if(familyDetailsBean.mmemberno!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.mmemberno, 30);
      maxLengthExceedFieldName="${Constant.errorFammemberNumber } ${position}";
    }
    if(familyDetailsBean.moccuptype!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.moccuptype.toString(), 4);
      maxLengthExceedFieldName="${Constant.errorFamEducation } ${position}, System issue";
    }
    if(familyDetailsBean.mrelationwithcust!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.mrelationwithcust, 3);
      maxLengthExceedFieldName="${Constant.errorFamRelationship } ${position}, System issue";
    }

    if(familyDetailsBean.maritalstatus!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.maritalstatus.toString(), 2);
      maxLengthExceedFieldName="${Constant.errorFamMarrital } ${position}";
    }
    if(familyDetailsBean.macidntlinsurance!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.macidntlinsurance.toString(), 1);
      maxLengthExceedFieldName="${Constant.errorFamAccidential } ${position}";
    }
    if(familyDetailsBean.mnomineeyn!=null) {
      error = ut.validateLengthToMatchMiddleware(
          familyDetailsBean.mnomineeyn, 1);
      maxLengthExceedFieldName="${Constant.errorFamNominee } ${position}";
    }
    if (error !=null) {
      globError= error;
      return false;
    }
    return true;
  }


  bool validateAddressMaxLength(AddressDetailsBean addressDetailsBean,int position) {
    String error = null;

    Utility ut = new Utility();
    if(addressDetailsBean.maddrType!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.maddrType.toString(), 2);
      maxLengthExceedFieldName="${Constant.errorFamName } ${position}";
    }
    if(addressDetailsBean.maddr1!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.maddr1, 50);
      maxLengthExceedFieldName="${Constant.errorAddr1 } ${position}";
    }
    if(addressDetailsBean.maddr2!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.maddr2, 50);
      maxLengthExceedFieldName="${Constant.errorAddr2 } ${position}";
    }
    if(addressDetailsBean.maddr3!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.maddr3, 30);
      maxLengthExceedFieldName="${Constant.errorAddr3 } ${position}";
    }
    if(addressDetailsBean.mpinCd!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mpinCd.toString(), 8);
      maxLengthExceedFieldName="${Constant.errorPinCd } ${position}";
    }
    if(addressDetailsBean.mtel1!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mtel1.toString(), 15);
      maxLengthExceedFieldName="${Constant.errorTel1 } ${position}, System issue";
    }
    if(addressDetailsBean.mtel2!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mtel2, 15);
      maxLengthExceedFieldName="${Constant.errorTel1 } ${position}, System issue";
    }
    if(addressDetailsBean.mcityCd!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mcityCd.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorCityCd } ${position}";
    }
    if(addressDetailsBean.mfax1!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mfax1.toString(), 15);
      maxLengthExceedFieldName="${Constant.errorFax1 } ${position}";
    }
    if(addressDetailsBean.mfax2!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mfax2, 15);
      maxLengthExceedFieldName="${Constant.errorFax2 } ${position}";
    }
    if(addressDetailsBean.mcountryCd!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mcountryCd, 3);
      maxLengthExceedFieldName="${Constant.errorContCD } ${position}";
    }
    if(addressDetailsBean.marea!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.marea.toString(), 9);
      maxLengthExceedFieldName="${Constant.errorArea } ${position}";
    }
    if(addressDetailsBean.mHouseType!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mHouseType.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorHouseType } ${position}";
    }
    if(addressDetailsBean.mRoofCond!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mRoofCond.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorRoofCont } ${position}";
    }
    if(addressDetailsBean.mUtils!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mUtils.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorUtils } ${position}";
    }
    if(addressDetailsBean.mAreaType!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mAreaType.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorAreaType } ${position}";
    }
    if(addressDetailsBean.mLandmark!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mLandmark, 80);
      maxLengthExceedFieldName="${Constant.errorLandmark } ${position}";
    }
    if(addressDetailsBean.mState!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mState, 3);
      maxLengthExceedFieldName="${Constant.errorState } ${position}";
    }
    if(addressDetailsBean.mYearStay!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mYearStay.toString(), 3);
      maxLengthExceedFieldName="${Constant.errorYearStay } ${position}";
    }
    if(addressDetailsBean.mWardNo!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mWardNo, 6);
      maxLengthExceedFieldName="${Constant.errorWardNo } ${position}";
    }
    if(addressDetailsBean.mMobile!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mMobile, 15);
      maxLengthExceedFieldName="${Constant.errorMobile} ${position}";
    }
    if(addressDetailsBean.mEmail!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mEmail, 35);
      maxLengthExceedFieldName="${Constant.errorFax2 } ${position}";
    }
    if(addressDetailsBean.mPattaName!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mPattaName, 30);
      maxLengthExceedFieldName="${Constant.errorFax2 } ${position}";
    }
    if(addressDetailsBean.mRelationship!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mRelationship, 30);
      maxLengthExceedFieldName="${Constant.errorFax2 } ${position}";
    }
    if(addressDetailsBean.mSourceOfDep!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mSourceOfDep.toString(), 2);
      maxLengthExceedFieldName="${Constant.errorSourceOfDep } ${position}";
    }
    if(addressDetailsBean.mToietYN!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mToietYN, 1);
      maxLengthExceedFieldName="${Constant.errorToietYN } ${position}";
    }
    if(addressDetailsBean.mNoOfRooms!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mNoOfRooms.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorNorooms } ${position}";
    }
    if(addressDetailsBean.mSpouseYearsStay!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mSpouseYearsStay.toString(), 3);
      maxLengthExceedFieldName="${Constant.errorSpouseYearsStay } ${position}";
    }
    if(addressDetailsBean.mDistCd!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mDistCd.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorFax2 } ${position}";
    }
    if(addressDetailsBean.mvillage!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mvillage.toString(), 6);
      maxLengthExceedFieldName="${Constant.errorvillage } ${position}";
    }
    if(addressDetailsBean.mCookFuel!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mCookFuel.toString(), 2);
      maxLengthExceedFieldName="${Constant.errorCookFuel } ${position}";
    }
    if(addressDetailsBean.mSecMobile!=null) {
      error = ut.validateLengthToMatchMiddleware(
          addressDetailsBean.mSecMobile, 15);
      maxLengthExceedFieldName="${Constant.errorSecMobile} ${position}";
    }
    if (error !=null) {
      globError= error;
      return false;
    }
    return true;
  }



  bool validateBorroMaxLength(BorrowingDetailsBean borrowingDetailsBean,int position) {
    String error = null;
    Utility ut = new Utility();
    if(borrowingDetailsBean.mnameofborrower!=null) {
      error = ut.validateLengthToMatchMiddleware(
          borrowingDetailsBean.mnameofborrower, 50);
      maxLengthExceedFieldName="${Constant.errorBorrName } ${position}";
    }
    if(borrowingDetailsBean.msource!=null) {
      error = ut.validateLengthToMatchMiddleware(
          borrowingDetailsBean.msource,50);
      maxLengthExceedFieldName="${Constant.errorBorrSource } ${position}";
    }
    if(borrowingDetailsBean.mpurpose!=null) {
      error = ut.validateLengthToMatchMiddleware(
          borrowingDetailsBean.mpurpose.toString(), 50);
      maxLengthExceedFieldName="${Constant.errorBorrPurpose } ${position}";
    }
    if(borrowingDetailsBean.mmemberno!=null) {
      error = ut.validateLengthToMatchMiddleware(
          borrowingDetailsBean.mmemberno.toString(), 30);
      maxLengthExceedFieldName="${Constant.errorBorrMemberNo } ${position}";
    }
    if(borrowingDetailsBean.mloancycle!=null) {
      error = ut.validateLengthToMatchMiddleware(
          borrowingDetailsBean.mloancycle.toString(), 2);
      maxLengthExceedFieldName="${Constant.errorBorrmemberLoanCycle } ${position}";
    }

    if (error !=null) {
      globError= error;
      return false;
    }
    return true;
  }*/
}
