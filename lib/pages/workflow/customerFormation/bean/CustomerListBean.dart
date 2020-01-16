
import 'package:eco_los/beans/BaseBean.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
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
import 'package:eco_los/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';

import 'package:eco_los/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/SocialFinancialDetailsBean.dart';

import 'IncomeStatementBean.dart';
import 'RiskRatingsBean.dart';
import 'TotalExpenditureDetailsBean.dart';

class CustomerListBean {//extends BaseBean{
  //numeric(8)
  int trefno;
  //numeric(8)
  int mrefno;
  //numeric(8)
  int mcustno;
  //numeric(8)
  int mlbrcode;
  //numeric(8)
  int mcenterid;
  //numeric(8)
  int mgroupcd;
  //nvarchar(4)
  String mnametitle;
  //nvarchar(250)
  String mlongname;
  //nvarchar(4)
  String mfathertitle;
  //nvarchar(100)
  String mfatherfname;
  String mfathermname;
  String mfatherlname;
  //nvarchar(4)
  String mspousetitle;
  //nvarchar(100)
  String mhusbandname;
  DateTime mdob;
  //numeric(2)
  int mage;
  //make this string as this is navarchar in middleware
  //nvarchar(20)
  String mbankacno;
  //nvarchar(1)
  String mbankacyn;
  //nvarchar(10)
  String mbankifsc;
  //nvarchar(25)
  String mbanknamelk;
  //nvarchar(25)
  String mbankbranch;
  //numeric(1)
  int mcuststatus;
  DateTime mdropoutdate;
  //nvarchar(12)
  String mmobno;
  //numeric(2)
  int mpanno;
  //nvarchar(25)
  String mpannodesc;
  //nvarchar(1)
  String mtdsyn;
  //numeric (2)
  int mtdsreasoncd;
  DateTime mtdsfrm15subdt;
  //nvarchar(50)
  String memailId;
  //numeric(2)
  String mcustcategory;
  //numeric(1)
  int mtier;
  //nvarchar(75)
  String mAdd1;
  //nvarchar(75)
  String mAdd2;
  //nvarchar(75)
  String mAdd3;
  //numeric(6)
  int mArea;
  //nvarchar(8)
  String mPinCode;
  //nvarchar(3)
  String mCounCd;
  //nvarchar(15)
  String mCityCd;
  //nvarchar(50)
  String mfname;
  //nvarchar(50)
  String mmname;
  //nvarchar(50)
  String mlname;
  //nvarchar(1)
  String mgender;
  //nvarchar(1)
  String mrelegion;
  //numeric(2)
  String mRuralUrban;
  //nvarchar(4)
  String mcaste;
  //nvarchar(15)
  String mqualification;
  //numeric(4)
  int moccupation;
  //nvarchar(4)
  String mLandType;
  //nvarchar(4)
  String mLandMeasurement;
  //numeric(2)
  int mmaritialStatus;
  //numeric(1)
  int mTypeOfId;
  //nvarchar(25)
  String mIdDesc;
  //nvarchar(1)
  String mInsuranceCovYN;
  //numeric(4)
  int mTypeofCoverage;

  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  List<FamilyDetailsBean> familyDetailsList  ;
  List<SocialFinancialDetailsBean> socialFinancialList;
  List<BorrowingDetailsBean> borrowingDetailsBean ;
  List<AddressDetailsBean> addressDetails ;
  List<ImageBean> imageMaster ;
  List<CustomerBusinessDetailsBean> customerBusinessDetailsBean  ;
   String missngautryt1 ;
   String missngautryt2 ;
   String missngautryt3 ;
   int mtypeofid3 ;
   String middesc3 ;
   DateTime mid3issuedate;
   DateTime mid3expdate;


  //List<CustomModel> assetDetailsList;
  //List<CustomModel> savingDetailsList;
  String mcentername;
  String mgroupname;

  String ifYesThen;
  //String mifyesthen;
  //String mOccBuisness;
  String mShopName;
  String mShpAdd;
  int mYrsInBz;
  String mregNum;
  //String mid1;
  //String mid2;
  String mHouse;
  String mAgricultureType;
  int mIsMbrGrp;
  //nvarchar(1)
  int mLoanAgreed;
  //nvarchar(1)
  int mGend;
  //nvarchar(1)
  int mInsurance;
  //int mRegion;
  int mConstruct;
  int mToilet;
  //int mBankAccYN;
  int mhousBizSp;
  int mBzRegs;
  int mBzTrnd;
  int misCbCheckDone;
  String merrormessage;
  double mexpsramt;
  DateTime mcbcheckrprtdt;
  String motpvrfdno ;
  List<BusinessExpenditureDetailsBean> businessExpendDetailsList;
  List<HouseholdExpenditureDetailsBean> householdExpendDetailsList;
  List<AssetDetailsBean> assetDetailsList;
  FixedAssetsBean fixedAssetsList;
  CurrentAssetsBean currentAssetsList;
  LongTermLiabilitiesBean longTermLiabilitiesList;
  ShortTermLiabilitiesBean shortTermLiabilitiesList;
  EquityBean equityList;
  IncomeStatementBean incomeStatementList;
  FinancialStmntBean financialStmntList;
  String mprofileind;
  DateTime mhusdob;

  String mlangofcust;
  String mmainoccupn;
  String msuboccupn;
  int msecoccupatn;
  String mmainoccupndesc;
  String msuboccupndesc;
  ESMSBean esmsentity;
  RiskRatingsBean riskratingsentity;
  String mnationality;


