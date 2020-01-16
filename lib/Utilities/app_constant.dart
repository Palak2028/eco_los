import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/main.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';
import 'package:eco_los/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/Bean/SettingsBean.dart';
import 'package:permission/permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;


const double PADDING_TINY = 2.0;
const double PADDING_VERY_SMALL = 4.0;
const double PADDING_SMALL = 8.0;
const double PADDING_MEDIUM = 16.0;
const double PADDING_LARGE = 24.0;
const double PADDING_VERY_LARGE = 32.0;

const double FONT_VERY_SMALL = 4.0;
const double FONT_SMALL = 8.0;
const double FONT_MEDIUM = 16.0;
const double FONT_LARGE = 24.0;
const double FONT_VERY_LARGE = 32.0;

//For Task Row
const double FONT_SIZE_TITLE = 16.0;
const double FONT_SIZE_LABEL = 14.0;
const double FONT_SIZE_DATE = 12.0;

const String TWITTER_URL = " ";
const String FACEBOOK_URL = " ";
const String GITHUB_URL = " ";
const String PROJECT_URL = " ";
const String ISSUE_URL = " ";
const String README_URL = " ";
const String EMAIL_URL = " ";
const String captionValue = "Purpose of loan";
//loan COllection

/*const String BRANCH = "डाली";
const String ISINDIVIDUAL = "IBL";
const String LOANOFFICER = "ऋण अधिकारी";
const String CENTERID = "केंद्र आईडी";
const String GROUPID = "समूह आईडी";
const String CUSTOMERNUMBER = "ग्राहक संख्या";
const String PRODUCTS = "उत्पाद";*/
const String BRANCH = "Branch";
const String ISINDIVIDUAL = "IBL";
const String LOANOFFICER = "Loan Officer";
const String CENTERID = "Center Id";
const String GROUPID = "Group Id";
const String CUSTOMERNUMBER = "Customer Number";
const String PRODUCTS = "Product";
const String fromDate = "From Date";
const String toDate = "To Date";
const String PAGESCOUNT = "Page Count Of Collection";
const String ENTERPAGESCOUNT = "Enter Page Count Of Collection";

//Credit BereauCallSubmission
//lebelText
const  String trefNo ="Reference No";
const  String queueNo ="Queue No";
const  String scanUIDQRHere ="Scan UID QR here";
const  String scannedUIDQRName ="Applicant Name";
const String scanUIDQRHouse = "Applicant House No";
const String scanUIDQstreet = "Applicant Street";
const String scannedUIDCity = "Applicant City";
const String scannedUIDState ="ApplicantState";
const String scannedUIDPincode = "Applicant Pincode";
const String selectDOB = "Select DOB";
const String contactNo ="Contact No";
const String enterOTP = "Enter OTP";
const String enterSpouseNameHere = "Enter Spouse Name Here";
const String enterNomineeHere = "Enter Nominee Here";
const String enterBranchId = "Enter Branch Id";
const String enterMemberId="Enter Member Id";
const String enterApplicantID2Here="Enter Applicant ID 2 here";
const String enterCreditRequestTypeHere="Enter Credit Request Type Here";
const String creditReportTransactionIDHere="Credit Report Transaction ID Here";
const String creditInquiryPurposeTypeHere="Credit Inquiry Purpose Type Here";
const String creditInquiryStageHere="credit Inquiry Stage Here";
const String creditReportTransactionDateTypeHere="Credit Report Transaction Date Type Here";
//hintText
const  String htrefNo ="Enter Tref Here ";
const  String scanUIDQR ="Scan UID QR";
const  String applicantName ="Applicant Name";
const  String houseNumber ="Applicant House No";
const String street="Applicant Street";
const  String applicantCity ="Applicant City";
const String applicantState ="Applicant State";
const String applicantPincode = "Applicant Pincode";
const String dateOfBirth="Date Of Birth";
const String OTP1="OTP";
const String spouseName="Spouse Name";
const String nomineeName = "Nominee Name";
const String nomineeRelation = "Nominee Relationship";

const String branchId="Branch Id";
const String memberId="Member Id";
const String applicantID2="Applicant ID 2";


//passwordChange

const String  userCode = "userCode";

//HighMark
const String creditRequestType="Credit Request Type";
const String creditReportTransactionID="Credit Report Transaction ID";
const String creditInquiryPurposeType="Credit Inquiry Purpose Type";
const String creditInquiryStage="credit Inquiry Stage";
const String creditReportTransactionDateType="Credit Report Transaction Date Type";


//product
const String highmarkUrl = "https://hub.crifhighmark.com/Inquiry/doGet.service/requestResponse";
const String highmarkUserId="chmprod@saija.in";
const String highmarkPass="2B751AC20331A7CF2C502136A9C6E62DC0E6F7A9";





//NOC Approval

const String noLoansFound="No Loans Found";
const String nameOfMFI="Name Of MFI";
const String balance="Balance";
const String status="Status";
const String expAmt="Exp Amt";
const String details="Details";
const String result="Result";
const String mfiOd="MFI OD";
const String odAcounts="OD Acounts";
const String mfiCurrBal="MFI Curr Bal";



//demo
/*
const String highmarkUrl = "https://test.crifhighmark.com/Inquiry/doGet.service/requestResponse";
const String highmarkUserId="chmuat@saija.in";
const String highmarkPass="ACA9F2284300A98B40524076DDA38290BEE3DDDF";
*/


const String creditRequestTypeVal="JOIN";
const String creditReportTransactionIDVal="Required";
const String creditInquiryPurposeTypeVal="ACCT-ORIG";
const String creditInquiryStageVal="PRE-DISB";
const String mfiId="MFI0000056";
const String subMbrId ="SAIJA";
const String productType="INDV";
const String productVersion="1.0";


const String searchList="Confirm Search";
const String viewList="View";




//prefixText
const String mobNoPrefix="+91";


//loan details

const String maxAmountApply = 'Max Amount Can Apply';
const String maxInstApply = 'Max Installment Can Apply';


//Button
const String bScanQR="Scan UID QR";
const String bGenerateOtp="Generate OTP";
const String bResendOtp="Resend OTP";
const String bVerify="Verify";

//Scaffold Messages
const String generateOTPfirst="Generate an OTP first";
const String entrVldNum="Enter a valid number";
const String bankName="Bank Name";


class Constant{
/*static String apiURL = "http://115.248.230.170:8090/";
static String myPublicURL = "http://115.248.230.170:8090/";
static String myPrivateURL = "http://115.248.230.170:8090/";*/



/*  static String apiURL = "http://14.141.164.239:8090/";
  static String myPublicURL = "http://14.141.164.238:8090/";
  static String myPrivateURL = "http://172.25.3.44:8090/";*/
  //static String apiURL = "http://115.248.230.170:8090/";//common m/c

/*  //Saija UAT
  static String apiURL = "http://223.31.12.91:8090/";
  static String myPublicURL = "http://223.31.12.91:8090/";
  static String myPrivateURL = "http://223.31.12.91:8090/";*/