  String mnametitle2;
  String mlongname2;
  String mfname2;
  String mmname2;
  String mlname2;

  DateTime mid1issuedate;
  DateTime mid1expdate;
  DateTime mid2issuedate;
  DateTime mid2expdate;
  TotalExpenditureDetailsBean totalExpenditureDetailsBean;
  double macctbal=0.0;
  String misstudyingmembr;
  String misearngmembr;
  String mmemberno;
  String mischldrn;

  String mbusinessname;
  String mtarget;
  String mownership;
  String mresstatus;
  String mdedupnationalid;
  String miscpemp;
  String mrankofemp;
  String mempid;


  @override
  String toString() {
    return 'CustomerListBean{ totalExpenditureDetailsBean: $totalExpenditureDetailsBean,trefno: $trefno, mrefno: $mrefno, mcustno: $mcustno, mlbrcode: $mlbrcode, mcenterid: $mcenterid, mgroupcd: $mgroupcd, mnametitle: $mnametitle, mlongname: $mlongname, mfathertitle: $mfathertitle, mfatherfname: $mfatherfname, mfathermname: $mfathermname, mfatherlname: $mfatherlname, mspousetitle: $mspousetitle, mhusbandname: $mhusbandname, mdob: $mdob, mage: $mage, mbankacno: $mbankacno, mbankacyn: $mbankacyn, mbankifsc: $mbankifsc, mbanknamelk: $mbanknamelk, mbankbranch: $mbankbranch, mcuststatus: $mcuststatus, mdropoutdate: $mdropoutdate, mmobno: $mmobno, mpanno: $mpanno, mpannodesc: $mpannodesc, mtdsyn: $mtdsyn, mtdsreasoncd: $mtdsreasoncd, mtdsfrm15subdt: $mtdsfrm15subdt, memailId: $memailId, mcustcategory: $mcustcategory, mtier: $mtier, mAdd1: $mAdd1, mAdd2: $mAdd2, mAdd3: $mAdd3, mArea: $mArea, mPinCode: $mPinCode, mCounCd: $mCounCd, mCityCd: $mCityCd, mfname: $mfname, mmname: $mmname, mlname: $mlname, mgender: $mgender, mrelegion: $mrelegion, mRuralUrban: $mRuralUrban, mcaste: $mcaste, mqualification: $mqualification, moccupation: $moccupation, mLandType: $mLandType, mLandMeasurement: $mLandMeasurement, mmaritialStatus: $mmaritialStatus, mTypeOfId: $mTypeOfId, mIdDesc: $mIdDesc, mInsuranceCovYN: $mInsuranceCovYN, mTypeofCoverage: $mTypeofCoverage, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: $missynctocoresys, mlastsynsdate: $mlastsynsdate, familyDetailsList: $familyDetailsList, socialFinancialList: $socialFinancialList, borrowingDetailsBean: $borrowingDetailsBean, addressDetails: $addressDetails, imageMaster: $imageMaster, customerBusinessDetailsBean: $customerBusinessDetailsBean, missngautryt1: $missngautryt1, missngautryt2: $missngautryt2, missngautryt3: $missngautryt3, mtypeofid3: $mtypeofid3, middesc3: $middesc3, mid3issuedate: $mid3issuedate, mid3expdate: $mid3expdate, mcentername: $mcentername, mgroupname: $mgroupname, ifYesThen: $ifYesThen, mShopName: $mShopName, mShpAdd: $mShpAdd, mYrsInBz: $mYrsInBz, mregNum: $mregNum, mHouse: $mHouse, mAgricultureType: $mAgricultureType, mIsMbrGrp: $mIsMbrGrp, mLoanAgreed: $mLoanAgreed, mGend: $mGend, mInsurance: $mInsurance, mConstruct: $mConstruct, mToilet: $mToilet, mhousBizSp: $mhousBizSp, mBzRegs: $mBzRegs, mBzTrnd: $mBzTrnd, misCbCheckDone: $misCbCheckDone, merrormessage: $merrormessage, mexpsramt: $mexpsramt, mcbcheckrprtdt: $mcbcheckrprtdt, motpvrfdno: $motpvrfdno, businessExpendDetailsList: $businessExpendDetailsList, householdExpendDetailsList: $householdExpendDetailsList, assetDetailsList: $assetDetailsList, fixedAssetsList: $fixedAssetsList, currentAssetsList: $currentAssetsList, longTermLiabilitiesList: $longTermLiabilitiesList, shortTermLiabilitiesList: $shortTermLiabilitiesList, equityList: $equityList, incomeStatementList: $incomeStatementList, financialStmntList: $financialStmntList, mprofileind: $mprofileind, mhusdob: $mhusdob, mlangofcust: $mlangofcust, mmainoccupn: $mmainoccupn, msuboccupn: $msuboccupn, msecoccupatn: $msecoccupatn, mmainoccupndesc: $mmainoccupndesc, msuboccupndesc: $msuboccupndesc, esmsentity: $esmsentity, riskratingsentity: $riskratingsentity, mnationality: $mnationality, mnametitle2: $mnametitle2, mlongname2: $mlongname2, mfname2: $mfname2, mmname2: $mmname2, mlname2: $mlname2, mid1issuedate: $mid1issuedate, mid1expdate: $mid1expdate, mid2issuedate: $mid2issuedate, mid2expdate: $mid2expdate, macctbal: $macctbal, misstudyingmembr: $misstudyingmembr, misearngmembr: $misearngmembr, mmemberno: $mmemberno, mischldrn: $mischldrn, mbusinessname: $mbusinessname, mtarget: $mtarget, mownership: $mownership, mresstatus: $mresstatus, mdedupnationalid: $mdedupnationalid, miscpemp: $miscpemp, mrankofemp: $mrankofemp, mempid: $mempid}';
  }

  CustomerListBean(
      {
        this.trefno,
        this.mrefno,
        this.mcustno,
        this.mlbrcode,
        this.mcenterid,
        this.mgroupcd,
        this.mnametitle,
        this.mlongname,
        this.mfathertitle,
        this.mfatherfname,
        this.mfathermname,
        this.mfatherlname,
        this.mspousetitle,
        this.mhusbandname,
        this.mdob,
        this.mage,
        this.mbankacno,
        this.mbankacyn,
        this.mbankifsc,
        this.mbanknamelk,
        this.mbankbranch,
        this.mcuststatus,
        this.mdropoutdate,
        this.mmobno,
        this.mpanno,
        this.mpannodesc,
        this.mtdsyn,
        this.mtdsreasoncd,
        this.mtdsfrm15subdt,
        this.memailId,
        this.mcustcategory,
        this.mtier,
        this.mAdd1,
        this.mAdd2,
        this.mAdd3,
        this.mArea,
        this.mPinCode,
        this.mCounCd,
        this.mCityCd,
        this.mfname,
        this.mmname,
        this.mlname,
        this.mgender,
        this.mrelegion,
        this.mRuralUrban,
        this.mcaste,
        this.mqualification,
        this.moccupation,
        this.mLandType,
        this.mLandMeasurement,
        this.mmaritialStatus,
        this.mTypeOfId,
        this.mIdDesc,
        this.mInsuranceCovYN,
        this.mTypeofCoverage,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.missynctocoresys,
        this.mlastsynsdate,
        this.familyDetailsList,
        this.socialFinancialList,
        this.borrowingDetailsBean,
        this.addressDetails,
        this.imageMaster,
        this.customerBusinessDetailsBean,
        this.mcentername,
        this.mgroupname,

        this.ifYesThen,

        this.mShopName,
        this.mShpAdd,
        this.mYrsInBz,
        this.mregNum,
        //this.mid1,
        //this.mid2,
        this.mHouse,
        this.mAgricultureType,
        this.mIsMbrGrp,
        this.mLoanAgreed,
        this.mGend,
        this.mInsurance,
        //this.mRegion,
        this.mConstruct,
        this.mToilet,
        //this.mBankAccYN,
        this.mhousBizSp,
        this.mBzRegs,
        this.mBzTrnd,
        this.misCbCheckDone,
        this.merrormessage,
        this.businessExpendDetailsList,
        this.householdExpendDetailsList,
        this.assetDetailsList,
        this.mexpsramt,
        this.mcbcheckrprtdt,
        this.motpvrfdno,
        this.mhusdob,
        this.mprofileind,
        this.mlangofcust,
        this.mmainoccupn,
        this.msecoccupatn,
        this.msuboccupn,
        this.mmainoccupndesc,
        this.msuboccupndesc,
        this.fixedAssetsList,
        this.currentAssetsList,
        this.longTermLiabilitiesList,
        this.shortTermLiabilitiesList,
        this.equityList,

	this.incomeStatementList,
        this.financialStmntList,

        this.mnametitle2,
        this.mlongname2,
        this.mfname2,
        this.mmname2,
        this.mlname2,
        this.mnationality,
        this.mid1issuedate,
        this.mid1expdate,
        this.mid2issuedate,
        this.mid2expdate,
        this.totalExpenditureDetailsBean,

        this.missngautryt1 ,
        this.missngautryt2 ,
        this.missngautryt3 ,
        this.mtypeofid3 ,
        this.middesc3 ,
        this.mid3issuedate,
        this.mid3expdate,
        this.macctbal,
        this.mmemberno,
        this.misearngmembr,
        this.misstudyingmembr,
        this.mischldrn,
        this.mbusinessname,
        this.mtarget,
        this.mownership,
	 this.esmsentity,
        this.mresstatus,
        this.mdedupnationalid,
        this.miscpemp,
        this.mrankofemp,
        this.mempid,
        this.riskratingsentity,
      });