  // Development Environment
/*  static String apiURL = "http://115.248.230.170:8090/";
  static String myPublicURL = "http://115.248.230.170:8090/";
  static String myPrivateURL = "http://115.248.230.170:8090/";*/
// new Development Environment
/*

static String apiURL = "http://14.141.164.236:8090/";
  static String myPublicURL = "http://14.141.164.236:8090/";
  static String myPrivateURL = "http://14.141.164.236:8090/";
*/

  /*//wasasa local ip not public
  static String apiURL = "http://172.31.1.29:8090/";
  static String myPublicURL = "http://172.31.1.29:8090/";
  static String myPrivateURL = "http://172.31.1.29:8090/";*/

  //Saija Production
  //static String apiURL = "http://104.211.159.5:8090/";
  //static String myPublicURL = "http://104.211.159.5:8090/";
  //static String myPrivateURL = "http://104.211.159.5:8090/";

  static String apiURL = "https://103.239.53.162";
  static String myPublicURL = "https://103.239.53.162";
  //static String myPrivateURL = "http://103.239.53.162";

  static bool isHttpsCallNeeded =false;

  static int mngrGrpCode = 33;
  static int foGrpCode = 22;
  static Color mandatoryColor  = Colors.grey[300];
  static Color calculatedColor  = Colors.orange[100];
  static Color readonlyColor  = Colors.black12;
  static Color semiMandatoryColor  = Colors.grey[300];

//GridWorkflow AppPermissions
  static  List<int> prospectCreationMenu=[22];
  static  List<int> nocAprovalMenu=[14];


//Syncing Activity Menu
  // Function Permission
  static  List<int> syncCenter=[22];
  static  List<int> syncGroup=[22];
  static  List<int> syncLookups=[22];
  static  List<int> syncInterestSlab=[22];
  static  List<int> syncInterestOffset=[22];
  static  List<int> syncLoanCycleParameterPrimary=[22];
  static  List<int> syncLoanCycleParameterSecondary=[22];
  static List<int> syncDailyCollection=[22];





  static  List<int> syncSubLookups=[22];
  static  List<int> syncProduct=[22];
  static  List<int> syncPurpose=[22];
  static  List<int> uploadNOCCheckRes=[14,13];
  static  List<int> syncProspect=[22,14,13];
  static  List<int> syncCustomer=[22,14,13];
  static  List<int> syncLoanDetails=[22,14,13];
  static  List<int> syncCGT1=[22,14,13];
  static  List<int> syncCGT2=[22,14,13];
  static  List<int> syncGRT=[14,13];
  static  List<int> getNOCPendingData=[14];
  static  List<int> getNOCCheckResult=[22];
  static  List<int> getWorkingLoan=[22];
  static  List<int> getWorkingCustomer=[22];
  static  List<int> getAllProspectData=[22,14];
  static  List<int> syncSystemParameter=[22,14];


  //Scaffold Messages
  static String gettingWorkingLoans = "Getting working Loans";
  static String gettingWorkingCustomer = "Getting Working Customer";
  static String gettingSavingsList = "Getting Savings List";

  static String gettingNOCPendingData = "Getting NOC Pending Data";
  static String gettingNOCCheckResult = "Getting NOC Check Result";
  static String syncingSubLookup = "Syncing Sub Lookup";
  static String syncingProduct = "Syncing Product";
  static String syncingCGT1 = "Syncing CGT 1";
  static String syncingCGT2 = "Syncing CGT 2";
  static String syncingProspect = "Syncing Prospect";
  static String syncingLookups= "Syncing Lookups";
  static String syncingInterestSlab= "Syncing Interest Slab";
  static String syncingInterestOffset= "Syncing Interest Offset";
  static String syncingLoanCycleParameterPrimary= "Syncing Loan Cycle Parameter Primary ";
  static String syncingLoanCycleParameterSecondary= "Syncing Loan Cycle Parameter Secondary ";
  static String syncingDailyCollection="Syncing Daily Collection";
  static String syncingTDRoiTables = "Syncing TD R.O.I Tables";
  static String syncingLoanApprovalLimit="Syncing Loan Approval Limit";
  static String syncingBranch = "Syncing BranchMaster";

  static String syncHbsUsers = "Syncing Hbs Users";



  static String gettingALLProspect= "Getting ALL Prospect";
  static String syncingAddress = "Syncing Address";
  static String  noGroups ="No groups assigned to selected center";


  //labels
  static String syncCenterlab = "Sync Center";
  static String syncedgrouplab = "Sync group";
  static String syncedLookupsLab = "Synced Lookups";
  static String syncedInterestSlabLab = "Sync Interest Slab";
  static String syncedInterestOffsetLab = "Sync Interest Offset ";
  static String syncedLoanCycleParameterPrimaryLab="Sync Loan Cycle Parameter Primary";
  static String syncedLoanCycleSecondaryPrimaryLab="Sync Loan Cycle Secondary Primary";
  static String syncedDailyCollection="Sync Daily Collection";
  static String syncingSystemParameter="Syncing System Parameter";



  static String syncSubLookupLab = "Sync Sub Lookup";
  static String syncProductLab = "Sync Product";
  static String syncToServerLab = "Sync To Server";
  static String syncProspectLab = "Sync Prospect";
  static String syncCustomerLoanAsLeadLab = "Sync Lead";
  static String syncSavingsLab = "Sync Savings";
  static String syncGuarantorLab = "Sync Guarantor";

  static String syncLoanUtilization = "Sync Loan Utilization";
  static String syncBranchLab = "Sync Branch";
  static String syncSavingsCollectionLab="Sync Savings Collection";

  static String syncLoanDetailsLab = "Sync Loan Details And Approval Process";
  static String syncCGT1Lab = "Sync CGT1";
  static String syncCGT2Lab = "Sync CGT 2";
  static String syncGRTLab = "Sync GRT";
  static String uploadNOCCheckResultLab = "Upload NOC Check Result";
  static String getNOCPendingDataLab = "Get NOC Pending Data";
  static String getNOCCheckResultLab = "Get NOC Check result";
  static String getWorkingLoanLab = "Sync to Get Your working  Loan";
  static String getWorkingCustomersLab = "Sync To get your working customers";
  static String getAllSavingsListLab = "Sync To get All Savings List";

  static String getFromCenterId = "Sync Customer from center id";

  static String syncFromServerLab = "Sync From server";
  static String getAllProspectDataLab = "Get All Prospect Data";
  static String syncAddress = "Sync Address";
  static String syncedSystemParameterLab = 'sync System Parameter';
  static String getDailyCollectionData = 'Get Daily Collection Data';
  static String syncDailyLoanCollected = "Sync Daily Loan collected";
  static String syncedTdROI = 'Sync TD Productwise and Offset';