  factory CustomerListBean.fromMap(Map<String, dynamic> map,bool isTrue) {
    return CustomerListBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mnametitle: map[TablesColumnFile.mnametitle] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mfathertitle: map[TablesColumnFile.mfathertitle] as String,
      mfatherfname: map[TablesColumnFile.mfatherfname] as String,
      mfathermname: map[TablesColumnFile.mfathermname] as String,
      mfatherlname: map[TablesColumnFile.mfatherlname] as String,
      mspousetitle: map[TablesColumnFile.mspousetitle] as String,
      mhusbandname: map[TablesColumnFile.mhusbandname] as String,
      mdob:(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mage: map[TablesColumnFile.mage] as int,
      mbankacno: map[TablesColumnFile.mbankacno] as String,
      mbankacyn: map[TablesColumnFile.mbankacyn] as String,
      mbankifsc: map[TablesColumnFile.mbankifsc] as String,
      mbanknamelk: map[TablesColumnFile.mbanknamelk] as String,
      mbankbranch: map[TablesColumnFile.mbankbranch] as String,
      mcuststatus: map[TablesColumnFile.mcuststatus] as int,
      mdropoutdate:(map[TablesColumnFile.mdropoutdate]=="null"||map[TablesColumnFile.mdropoutdate]==null)?null:DateTime.parse(map[TablesColumnFile.mdropoutdate]) as DateTime,
      mmobno: map[TablesColumnFile.mmobno] as String,
      mpanno: map[TablesColumnFile.mpanno] as int,
      mpannodesc: map[TablesColumnFile.mpannodesc] as String,
      mtdsyn: map[TablesColumnFile.mtdsyn] as String,
      mtdsreasoncd: map[TablesColumnFile.mtdsreasoncd] as int,
      mtdsfrm15subdt:(map[TablesColumnFile.mtdsfrm15subdt]=="null"||map[TablesColumnFile.mtdsfrm15subdt]==null)?null:DateTime.parse(map[TablesColumnFile.mtdsfrm15subdt]) as DateTime,
      memailId: map[TablesColumnFile.memailId] as String,
      mcustcategory: map[TablesColumnFile.mcustcategory] as String,
      merrormessage:			map[TablesColumnFile.merrormessage] as String,
      mtier: map[TablesColumnFile.mtier] as int,
      mAdd1: map[TablesColumnFile.mAdd1] as String,
      mAdd2: map[TablesColumnFile.mAdd2] as String,
      mAdd3: map[TablesColumnFile.mAdd3] as String,
      mArea: map[TablesColumnFile.marea] as int,
      mPinCode: map[TablesColumnFile.mPinCode] as String,
      mCounCd: map[TablesColumnFile.mCounCd] as String,
      mCityCd: map[TablesColumnFile.mCityCd] as String,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mgender: map[TablesColumnFile.mgender] as String,
      mrelegion: map[TablesColumnFile.mrelegion] as String,
      mRuralUrban: map[TablesColumnFile.mRuralUrban] as String,
      mcaste: map[TablesColumnFile.mcaste] as String,
      mqualification: map[TablesColumnFile.mqualification] as String,
      moccupation: map[TablesColumnFile.moccupation] as int,
      mLandType: map[TablesColumnFile.mLandType] as String,
      mLandMeasurement: map[TablesColumnFile.mLandMeasurement] as String,
      mmaritialStatus: map[TablesColumnFile.mmaritialStatus] as int,
      mTypeOfId: map[TablesColumnFile.mTypeOfId] as int,
      mIdDesc: map[TablesColumnFile.mIdDesc] as String,
      mInsuranceCovYN: map[TablesColumnFile.mInsuranceCovYN] as String,
      mTypeofCoverage: map[TablesColumnFile.mTypeofCoverage] as int,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

      ifYesThen:			map[TablesColumnFile.ifYesThen] as String,

      mShopName:			map[TablesColumnFile.mShopName] as String,
      mShpAdd:			map[TablesColumnFile.mShpAdd] as String,
      mYrsInBz:			map[TablesColumnFile.mYrsInBz] as int,
      mregNum:			map[TablesColumnFile.mregNum] as String,
      //mid1:			map[TablesColumnFile.mid1] as String,
      //mid2:			map[TablesColumnFile.mid2] as String,
      mHouse:			map[TablesColumnFile.mhouse] as String,
      mAgricultureType:			map[TablesColumnFile.mAgricultureType] as String,
      mIsMbrGrp:			map[TablesColumnFile.mIsMbrGrp] as int,
      mLoanAgreed:			map[TablesColumnFile.mLoanAgreed] as int,
      mGend:			map[TablesColumnFile.mGend] as int,
      mInsurance:			map[TablesColumnFile.mInsurance] as int,
      //mRegion:			map[TablesColumnFile.mRegion] as int,
      mConstruct:			map[TablesColumnFile.mConstruct] as int,
      mToilet:			map[TablesColumnFile.mToilet] as int,
      //mBankAccYN:			map[TablesColumnFile.mBankAccYN] as int,
      mhousBizSp:			map[TablesColumnFile.mhousBizSp] as int,
      mBzRegs:			map[TablesColumnFile.mBzRegs] as int,
      mBzTrnd:			map[TablesColumnFile.mBzTrnd] as int,
      misCbCheckDone:			map[TablesColumnFile.misCbCheckDone] as int,
      //errorMessage:			map[TablesColumnFile.merrormessage] as String,
      mcentername : map[TablesColumnFile.mcentername] as String,
      mgroupname : map[TablesColumnFile.mgroupname] as String,
      mexpsramt : map[TablesColumnFile.mexpsramt] as double,
      mcbcheckrprtdt : (map[TablesColumnFile.mcbcheckrprtdt]=="null"||
          map[TablesColumnFile.mcbcheckrprtdt]==null)?null:DateTime.parse(map[TablesColumnFile.mcbcheckrprtdt]) as DateTime,

        motpvrfdno:map[TablesColumnFile.motpvrfdno] as String,
        mhusdob:(map[TablesColumnFile.mhusdob]=="null"||map[TablesColumnFile.mhusdob]==null)?null:DateTime.parse(map[TablesColumnFile.mhusdob]) as DateTime,
        mprofileind : map[TablesColumnFile.mprofileind] as String,
        mlangofcust : map[TablesColumnFile.mlangofcust] as String,
        mmainoccupn : map[TablesColumnFile.mmainoccupn] as String,
        msuboccupn : map[TablesColumnFile.msuboccupn] as String,
        msecoccupatn : map[TablesColumnFile.msecoccupatn] as int,
        mmainoccupndesc : map[TablesColumnFile.mmainoccupndesc] as String,
        msuboccupndesc : map[TablesColumnFile.msuboccupndesc] as String,


      mnametitle2: map[TablesColumnFile.mnametitle2] as String,
      mlongname2: map[TablesColumnFile.mlongname2] as String,
      mfname2: map[TablesColumnFile.mfname2] as String,
      mmname2: map[TablesColumnFile.mmname2] as String,
      mlname2: map[TablesColumnFile.mlname2] as String,
      mnationality: map[TablesColumnFile.mnationality] as String,

      mid1issuedate: (map[TablesColumnFile.mid1issuedate]=="null"||map[TablesColumnFile.mid1issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid1issuedate]) as DateTime,
      mid2issuedate: (map[TablesColumnFile.mid2issuedate]=="null"||map[TablesColumnFile.mid2issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid2issuedate]) as DateTime,
      mid1expdate: (map[TablesColumnFile.mid1expdate]=="null"||map[TablesColumnFile.mid1expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid1expdate]) as DateTime,
      mid2expdate: (map[TablesColumnFile.mid2expdate]=="null"||map[TablesColumnFile.mid2expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid2expdate]) as DateTime,


      mid3issuedate: (map[TablesColumnFile.mid3issuedate]=="null"||map[TablesColumnFile.mid3issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid3issuedate]) as DateTime,
      mid3expdate: (map[TablesColumnFile.mid3expdate]=="null"||map[TablesColumnFile.mid3expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid3expdate]) as DateTime,
      missngautryt1: map[TablesColumnFile.missngautryt1] as String,
      missngautryt2: map[TablesColumnFile.missngautryt2] as String,
      missngautryt3: map[TablesColumnFile.missngautryt3] as String,
      mtypeofid3: map[TablesColumnFile.mtypeofid3] as int,
      middesc3: map[TablesColumnFile.middesc3] as String,
      macctbal : map[TablesColumnFile.macctbal]!=null && map[TablesColumnFile.macctbal]!='null'?map[TablesColumnFile.macctbal] as double:0.0,
      misearngmembr:map[TablesColumnFile.misearngmembr] as String,
      misstudyingmembr:map[TablesColumnFile.misstudyingmembr] as String,
      mmemberno: map[TablesColumnFile.mmemberno]as String,
      mischldrn: map[TablesColumnFile.mischldrn]as String,
      mbusinessname: map[TablesColumnFile.mbusinessname]as String,
      mtarget: map[TablesColumnFile.mtarget]as String,
      mownership: map[TablesColumnFile.mownership]as String,
      mresstatus: map[TablesColumnFile.mresstatus]as String,
      mdedupnationalid: map[TablesColumnFile.mdedupnationalid]as String,
        miscpemp: map[TablesColumnFile.miscpemp]as String,
        mrankofemp: map[TablesColumnFile.mrankofemp]as String,
        mempid: map[TablesColumnFile.mempid]as String,


    );
  }
  factory CustomerListBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    print(map[TablesColumnFile.imageMaster]);
    print("mrefno");
    print(map[TablesColumnFile.mrefno]);
/*    List<FamilyDetailsBean> famBean;
    try {
      famBean =
          map[TablesColumnFile.familyDetails].map<FamilyDetailsBean>((i) =>
              FamilyDetailsBean.fromMap(i))
              .toList();
    }catch(_){}*/
    return CustomerListBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mnametitle: map[TablesColumnFile.mnametitle] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mfathertitle: map[TablesColumnFile.mfathertitle] as String,
      mfatherfname: map[TablesColumnFile.mfatherfname] as String,
      mfathermname: map[TablesColumnFile.mfathermname] as String,
      mfatherlname: map[TablesColumnFile.mfatherlname] as String,
      mspousetitle: map[TablesColumnFile.mspousetitle] as String,
      mhusbandname: map[TablesColumnFile.mhusbandname] as String,
      mdob: (map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mage: map[TablesColumnFile.mage] as int,
      mbankacno: map[TablesColumnFile.mbankacno] as String,
      mbankacyn: map[TablesColumnFile.mbankacyn] as String,
      mbankifsc: map[TablesColumnFile.mbankifsc] as String,
      mbanknamelk: map[TablesColumnFile.mbanknamelk] as String,
      mbankbranch: map[TablesColumnFile.mbankbranch] as String,
      mcuststatus: map[TablesColumnFile.mcuststatus] as int,
      mdropoutdate:  (map[TablesColumnFile.mdropoutdate]=="null"||map[TablesColumnFile.mdropoutdate]==null)?null:DateTime.parse(map[TablesColumnFile.mdropoutdate]) as DateTime,
      mmobno: map[TablesColumnFile.mmobno] as String,
      mpanno: map[TablesColumnFile.mpanno] as int,
      mpannodesc: map[TablesColumnFile.mpannodesc] as String,
      mtdsyn: map[TablesColumnFile.mtdsyn] as String,
      mtdsreasoncd: map[TablesColumnFile.mtdsreasoncd] as int,
      mtdsfrm15subdt:  (map[TablesColumnFile.mtdsfrm15subdt]=="null"||map[TablesColumnFile.mtdsfrm15subdt]==null)?null:DateTime.parse(map[TablesColumnFile.mtdsfrm15subdt]) as DateTime,
      memailId: map[TablesColumnFile.memailId] as String,
      mcustcategory: map[TablesColumnFile.mcustcategory] as String,
        mtier: map[TablesColumnFile.mtier] as int,
      mAdd1: map[TablesColumnFile.mAdd1] as String,
      mAdd2: map[TablesColumnFile.mAdd2] as String,
      mAdd3: map[TablesColumnFile.mAdd3] as String,
      mArea: map[TablesColumnFile.marea] as int,
      mPinCode: map[TablesColumnFile.mPinCode] as String,
      mCounCd: map[TablesColumnFile.mCounCd] as String,
      mCityCd: map[TablesColumnFile.mCityCd] as String,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mgender: map[TablesColumnFile.mgender] as String,
      mrelegion: map[TablesColumnFile.mrelegion] as String,
      mRuralUrban: map[TablesColumnFile.mRuralUrban] as String,
      mcaste: map[TablesColumnFile.mcaste] as String,
      mqualification: map[TablesColumnFile.mqualification] as String,
      moccupation: map[TablesColumnFile.moccupation] as int,
      mLandType: map[TablesColumnFile.mLandType] as String,
      mLandMeasurement: map[TablesColumnFile.mLandMeasurement] as String,
      mmaritialStatus: map[TablesColumnFile.mmaritialStatus] as int,
      mTypeOfId: map[TablesColumnFile.mTypeOfId] as int,
      mIdDesc: map[TablesColumnFile.mIdDesc] as String,
      mInsuranceCovYN: map[TablesColumnFile.mInsuranceCovYN] as String,
      mTypeofCoverage: map[TablesColumnFile.mTypeofCoverage] as int,

      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,


      ifYesThen:			map[TablesColumnFile.ifYesThen] as String,

      mShopName:			map[TablesColumnFile.mShopName] as String,
      mShpAdd:			map[TablesColumnFile.mShpAdd] as String,
      mYrsInBz:			map[TablesColumnFile.mYrsInBz] as int,
      mregNum:			map[TablesColumnFile.mregNum] as String,
      //mid1:			map[TablesColumnFile.mid1] as String,
      //mid2:			map[TablesColumnFile.mid2] as String,
      mHouse:			map[TablesColumnFile.mhouse] as String,
      mAgricultureType:			map[TablesColumnFile.mAgricultureType] as String,
      mIsMbrGrp:			map[TablesColumnFile.mIsMbrGrp] as int,
      mLoanAgreed:			map[TablesColumnFile.mLoanAgreed] as int,
      mGend:			map[TablesColumnFile.mGend] as int,
      mInsurance:			map[TablesColumnFile.mInsurance] as int,
      //mRegion:			map[TablesColumnFile.mRegion] as int,
      mConstruct:			map[TablesColumnFile.mConstruct] as int,
      mToilet:			map[TablesColumnFile.mToilet] as int,
      //mBankAccYN:			map[TablesColumnFile.mBankAccYN] as int,
      mhousBizSp:			map[TablesColumnFile.mhousBizSp] as int,
      mBzRegs:			map[TablesColumnFile.mBzRegs] as int,
      mBzTrnd:			map[TablesColumnFile.mBzTrnd] as int,
      misCbCheckDone:			map[TablesColumnFile.misCbCheckDone] as int,
      merrormessage:			map[TablesColumnFile.merrormessage] as String,
      mcentername : map[TablesColumnFile.mcentername] as String,
      mgroupname : map[TablesColumnFile.mgroupname] as String,
      mexpsramt : map[TablesColumnFile.mexpsramt] as double,
      mcbcheckrprtdt:(map[TablesColumnFile.mcbcheckrprtdt]=="null"||map[TablesColumnFile.mcbcheckrprtdt]==null)?null:DateTime.parse(map[TablesColumnFile.mcbcheckrprtdt]) as DateTime,
      // : map[TablesColumnFile.mcbcheckrprtdt] as DateTime,
      motpvrfdno:map[TablesColumnFile.motpvrfdno] as String,
      mhusdob:(map[TablesColumnFile.mhusdob]=="null"||map[TablesColumnFile.mhusdob]==null)?null:DateTime.parse(map[TablesColumnFile.mhusdob]) as DateTime,
      mprofileind : map[TablesColumnFile.mprofileind] as String,
      mlangofcust : map[TablesColumnFile.mlangofcust] as String,
      mmainoccupn : map[TablesColumnFile.mmainoccupn] as String,
      msuboccupn : map[TablesColumnFile.msuboccupn] as String,
      msecoccupatn : map[TablesColumnFile.msecoccupatn] as int,

    familyDetailsList:map[TablesColumnFile.familyDetails].map<FamilyDetailsBean>((i) =>
        FamilyDetailsBean.fromMap(i))
        .toList(),
      socialFinancialList:map[TablesColumnFile.bankDetails].map<SocialFinancialDetailsBean>((i) =>
          SocialFinancialDetailsBean.fromMap(i))
          .toList(),
      borrowingDetailsBean: map[TablesColumnFile.borrowingDetails].map<BorrowingDetailsBean>((i) => BorrowingDetailsBean.fromMap(i))
          .toList(),

      addressDetails : map[TablesColumnFile.addressDetails].map<AddressDetailsBean>((i) => AddressDetailsBean.fromMap(i))
          .toList(),
      customerBusinessDetailsBean: map[TablesColumnFile.customerBussDetails].map<CustomerBusinessDetailsBean>((i) => CustomerBusinessDetailsBean.fromMap(i))
            .toList(),
      imageMaster: map[TablesColumnFile.imageMaster]==null?null: map[TablesColumnFile.imageMaster].map<ImageBean>((i) => ImageBean.fromMapFromMiddleWare(i))
          .toList(),
     // businessExpendDetailsList: map[TablesColumnFile.businessExpendDetails].map<BusinessExpenditureDetailsBean>((i) => BusinessExpenditureDetailsBean.fromMap(i))
       //   .toList(),
/*
      householdExpendDetailsList: map[TablesColumnFile.householdExpendDetails].map<HouseholdExpenditureDetailsBean>((i) => HouseholdExpenditureDetailsBean.fromMap(i))
          .toList(),
*/
      assetDetailsList: map[TablesColumnFile.assetDetailsList].map<AssetDetailsBean>((i) => AssetDetailsBean.fromMap(i))
          .toList(),
      fixedAssetsList:map[TablesColumnFile.fixedAssetsList]==null?null:FixedAssetsBean.fromMapMiddleware(map[TablesColumnFile.fixedAssetsList]),
      currentAssetsList:map[TablesColumnFile.currentAssetsList]==null?null:CurrentAssetsBean.fromMapMiddleware(map[TablesColumnFile.currentAssetsList]),
      longTermLiabilitiesList:map[TablesColumnFile.longTermLiabilitiesList]==null?null:LongTermLiabilitiesBean.fromMapMiddleware(map[TablesColumnFile.longTermLiabilitiesList]),
      shortTermLiabilitiesList:map[TablesColumnFile.shortTermLiabilitiesList]==null?null:ShortTermLiabilitiesBean.fromMapMiddleware(map[TablesColumnFile.shortTermLiabilitiesList]),
      equityList:map[TablesColumnFile.equityList]==null?null:EquityBean.fromMapMiddleware(map[TablesColumnFile.equityList]),


      esmsentity: map[TablesColumnFile.esmsentity]==null?null:ESMSBean.fromMapMiddleware(map[TablesColumnFile.esmsentity]),
      riskratingsentity: map[TablesColumnFile.riskratingsentity]==null?null:RiskRatingsBean.fromMapMiddleware(map[TablesColumnFile.riskratingsentity]),
     /* fixedAssetsList: map[TablesColumnFile.fixedAssetsList].map<FixedAssetsBean>((i) => FixedAssetsBean.fromMap(i))
          .toList(),
      currentAssetsList: map[TablesColumnFile.currentAssetsList].map<CurrentAssetsBean>((i) => CurrentAssetsBean.fromMap(i))
          .toList(),
      longTermLiabilitiesList: map[TablesColumnFile.longTermLiabilitiesList].map<LongTermLiabilitiesBean>((i) => LongTermLiabilitiesBean.fromMap(i))
          .toList(),
      shortTermLiabilitiesList: map[TablesColumnFile.shortTermLiabilitiesList].map<ShortTermLiabilitiesBean>((i) => ShortTermLiabilitiesBean.fromMap(i))
          .toList(),
      equityList: map[TablesColumnFile.equityList].map<EquityBean>((i) => EquityBean.fromMap(i))
          .toList(),*/
      incomeStatementList:map[TablesColumnFile.incomeStatementList]==null?null:IncomeStatementBean.fromMapMiddleware(map[TablesColumnFile.incomeStatementList]),
      financialStmntList:map[TablesColumnFile.financialStmntList]==null?null:FinancialStmntBean.fromMapMiddleware(map[TablesColumnFile.financialStmntList]),

      mnametitle2: map[TablesColumnFile.mnametitle2] as String,
      mlongname2: map[TablesColumnFile.mlongname2] as String,
      mfname2: map[TablesColumnFile.mfname2] as String,
      mmname2: map[TablesColumnFile.mmname2] as String,
      mlname2: map[TablesColumnFile.mlname2] as String,
      mnationality: map[TablesColumnFile.mnationality] as String,

      mid1issuedate: (map[TablesColumnFile.mid1issuedate]=="null"||map[TablesColumnFile.mid1issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid1issuedate]) as DateTime,
      mid2issuedate: (map[TablesColumnFile.mid2issuedate]=="null"||map[TablesColumnFile.mid2issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid2issuedate]) as DateTime,
      mid1expdate: (map[TablesColumnFile.mid1expdate]=="null"||map[TablesColumnFile.mid1expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid1expdate]) as DateTime,
      mid2expdate: (map[TablesColumnFile.mid2expdate]=="null"||map[TablesColumnFile.mid2expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid2expdate]) as DateTime,
      totalExpenditureDetailsBean:map[TablesColumnFile.totalExpenditureDetailsBean]==null?null:TotalExpenditureDetailsBean.fromMap(map[TablesColumnFile.totalExpenditureDetailsBean]),

      mid3issuedate: (map[TablesColumnFile.mid3issuedate]=="null"||map[TablesColumnFile.mid3issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid3issuedate]) as DateTime,
      mid3expdate: (map[TablesColumnFile.mid3expdate]=="null"||map[TablesColumnFile.mid3expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid3expdate]) as DateTime,
      missngautryt1: map[TablesColumnFile.missngautryt1] as String,
      missngautryt2: map[TablesColumnFile.missngautryt2] as String,
      missngautryt3: map[TablesColumnFile.missngautryt3] as String,
      mtypeofid3: map[TablesColumnFile.mtypeofid3] as int,
      middesc3: map[TablesColumnFile.middesc3] as String,
      macctbal : map[TablesColumnFile.macctbal] as double,
      misearngmembr:map[TablesColumnFile.misearngmembr] as String,
      misstudyingmembr:map[TablesColumnFile.misstudyingmembr] as String,
      mmemberno: map[TablesColumnFile.mmemberno]as String,
      mischldrn: map[TablesColumnFile.mischldrn]as String,
      mbusinessname: map[TablesColumnFile.mbusinessname]as String,
      mtarget: map[TablesColumnFile.mtarget]as String,
      mownership: map[TablesColumnFile.mownership]as String,
      mresstatus: map[TablesColumnFile.mresstatus]as String,
      mdedupnationalid: map[TablesColumnFile.mdedupnationalid]as String,
      miscpemp: map[TablesColumnFile.miscpemp]as String,
      mrankofemp: map[TablesColumnFile.mrankofemp]as String,
      mempid: map[TablesColumnFile.mempid]as String,
    );}



  factory CustomerListBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map,bool isFromMiddleware) {
    return CustomerListBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,

      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
  merrormessage:			map[TablesColumnFile.merrormessage] as String,

      familyDetailsList:map[TablesColumnFile.familyDetails]==null?null:map[TablesColumnFile.familyDetails].map<FamilyDetailsBean>((i) =>
          FamilyDetailsBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),

      socialFinancialList :map[TablesColumnFile.bankDetails]==null?null:map[TablesColumnFile.bankDetails].map<SocialFinancialDetailsBean>((i) =>
          SocialFinancialDetailsBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),
      borrowingDetailsBean:map[TablesColumnFile.borrowingDetails]==null?null: map[TablesColumnFile.borrowingDetails].map<BorrowingDetailsBean>((i) => BorrowingDetailsBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),
      addressDetails : map[TablesColumnFile.addressDetails]==null?null:map[TablesColumnFile.addressDetails].map<AddressDetailsBean>((i) => AddressDetailsBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),
      customerBusinessDetailsBean: map[TablesColumnFile.customerBussDetails]==null?null:map[TablesColumnFile.customerBussDetails].map<CustomerBusinessDetailsBean>((i) => CustomerBusinessDetailsBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),
      imageMaster:  map[TablesColumnFile.imageMaster]==null?null:map[TablesColumnFile.imageMaster].map<ImageBean>((i) => ImageBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),

      assetDetailsList: map[TablesColumnFile.assetDetailsList]==null?null:map[TablesColumnFile.assetDetailsList].map<AssetDetailsBean>((i) => AssetDetailsBean.fromMapMiddlewareFroMrefNoOnly(i))
          .toList(),
      fixedAssetsList:map[TablesColumnFile.fixedAssetsList]==null?null:FixedAssetsBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.fixedAssetsList]),
      currentAssetsList:map[TablesColumnFile.currentAssetsList]==null?null:CurrentAssetsBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.currentAssetsList]),
      longTermLiabilitiesList:map[TablesColumnFile.longTermLiabilitiesList]==null?null:LongTermLiabilitiesBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.longTermLiabilitiesList]),
      shortTermLiabilitiesList:map[TablesColumnFile.shortTermLiabilitiesList]==null?null:ShortTermLiabilitiesBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.shortTermLiabilitiesList]),
      equityList:map[TablesColumnFile.equityList]==null?null:EquityBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.equityList]),
      incomeStatementList:map[TablesColumnFile.incomeStatementList]==null?null:IncomeStatementBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.incomeStatementList]),
      financialStmntList:map[TablesColumnFile.financialStmntList]==null?null:FinancialStmntBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.financialStmntList]),
      totalExpenditureDetailsBean:map[TablesColumnFile.totalExpenditureDetailsBean]==null?null:TotalExpenditureDetailsBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.totalExpenditureDetailsBean]),
      esmsentity: map[TablesColumnFile.esmsentity]==null?null:ESMSBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.esmsentity]),
      riskratingsentity: map[TablesColumnFile.riskratingsentity]==null?null:RiskRatingsBean.fromMapMiddlewareFroMrefNoOnly(map[TablesColumnFile.riskratingsentity]),
      mid3issuedate: (map[TablesColumnFile.mid3issuedate]=="null"||map[TablesColumnFile.mid3issuedate]==null)?null:DateTime.parse(map[TablesColumnFile.mid3issuedate]) as DateTime,
      mid3expdate: (map[TablesColumnFile.mid3expdate]=="null"||map[TablesColumnFile.mid3expdate]==null)?null:DateTime.parse(map[TablesColumnFile.mid3expdate]) as DateTime,
      missngautryt1: map[TablesColumnFile.missngautryt1] as String,
      missngautryt2: map[TablesColumnFile.missngautryt2] as String,
      missngautryt3: map[TablesColumnFile.missngautryt3] as String,
      mtypeofid3: map[TablesColumnFile.mtypeofid3] as int,
      middesc3: map[TablesColumnFile.middesc3] as String,
      macctbal : map[TablesColumnFile.macctbal] as double,

      misearngmembr:map[TablesColumnFile.misearngmembr] as String,
      misstudyingmembr:map[TablesColumnFile.misstudyingmembr] as String,
      mmemberno: map[TablesColumnFile.mmemberno]as String,
      mischldrn: map[TablesColumnFile.mischldrn]as String,
      mbusinessname: map[TablesColumnFile.mbusinessname]as String,
      mtarget: map[TablesColumnFile.mtarget]as String,
      mownership: map[TablesColumnFile.mownership]as String,
      mresstatus: map[TablesColumnFile.mresstatus]as String,
      mdedupnationalid: map[TablesColumnFile.mdedupnationalid]as String,
    );
  }
  factory CustomerListBean.fromMapMiddlewareDedup(Map<String, dynamic> map,bool isFromMiddleware) {
    return CustomerListBean(

      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      miscpemp: map[TablesColumnFile.miscpemp]as String,
      mrankofemp: map[TablesColumnFile.mrankofemp]as String,
      mempid: map[TablesColumnFile.mempid]as String,
      mcreatedby:map[TablesColumnFile.mcreatedby],
    );
  }

}