  //labels for FPS
  static String label_biometric_scan = "Biometric Scan";
  static String label_please_select_rt_hand_fngr = "Please select fingers of your Right hand for scannning";
  static String label_please_select_lt_hand_fngr = "Please select fingers of your Left hand for scannning";
  static String label_thumb_finger = "Thumb";
  static String label_please_select_fngr = "Please select two fingers of your Left hand for scannning";
  static String label_index_finger = "Index Finger";
  static String label_middle_finger = "Middle Finger";
  static String label_ring_finger = "Ring Finger";
  static String label_pinky_finger = "Pinky Finger";





  //CustomerPersonalInfo
  static String applicantDOB = "Applicant Date Of Birth";
  static String husDob = "Spouse Date Of Birth";






  //CustomerFormationLoanDetails
  static String loanDate = "Loan Date";
  static String repaymentDate = "Repayment Date";
  static String loandisbdt = "Tentitive Disbursement Date";
  static String loaninstStrtDt = "Tentitive Installment Start Date";



  //errors for customer
  static String errorMaxExceedChar = "Field must Not have more than";
  static String errorChar = "charater";

  //family
  static String errorFamName = "Family member name on grid position";
  static String errorFamNIC = "Family member NIC on grid position";
  static String errorFamAge = "Family member Age on grid position";
  static String errorFamEducation = "System issue!! Family member Education on grid position ";
  static String errorFammemberNumber = "Family member Number on grid position";
  static String errorFamOccupation = "System issue!! Family member Occupation type on grid position ";
  static String errorFamRelationship = "System issue!! Family member Relationship on grid position";
  static String errorFamMarrital = "Family member Marrital status on grid position";
  static String errorFamAccidential = "Family member Accidential insurance on grid position";
  static String errorFamNominee = "Family member Dependent on grid position";


  //Address
  static String errorAddrType = "Address Type name on grid position";
  static String errorAddr1 = "Address Line 1  on grid position";
  static String errorAddr2 = "Address Line 2 on grid position";
  static String errorAddr3 = "Address Line 3 on grid position ";
  static String errorPinCd = "Pin Code on grid position";
  static String errorTel1 = "Tel1 on grid position ";
  static String errorTel2 = "Tel2 on grid position";
  static String errorCityCd = "City Code on grid position";
  static String errorFax1 = "Fax 1 on grid position";
  static String errorFax2 = "Fax 2 on grid position";
  static String errorContCD = "Country Code on grid position";
  static String errorArea = "Area on grid position";
  static String errorHouseType = "HouseType on grid position";
  static String errorRntLeasAmt = "Rent Leas Amount on grid position";
  static String errorRntLeasDep = "Rent Leas Dep on grid position";
  static String errorRntLeasExp = "Rent Leas Exp on grid position";
  static String errorRoofCont = "Roof Cont on grid position";
  static String errorUtils = "Utils on grid position";
  static String errorAreaType = "AreaType on grid position";
  static String errorLandmark = "Landmark on grid position";
  static String errorState = "State on grid position";
  static String errorYearStay = "YearStay on grid position";
  static String errorWardNo = "WardNo on grid position";
  static String errorMobile = "Mobile on grid position";
  static String errorEmail = "Email on grid position";
  static String errorPattaName = "PattaName on grid position";
  static String errorRelationship = "Relationship on grid position";
  static String errorSourceOfDep = "SourceOfDep on grid position";
  static String errorInstAmount = "InstAmount on grid position";
  static String errorToietYN = "Toilet on grid position";
  static String errorNorooms = "No Of rooms on grid position";
  static String errorSpouseYearsStay = "SpouseYearsStay on grid position";

  static String errorDistCd = "DistCd on grid position";
  static String errorvillage = "Village on grid position";
  static String errorCookFuel = "CookFuel on grid position";
  static String errorSecMobile = "SecMobile on grid position";

//borrowing details

  static String errorBorrName = "Borrowing Details name on grid position";
  static String errorBorrSource = "Borrowing Details source on grid position";
  static String errorBorrPurpose = "Borrowing Details Purpose on grid position";
  static String errorBorrMemberNo = " Borrowing Details MemberNo on grid position ";
  static String errorBorrmemberLoanCycle = "Borrowing Details LoanCycle on grid position";


  //collection
  //label
  static String productNameNo = "Product Name / No";
  static String centerNameNo = "Cutomer Name/No";
  static String accountNo = "Acc No";
  static String paidByGrp = "Paid By Group";
  static String adjFrmSD = "From SD";
  static String adjFrmExcs = "From Excess";
  static String attendence = "Attendence";
  static String paid = "Paid";



  static String chkExstngCustIp = "/customerData/getCustomerbyID/";

  //Term Deposit
  static String certificateDate = "Certificate Date";
  static String tenure = "Tenure: ";
  static String appBarLabelNewTermDeposit = "New Term Deposit";
  static String labelCustName = "Cutomer Name/No";
  static String labelProdName = "Product Name/No";
  static String labelMaturityDate = "Maturity Date";
  static String labelRateOfInterest = "Rate of Interest";
  static String labelModeOfPayout = "Mode of Payout";
  static String labelAccountNo = "Accout No :";




  //putting everything in constant

  static String somethingWentWrong= "Something went wrong";
  static String error="Error";
  static String loginPage="LoginPage";
  static String trefno="Trefno : ";
  /* static String loginPage="LoginPage";
  static String loginPage="LoginPage";
  static String loginPage="LoginPage";*/

  //Guarantor
  static String dateOfBirth="Date Of Birth";


  static var SMSVerURL = 'https://api.textlocal.in/send/?';
  static String otpMessage = "This is your OTP from Bank Please verify same to customer";

  //NEW BUSINESS SCREENS FOR CUSTOMER
  static String showAssets = "Balance Sheet";

  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";

  static String  getProspectStatus(int prospectStatus){
    if(prospectStatus == 0)return "CB Check Pending";
    else if(prospectStatus == 1)return "CB Checked";
    else if(prospectStatus == 2)return "Pass";
    else if(prospectStatus == 3)return "Fail";
    else if(prospectStatus == 4)return "NOC Pending";
    /* else if(prospectStatus == 4)return "NOC Pending";
   else if(prospectStatus == 4)return "NOC Pending";*/
    else if(prospectStatus == 5)return "NOC Rejected";
    else if(prospectStatus == 6)return "NOC Verified";
    else if(prospectStatus == 7)return "Customer Created";
    else if(prospectStatus == 8)return "Loan Creted";
    else if(prospectStatus == 9)return "CGT 1 Done";
    else if(prospectStatus == 10)return "CGT 2 Done";
    else if(prospectStatus == 11)return "Loan Disbursed";


  }



  static String  getLoanStatus(int loanStatus){
    if(loanStatus == 1)return "New";
    else if(loanStatus == 5)return "CGT1";
    else if(loanStatus == 6)return "CGT2";
    else if(loanStatus == 7)return "GRT Approved";
    else if(loanStatus == 99)return "GRT Rejected";
    else return "";
  }

  static String  getSavingsAccountStatus(int savingsStatus){
    if(savingsStatus == 1)return "Normal/Operative";
    else if(savingsStatus == 2)return "New";
    else if(savingsStatus == 3)return "Closed";
    else if(savingsStatus == 14)return "WrittenOff";
    else if(savingsStatus == 11)return "NPA";
    else return "";
  }

  Future<Null>  getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch = prefs.get(TablesColumnFile.musrbrcode).toString();
    username = prefs.getString(TablesColumnFile.usrCode);
    usrRole = prefs.getString(TablesColumnFile.usrDesignation);
    usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
    loginTime = prefs.getString(TablesColumnFile.LoginTime);
    geoLocation = prefs.getString(TablesColumnFile.geoLocation);
    geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
    geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();


  }

  static Future<Null> setVer()async{
    try {

      globals.version = await GetVersion.projectVersion;
      // globals.version = await GetVersion.projectVersion;
      print("aagya kya apk globals"+ globals.version.toString());
    } on PlatformException {
      globals.version = 'Failed to get project version.';
    }
  }


  static getPermissionStatus() async {
    get = '';
    List<Permissions> permissions = await Permission.getPermissionsStatus([
      PermissionName.Calendar,
      PermissionName.Camera,
      PermissionName.Contacts,
      PermissionName.Location,
      PermissionName.Microphone,
      PermissionName.Phone,
      PermissionName.Sensors,
      PermissionName.SMS,
      PermissionName.Storage,
    ]);
    permissions.forEach((permission) {
      get += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    ;
    print(get);
  }

  static requestPermissions() async {
    final res = await Permission.requestPermissions([
      PermissionName.Calendar,
      PermissionName.Camera,
      PermissionName.Contacts,
      PermissionName.Location,
      PermissionName.Microphone,
      PermissionName.Phone,
      PermissionName.Sensors,
      PermissionName.SMS,
      PermissionName.Storage
    ]);
    res.forEach((permission) {});
  }


  static generateUrl()async{
    print("data of on value Api Url");
    await  AppDatabase.get().getApiUrl().then((onValue){
      print(onValue.length.toString());
      for(int settingsList = 0;settingsList<onValue.length;settingsList++){
        print("data of on value Api Url" + onValue[settingsList].mipaddress);
        settingsBean = new SettingsBean();
        settingsBean.musrcode = onValue[settingsList].musrcode;
        settingsBean.musrpass = onValue[settingsList].musrpass ;
        settingsBean.mipaddress = onValue[settingsList].mipaddress ;
        settingsBean.mportno = onValue[settingsList].mportno ;
        settingsBean.isHttps = onValue[settingsList].isHttps ;
        settingsBean.isPortRequired = onValue[settingsList].isPortRequired ;
        //TODO take request type from system params table eg(http/https)
        //Constant.apiURL = "http://"+settingsBean.mipaddress.toString()+":"+settingsBean.mportno.toString()+"/";
        //TODO take request type from system params table eg(http/https)
        Constant.isHttpsCallNeeded = settingsBean.isHttps==1? true : false;
        String isHttpsVal = "${settingsBean.isHttps==1? "https://" : "http://"}";
        String isPortRequiredVal = "${settingsBean.isPortRequired==1? "" :":${settingsBean.mportno}" }";

        Constant.apiURL = isHttpsVal+settingsBean.mipaddress.toString()+isPortRequiredVal+"/";
        //Constant.apiURL = isHttpsVal+settingsBean.mipaddress.toString()+":"+settingsBean.mportno.toString()+"/";
        //Constant.apiURL = "https://"+settingsBean.mipaddress.toString()+"/";
        print( Constant.apiURL.toString()+" jhsjahsashhasjajh");
        //  globals.dropdownCaptionsValuesPersonalInfo[1].add(bean);
      }
    });

  }




  static getDropDownInitialize()async{

//prospect

//nominee relationship
    await  AppDatabase.get().getLookupDataFromLocalDb(909009).then((onValue){
      globals.dropdownCaptionsValuesProspectInf[0].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesProspectInf[0].add(bean);

      }
    });

    //documentId id type 2
    await  AppDatabase.get().getLookupDataFromLocalDb(909066).then((onValue){
      globals.dropdownCaptionsValuesProspectInf[1].clear();
      globals.dropdownCaptionsValuesKyc[1].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesProspectInf[1].add(bean);
        globals.dropdownCaptionsValuesKyc[1].add(bean);
      }
    });


    //documentId id type 3
    await  AppDatabase.get().getLookupDataFromLocalDb(909067).then((onValue){

      globals.dropdownCaptionsValuesKyc[2].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;

        globals.dropdownCaptionsValuesKyc[2].add(bean);
      }
    });
//social financial
    await  AppDatabase.get().getLookupDataFromLocalDb(909003).then((onValue){
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[0].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[0].add(bean);


        /*LookUpDescriptionValueObj lookup = new LookUpDescriptionValueObj();
      Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[0].add(map);*/
      }
    });
    //if yes the
    await  AppDatabase.get().getLookupDataFromLocalDb(909015).then((onValue){
      globals.dropdownCaptionsValuesFamilyDetails[1].clear();
      globals.dropdownCaptionsValuesFamilyDetails[5].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        //globals.dropdownCaptionsValuesPersonalInfo[0].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[1].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[5].add(bean);
      }
    });

//mdesignation
    await  AppDatabase.get().getLookupDataFromLocalDb(4093).then((onValue){
      globals.dropdownCaptionsValuesFamilyDetails[6].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesFamilyDetails[6].add(bean);
      }
    });

    //relegion
    await  AppDatabase.get().getLookupDataFromLocalDb(1132).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[1].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[1].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1063).then((onValue){//frequency
      globals.dropdownCaptionsValuesSavingsListInfo[1].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesSavingsListInfo[1].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(1057).then((onValue){//purpose of loan
      globals.dropdownCaptionsValuesSavingsListInfo[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesSavingsListInfo[0].add(bean);
      }
    });

    //is married
    await  AppDatabase.get().getLookupDataFromLocalDb(1154).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[2].clear();
      globals.dropdownCaptionsValuesFamilyDetails[3].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[2].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[3].add(bean);
      }
    });

    //is educated
    await  AppDatabase.get().getLookupDataFromLocalDb(1159).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[3].clear();
      globals.dropdownCaptionsValuesFamilyDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[3].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[0].add(bean);
      }
    });

    //socical fin bank detatils
    await  AppDatabase.get().getLookupDataFromLocalDb(120001).then((onValue){
      globals.dropdownCaptionsValuesSocialFinDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesSocialFinDetails[0].add(bean);
      }
    });
    //occupation
    await  AppDatabase.get().getLookupDataFromLocalDb(42034).then((onValue){
      globals.dropdownCaptionsValuesFamilyDetails[2].clear();
      globals.dropdownCaptionsValuesPersonalInfo[4].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesFamilyDetails[2].add(bean);
        globals.dropdownCaptionsValuesPersonalInfo[4].add(bean);
      }
    });



    //secondary occupation and is occupation
    await  AppDatabase.get().getLookupDataFromLocalDb(909011).then((onValue){

      globals.dropdownCaptionsValuesPersonalInfo[7].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[7].add(bean);
      }
    });

    //Title
    await  AppDatabase.get().getLookupDataFromLocalDb(1059).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[6].clear();
      globals.dropdownCaptionsValuesFamilyDetails[4].clear();
      globals.dropdownCaptionsValuesCollateralsInfo[2].clear();
      globals.dropDownCaptionValuesCollateralREMlandandhouse[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[6].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[4].add(bean);
        globals.dropdownCaptionsValuesCollateralsInfo[2].add(bean);
        globals.dropDownCaptionValuesCollateralREMlandandhouse[0].add(bean);
      }
    });


    //size of property
    await  AppDatabase.get().getLookupDataFromLocalDb(2211).then((onValue){
      globals.dropDownCaptionValuesCollateralREMlandandhouse[4].clear();
      globals.dropDownCaptionValuesCollateralREMlandandbuilding[0].clear();
      globals.dropDownCaptionValuesCollateralREMlandandbuilding[1].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCollateralREMlandandhouse[4].add(bean);
        globals.dropDownCaptionValuesCollateralREMlandandbuilding[0].add(bean);
        globals.dropDownCaptionValuesCollateralREMlandandbuilding[1].add(bean);
      }
    });




    //Region
    await  AppDatabase.get().getLookupDataFromLocalDb(11390).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[5].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[5].add(bean);
      }
    });

//gender
    await  AppDatabase.get().getLookupDataFromLocalDb(1139).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[8].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[8].add(bean);
      }
    });

    //Name title 2
    await  AppDatabase.get().getLookupDataFromLocalDb(1059).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[9].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[9].add(bean);
      }
    });

    //Language
    await  AppDatabase.get().getLookupDataFromLocalDb(38999).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[10].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[10].add(bean);
      }
    });

    //Target
    await  AppDatabase.get().getLookupDataFromLocalDb(109900 ).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[11].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[11].add(bean);
      }
    });

    //Ownership
    await  AppDatabase.get().getLookupDataFromLocalDb(109800).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[12].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[12].add(bean);
      }
    });

    //resident status
    await  AppDatabase.get().getLookupDataFromLocalDb(1001119).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[13].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[13].add(bean);
      }
    });
    //Is cp employee personal
    await  AppDatabase.get().getLookupDataFromLocalDb(11111112).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[14].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[14].add(bean);
      }
    });
    //Rank of employee personal
    await  AppDatabase.get().getLookupDataFromLocalDb(11111111).then((onValue){
      globals.dropdownCaptionsValuesPersonalInfo[15].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesPersonalInfo[15].add(bean);
      }
    });


//id type 1 , pan no
    await  AppDatabase.get().getLookupDataFromLocalDb(1075).then((onValue){//1321
      globals.dropdownCaptionsValuesKyc[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesKyc[0].add(bean);
        //      globals.dropdownCaptionsValuesKyc[1].add(bean);
      }
    });
    //custType
    await  AppDatabase.get().getLookupDataFromLocalDb(101004).then((onValue){
      globals.dropdownCaptionsValuesProfileDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesProfileDetails[0].add(bean);
      }
    });

    //nationality
    await  AppDatabase.get().getLookupDataFromLocalDb(5055).then((onValue){
      globals.dropdownCaptionsValuesProfileDetails[1].clear();
      for(int i = 0;i<onValue.length;i++){

        print("setting required values ${onValue[i].mcodedesc}");

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesProfileDetails[1].add(bean);
      }
    });

    //id type
    /*await  AppDatabase.get().getFromSubLookupDataFromLocalDb(102).then((onValue){//1321
    for(int i = 0;i<onValue.length;i++){

      LookupBeanData bean = new LookupBeanData();
      bean.mcodedesc = onValue[i].mcodedesc;
      bean.mcode = onValue[i].mcode ;
      bean.mcodetype = onValue[i].mcodetype ;
      bean.mfield1value = onValue[i].mfield1value ;
      globals.dropdownCaptionsValuesKyc[1].add(bean);
    }o
  });*/
    //contact
    //address type
    await  AppDatabase.get().getLookupDataFromLocalDb(909002).then((onValue){
      globals.dropdownCaptionsValuesKycDetails2[0].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesKycDetails2[0].add(bean);
      }
    });

    //Homw ownership
    await  AppDatabase.get().getLookupDataFromLocalDb(90900222).then((onValue){
      globals.dropdownCaptionsValuesKycDetails2[1].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesKycDetails2[1].add(bean);
      }
    });
    //business owned
    await  AppDatabase.get().getLookupDataFromLocalDb(150000).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[0].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //IS self employed
    //mdsitrequiretorefroff
    await  AppDatabase.get().getLookupDataFromLocalDb(51).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[1].clear();
      globals.dropdownCaptionsValuesESMS2[1].clear();
      globals.dropdownCaptionsValuesCollateralsInfo[6].clear();
      globals.dropdownCaptionsValuesCollateralsInfo[7].clear();
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[5].clear();
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[7].clear();
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[8].clear();
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[9].clear();




      globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[1].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[1].add(bean);
        globals.dropdownCaptionsValuesESMS2[1].add(bean);
        globals.dropDownCaptionValuesCollateralREMlandandhouse[3].add(bean);
        globals.dropdownCaptionsValuesCollateralsInfo[6].add(bean);
        globals.dropdownCaptionsValuesCollateralsInfo[7].add(bean);
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[5].add(bean);
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[7].add(bean);
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[8].add(bean);
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[9].add(bean);


        globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[1].add(bean);

      }
    });


    //Type Of Loan
    await  AppDatabase.get().getLookupDataFromLocalDb(12345).then((onValue){
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[4].clear();

      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[4].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(42032).then((onValue){
      globals.dropDownCaptionValuesCollateralREMlandandhouse[3].clear();

      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCollateralREMlandandhouse[3].add(bean);
      }
    });



    //COmpany category
    await  AppDatabase.get().getLookupDataFromLocalDb(1234567).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[2].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[2].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //Business-type
    await  AppDatabase.get().getLookupDataFromLocalDb(42033).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[3].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[3].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //source name
    await  AppDatabase.get().getLookupDataFromLocalDb(1511111).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[4].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[4].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });


    //Statues of emp
    await  AppDatabase.get().getLookupDataFromLocalDb(1511112).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[5].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[5].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //Is CP emp
    await  AppDatabase.get().getLookupDataFromLocalDb(51).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[6].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[6].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //Rank of employee employmet screen
    await  AppDatabase.get().getLookupDataFromLocalDb(150001).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[7].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[7].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });


    //Position owned
    await  AppDatabase.get().getLookupDataFromLocalDb(3031).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[8].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[8].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //Departmant
    await  AppDatabase.get().getLookupDataFromLocalDb(4053).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[9].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[9].add(bean);

      }
    });

    //Business status
    await  AppDatabase.get().getLookupDataFromLocalDb(29).then((onValue){
      globals.dropDownCaptionValuesBusinessDetails[10].clear();
      for(int i = 0;i<onValue.length;i++){
        Map<String,String> map = new Map<String,String>();;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesBusinessDetails[10].add(bean);

      }
    });
    //LoanLimitDetails


    //CGT1

    await  AppDatabase.get().getLookupDataFromLocalDb(7070).then((onValue){
      globals.questionCGT1 = List<CheckListCGT1Bean>(onValue.length);
      for(int i = 0;i<onValue.length;i++){
        print("data of on value code desription here is data is " + onValue[i].mcodedesc);
        CheckListCGT1Bean checkList = new CheckListCGT1Bean();
        checkList..mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode ;
        globals.questionCGT1[i] = checkList;
      }
    });
//CGT2
    await  AppDatabase.get().getLookupDataFromLocalDb(7071).then((onValue){
      globals.questionCGT2 = List<CheckListCGT2Bean>(onValue.length);
      for(int i = 0;i<onValue.length;i++){
        print("data of on value code desription here is data is " + onValue[i].mcodedesc);
        CheckListCGT2Bean checkList = new CheckListCGT2Bean();
        checkList.mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode ;
        globals.questionCGT2[i] = checkList;
      }
    });

    //GRT


    await  AppDatabase.get().getLookupDataFromLocalDb(7072).then((onValue){
      globals.questionGRT = List<CheckListGRTBean>(onValue.length);
      for(int i = 0;i<onValue.length;i++){
        print("data of on value code desription here is data is " + onValue[i].mcodedesc);
        CheckListGRTBean checkList = new CheckListGRTBean();
        checkList.mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode ;
        globals.questionGRT[i] = checkList;
      }
    });
//change here --- bhawpriya

    await  AppDatabase.get().getLookupDataFromLocalDb(909022).then((onValue){//purpose of loan
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[0].add(bean);
      }
    });

    //frequency
    await  AppDatabase.get().getLookupDataFromLocalDb(655).then((onValue){
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[1].clear();
      globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[2].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[1].add(bean);
        globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[2].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(909999).then((onValue){//repayment mode
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[2].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[2].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(909094).then((onValue){// mode of disb
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[3].clear();
      globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[3].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[3].add(bean);
        globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[3].add(bean);
      }
    });

    //expense detail , business
    await  AppDatabase.get().getLookupDataFromLocalDb(1100).then((onValue){
      globals.dropdownCaptionsValuesExpenseDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesExpenseDetails[0].add(bean);
      }
    });

    //expense detail , household
    await  AppDatabase.get().getLookupDataFromLocalDb(1500).then((onValue){
      globals.dropdownCaptionsValuesExpenseDetails[1].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesExpenseDetails[1].add(bean);
      }
    });

    // name of bank
    await  AppDatabase.get().getLookupDataFromLocalDb(909050).then((onValue){
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[2].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[2].add(bean);
        //globals.dropDownCaptionValuesCOdeKeysSocialFinancial[2].sort((a, b) => a.mcodedesc.compareTo(b.mcodedesc));
      }
    });

    // asset detail
    await  AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue){
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3].add(bean);
      }
    });


    //PPI Question

    /*   await  AppDatabase.get().getLookupDataFromLocalDb(70771).then((onValue){
      globals.dropdownCaptionsValuePPIDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuePPIDetails[0].add(bean);
      }
    });*/


    //agriculture land type
    await  AppDatabase.get().getLookupDataFromLocalDb(1800).then((onValue){
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[1].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[1].add(bean);
      }
    });

    //role of member
    await  AppDatabase.get().getLookupDataFromLocalDb(1260).then((onValue){
      globals.dropdownCaptionsValuesProfileDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesProfileDetails[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(110789).then((onValue) {
      //mode of payout
      globals.dropdownCaptionsValuesModeOfPayout[0].clear();
      for (int i = 0; i < onValue.length; i++) {

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesModeOfPayout[0].add(bean);
      }
    });


    //Guarantor
    await  AppDatabase.get().getLookupDataFromLocalDb(909066).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[0].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[0].add(bean);
      }
    });
    //applicant type
    await  AppDatabase.get().getLookupDataFromLocalDb(909018).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[1].clear();
      globals.dropDownCaptionDocumentCollecter[1].clear();


      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[1].add(bean);
        globals.dropDownCaptionDocumentCollecter[1].add(bean);


      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(1140).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[2].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[2].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(9028).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[3].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[3].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(909003).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[4].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[4].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(2000).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[5].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[5].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(909011).then((onValue){
      globals.dropdownCaptionsValuesGuarantorInfo[6].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesGuarantorInfo[6].add(bean);
      }
    });

    // business detais
    // fixed assets
    await  AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue){
      globals.dropDownCaptionValuesCodeKeysBusiness[0].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCodeKeysBusiness[0].add(bean);
      }
    });

    // current assets
    await  AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue){
      globals.dropDownCaptionValuesCodeKeysBusiness[1].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCodeKeysBusiness[1].add(bean);
      }
    });

    // long term liability
    await  AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue){
      globals.dropDownCaptionValuesCodeKeysBusiness[2].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCodeKeysBusiness[2].add(bean);
      }
    });

    // short term liability
    await  AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue){
      globals.dropDownCaptionValuesCodeKeysBusiness[3].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCodeKeysBusiness[3].add(bean);
      }
    });

    // equity
    await  AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue){
      globals.dropDownCaptionValuesCodeKeysBusiness[4].clear();
      for(int i = 0;i<onValue.length;i++){

        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCodeKeysBusiness[4].add(bean);
      }
    });

    // Currency
    await  AppDatabase.get().getLookupDataFromLocalDb(120001).then((onValue){
      globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesLoanFromOthrFinanclDetails[0].add(bean);
      }
    });


    //LTV
    await  AppDatabase.get().getLookupDataFromLocalDb(9088).then((onValue){
      globals.dropdownCaptionsValuesVehicleAcceptanceInfo[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesVehicleAcceptanceInfo[0].add(bean);
      }
    });



    //Good/V.Good
    await  AppDatabase.get().getLookupDataFromLocalDb(91).then((onValue){
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[0].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[1].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[2].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[3].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[4].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[5].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[6].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[7].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[8].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[9].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[10].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[11].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[12].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation1[13].clear();

      globals.dropdownCaptionsValuesCollateralVehicleValuation2[0].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[1].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[2].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[3].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[4].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[5].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[6].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[7].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[8].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[9].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[10].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[11].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[12].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation2[13].clear();

      globals.dropdownCaptionsValuesCollateralVehicleValuation3[0].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[1].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[2].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[3].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[4].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[5].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[6].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[7].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[8].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[9].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[10].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[11].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation3[12].clear();

      globals.dropdownCaptionsValuesCollateralVehicleValuation4[0].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[1].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[2].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[3].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[4].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[5].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[6].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[7].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[8].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[9].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[10].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[11].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[12].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[13].clear();
      globals.dropdownCaptionsValuesCollateralVehicleValuation4[14].clear();
      globals.dropDownCaptionValuesCollateralREMlandandhouse[3].clear();

      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[0].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[1].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[2].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[3].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[4].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[5].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[6].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[7].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[8].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[9].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[10].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[11].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[12].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation1[13].add(bean);

        globals.dropdownCaptionsValuesCollateralVehicleValuation2[0].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[1].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[2].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[3].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[4].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[5].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[6].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[7].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[8].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[9].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[10].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[11].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[12].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation2[13].add(bean);

        globals.dropdownCaptionsValuesCollateralVehicleValuation3[0].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[1].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[2].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[3].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[4].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[5].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[6].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[7].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[8].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[9].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[10].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[11].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation3[12].add(bean);

        globals.dropdownCaptionsValuesCollateralVehicleValuation4[0].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[1].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[2].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[3].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[4].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[5].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[6].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[7].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[8].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[9].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[10].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[11].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[12].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[13].add(bean);
        globals.dropdownCaptionsValuesCollateralVehicleValuation4[14].add(bean);

      }
    });
    //Collaterals
    await  AppDatabase.get().getLookupDataFromLocalDb(10).then((onValue){
      globals.dropdownCaptionsValuesCollateralsInfo[0].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralsInfo[0].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(8080808).then((onValue){
      globals.dropdownCaptionsValuesCollateralsInfo[1].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralsInfo[1].add(bean);
      }
    });
    /*await  AppDatabase.get().getLookupDataFromLocalDb(1059).then((onValue){
      globals.dropdownCaptionsValuesCollateralsInfo[2].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralsInfo[2].add(bean);
      }
    });*/
    await  AppDatabase.get().getLookupDataFromLocalDb(909009).then((onValue){
      globals.dropdownCaptionsValuesCollateralsInfo[3].clear();
      for(int i = 0;i<onValue.length;i++){



        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralsInfo[3].add(bean);
      }
    });
    await  AppDatabase.get().getLookupDataFromLocalDb(13).then((onValue){
      globals.dropdownCaptionsValuesCollateralsInfo[4].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralsInfo[4].add(bean);
      }
    });
    //collateral title
    await  AppDatabase.get().getLookupDataFromLocalDb(511).then((onValue){
      globals.dropdownCaptionsValuesCollateralsInfo[5].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCollateralsInfo[5].add(bean);
      }
    });

    //House build Type
    await  AppDatabase.get().getLookupDataFromLocalDb(42030).then((onValue){
      globals.dropDownCaptionValuesCollateralREMlandandhouse[1].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCollateralREMlandandhouse[1].add(bean);
      }
    });


    //Enviornment
    await  AppDatabase.get().getLookupDataFromLocalDb(42031).then((onValue){
      globals.dropDownCaptionValuesCollateralREMlandandhouse[2].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionValuesCollateralREMlandandhouse[2].add(bean);
      }
    });


    //end


    //ESMS STart

    await  AppDatabase.get().getLookupDataFromLocalDb(1001111).then((onValue){
      globals.dropdownCaptionsValuesESMS[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[0].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001112).then((onValue){
      globals.dropdownCaptionsValuesESMS[1].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[1].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001113).then((onValue){
      globals.dropdownCaptionsValuesESMS[2].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[2].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001114).then((onValue){
      globals.dropdownCaptionsValuesESMS[3].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[3].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001115).then((onValue){
      globals.dropdownCaptionsValuesESMS[4].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[4].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001116).then((onValue){
      globals.dropdownCaptionsValuesESMS[5].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[5].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001117).then((onValue){
      globals.dropdownCaptionsValuesESMS[6].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[6].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001118).then((onValue){
      globals.dropdownCaptionsValuesESMS[7].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[7].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001199).then((onValue){
      globals.dropdownCaptionsValuesESMS[8].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[8].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(1001121).then((onValue){
      globals.dropdownCaptionsValuesESMS[9].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS[9].add(bean);
      }
    });

//mdecision
    await  AppDatabase.get().getLookupDataFromLocalDb(12121313).then((onValue){
      globals.dropdownCaptionsValuesESMS2[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesESMS2[0].add(bean);
      }
    });


    //STart RiskRatings
    //mcountryrisk
    await  AppDatabase.get().getLookupDataFromLocalDb(12121).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[0].add(bean);
      }
    });

    //mvisaperiod
    await  AppDatabase.get().getLookupDataFromLocalDb(12122).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[1].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[1].add(bean);
      }
    });

    //mvisavalid
    await  AppDatabase.get().getLookupDataFromLocalDb(12123).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[2].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[2].add(bean);
      }
    });

    //mvisatype
    await  AppDatabase.get().getLookupDataFromLocalDb(12124).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[3].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[3].add(bean);
      }
    });

    //mnatureofbuss
    await  AppDatabase.get().getLookupDataFromLocalDb(12125).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[4].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[4].add(bean);
      }
    });

    //mhwwsacctopn
    await  AppDatabase.get().getLookupDataFromLocalDb(12126).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[5].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[5].add(bean);
      }
    });

    //mnetwrth
    await  AppDatabase.get().getLookupDataFromLocalDb(12127).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[6].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[6].add(bean);
      }
    });

    //mexpectedvalue
    await  AppDatabase.get().getLookupDataFromLocalDb(12128).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[7].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[7].add(bean);
      }
    });

    //mnooftransmnthly
    await  AppDatabase.get().getLookupDataFromLocalDb(12129).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[8].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[8].add(bean);
      }
    });

    //mhighnetwrth
    await  AppDatabase.get().getLookupDataFromLocalDb(12130).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[9].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[9].add(bean);
      }
    });

    //mprcdservrskque1
    await  AppDatabase.get().getLookupDataFromLocalDb(12131).then((onValue){
      globals.dropdownCaptionsValuesRiskRatings[10].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesRiskRatings[10].add(bean);
      }
    });

    //ENds here
    //ends
    //Utility Bills start here
    await  AppDatabase.get().getLookupDataFromLocalDb(992030).then((onValue){
      globals.dropDownCaptionUtilityBillPayment[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionUtilityBillPayment[0].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(4444).then((onValue){
      globals.dropDownCaptionUtilityBillPayment[1].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionUtilityBillPayment[1].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(5555).then((onValue){
      globals.dropDownCaptionUtilityBillPayment[2].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionUtilityBillPayment[2].add(bean);
      }
    });

    await  AppDatabase.get().getLookupDataFromLocalDb(6666).then((onValue){
      globals.dropDownCaptionUtilityBillPayment[3].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionUtilityBillPayment[3].add(bean);
      }
    });
    //Ends

    //Documents COllector
    await  AppDatabase.get().getLookupDataFromLocalDb(13131313).then((onValue){
      globals.dropDownCaptionDocumentCollecter[0].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropDownCaptionDocumentCollecter[0].add(bean);
      }
    });

    //Repayment Frequency

    await  AppDatabase.get().getLookupDataFromLocalDb(909119).then((onValue){
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[6].clear();
      for(int i = 0;i<onValue.length;i++){
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode ;
        bean.mcodetype = onValue[i].mcodetype ;
        bean.mfield1value = onValue[i].mfield1value ;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[6].add(bean);
      }
    });


    //ENds

    //static insert lastsynced table
    //baad mai insert this using list obj
    List<LastSyncedDateTime> lastSyncedDateTimeBean = new List<LastSyncedDateTime>();
    LastSyncedDateTime lastSyncObj  = LastSyncedDateTime();
    lastSyncObj.id=1;
    lastSyncObj.tTabelDesc ="customerFoundationMasterDetails";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 1);

    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=2;
    lastSyncObj.tTabelDesc ="Credit_Bereau_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 2);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=3;
    lastSyncObj.tTabelDesc ="CGT1_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 3);


    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=4;
    lastSyncObj.tTabelDesc ="CGT2_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 4);

    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=5;
    lastSyncObj.tTabelDesc ="GRT_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 5);


    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=6;
    lastSyncObj.tTabelDesc ="customer_Loan_Details_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 6);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=7;
    lastSyncObj.tTabelDesc ="collected_LoansAmt_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 7);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=8;
    lastSyncObj.tTabelDesc ="System_Parameter_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 8);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=9;
    lastSyncObj.tTabelDesc ="Lookup_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 9);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=10;
    lastSyncObj.tTabelDesc ="Sub_Lookup_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 10);


    // Savings list
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=11;
    lastSyncObj.tTabelDesc ="savings_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 11);

    // Savings Collection list
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=12;
    lastSyncObj.tTabelDesc ="savings_Collection_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 12);

    // Savings Collection list
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=13;
    lastSyncObj.tTabelDesc ="Term_Deposit_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 13);

    // Collateral Vehicle
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=14;
    lastSyncObj.tTabelDesc ="Collateral_Vehicle_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 14);

    // guranter Basic
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=15;
    lastSyncObj.tTabelDesc ="gaurantor_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 15);

    // Collateral Collaterals_Master
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=16;
    lastSyncObj.tTabelDesc ="Collaterals_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 16);


    // Collateral Collaterals_REM
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=17;
    lastSyncObj.tTabelDesc ="Collaterals_REM";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 17);

    // Document_Master
    lastSyncedDateTimeBean.clear();
    lastSyncObj=null;
    lastSyncObj  = new LastSyncedDateTime();
    lastSyncObj.id=18;
    lastSyncObj.tTabelDesc ="Document_Master";
    lastSyncObj.tlastSyncedFromTab=null;
    lastSyncObj.tlastSyncedToTab=null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get().insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 18);
  }

  static Future setSystemVariables()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SystemParameterBean  sysBean = new SystemParameterBean();
    int lbrcode =prefs.getInt(TablesColumnFile.musrbrcode);
    print(lbrcode); // if(AppDatabase.get().getSystemParameter(1,lbrcode)!=null){

    sysBean = await AppDatabase.get().getSystemParameter('1',lbrcode);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.mValidity, sysBean.mcodevalue);
    }

    // if(AppDatabase.get().getSystemParameter(2,lbrcode)!=null){
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('2',0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.mIsProspectNeeded, sysBean.mcodevalue);
    }

    //if (AppDatabase.get().getSystemParameter(3, lbrcode) != null) {
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('3', 0);
    if(sysBean !=null){
      prefs.setString(
          TablesColumnFile.mIsProspectRepeatNeeded, sysBean.mcodevalue);
    }

    // if (AppDatabase.get().getSystemParameter(4, lbrcode) != null) {
    /* sysBean = new SystemParameterBean();
       sysBean = await AppDatabase.get().getSystemParameter(4, 0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.mCompanyName, sysBean.mcodevalue);
    }
*/

    // for Term Deposit RATE OF INTEREST logic
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('5', 0);// id
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.mTdparam, sysBean.mcodevalue);
    }



    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('8', 0);
    if(sysBean !=null){
      print(sysBean.mcodevalue);
      int CGT1toCGT2Gap = 0;
      try{
        CGT1toCGT2Gap= int.parse(sysBean.mcodevalue);
      }catch(_){
        print("Exception in parsing");
      }

      prefs.setInt(TablesColumnFile.CGT1toCGT2Gap, CGT1toCGT2Gap);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('7', 0);
    if(sysBean !=null){
      print(sysBean.mcodevalue);
      int CgtToGrtgap = 0;
      try{
        CgtToGrtgap= int.parse(sysBean.mcodevalue);
      }catch(_){
        print("Exception in parsing");
      }

      prefs.setInt(TablesColumnFile.CGT2toGRTGap, CgtToGrtgap);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('11', 0);
    prefs.setString(TablesColumnFile.mIsGroupLendingNeeded, "0");
    if(sysBean!=null){
      prefs.setString(TablesColumnFile.mIsGroupLendingNeeded, sysBean.mcodevalue);
    }


    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('12', 0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.mCompanyName, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('CENTER', 0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.CENTERCAPTION, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('GROUP', 0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.GROUPCAPTION, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('14', 0);
    print("Setting system paramaetr for iscgt2 needed");
    prefs.setString(TablesColumnFile.isCGT2Needed, "0");
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.isCGT2Needed, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('RESEDENCYADDRESSMCODE', 0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.RESEDENCYADDRESSMCODE, sysBean.mcodevalue);
    }

  }
}

