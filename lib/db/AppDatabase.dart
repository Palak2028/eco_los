import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_los/pages/timelines/ChartsBean.dart';
import 'package:eco_los/pages/timelines/Timelines_Dashboard.dart';
import 'package:eco_los/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_los/pages/workflow/Collateral/Bean/CollateralBasicSelectionBean.dart';
import 'package:eco_los/pages/workflow/CollateralREM/Bean/CollateralREMlandandhouseBean.dart';
import 'package:eco_los/pages/workflow/CollatralVehicle/CollateralVehicleBean.dart';
import 'package:eco_los/pages/workflow/DocumentCollector/DocumentCollectorBean.dart';
import 'package:eco_los/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/HbsUserBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ESMSBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FinancialStmntBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/IncomeStatementBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/RiskRatingsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/SocialFinancialDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/TotalExpenditureDetailsBean.dart';
import 'package:flutter/material.dart';
import 'package:eco_los/LoginBean.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/main.dart';
import 'package:eco_los/models/Label.dart';
import 'package:eco_los/models/Project.dart';
import 'package:eco_los/models/TaskLabels.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';
import 'package:eco_los/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_los/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_los/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_los/pages/workflow/InterestOffsetMaster/InterestOffsetBean.dart';
import 'package:eco_los/pages/workflow/InterestOffsetMaster/InterestOffsetServices.dart';
import 'package:eco_los/pages/workflow/InterestSlabMaster/InterestSlabBean.dart';
import 'package:eco_los/pages/workflow/InterestSlabMaster/InterestSlabServices.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/RepaymentFrequency.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/TransactionMode.dart';
import 'package:eco_los/pages/workflow/LoanApprovalLimit/LoanApprovalLimitBean.dart';
import 'package:eco_los/pages/workflow/LoanApprovalLimit/LoanApprovalLimitServices.dart';
import 'package:eco_los/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryBean.dart';
import 'package:eco_los/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryServices.dart';
import 'package:eco_los/pages/workflow/LoanCycleParameterSecondaryTable/LoanCycleParameterSecondaryBean.dart';
import 'package:eco_los/pages/workflow/LoanCycleParameterSecondaryTable/LoanCycleParameterSecondaryServices.dart';

import 'package:eco_los/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';
import 'package:eco_los/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_los/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_los/pages/workflow/SpeedoMeter/bean/SpeedoMeterBean.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_los/pages/workflow/SystemParameter/SystemParameterServices.dart';
import 'package:eco_los/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_los/pages/workflow/address/beans/CountryDropDownBean.dart';
import 'package:eco_los/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_los/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_los/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_los/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/Bean/NOCImageBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/Bean/SettingsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingLookupDataServices.dart';
import 'package:eco_los/pages/workflow/LookupMasterBean.dart';

import 'package:eco_los/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_los/pages/workflow/creditBereau/Bean/CbResultBean.dart';

import 'package:eco_los/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingSubLookupDataServices.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingTDOffsetInteresetMasterServices.dart';
import 'package:eco_los/pages/workflow/syncingActivity/SyncingTDRoiDataServices.dart';
import 'package:eco_los/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:eco_los/pages/workflow/termDeposit/ProductwiseInterestTableBean.dart';
import 'package:eco_los/pages/workflow/termDeposit/TDOffsetInterestMasterBean.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eco_los/models/Tasks.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/pages/workflow/syncingActivity/SyncingLookupDataServices.dart';

/// This is the singleton database class which handlers all database transactions
/// All the task raw queries is handle here and return a Future<T> with result
class AppDatabase {
  String timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
  static final AppDatabase _appDatabase = new AppDatabase._internal();
  static final userMasterTable = "User_Master";
  static final LookupMaster = "Lookup_Master";
  static final SystemParameterMaster = "System_Parameter_Master";
  static final TermDepositMaster = "Term_Deposit_Master";
  static final TDProductwiseInterestTable = "TD_Productwise_interest_table";
  static final TDOffsetInterestMaster = "TD_Offset_Interest_Master";

  static final InterestSlabMaster = "Interest_Slab_Master";
  static final InterestOffsetMaster = "Interest_Offset_Master";
  static final LoanCycleParameterPrimaryMaster =
      "Loan_Cycle_Parameter_Primary_Master";
  static final LoanCycleParameterSecondaryMaster =
      "Loan_Cycle_Parameter_Secondary_Master";

  static final SubLookupMaster = "Sub_Lookup_Master";
  static final creditBereauMaster = "Credit_Bereau_Master";
  static final creditBereauBatchMaster = "Credit_Bereau_Batch_Master";
  static final creditBereauResultMaster = "Credit_Bereau_Result_Master";

  //static final creditBereauResultDetailsMaster="Credit_Bereau_Result_Details_Master";
  static final creditBereauLoanDetailsMaster =
      "Credit_Bereau_Loan_Details_Master";
  static final groupFoundationMaster = "Group_Foundation";
  static final centerDetailsMaster = "Center_Details_Master";

  //static final centerFoundationMaster = "Center_Foundation_Master";
  //changes of restructure
  static final lastSyncedDateTimeMaster = "lastSyncedDateTimeMaster";
  static final customerFoundationMasterDetails =
      "customerFoundationMasterDetails";
  static final customerFoundationFamilyMasterDetails =
      "customerFoundationFamilyMasterDetails";

  static final bankDetailsMaster="bankDetailsMaster";
  static final customerFoundationAddressMasterDetails =
      "customerFoundationAddressMasterDetails";
  static final customerFoundationBorrowingMasterDetails =
      "customerFoundationBorrowingMasterDetails";
  static final customerBusinessDetailMaster = "CustomerBusinessDetailMaster";

  //changes of restructure ends
  static final imageMaster = "Image_Master";

  static final productMaster = "Product_Master";
  static final purposeMaster = "Purpose_Master";
  static final transactionModeMaster = "Transaction_Mode_Master";
  static final repaymentFrequencyMaster = "repayment_Frequency_Master";
  static final customerLoanDetailsMaster = "customer_Loan_Details_Master";
  static final loanUtilizationMaster =
      "loan_Utilization_Master";
  static final savingsCollectionMaster = "savings_Collection_Master";
  static final gaurantorMaster = "gaurantor_Master";
  static final savingsMaster = "savings_Master";
  static final miniStatementMaster = "mini_Statement_Master";
  static final settingsMaster = "settings_Master";
  static final customerNOCImageMaster = "customer_NOC_Image_Master";

  //static final checkListMaster = "check_list_Master";
  static final cgt1QaMaster = "CGT1_QA_Master";
  static final cgt2QaMaster = "CGT2_QA_Master";
  static final grtQaMaster = "GRT_QA_Master";
  static final CGT1Master = "CGT1_Master";
  static final CGT2Master = "CGT2_Master";
  static final GRTMaster = "GRT_Master";
  static final speedoMeterMaster = "SpeedoMeter_Master";
  static final countryMaster = "Country_Master";
  static final stateMaster = "State_Master";
  static final districtMaster = "District_Master";
  static final subDistrictMaster = "SubDistrict_Master";
  static final areaMaster = "Area_Master";
  static final businessExpenseMaster = "Business_Expense_Master";
  static final houseExpenseMaster = "Household_Expense_Master";
  static final assetDetailMaster = "Asset_Detail_Master";
  static final collectionMaster = "collection_Master";
  static final collectedLoansAmtMaster = "collected_LoansAmt_Master";
  static final loanApprovalLimitMaster = "Loan_Approval_limit_Master";
  static final branchMaster = "Branch_Master";
  static final fixedAssetMaster = "Fixed_Asset_Master";
  static final currentAssetMaster = "Current_Asset_Master";
  static final longTermLiabilitiesMaster = "LongTerm_Liabilities_Master";
  static final shortTermLiabilitiesMaster = "ShortTerm_Liabilities_Master";
  static final equityMaster = "Equity_Master";
  static final incomeStatementMaster = "Income_Statement_Master";
  static final financialStatementMaster = "Financial_Statement_Master";
  static final collateralsMaster = "Collaterals_Master";
  
   static final collateralVehicleMaster = "Collateral_Vehicle_Master";
  static final CollateralREMlandandhouseMaster="Collateral_REM_land_and_house_Master";
  static final totalExpndtrMaster = "Total_Expentiture_details";
  static final ESMSMaster = "ESMS_Master";
  static final RISKRATINGSMASTER = "RISK_RATINGS_MASTER";
  static final CHARTMASTER = "Charts_Master";
  static final CHARTFILTERMASTER = "Charts_Filter_Master";
  static final GETHBSUSERS = "Get_Hbs_Users";
  static final DOCUMENTSMASTER = "Documents_Master";

  bool chk = false;

  //private internal constructor to make it singleton
  AppDatabase._internal();

  CreditBereauBean creditbean = new CreditBereauBean();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "microfinance.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await _createProjectTable(db);
          await _createTaskTable(db);
          await _createLabelTable(db);
          await _createUserMasterTable(db);
          await _createTermDepositMasterTable(db);
          await _createTDProductwiseInterestTable(db);
          await _createTDOffsetInterestMaster(db);
          await _createCustomerFoundationMasterDetailsTable(db);
          await _createCreditbereauMaster(db);
          await _createCreditBereauResult(db);
          await _createCreditBereauLoanDetails(db);
          await _createGroupFoundation(db);
          await _createCenterFoundation(db);
          await _createImageMaster(db);
          await _createCustomerFoundationFamilyDetailsTable(db);
          await _createCustomerFoundationBankDetailsTable(db);
          await _createLastSyncedDateTimeMaster(db);
          await _createCustomerFoundationBorrowingDetailsTable(db);
          await _createCustomerFoundationAddressDetailsBeanTable(db);
          await _createProductMaster(db);
          await _createPurposeMaster(db);
          await _createTransactionModeMaster(db);
          await _createRepaymentFrequencyMaster(db);
          await _createCustomerLoanDetailsMaster(db);
          await _createLoanUtilizationMaster(db);
          await _createLookupMasterTable(db);
          await _createInterestSlabMasterTable(db);
          await _createSystemParameterMasterTable(db);
          await _createLoanCycleParameterPrimaryMasterTable(db);
          await _createLoanCycleParameterSecondaryMasterTable(db);
          await _createInterestOffsetMasterTable(db);
          await _createSubLookupMasterTable(db);
          await _createNOCImageMaster(db);
          await createCollateralREMlandandhouseMasterTable(db);
          //await _createCheckListMaster(db);
          await _createCgt1QaMaster(db);
          await _createCgt2QaMaster(db);
          await _createGrtQaMaster(db);
          await _createSavingsCollectionMaster(db);
          await _createGaurantorMaster(db);
          await _createSettingsMaster(db);
          await _createminiStatementMaster(db);
          await _createSavingsMaster(db);
          await _createCGT1Master(db);
          await _createCGT2Master(db);
          await _createGRTMaster(db);
          await _createSpeedoMeterMaster(db);
          await _createCountryMaster(db);
          await _createStateMaster(db);
          await _createDistrictMaster(db);
          await _createSubDistrictMaster(db);
          await _createAreaMaster(db);
          await _createCustomerBusinessDetailMaster(db);
          await _createBusinessExpenseMaster(db);
          await _createHouseExpenseMaster(db);
          await _createAssetDetailMaster(db);
          await _createCollectionMasterTable(db);
          await _createCollectedLoanAmtMasterTable(db);
          await _createLoanApprovalLimitMasterTable(db);
          await _createFixedAssetMaster(db);
          await _createCurrentAssetMaster(db);
          await _createLongTermLiabilitiesMaster(db);
          await _createBranchMasterTable(db);
          await _createShortTermLiabilitiesMaster(db);
          await _createEquityMaster(db);
          await _createIncomeStatementMaster(db);
          await _createFinancialStatementMaster(db);
          await _createCollateralsMaster(db);
	  await createCollateralVehicleMasterTable(db);
          await _createTotalExpendtrMaster(db);
	   await _createESMSMasterTable(db);
          await _createRiskRatingsMaster(db);
          await _createChartsMaster(db);
          await _createChartsFilterMaster(db);
          await _createHbsUSersMaster(db);
          await _createDocumentsMaster(db);
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          await db.execute("DROP TABLE ${Tasks.tblTask}");
          await db.execute("DROP TABLE ${Project.tblProject}");
          await db.execute("DROP TABLE ${TaskLabels.tblTaskLabel}");
          await db.execute("DROP TABLE ${Label.tblLabel}");
          await db.execute("DROP TABLE $userMasterTable");
          await db.execute("DROP TABLE $creditBereauMaster");
          await db.execute("DROP TABLE $creditBereauResultMaster");
          await db.execute("DROP TABLE $creditBereauLoanDetailsMaster");
          await db.execute("DROP TABLE $groupFoundationMaster");
          await db.execute("DROP TABLE $centerDetailsMaster");
          await db.execute("DROP TABLE $imageMaster");
          await db.execute("DROP TABLE $LookupMaster");
          await db.execute("DROP TABLE $SystemParameterMaster");
          await db.execute("DROP TABLE $InterestSlabMaster");
          await db.execute("DROP TABLE $InterestOffsetMaster");
          await db.execute("DROP TABLE $LoanCycleParameterPrimaryMaster");
          await db.execute("DROP TABLE $LoanCycleParameterSecondaryMaster");

          await db.execute("DROP TABLE $SubLookupMaster");
          await db.execute("DROP TABLE $lastSyncedDateTimeMaster");
          await db.execute("DROP TABLE $customerFoundationFamilyMasterDetails");
          await db.execute("DROP TABLE $bankDetailsMaster");


          await db.execute(
              "DROP TABLE $customerFoundationBorrowingMasterDetails");
          await db.execute("DROP TABLE $customerFoundationMasterDetails");
          await db.execute(
              "DROP TABLE $customerFoundationAddressMasterDetails");
          await db.execute("DROP TABLE $productMaster");
          await db.execute("DROP TABLE $purposeMaster");
          await db.execute("DROP TABLE $transactionModeMaster");
          await db.execute("DROP TABLE $repaymentFrequencyMaster");
          await db.execute("DROP TABLE $customerLoanDetailsMaster");
          await db.execute("DROP TABLE $loanUtilizationMaster");
          await db.execute("DROP TABLE $settingsMaster");
          await db.execute("DROP TABLE $savingsMaster");
          await db.execute("DROP TABLE $miniStatementMaster");


          await db.execute("DROP TABLE $savingsCollectionMaster");
          await db.execute("DROP TABLE $gaurantorMaster");



          await db.execute("DROP TABLE $customerNOCImageMaster");
          //await db.execute("DROP TABLE $checkListMaster");
          await db.execute("DROP TABLE $cgt1QaMaster");
          await db.execute("DROP TABLE $cgt2QaMaster");
          await db.execute("DROP TABLE $grtQaMaster");
          await db.execute("DROP TABLE $CGT1Master");
          await db.execute("DROP TABLE $CGT2Master");
          await db.execute("DROP TABLE $GRTMaster");
          await db.execute("DROP TABLE $speedoMeterMaster");
          await db.execute("DROP TABLE $countryMaster");
          await db.execute("DROP TABLE $stateMaster");
          await db.execute("DROP TABLE $districtMaster");
          await db.execute("DROP TABLE $subDistrictMaster");
          await db.execute("DROP TABLE $areaMaster");
          await db.execute("DROP TABLE $businessExpenseMaster");
          await db.execute("DROP TABLE $houseExpenseMaster");
          await db.execute("DROP TABLE $assetDetailMaster");
          await db.execute("DROP TABLE $collectionMaster");
          await db.execute("Drop TABLE $collectedLoansAmtMaster");
          await db.execute("Drop TABLE $loanApprovalLimitMaster");
          await db.execute("DROP TABLE $branchMaster");
          await db.execute("DROP TABLE $fixedAssetMaster");
          await db.execute("DROP TABLE $currentAssetMaster");
          await db.execute("DROP TABLE $longTermLiabilitiesMaster");
          await db.execute("DROP TABLE $shortTermLiabilitiesMaster");
          await db.execute("DROP TABLE $equityMaster");
          await db.execute("DROP TABLE $incomeStatementMaster");
          await db.execute("DROP TABLE $financialStatementMaster");
          await db.execute("DROP TABLE $collateralsMaster");
	        await db.execute("DROP TABLE ${collateralVehicleMaster}");
          await db.execute("DROP TABLE ${CollateralREMlandandhouseMaster}");
          await db.execute("DROP TABLE ${totalExpndtrMaster}");
	   await db.execute("DROP TABLE ${ESMSMaster}");
          await db.execute("DROP TABLE ${RISKRATINGSMASTER}");
          await db.execute("DROP TABLE ${CHARTMASTER}");
          await db.execute("DROP TABLE ${CHARTFILTERMASTER}");
          await db.execute("DROP TABLE ${GETHBSUSERS}");
          await db.execute("DROP TABLE ${DOCUMENTSMASTER}");
          await _createTermDepositMasterTable(db);
          await _createTDProductwiseInterestTable(db);
          await _createTDOffsetInterestMaster(db);
          await _createUserMasterTable(db);
          await _createCustomerFoundationMasterDetailsTable(db);
          await _createProjectTable(db);
          await _createTaskTable(db);
          await _createLabelTable(db);
          await _createCreditbereauMaster(db);
          await _createCreditBereauResult(db);
          await _createCreditBereauLoanDetails(db);
          await _createGroupFoundation(db);
          await _createCenterFoundation(db);
          await _createImageMaster(db);
          await _createLastSyncedDateTimeMaster(db);
          await _createCustomerFoundationFamilyDetailsTable(db);
          await _createCustomerFoundationBankDetailsTable(db);
          await _createCustomerFoundationBorrowingDetailsTable(db);
          await _createCustomerFoundationAddressDetailsBeanTable(db);
          await _createProductMaster(db);
          await _createPurposeMaster(db);
          await _createTransactionModeMaster(db);
          await _createRepaymentFrequencyMaster(db);
          await _createCustomerLoanDetailsMaster(db);
          await _createLoanUtilizationMaster(db);
          await _createLookupMasterTable(db);
          await _createInterestSlabMasterTable(db);
          await _createInterestSlabMasterTable(db);
          await _createInterestOffsetMasterTable(db);
          await _createLoanCycleParameterPrimaryMasterTable(db);
          await _createLoanCycleParameterSecondaryMasterTable(db);
          await _createSubLookupMasterTable(db);

          await _createNOCImageMaster(db);
          await createCollateralREMlandandhouseMasterTable(db);
          //await _createCheckListMaster(db);
          await _createCgt1QaMaster(db);
          await _createCgt2QaMaster(db);
          await _createGrtQaMaster(db);
          await _createSavingsCollectionMaster(db);
          await _createGaurantorMaster(db);
          await _createSettingsMaster(db);
          await _createminiStatementMaster(db);
          await _createSavingsMaster(db);
          await _createCGT1Master(db);
          await _createCGT2Master(db);
          await _createGRTMaster(db);
          await _createSpeedoMeterMaster(db);
          await _createCountryMaster(db);
          await _createStateMaster(db);
          await _createDistrictMaster(db);
          await _createSubDistrictMaster(db);
          await _createAreaMaster(db);
          await _createCustomerBusinessDetailMaster(db);
          await _createBusinessExpenseMaster(db);
          await _createHouseExpenseMaster(db);
          await _createAssetDetailMaster(db);
          await _createCollectionMasterTable(db);
          await _createCollectedLoanAmtMasterTable(db);
          await _createLoanApprovalLimitMasterTable(db);
          await _createBranchMasterTable(db);
          await _createFixedAssetMaster(db);
          await _createCurrentAssetMaster(db);
          await _createLongTermLiabilitiesMaster(db);
          await _createShortTermLiabilitiesMaster(db);
          await _createEquityMaster(db);
          await _createIncomeStatementMaster(db);
          await _createFinancialStatementMaster(db);
          await _createCollateralsMaster(db);
	   await createCollateralVehicleMasterTable(db);
          await _createTotalExpendtrMaster(db);
	    await _createESMSMasterTable(db);
          await _createRiskRatingsMaster(db);
          await _createChartsMaster(db);
          await _createChartsFilterMaster(db);
          await _createHbsUSersMaster(db);
          await _createDocumentsMaster(db);
        });
    didInit = true;
  }

  Future _createProjectTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Project.tblProject} ("
          "${Project.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Project.dbName} TEXT,"
          "${Project.dbColorName} TEXT,"
          "${Project.dbColorCode} INTEGER);");
      txn.rawInsert('INSERT INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project
          .dbColorName},${Project.dbColorCode})'
          ' VALUES(1, "Inbox", "Grey", ${Colors.grey.value});');
    });
  }

  Future _createLabelTable(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${Label.tblLabel} ("
          "${Label.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Label.dbName} TEXT,"
          "${Label.dbColorName} TEXT,"
          "${Label.dbColorCode} INTEGER);");
      txn.execute("CREATE TABLE ${TaskLabels.tblTaskLabel} ("
          "${TaskLabels.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${TaskLabels.dbTaskId} INTEGER,"
          "${TaskLabels.dbLabelId} INTEGER,"
          "FOREIGN KEY(${TaskLabels.dbTaskId}) REFERENCES ${Tasks
          .tblTask}(${Tasks.dbId}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TaskLabels.dbLabelId}) REFERENCES ${Label
          .tblLabel}(${Label.dbId}) ON DELETE CASCADE);");
    });
  }

  Future _createTaskTable(Database db) {
    return db.execute("CREATE TABLE ${Tasks.tblTask} ("
        "${Tasks.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Tasks.dbTitle} TEXT,"
        "${Tasks.dbComment} TEXT,"
        "${Tasks.dbDueDate} LONG,"
        "${Tasks.dbPriority} LONG,"
        "${Tasks.dbProjectID} LONG,"
        "${Tasks.dbStatus} LONG,"
        "FOREIGN KEY(${Tasks.dbProjectID}) REFERENCES ${Project
        .tblProject}(${Project.dbId}) ON DELETE CASCADE);");
  }

  Future<List<Tasks>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) async {
    var db = await _getDb();
    var whereClause = startDate > 0 && endDate > 0
        ? "WHERE ${Tasks.tblTask}.${Tasks
        .dbDueDate} BETWEEN $startDate AND $endDate"
        : "";

    if (taskStatus != null) {
      var taskWhereClause =
          "${Tasks.tblTask}.${Tasks.dbStatus} = ${taskStatus.index}";
      whereClause = whereClause.isEmpty
          ? "WHERE $taskWhereClause"
          : "$whereClause AND $taskWhereClause";
    }

    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project
            .dbName},${Project.tblProject}.${Project
            .dbColorCode},group_concat(${Label.tblLabel}.${Label
            .dbName}) as labelNames '
            'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels
            .tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels
            .dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
            'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label
            .dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
            'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks
            .dbProjectID} = ${Project.tblProject}.${Project
            .dbId} $whereClause GROUP BY ${Tasks.tblTask}.${Tasks
            .dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

    return bindData(result);
  }

  Future<List<Tasks>> getTasksByProject(int projectId) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project
            .dbName},${Project.tblProject}.${Project
            .dbColorCode},group_concat(${Label.tblLabel}.${Label
            .dbName}) as labelNames '
            'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels
            .tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels
            .dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
            'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label
            .dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
            'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks
            .dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks
            .tblTask}.${Tasks.dbProjectID}=$projectId GROUP BY ${Tasks
            .tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks
            .dbDueDate} ASC;');

    return bindData(result);
  }

  Future<List<Tasks>> getTasksByLabel(String labelName) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project
            .dbName},${Project.tblProject}.${Project
            .dbColorCode},group_concat(${Label.tblLabel}.${Label
            .dbName}) as labelNames FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels
            .tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels
            .dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
            'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label
            .dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
            'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks
            .dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks
            .tblTask}.${Tasks.dbProjectID}=${Project.tblProject}.${Project
            .dbId} GROUP BY ${Tasks.tblTask}.${Tasks
            .dbId} having labelNames LIKE "%$labelName%" ORDER BY ${Tasks
            .tblTask}.${Tasks.dbDueDate} ASC;');

    return bindData(result);
  }

  List<Tasks> bindData(List<Map<String, dynamic>> result) {
    List<Tasks> tasks = new List();
    for (Map<String, dynamic> item in result) {
      var myTask = new Tasks.fromMap(item);
      myTask.projectName = item[Project.dbName];
      myTask.projectColor = item[Project.dbColorCode];
      var labelComma = item["labelNames"];
      if (labelComma != null) {
        myTask.labelList = labelComma.toString().split(",");
      }
      tasks.add(myTask);
    }
    return tasks;
  }

  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    var db = await _getDb();
    var whereClause = isInboxVisible ? ";" : " WHERE ${Project.dbId}!=1;";
    var result =
    await db.rawQuery('SELECT * FROM ${Project.tblProject} $whereClause');
    List<Project> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = new Project.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future<List<Label>> getLabels() async {
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM ${Label.tblLabel}');
    List<Label> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = new Label.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  /// Inserts or replaces the task.
  Future updateTask(Tasks task, {List<int> labelIDs}) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Tasks.tblTask}(${Tasks.dbId},${Tasks.dbTitle},${Tasks
          .dbProjectID},${Tasks.dbComment},${Tasks.dbDueDate},${Tasks
          .dbPriority},${Tasks.dbStatus})'
          ' VALUES(${task.id}, "${task.title}", ${task.projectId},"${task
          .comment}", ${task.dueDate},${task.priority.index},${task.tasksStatus
          .index})');
      if (id > 0 && labelIDs != null && labelIDs.length > 0) {
        labelIDs.forEach((labelId) {
          txn.rawInsert('INSERT OR REPLACE INTO '
              '${TaskLabels.tblTaskLabel}(${TaskLabels.dbId},${TaskLabels
              .dbTaskId},${TaskLabels.dbLabelId})'
              ' VALUES(null, $id, $labelId)');
        });
      }
    });
  }

  Future updateProject(Project project) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project
          .dbColorCode},${Project.dbColorName})'
          ' VALUES(${project.id},"${project.name}", ${project
          .colorValue}, "${project.colorName}")');
    });
  }

  Future updateLabels(Label label) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Label.tblLabel}(${Label.dbName},${Label.dbColorCode},${Label
          .dbColorName})'
          ' VALUES("${label.name}", ${label.colorValue}, "${label
          .colorName}")');
    });
  }

  Future deleteProject(int projectID) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Project.tblProject} WHERE ${Project
              .dbId}==$projectID;');
    });
  }

  Future deleteTask(int taskID) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Tasks.tblTask} WHERE ${Tasks.dbId}=$taskID;');
    });
  }

  Future updateTaskStatus(int taskID, TaskStatus status) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Tasks.tblTask} SET ${Tasks.dbStatus} = '${status
              .index}' WHERE ${Tasks.dbId} = '$taskID'");
    });
  }

  Future<bool> isLabelExits(Label label) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${Label.tblLabel} WHERE ${Label.dbName} LIKE '${label
            .name}'");
    if (result.length == 0) {
      return await updateLabels(label).then((value) {
        return false;
      });
    } else {
      return true;
    }
  }

  Future _createCollectionMasterTable(Database db) {
    String query = "CREATE TABLE ${collectionMaster} ("
        "${TablesColumnFile.masondate} DATETIME,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.macctstat} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupid} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mfocode} TEXT,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.midealbaldate} DATETIME,"
        "${TablesColumnFile.modamt} REAL,"
        "${TablesColumnFile.memiamt} REAL,"
        "${TablesColumnFile.mcurrentdue} REAL,"
        "${TablesColumnFile.midealbal} REAL,"
        "${TablesColumnFile.memino} INTEGER,"
        "${TablesColumnFile.mexpdate} DATETIME,"
        "${TablesColumnFile.mexpprnpaid} REAL,"
        "${TablesColumnFile.mexpintpaid} REAL,"
        "${TablesColumnFile.mpaidprn} REAL,"
        "${TablesColumnFile.mpaidint} REAL,"
        "${TablesColumnFile.mprnos} REAL,"
        "${TablesColumnFile.mintos} REAL,"
        "${TablesColumnFile.mclosint} REAL,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mappliedasind} TEXT,"
        "${TablesColumnFile.malmeffdate} DATETIME,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastopendate} DATETIME,"
        "${TablesColumnFile.mexcesspaid} REAL,"
        "${TablesColumnFile.msdbal} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.masondate}, ${TablesColumnFile
        .mlbrcode}, ${TablesColumnFile.mprdacctid}))";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  //TODO add ideal bal date here
  Future _createCollectedLoanAmtMasterTable(Database db) {
    String query = "CREATE TABLE ${collectedLoansAmtMaster} ("
        "${TablesColumnFile.trefno} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT ,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupid} INTEGER,"
        "${TablesColumnFile.mfocode} TEXT,"
        "${TablesColumnFile.memino} INTEGER,"
        "${TablesColumnFile.malmeffdate} DATETIME,"
        "${TablesColumnFile.madjfrmsd} INTEGER,"
        "${TablesColumnFile.madjfrmexcss} INTEGER,"
        "${TablesColumnFile.mpaidbygrp} INTEGER,"
        "${TablesColumnFile.mattndnc} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mremarks} TEXT,"
        "${TablesColumnFile.mcollamt} REAL, "
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.midealbaldate} DATETIME,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME"
        ");";

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createUserMasterTable(Database db) {
    print("shadab's  table xxxxxxxxxxxxx");
    String query = "CREATE TABLE ${userMasterTable} ("
        "${TablesColumnFile.musrcode} TEXT PRIMARY KEY,"
        "${TablesColumnFile.mcustaccesslvl} INTEGER,"
        "${TablesColumnFile.mextnno} INTEGER,"
        "${TablesColumnFile.mactiveinstn} TEXT,"
        "${TablesColumnFile.mautologoutperiod} INTEGER,"
        "${TablesColumnFile.mautologoutyn} TEXT,"
        "${TablesColumnFile.mbadloginsdt} DATETIME,"
        "${TablesColumnFile.memailid} TEXT,"
        "${TablesColumnFile.merror} INTEGER,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mgrpcd} INTEGER,"
        "${TablesColumnFile.misloggedinyn} INTEGER,"
        "${TablesColumnFile.mlastpwdchgdt} DATETIME,"
        "${TablesColumnFile.mlastsyslidt} DATETIME,"
        "${TablesColumnFile.mmaxbadlginperday} INTEGER,"
        "${TablesColumnFile.mmaxbadlginperinst} INTEGER,"
        "${TablesColumnFile.mmobile} TEXT,"
        "${TablesColumnFile.mnextpwdchgdt} DATETIME,"
        "${TablesColumnFile.mnextsyslgindt} DATETIME,"
        "${TablesColumnFile.mnoofbadlogins} INTEGER,"
        "${TablesColumnFile.mpwdchgforcedyn} TEXT,"
        "${TablesColumnFile.mpwdchgperioddays} INTEGER,"
        "${TablesColumnFile.mregdevicemacid} TEXT,"
        "${TablesColumnFile.mreportinguser} TEXT,"
        "${TablesColumnFile.mstatus} INTEGER,"
        "${TablesColumnFile.musrbrcode} INTEGER,"
        "${TablesColumnFile.musrdesignation} TEXT,"
        "${TablesColumnFile.musrname} TEXT,"
        "${TablesColumnFile.musrpass} TEXT,"
        "${TablesColumnFile.musrshortname} TEXT,"
        "${TablesColumnFile.mReason} TEXT,"
        "${TablesColumnFile.mSusDate} DATETIME,"
        "${TablesColumnFile.mJoinDate} DATETIME,"
        "${TablesColumnFile.mgender} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME"
        ");";
    print("table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }


  Future _createBranchMasterTable(Database db) {
    print("shadab's  table xxxxxxxxxxxxx");
    String query = "CREATE TABLE ${branchMaster} ("
        "${TablesColumnFile.mpbrcode} INTEGER PRIMARY KEY,"
        "${TablesColumnFile.mname} TEXT,"
        "${TablesColumnFile.mshortname} TEXT,"
        "${TablesColumnFile.madd1} TEXT,"
        "${TablesColumnFile.madd2} TEXT,"
        "${TablesColumnFile.madd3} TEXT,"
        "${TablesColumnFile.mcitycd} TEXT,"
        "${TablesColumnFile.mpincode} INTEGER,"
        "${TablesColumnFile.mcountrycd} TEXT,"
        "${TablesColumnFile.mbranchtype} INTEGER,"
        "${TablesColumnFile.mtele1} TEXT,"
        "${TablesColumnFile.mtele2} TEXT,"
        "${TablesColumnFile.mfaxno1} TEXT,"
        "${TablesColumnFile.mswiftaddr} TEXT,"
        "${TablesColumnFile.mpostcode} TEXT,"
        "${TablesColumnFile.mweekoff1} INTEGER,"
        "${TablesColumnFile.mweekoff2} INTEGER,"
        "${TablesColumnFile.mparentbrcode} INTEGER,"
        "${TablesColumnFile.mbranchtype1} INTEGER,"
        "${TablesColumnFile.mbranchcat} INTEGER,"
        "${TablesColumnFile.mformatndt} DATETIME,"
        "${TablesColumnFile.mdistrict} TEXT,"
        "${TablesColumnFile.mbrnmanager} TEXT,"
        "${TablesColumnFile.mstate} TEXT,"
        "${TablesColumnFile.mmingroupmembers} INTEGER,"
        "${TablesColumnFile.mmaxgroupmembers} INTEGER,"
        "${TablesColumnFile.msector} INTEGER,"
        "${TablesColumnFile.mbranchemailid} TEXT,"
        "${TablesColumnFile.mbiccode} TEXT,"
        "${TablesColumnFile.mlegacybrncd} TEXT,"
        "${TablesColumnFile.mlatitude} REAL,"
        "${TablesColumnFile.mlongitude} REAL,"
        "${TablesColumnFile.mlastopendate} DATETIME"
        ");";
    print("table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCreditbereauMaster(Database db) {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxinside credit Master Create");
    String query = "CREATE TABLE ${creditBereauMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mqueueno} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mprospectdt} DATETIME,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mprospectname} TEXT,"
        "${TablesColumnFile.mmobno} INTEGER,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.motpverified} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mcbcheckstatus} TEXT,"
        "${TablesColumnFile.mprospectstatus} INTEGER,"
        "${TablesColumnFile.madd1} TEXT,"
        "${TablesColumnFile.madd2} TEXT,"
        "${TablesColumnFile.madd3} TEXT,"
        "${TablesColumnFile.mhomeloc} TEXT,"
        "${TablesColumnFile.mareacd} INTEGER,"
        "${TablesColumnFile.mvillage} TEXT,"
        "${TablesColumnFile.mdistcd} INTEGER,"
        "${TablesColumnFile.mstatecd} TEXT,"
        "${TablesColumnFile.mcountrycd} TEXT,"
        "${TablesColumnFile.mpincode} INTEGER,"
        "${TablesColumnFile.mcountryoforigin} TEXT,"
        "${TablesColumnFile.mnationality} TEXT,"
        "${TablesColumnFile.mpanno} TEXT,"
        "${TablesColumnFile.mpannodesc} TEXT,"
        "${TablesColumnFile.misuploaded} INTEGER,"
        "${TablesColumnFile.mspousename} TEXT,"
        "${TablesColumnFile.mspouserelation} TEXT,"
        "${TablesColumnFile.mnomineename} TEXT,"
        "${TablesColumnFile.mnomineerelation} TEXT,"
        "${TablesColumnFile.mcreditenqpurposetype} TEXT,"
        "${TablesColumnFile.mcreditequstage} TEXT,"
        "${TablesColumnFile.mcreditreporttransdatetype} TEXT,"
        "${TablesColumnFile.mcreditreporttransid} TEXT,"
        "${TablesColumnFile.mcreditrequesttype} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mstreet} TEXT,"
        "${TablesColumnFile.mhouse} TEXT,"
        "${TablesColumnFile.mcity} TEXT,"
        "${TablesColumnFile.mstate} TEXT,"
        "${TablesColumnFile.mid1} TEXT,"
        "${TablesColumnFile.mid1desc} TEXT,"
        "${TablesColumnFile.motp} INTEGER,"
        "${TablesColumnFile.mroutedto} TEXT ,"
        "${TablesColumnFile.miscustcreated} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mtier} INTEGER DEFAULT 1,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mhighmarkchkdt} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("xxxxxxxxxxxxxxxxxxxtable Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCreditBereauResult(Database db) {
    String query = "CREATE TABLE ${creditBereauResultMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mrefresultsrno} INTEGER ,"
        "${TablesColumnFile.trefresultsrno} INTEGER ,"
        "${TablesColumnFile.mcbcheckstatus} TEXT,"
        "${TablesColumnFile.mdateofissue} TEXT,"
        "${TablesColumnFile.mdateofrequest} TEXT,"
        "${TablesColumnFile.miscustomercreated} TEXT,"
        "${TablesColumnFile.mpreparedfor} TEXT,"
        "${TablesColumnFile.mreportid} TEXT,"
        "${TablesColumnFile.mothrmficnt} INTEGER ,"
        "${TablesColumnFile.mloancycle} INTEGER ,"
        "${TablesColumnFile.mothrmficurbal} REAL ,"
        "${TablesColumnFile.mothrmfiovrdueamt} REAL ,"
        "${TablesColumnFile.mothrmfidisbamt} REAL ,"
        "${TablesColumnFile.mtotovrdueaccno} INTEGER ,"
        "${TablesColumnFile.mmfitotdisbamt} REAL ,"
        "${TablesColumnFile.mmfitotcurrentbal} REAL ,"
        "${TablesColumnFile.mmfitotovrdueamt} REAL ,"
        "${TablesColumnFile.mtotovrdueamt} REAL ,"
        "${TablesColumnFile.mtotcurrentbal} REAL ,"
        "${TablesColumnFile.mtotdisbamt} REAL ,"
        "${TablesColumnFile.mexpsramt} REAL ,"
        "${TablesColumnFile.mcbresultblob} TEXT ,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno} , ${TablesColumnFile.mrefno})"
        ");";
    print(
        "xxxxxxxxxxxxxxxxxxx  ${creditBereauResultMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCreditBereauLoanDetails(Database db) {
    String query = "CREATE TABLE ${creditBereauLoanDetailsMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.trefsrno} INTEGER,"
        "${TablesColumnFile.mrefsrno} INTEGER,"
        "${TablesColumnFile.maccounttype} TEXT,"
        "${TablesColumnFile.mcurrentbalance} REAL,"
        "${TablesColumnFile.mcustbankacnum} TEXT,"
        "${TablesColumnFile.mdatereported} TEXT,"
        "${TablesColumnFile.mdisbursedamount} REAL,"
        "${TablesColumnFile.mnameofmfi} TEXT,"
        "${TablesColumnFile.mnocimagestring} TEXT,"
        "${TablesColumnFile.moverdueamount} REAL,"
        "${TablesColumnFile.mwriteoffamount} REAL,"
        "PRIMARY KEY(${TablesColumnFile.trefno},${TablesColumnFile
        .mrefno},${TablesColumnFile.trefsrno})"
        ");";
    print(
        "xxxxxxxxxxxxxxxxxxx ${creditBereauLoanDetailsMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createGroupFoundation(Database db) {
    String query = "CREATE TABLE ${groupFoundationMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mgroupid} INTEGER,"
        "${TablesColumnFile.mgroupname} TEXT,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.magentcd} TEXT,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mGrprecogTestDate} DATETIME,"
        "${TablesColumnFile.mMaxGroupMembers} INTEGER,"
        "${TablesColumnFile.mMinGroupMembers} INTEGER,"
        "${TablesColumnFile.mgrouptype} TEXT,"
        "${TablesColumnFile.mgrtapprovedby} TEXT,"
        "${TablesColumnFile.mloanlimit} DOUBLE,"
        "${TablesColumnFile.meetingday} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${groupFoundationMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCenterFoundation(Database db) {
    String query = "CREATE TABLE ${centerDetailsMaster} ("
        "${TablesColumnFile.trefno} INTEGER  ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mCenterId} INTEGER,"
        "${TablesColumnFile.mEffectiveDt} DATETIME,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcentername} TEXT,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.marea} INTEGER,"
        "${TablesColumnFile.mareatype} INTEGER,"
        "${TablesColumnFile.mformatndt} DATETIME,"
        "${TablesColumnFile.mmeetingfreq} TEXT,"
        "${TablesColumnFile.mmeetinglocn} TEXT,"
        "${TablesColumnFile.mmeetingday} INTEGER,"
        "${TablesColumnFile.mcentermthhmm} TEXT,"
        "${TablesColumnFile.mcentermtampm} INTEGER,"
        "${TablesColumnFile.mfirstmeetngdt} DATETIME,"
        "${TablesColumnFile.mnextmeetngdt} DATETIME,"
        "${TablesColumnFile.mlastmeetngdt} DATETIME,"
        "${TablesColumnFile.mrepayfrom} INTEGER,"
        "${TablesColumnFile.mrepayto} INTEGER,"
        "${TablesColumnFile.mcurrnoOfmembers} INTEGER,"
        "${TablesColumnFile.mcenterstatus} INTEGER,"
        "${TablesColumnFile.mdropoutdate} DATETIME,"
        "${TablesColumnFile.mlastmonitoringdate} DATETIME,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    for (var items in query.split(",")) {
      print(items);
    }

    print("xxxxxxxxxxxxxxxxxxx ${centerDetailsMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createProductMaster(Database db) {
    String query = "CREATE TABLE ${productMaster} ("
        "${TablesColumnFile.trefno} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.mrefno} INTEGER  ,"
        "${TablesColumnFile.mlbrcode} INTEGER  ,"
        "${TablesColumnFile.mprdCd} TEXT,"
        "${TablesColumnFile.mname} TEXT,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mcurCd} TEXT,"
        "${TablesColumnFile.mdivisiontype} TEXT,"
        "${TablesColumnFile.mnoofguaranter} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME);";

    print(
        "xxxxxxxxxxxxxxxxxxx ${productMaster} table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createPurposeMaster(Database db) {
    String query = "CREATE TABLE ${purposeMaster} ("
        "${TablesColumnFile.purposeId} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.purposeName} TEXT,"
        "${TablesColumnFile.purposeDescription} TEXT);";
    print(
        "xxxxxxxxxxxxxxxxxxx ${purposeMaster} table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createTransactionModeMaster(Database db) {
    String query = "CREATE TABLE ${transactionModeMaster} ("
        "${TablesColumnFile.transactionModeId} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.transactionMode} TEXT,"
        "${TablesColumnFile.transactionModeDescription} TEXT);";
    print(
        "xxxxxxxxxxxxxxxxxxx ${transactionModeMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createRepaymentFrequencyMaster(Database db) {
    String query = "CREATE TABLE ${repaymentFrequencyMaster} ("
        "${TablesColumnFile.repaymentFrequencyId} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.repaymentFrequency} TEXT,"
        "${TablesColumnFile.repaymentFrequencyDescription} TEXT);";
    print(
        "xxxxxxxxxxxxxxxxxxx ${repaymentFrequencyMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCustomerLoanDetailsMaster(Database db) {
    String query = "CREATE TABLE ${customerLoanDetailsMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mappldloanamt} REAL,"
        "${TablesColumnFile.mapprvdloanamt} REAL,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mcustcategory} TEXT,"
        "${TablesColumnFile.mloanamtdisbd} REAL,"
        "${TablesColumnFile.mloandisbdt} DATETIME,"
        "${TablesColumnFile.mleadstatus} INTEGER,"
        "${TablesColumnFile.mleadstatusdesc} TEXT,"
        "${TablesColumnFile.mexpdt} DATETIME,"
        "${TablesColumnFile.minstamt} REAL,"
        "${TablesColumnFile.minststrtdt} DATETIME,"
        "${TablesColumnFile.minterestamount} REAL,"
        "${TablesColumnFile.mrepaymentmode} INTEGER,"
        "${TablesColumnFile.mmodeofdisb} INTEGER,"
        "${TablesColumnFile.mperiod} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.mpurposeofLoan} INTEGER,"
        "${TablesColumnFile.msubpurposeofloan} TEXT,"
        "${TablesColumnFile.msubpurposeofloandesc} TEXT,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mroutefrom} TEXT,"
        "${TablesColumnFile.mrouteto} TEXT,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER ,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mtypeofloan} TEXT,"
        "${TablesColumnFile.missecuredloan} TEXT,"
        "${TablesColumnFile.mrepaymentfreq} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mprdname} TEXT,"
        "${TablesColumnFile.mcustname} TEXT ,"
        "${TablesColumnFile.mApprovalDesc} TEXT ,"
        "${TablesColumnFile.merrormessage} TEXT ,"
        "${TablesColumnFile.mappliedasind} TEXT ,"
        "${TablesColumnFile.mmainoccupn} TEXT,"
        "${TablesColumnFile.msuboccupn} TEXT,"
        "${TablesColumnFile.mmainoccupndesc} TEXT,"
        "${TablesColumnFile.msuboccupndesc} TEXT,"
        "${TablesColumnFile.maccno} TEXT,"
        "${TablesColumnFile.minvestment} TEXT,"
        "${TablesColumnFile.mrental} TEXT,"
        "${TablesColumnFile.mowneruse} TEXT,"
        "${TablesColumnFile.mremarks} TEXT,"

        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
        ");";
    print(
        "Customer Loan Details Master ${customerLoanDetailsMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  /*Future _createCheckListMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${checkListMaster} ("
          "${TablesColumnFile.trefno} INTEGER PRIMARY KEY,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mquestionid} TEXT,"
          "${TablesColumnFile.manschecked} INTEGER,"
          "${TablesColumnFile.mproctype} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missync} TEXT,"
          "${TablesColumnFile.mlastsynsdate} DATETIME;"
      );
    });
  }*/

  Future _createCgt1QaMaster(Database db) {
    return db.transaction((Transaction txn) {
      String table = "CREATE TABLE ${cgt1QaMaster} ("
          "${TablesColumnFile.tclcgt1refno} INTEGER,"
          "${TablesColumnFile.mclcgt1refno} INTEGER,"
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mquestionid} TEXT,"
          "${TablesColumnFile.manschecked} INTEGER,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
          .mrefno},${TablesColumnFile.tclcgt1refno})"
          "FOREIGN KEY(${TablesColumnFile
          .mrefno}) REFERENCES ${CGT1Master}(${TablesColumnFile
          .mrefno}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TablesColumnFile
          .trefno}) REFERENCES ${CGT1Master}(${TablesColumnFile
          .trefno}) ON DELETE CASCADE);";

      txn.execute(table);
    });
  }

  Future _createCgt2QaMaster(Database db) {
    String table = "CREATE TABLE ${cgt2QaMaster} ("
        "${TablesColumnFile.tclcgt2refno} INTEGER,"
        "${TablesColumnFile.mclcgt2refno} INTEGER,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mquestionid} TEXT,"
        "${TablesColumnFile.manschecked} INTEGER,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tclcgt2refno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${CGT2Master}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${CGT2Master}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(table);
    });
  }

  Future _createGrtQaMaster(Database db) {
    String table = "CREATE TABLE ${grtQaMaster} ("
        "${TablesColumnFile.tclgrtrefno} INTEGER,"
        "${TablesColumnFile.mclgrtrefno} INTEGER,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mquestionid} TEXT,"
        "${TablesColumnFile.manschecked} INTEGER,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tclgrtrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${GRTMaster}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${GRTMaster}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(table);
    });
  }

  Future _createGaurantorMaster(Database db) {
    String query = "CREATE TABLE ${gaurantorMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.loantrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mapplicanttype} INTEGER,"
        "${TablesColumnFile.mexistingcustyn} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mnameofguar} TEXT,"
        "${TablesColumnFile.mgender} TEXT,"
        "${TablesColumnFile.mrelationwithcust} TEXT,"
        "${TablesColumnFile.mrelationsince} INTEGER,"
        "${TablesColumnFile.mage} INTEGER,"
        "${TablesColumnFile.mphone} TEXT,"
        "${TablesColumnFile.mmobile} TEXT,"
        "${TablesColumnFile.maddress} TEXT,"
        "${TablesColumnFile.mmonthlyincome} REAL,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.moccupationtype} INTEGER,"
        "${TablesColumnFile.mmainoccupation} INTEGER,"
        "${TablesColumnFile.mworkexpinyrs} INTEGER,"
        "${TablesColumnFile.mincomeothsources} REAL,"
        "${TablesColumnFile.mtotalincome} REAL,"
        "${TablesColumnFile.mhousetype} INTEGER,"
        "${TablesColumnFile.mworkingaddress} TEXT,"
        "${TablesColumnFile.mworkphoneno} TEXT,"
        "${TablesColumnFile.mmothermaidenname} TEXT,"
        "${TablesColumnFile.mpromissorynote} TEXT,"
        "${TablesColumnFile.mnationalidtype} INTEGER,"
        "${TablesColumnFile.mnationalid} INTEGER,"
        "${TablesColumnFile.mnationaliddesc} TEXT,"
        "${TablesColumnFile.maddress2} TEXT,"
        "${TablesColumnFile.maddress3} TEXT,"
        "${TablesColumnFile.maddress4} TEXT,"
        "${TablesColumnFile.mmaritalstatus} INTEGER,"
        "${TablesColumnFile.mreligioncd} INTEGER,"
        "${TablesColumnFile.meducationalqual} TEXT,"
        "${TablesColumnFile.memailaddr} TEXT,"
        "${TablesColumnFile.memployername} TEXT,"
        "${TablesColumnFile.mbusinessname} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mrevsrc1} TEXT,"
        "${TablesColumnFile.mrevsrc2} TEXT,"
        "${TablesColumnFile.mnamesrc1} TEXT,"
        "${TablesColumnFile.mnamesrc2} TEXT,"
        "${TablesColumnFile.mpldggurproprty1} TEXT,"
        "${TablesColumnFile.mpldggurproprty2} TEXT,"
        "${TablesColumnFile.mpldggurproprty3} TEXT,"
        "${TablesColumnFile.mrev1} REAL,"
        "${TablesColumnFile.mrev2} REAL,"
        "${TablesColumnFile.mexp1} REAL,"
        "${TablesColumnFile.mexp2} REAL,"
        "${TablesColumnFile.minc1} REAL,"
        "${TablesColumnFile.minc2} REAL,"
        "${TablesColumnFile.mrevtotal} REAL,"
        "${TablesColumnFile.mexptotal} REAL,"
        "${TablesColumnFile.minctotal} REAL,"
        "${TablesColumnFile.msize1} REAL,"
        "${TablesColumnFile.msize2} REAL,"
        "${TablesColumnFile.msize3} REAL,"
        "${TablesColumnFile.mcollvalue1} REAL,"
        "${TablesColumnFile.mcollvalue2} REAL,"
        "${TablesColumnFile.mcollvalue3} REAL,"
        "${TablesColumnFile.mcollvaluetotal} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno}))";
    print("primary of gaurantor table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createSavingsCollectionMaster(Database db) {
    String query = "CREATE TABLE ${savingsCollectionMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mcollectiondate} DATETIME,"
        "${TablesColumnFile.mcollectedamount} REAL,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mremark} TEXT,"
        "${TablesColumnFile.mcashflow} TEXT,"
    //"${TablesColumnFile.mentrydate} DATETIME,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.msetno} INTEGER,"
        "${TablesColumnFile.mscrollno} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} DATETIME,"
        "${TablesColumnFile.mlastsynsdate} TEXT,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno}))";
    print("primary of Savings table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }


  Future _createminiStatementMaster(Database db) {
    String query = "CREATE TABLE ${miniStatementMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mbramchname} TEXT,"
        "${TablesColumnFile.mparticulars} TEXT,"
        "${TablesColumnFile.mlcytrnamt} REAL,"
        "${TablesColumnFile.macttotballcy} REAL,"
        "${TablesColumnFile.mtotallienfcy} REAL,"
        "${TablesColumnFile.mentrydate} TEXT,"
        "${TablesColumnFile.mdrcr} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0)";
    print(query.toString());
    print(" Mini Statement table created");

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }


  Future _createSavingsMaster(Database db) {
    String query = "CREATE TABLE ${savingsMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mmobno} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mdateopen} DATETIME,"
        "${TablesColumnFile.mdateclosed} DATETIME,"
        "${TablesColumnFile.mfreezetype} INTEGER,"
        "${TablesColumnFile.macctstat} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mactTotbalfcy} REAL,"
        "${TablesColumnFile.mtotallienfcy} REAL,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno} , ${TablesColumnFile
        .trefno}))";
    print("primary of Savings table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createSettingsMaster(Database db) {
    String query = "CREATE TABLE ${settingsMaster} ("
        "${TablesColumnFile.trefno} INTEGER PRIMARY KEY,"
        "${TablesColumnFile.musrcode} TEXT,"
        "${TablesColumnFile.musrpass} TEXT,"
        "${TablesColumnFile.mipaddress} TEXT,"
        "${TablesColumnFile.mportno} TEXT,"
        "${TablesColumnFile.isHttps} INTEGER DEFAULT 0,"
        "${TablesColumnFile.isPortRequired} INTEGER DEFAULT 0,"
        "${TablesColumnFile.yesno} INTEGER)";
    print("primary of settings table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLoanUtilizationMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${loanUtilizationMaster} ("
          "${TablesColumnFile.mcustno} INTEGER ,"
          "${TablesColumnFile.mcustname} TEXT,"
          "${TablesColumnFile.mgroupcd} INTEGER,"
          "${TablesColumnFile.mcenterid} INTEGER,"
          "${TablesColumnFile.mpurposeofLoan} TEXT,"
          "${TablesColumnFile.mprdacctid} TEXT,"
          "${TablesColumnFile.mactualutilization} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.musrname} TEXT,"
          "${TablesColumnFile.mremarks} TEXT,"
          "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0 "
          ");");
    });
  }

  Future _createCGT1Master(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${CGT1Master} ("
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.loantrefno} INTEGER,"
          "${TablesColumnFile.loanmrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mcgt1doneby} TEXT,"
          "${TablesColumnFile.mstarttime} TEXT,"
          "${TablesColumnFile.mendtime} TEXT,"
          "${TablesColumnFile.mroutefrom} TEXT,"
          "${TablesColumnFile.mrouteto} TEXT,"
          "${TablesColumnFile.mremark} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missynctocoresys} INTEGER,"
          "${TablesColumnFile.mlastsynsdate} DATETIME,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
          .mrefno})"
          ");");
    });
  }

  Future _createCGT2Master(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${CGT2Master} ("
          "${TablesColumnFile.trefno} INTEGER ,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.loantrefno} INTEGER,"
          "${TablesColumnFile.loanmrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mcgt2doneby} TEXT,"
          "${TablesColumnFile.mstarttime} TEXT,"
          "${TablesColumnFile.mendtime} TEXT,"
          "${TablesColumnFile.mroutefrom} TEXT,"
          "${TablesColumnFile.mrouteto} TEXT,"
          "${TablesColumnFile.mremark} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missynctocoresys} INTEGER,"
          "${TablesColumnFile.mlastsynsdate} DATETIME,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
          .mrefno})"
          ");");
    });
  }

  Future _createGRTMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${GRTMaster} ("
          "${TablesColumnFile.trefno} INTEGER ,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.loantrefno} INTEGER,"
          "${TablesColumnFile.loanmrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mgrtdoneby} TEXT,"
          "${TablesColumnFile.mstarttime} TEXT,"
          "${TablesColumnFile.mendtime} TEXT,"
          "${TablesColumnFile.mroutefrom} TEXT,"
          "${TablesColumnFile.mrouteto} TEXT,"
          "${TablesColumnFile.mremark} TEXT,"
          "${TablesColumnFile.midtype1status} TEXT,"
          "${TablesColumnFile.midtype2status} TEXT,"
          "${TablesColumnFile.midtype3status} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missynctocoresys} INTEGER,"
          "${TablesColumnFile.mlastsynsdate} DATETIME,"
          "${TablesColumnFile.mhouseVerifiImg} TEXT,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
          .mrefno})"
          ");");
    });
  }

  Future _createSpeedoMeterMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${speedoMeterMaster} ("
          "${TablesColumnFile.usrName} TEXT,"
          "${TablesColumnFile.effDate} DATETIME ,"
          "${TablesColumnFile.geoLocation} TEXT,"
          "${TablesColumnFile.geoLongitude} TEXT,"
          "${TablesColumnFile.geoLatitude} TEXT,"
          "${TablesColumnFile.startingFromImg} TEXT,"
          "${TablesColumnFile.endingFromImg} TEXT,"
          "${TablesColumnFile.startingPoint} INTEGER,"
          "${TablesColumnFile.endingPoint} INTEGER,"
          "${TablesColumnFile.totMeterReading} INTEGER ,"
          "${TablesColumnFile.updatedBy} TEXT,"
          "${TablesColumnFile.createdBy} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME,"
          "${TablesColumnFile.updatedAt} DATETIME,"
          "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
          "PRIMARY KEY(${TablesColumnFile.effDate},${TablesColumnFile
          .usrName}));");
    });
  }

  Future _createCountryMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${countryMaster} ("
          "${TablesColumnFile.cntryCd} TEXT PRIMARY KEY ,"
          "${TablesColumnFile.countryName} TEXT,"
      //"${TablesColumnFile.updatedBy} TEXT,"
      //"${TablesColumnFile.createdBy} TEXT,"
      //"${TablesColumnFile.updatedAt} DATETIME,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createStateMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${stateMaster} ("
          "${TablesColumnFile.stateCd} TEXT PRIMARY KEY ,"
          "${TablesColumnFile.stateDesc} TEXT,"
          "${TablesColumnFile.cntryCd} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createDistrictMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${districtMaster} ("
          "${TablesColumnFile.distCd} INTEGER PRIMARY KEY ,"
          "${TablesColumnFile.distDesc} TEXT,"
          "${TablesColumnFile.stateCd} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createSubDistrictMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${subDistrictMaster} ("
          "${TablesColumnFile.placeCd} TEXT PRIMARY KEY ,"
          "${TablesColumnFile.placeCdDesc} TEXT,"
          "${TablesColumnFile.distCd} INTEGER,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createAreaMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${areaMaster} ("
          "${TablesColumnFile.areaCd} INTEGER,"
          "${TablesColumnFile.placeCd} TEXT,"
          "${TablesColumnFile.areaDesc} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME,"
          "PRIMARY KEY(${TablesColumnFile.areaCd},${TablesColumnFile
          .placeCd}));");
    });
  }



  Future _createNOCImageMaster(Database db) {
    String query = "CREATE TABLE ${customerNOCImageMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.serialNo} INTEGER,"
        "${TablesColumnFile.imageString} TEXT,"
        "${TablesColumnFile.createdAt} DATETIME,"
        "${TablesColumnFile.updatedAt} DATETIME,"
        "${TablesColumnFile.mnameofmfi} STRING,"
        "${TablesColumnFile.isDataSynced} INTEGER, "
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .serialNo})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${customerNOCImageMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }





  Future createCollateralREMlandandhouseMasterTable(Database db) {
    print("xxxxxxxxxxxxxxxxxxx123456 ${CollateralREMlandandhouseMaster} table Query Here is : ");
    String query = "CREATE TABLE ${CollateralREMlandandhouseMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER ,"
        "${TablesColumnFile.loantrefno} INTEGER ,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.colleteraltrefno} INTEGER,"
        "${TablesColumnFile.colleteralmrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT ,"
        "${TablesColumnFile.mtitle} TEXT ,"
        "${TablesColumnFile.mfname} TEXT ,"
        "${TablesColumnFile.mmname} TEXT ,"
        "${TablesColumnFile.mlname} TEXT ,"
        "${TablesColumnFile.maddress1} TEXT ,"
        "${TablesColumnFile.maddress2} TEXT ,"
        "${TablesColumnFile.mcountry} TEXT ,"
        "${TablesColumnFile.mstate} TEXT ,"
        "${TablesColumnFile.mdist} TEXT ,"
        "${TablesColumnFile.msubdist} TEXT ,"
        "${TablesColumnFile.marea} TEXT ,"
        "${TablesColumnFile.mhousebuilttype} TEXT ,"
        "${TablesColumnFile.menvdescription} TEXT ,"
        "${TablesColumnFile.mlotarea} REAL ,"
        "${TablesColumnFile.mfloorarea} REAL ,"
        "${TablesColumnFile.mdescofproperty} TEXT ,"
        "${TablesColumnFile.msizeofproperty} TEXT ,"
        "${TablesColumnFile.msizeofpropertyl} TEXT ,"
        "${TablesColumnFile.msizeofpropertyh} TEXT ,"
        "${TablesColumnFile.mtctno} INTEGER ,"
        "${TablesColumnFile.msrno} INTEGER ,"
        "${TablesColumnFile.mregdate} DATETIME ,"
        "${TablesColumnFile.mepebdate} DATETIME ,"
        "${TablesColumnFile.mrescodeorremark} TEXT ,"
        "${TablesColumnFile.mepebno} INTEGER ,"
        "${TablesColumnFile.mregofdeedslocation} TEXT ,"
        "${TablesColumnFile.mcreateddt} DATETIME ,"
        "${TablesColumnFile.mcreatedby} TEXT ,"
        "${TablesColumnFile.mlastupdatedt} DATETIME ,"
        "${TablesColumnFile.mlastupdateby} TEXT ,"
        "${TablesColumnFile.mgeolocation} TEXT ,"
        "${TablesColumnFile.mgeolatd} TEXT ,"
        "${TablesColumnFile.mgeologd} TEXT ,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.merrormessage} TEXT ,"
        "${TablesColumnFile.mcollno} INTEGER ,"
        "${TablesColumnFile.mpriorsec} TEXT ,"
        "${TablesColumnFile.mcolltype} TEXT ,"
        "${TablesColumnFile.mcollsubtype} TEXT ,"
        "${TablesColumnFile.mtypeofproperty} TEXT ,"
        "${TablesColumnFile.mltypeofownercerti} TEXT ,"
        "${TablesColumnFile.mhtypeofownercerti} TEXT ,"
        "${TablesColumnFile.mlissuednoprop} TEXT ,"
        "${TablesColumnFile.mhissuednoprop} TEXT ,"
        "${TablesColumnFile.mlissueby} TEXT ,"
        "${TablesColumnFile.mhissueby} TEXT ,"
        "${TablesColumnFile.mlsizeprop} TEXT ,"
        "${TablesColumnFile.mhsizeprop} TEXT ,"
        "${TablesColumnFile.mlnpropborder} TEXT ,"
        "${TablesColumnFile.mhnpropborder} TEXT ,"
        "${TablesColumnFile.mlspropborder} TEXT ,"
        "${TablesColumnFile.mhspropborder} TEXT ,"
        "${TablesColumnFile.mlwpropborder} TEXT ,"
        "${TablesColumnFile.mhwpropborder} TEXT ,"
        "${TablesColumnFile.mlepropborder} TEXT ,"
        "${TablesColumnFile.mhepropborder} TEXT ,"
        "${TablesColumnFile.mllocprop} TEXT ,"
        "${TablesColumnFile.mhlocprop} TEXT ,"
        "${TablesColumnFile.mltitleowener} TEXT ,"
        "${TablesColumnFile.mhtitleowener} TEXT ,"
        "${TablesColumnFile.mllocalauthvalue} REAL ,"
        "${TablesColumnFile.mhlocalauthvalue} REAL ,"
        "${TablesColumnFile.mlrealestatecmpnyvalue} REAL ,"
        "${TablesColumnFile.mhrealestatecmpnyvalue} REAL ,"
        "${TablesColumnFile.mlaskneighonvalue} REAL ,"
        "${TablesColumnFile.mhaskneighonvalue} REAL ,"
        "${TablesColumnFile.mlsumonvalprop} REAL ,"
        "${TablesColumnFile.mhsumonvalprop} REAL ,"
        "${TablesColumnFile.mlissuedt} DATETIME ,"
        "${TablesColumnFile.mhissuedt} DATETIME ,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno}) "
        ");";

    print("xxxxxxxxxxxxxxxxxxx123456 ${CollateralREMlandandhouseMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future createCollateralVehicleMasterTable(Database db) {
    String query = "CREATE TABLE ${collateralVehicleMaster} ("
        "${TablesColumnFile.msrno} INTEGER ,"
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mprdacctid} TEXT ,"
        "${TablesColumnFile.msectype} TEXT ,"
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.loantrefno} INTEGER ,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.colleteraltrefno} INTEGER,"
        "${TablesColumnFile.colleteralmrefno} INTEGER,"
        "${TablesColumnFile.mbusinessname} TEXT ,"
        "${TablesColumnFile.mownername} TEXT ,"
        "${TablesColumnFile.mtel} TEXT ,"
        "${TablesColumnFile.maddress1} TEXT ,"
        "${TablesColumnFile.maddress2} TEXT ,"
        "${TablesColumnFile.mcountry} TEXT ,"
        "${TablesColumnFile.mstate} TEXT ,"
        "${TablesColumnFile.mdist} TEXT ,"
        "${TablesColumnFile.msubdist} TEXT ,"
        "${TablesColumnFile.marea} TEXT ,"
        "${TablesColumnFile.mvillage} TEXT ,"
        "${TablesColumnFile.mbrand} TEXT ,"
        "${TablesColumnFile.mnoofaxles} INTEGER ,"
        "${TablesColumnFile.mtype} TEXT ,"
        "${TablesColumnFile.mnoofcylinder} INTEGER ,"
        "${TablesColumnFile.mcolor} TEXT ,"
        "${TablesColumnFile.msizeofcylinder} INTEGER ,"
        "${TablesColumnFile.mbodyno} TEXT ,"
        "${TablesColumnFile.menginepower} REAL ,"
        "${TablesColumnFile.mengineno} TEXT ,"
        "${TablesColumnFile.myearmade} INTEGER ,"
        "${TablesColumnFile.mchassisno} TEXT ,"
        "${TablesColumnFile.mmadeby} TEXT ,"
        "${TablesColumnFile.midentitycarno} TEXT ,"
        "${TablesColumnFile.mcarpricing} REAL ,"
        "${TablesColumnFile.mstdpricing} REAL ,"
        "${TablesColumnFile.minsurancepricing} REAL ,"
        "${TablesColumnFile.mpriceafterevaluation} REAL ,"
        "${TablesColumnFile.mltv} REAL ,"
        "${TablesColumnFile.mcartype} TEXT ,"
        "${TablesColumnFile.mltvdd} TEXT ,"
        "${TablesColumnFile.mloantovalueltv} TEXT ,"
        "${TablesColumnFile.mwhobelongocarowner} TEXT ,"
        "${TablesColumnFile.mcarlegality} INTEGER ,"
        "${TablesColumnFile.mreason} TEXT ,"
        "${TablesColumnFile.mdescription} TEXT ,"
        "${TablesColumnFile.mcarcanbeused} TEXT,"
        "${TablesColumnFile.mcredittenor} TEXT,"
        "${TablesColumnFile.mdmirror} TEXT ,"
        "${TablesColumnFile.mddoor} TEXT ,"
        "${TablesColumnFile.mdmirrorbacklock} TEXT ,"
        "${TablesColumnFile.mdcolororspot} TEXT ,"
        "${TablesColumnFile.mfcolorandspot} TEXT ,"
        "${TablesColumnFile.mftireandyan} TEXT ,"
        "${TablesColumnFile.mfcapofsplatter} TEXT ,"
        "${TablesColumnFile.mhmirror} TEXT ,"
        "${TablesColumnFile.mhvent} TEXT ,"
        "${TablesColumnFile.mhlightfarl} TEXT ,"
        "${TablesColumnFile.mhlightfarr} TEXT ,"
        "${TablesColumnFile.mhsignal} TEXT ,"
        "${TablesColumnFile.mhwincap} TEXT ,"
        "${TablesColumnFile.mpmirror} TEXT ,"
        "${TablesColumnFile.mpdoor} TEXT ,"
        "${TablesColumnFile.mpbackmirror} TEXT ,"
        "${TablesColumnFile.mpcolororspot} TEXT ,"
        "${TablesColumnFile.mftcolorandspot} TEXT ,"
        "${TablesColumnFile.mfttanandyan} TEXT ,"
        "${TablesColumnFile.mftcap} TEXT ,"
        "${TablesColumnFile.mftsplattercap} TEXT ,"
        "${TablesColumnFile.mbpmirror} TEXT ,"
        "${TablesColumnFile.mbpdoor} TEXT ,"
        "${TablesColumnFile.mbpcolorandspot} TEXT ,"
        "${TablesColumnFile.mbtcolorandsport} TEXT ,"
        "${TablesColumnFile.mbttanandyan} TEXT ,"
        "${TablesColumnFile.mbtcap} TEXT ,"
        "${TablesColumnFile.mbcbacklightr} TEXT ,"
        "${TablesColumnFile.mbcturnsignal} TEXT ,"
        "${TablesColumnFile.mbcmessagesignal} TEXT ,"
        "${TablesColumnFile.mbcsignal} TEXT ,"
        "${TablesColumnFile.mbcbacklightl} TEXT ,"
        "${TablesColumnFile.mbcbackdoor} TEXT ,"
        "${TablesColumnFile.mbccranes} TEXT ,"
        "${TablesColumnFile.mbctakelock} TEXT ,"
        "${TablesColumnFile.mbcholdlock} TEXT ,"
        "${TablesColumnFile.mbchandcranes} TEXT ,"
        "${TablesColumnFile.mbcreservetire} TEXT,"
        "${TablesColumnFile.mbcbackmirror} TEXT ,"
        "${TablesColumnFile.mbcantenna} TEXT ,"
        "${TablesColumnFile.mbtlcolororspot} TEXT ,"
        "${TablesColumnFile.mbtltanandyan} TEXT ,"
        "${TablesColumnFile.mbtlcap} TEXT ,"
        "${TablesColumnFile.mhheadcap} TEXT ,"
        "${TablesColumnFile.mbtlsplattercap} TEXT ,"
        "${TablesColumnFile.mbtrcolororspot} TEXT ,"
        "${TablesColumnFile.mbtrtireandyan} TEXT ,"
        "${TablesColumnFile.mbtrcap} TEXT ,"
        "${TablesColumnFile.mbtrsplattercap} TEXT ,"
        "${TablesColumnFile.mibarsun} TEXT ,"
        "${TablesColumnFile.midescriptionbook} TEXT ,"
        "${TablesColumnFile.miautosystem} TEXT ,"
        "${TablesColumnFile.miairconditioner} TEXT ,"
        "${TablesColumnFile.mimirrorremote} TEXT ,"
        "${TablesColumnFile.misafebell} TEXT ,"
        "${TablesColumnFile.mimiddlebox} TEXT ,"
        "${TablesColumnFile.mregdate} DATETIME,"
        "${TablesColumnFile.mregexpdate} DATETIME,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT  ,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT  ,"
        "${TablesColumnFile.mgeolocation} TEXT ,"
        "${TablesColumnFile.mgeolatd} TEXT ,"
        "${TablesColumnFile.missynctocoresys} INTEGER ,"
        "${TablesColumnFile.mgeologd} TEXT ,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno})"
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${collateralVehicleMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

//RIsk ratings

  Future _createRiskRatingsMaster(Database db) {
    String query = "CREATE TABLE ${RISKRATINGSMASTER} ("
        "${TablesColumnFile.triskratingsrefno} INTEGER ,"
        "${TablesColumnFile.mriskratingsrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mtypeofaccount} TEXT,"
        "${TablesColumnFile.macctno} TEXT,"
        "${TablesColumnFile.mcifno} TEXT,"
        "${TablesColumnFile.vmpurposeofacct} TEXT,"
        "${TablesColumnFile.mcountryrisk} TEXT,"
        "${TablesColumnFile.mvisaperiod} TEXT,"
        "${TablesColumnFile.mvisavalid} TEXT,"
        "${TablesColumnFile.mvisatype} TEXT,"
        "${TablesColumnFile.mnatureofbuss} TEXT,"
        "${TablesColumnFile.mhwwsacctopn} TEXT,"
        "${TablesColumnFile.mnetwrth} TEXT,"
        "${TablesColumnFile.mexpectedvalue} TEXT,"
        "${TablesColumnFile.mnooftransmnthly} TEXT,"
        "${TablesColumnFile.mhighnetwrth} TEXT,"
        "${TablesColumnFile.mprcdservrskque1} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.triskratingsrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

//
  Future _createESMSMasterTable(Database db) {
    String query = "CREATE TABLE ${ESMSMaster} ("
        "${TablesColumnFile.tesmsrefno} INTEGER ,"
        "${TablesColumnFile.mesmsrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mexclistchecked} TEXT,"
        "${TablesColumnFile.misbrwrinlist} TEXT,"
        "${TablesColumnFile.mnontrgtcust} TEXT,"
        "${TablesColumnFile.misbrwrinnontrgt} TEXT,"
        "${TablesColumnFile.mairemssn} TEXT,"
        "${TablesColumnFile.maeapplglrequire} TEXT,"
        "${TablesColumnFile.maecmplncstatus} TEXT,"
        "${TablesColumnFile.maeevediance} TEXT,"
        "${TablesColumnFile.mwastewater} TEXT,"
        "${TablesColumnFile.mwwapplglrequire} TEXT,"
        "${TablesColumnFile.mwwcmplncstatus} TEXT,"
        "${TablesColumnFile.mwwevediance} TEXT,"
        "${TablesColumnFile.msolidnhrdauswaste} TEXT,"
        "${TablesColumnFile.mshapplglrequire} TEXT,"
        "${TablesColumnFile.mshcmplncstatus} TEXT,"
        "${TablesColumnFile.mshevediance} TEXT,"
        "${TablesColumnFile.mhrdzchemnfule} TEXT,"
        "${TablesColumnFile.mhcapplglrequire} TEXT,"
        "${TablesColumnFile.mhccmplncstatus} TEXT,"
        "${TablesColumnFile.mhcevediance} TEXT,"
        "${TablesColumnFile.mrescnsmpt} TEXT,"
        "${TablesColumnFile.mnuisance} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mdust} BOOLEAN,"
        "${TablesColumnFile.mtrafficcongandobs} BOOLEAN,"
        "${TablesColumnFile.mvibration} BOOLEAN,"
        "${TablesColumnFile.mfumes} BOOLEAN,"
        "${TablesColumnFile.modours} BOOLEAN,"
        "${TablesColumnFile.mnoise} BOOLEAN,"
        "${TablesColumnFile.mnocomissue} BOOLEAN,"
        "${TablesColumnFile.mnodesigperson} BOOLEAN,"
        "${TablesColumnFile.mdispandressetle} BOOLEAN,"
        "${TablesColumnFile.mlandacqreq} BOOLEAN,"
        "${TablesColumnFile.mnoissue} BOOLEAN,"
        "${TablesColumnFile.marchimp} BOOLEAN,"
        "${TablesColumnFile.msiteofcultural} BOOLEAN,"
        "${TablesColumnFile.mcomplaintsfromneig} BOOLEAN,"
        "${TablesColumnFile.mimpactofindgenous} BOOLEAN,"
        "${TablesColumnFile.mimpactonlocal} BOOLEAN,"
        "${TablesColumnFile.mnorecognitionofemp} BOOLEAN,"
        "${TablesColumnFile.mlabourunion} BOOLEAN,"
        "${TablesColumnFile.mnolabissue} BOOLEAN,"
        "${TablesColumnFile.mnopersonalprotectiveEquip} BOOLEAN,"
        "${TablesColumnFile.mnoprocessforemployees} BOOLEAN,"
        "${TablesColumnFile.mchildoffrcdlabour} BOOLEAN,"
        "${TablesColumnFile.mempblwminage} BOOLEAN,"
        "${TablesColumnFile.mpayblwminwage} BOOLEAN,"
        "${TablesColumnFile.munequalOpp} BOOLEAN,"
        "${TablesColumnFile.minadequatetermsofemp} BOOLEAN,"
        "${TablesColumnFile.minediquateworkingcond} BOOLEAN,"
        "${TablesColumnFile.muinadequateemployeehealth} BOOLEAN,"
        "${TablesColumnFile.mnontarget} BOOLEAN,"
        "${TablesColumnFile.mcategoryc} BOOLEAN,"
        "${TablesColumnFile.mcategoryb} BOOLEAN,"
        "${TablesColumnFile.mcategorya} BOOLEAN,"
        "${TablesColumnFile.mcomntfrmoff} TEXT,"
        "${TablesColumnFile.mdecision} TEXT,"
        "${TablesColumnFile.mdsitrequiretorefroff} TEXT ,"
        "${TablesColumnFile.msign} TEXT,"
        "${TablesColumnFile.mnameofoff} TEXT,"
        "${TablesColumnFile.date} DATETIME,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tesmsrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }


  //Documents master
  _createDocumentsMaster(Database db) {
    String query = "CREATE TABLE ${DOCUMENTSMASTER} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.loantrefno} INTEGER,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.mforeignindicator} TEXT,"
        "${TablesColumnFile.mdoctno} TEXT,"
        "${TablesColumnFile.mcustname} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"

        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.missuingauth} TEXT,"
        "${TablesColumnFile.missuedate} DATETIME,"
        "${TablesColumnFile.mexpdate} DATETIME,"
        "${TablesColumnFile.mexecutiondate} DATETIME,"
        "${TablesColumnFile.mimgtype} TEXT,"
        "${TablesColumnFile.mcustomertype} TEXT,"
        "${TablesColumnFile.mimgtypedesc} TEXT,"
        "${TablesColumnFile.mimgsubtype} TEXT,"
        "${TablesColumnFile.mcomment} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.imgstring} TEXT,"
        "${TablesColumnFile.mremarks} TEXT,"

        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });

  }

//Charts Master
  _createChartsMaster(Database db) {
    String query = "CREATE TABLE ${CHARTMASTER} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mchartid} TEXT,"
        "${TablesColumnFile.mtitle} TEXT,"
        "${TablesColumnFile.mxcatg} TEXT,"
        "${TablesColumnFile.mycatg} TEXT,"
        "${TablesColumnFile.mquery} TEXT,"
        "${TablesColumnFile.mtype} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });

  }


  //charts filter

   _createChartsFilterMaster(Database db) {
     String query = "CREATE TABLE ${CHARTFILTERMASTER} ("
         "${TablesColumnFile.trefno} INTEGER,"
         "${TablesColumnFile.mrefno} INTEGER,"
         "${TablesColumnFile.mfilterid} TEXT,"
         "${TablesColumnFile.mdesc} TEXT,"
         "${TablesColumnFile.mfield1value} TEXT,"
         "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
         ");";

     print("primary of lookup table");
     print(query.toString());

     return db.transaction((Transaction txn) {
       txn.execute(query);
     });
   }

   //HBSUSERS
  _createHbsUSersMaster(Database db) {
    String query = "CREATE TABLE ${GETHBSUSERS} ("
        "${TablesColumnFile.mgrpcd} INTEGER,"
        "${TablesColumnFile.musrcode} TEXT,"
        "${TablesColumnFile.musrname} TEXT,"
        "${TablesColumnFile.musrbrcode} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.musrcode})"
        ");";
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future updateGetHbsUsers(LoginBean loginBean) async {
    print("trying to insert or replace ${GETHBSUSERS}");
    String insertQuery = "INSERT OR REPLACE INTO ${GETHBSUSERS}  ("
        "${TablesColumnFile.mgrpcd} ,"
        "${TablesColumnFile.musrcode} ,"
        "${TablesColumnFile.musrname} ,"
        "${TablesColumnFile.musrbrcode}  ) "
        "VALUES "
        "(${loginBean.mgrpcd} ,"
        "'${loginBean.musrcode}' ,"
        "'${loginBean.musrname}' ,"
        "'${loginBean.musrbrcode}'); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${GETHBSUSERS}");
    });
  }//ends


  Future updateGroupFoundation(GroupFoundationBean gfb) async {
    print("trying to insert or replace ${groupFoundationMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${groupFoundationMaster}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mgroupid} ,"
        "${TablesColumnFile.mgroupname} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.magentcd} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mGrprecogTestDate} ,"
        "${TablesColumnFile.mMaxGroupMembers} ,"
        "${TablesColumnFile.mMinGroupMembers} ,"
        "${TablesColumnFile.mgrouptype} ,"
        "${TablesColumnFile.mgrtapprovedby} ,"
        "${TablesColumnFile.mloanlimit} ,"
        "${TablesColumnFile.meetingday} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mlastsynsdate}  ) "
        "VALUES "
        "(${gfb.trefno} ,"
        "${gfb.mrefno} ,"
        "${gfb.mgroupid} ,"
        "'${gfb.mgroupname} ',"
        "${gfb.mlbrcode} ,"
        "'${gfb.magentcd}' ,"
        "${gfb.mcenterid} ,"
        "${gfb.mGrprecogTestDate} ,"
        "${gfb.mMaxGroupMembers} ,"
        "${gfb.mMinGroupMembers} ,"
        "'${gfb.mgrouptype}' ,"
        "'${gfb.mgrtapprovedby}' ,"
        "${gfb.mloanlimit} ,"
        "${gfb.meetingday} ,"
        "${gfb.mcreateddt} ,"
        "'${gfb.mcreatedby}' ,"
        "'${gfb.mlastupdatedt}' ,"
        "'${gfb.mlastupdateby}' ,"
        "'${gfb.mgeolocation}' ,"
        "'${gfb.mgeolatd}' ,"
        "'${gfb.mgeologd}' ,"
        "'${gfb.mlastsynsdate}'   ); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${groupFoundationMaster}");
    });
  }

  Future updateCenterFoundation(CenterDetailsBean centrObj) async {
    print("trying to insert or replace ${centerDetailsMaster}");
    String insertQuery = 'INSERT OR REPLACE INTO ${centerDetailsMaster} ('
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mCenterId} ,"
        "'${TablesColumnFile.mEffectiveDt}',"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mcentername} ,"
        "${TablesColumnFile.mcrs} ,"
        "${TablesColumnFile.marea} ,"
        "${TablesColumnFile.mareatype} ,"
        "${TablesColumnFile.mformatndt},"
        "${TablesColumnFile.mmeetingfreq} ,"
        "${TablesColumnFile.mmeetinglocn} ,"
        "${TablesColumnFile.mmeetingday} ,"
        "${TablesColumnFile.mcentermthhmm} ,"
        "${TablesColumnFile.mcentermtampm} ,"
        "${TablesColumnFile.mfirstmeetngdt},"
        "${TablesColumnFile.mnextmeetngdt},"
        "${TablesColumnFile.mlastmeetngdt},"
        "${TablesColumnFile.mrepayfrom} ,"
        "${TablesColumnFile.mrepayto} ,"
        "${TablesColumnFile.mcurrnoOfmembers} ,"
        "${TablesColumnFile.mcenterstatus} ,"
        "${TablesColumnFile.mdropoutdate},"
        "${TablesColumnFile.mlastmonitoringdate},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mlastsynsdate})"
        "VALUES"
        "("
        "${centrObj.trefno},"
        "${centrObj.mrefno},"
        "${centrObj.mCenterId},"
        "'${centrObj.mEffectiveDt}',"
        "${centrObj.mlbrcode},"
        "'${centrObj.mcentername}',"
        "'${centrObj.mcrs}',"
        "${centrObj.marea},"
        "${centrObj.mareatype},"
        "'${centrObj.mformatndt}',"
        "'${centrObj.mmeetingfreq}',"
        "'${centrObj.mmeetinglocn}',"
        "${centrObj.mmeetingday},"
        "'${centrObj.mcentermthhmm}',"
        "${centrObj.mcentermtampm},"
        "'${centrObj.mfirstmeetngdt}',"
        "'${centrObj.mnextmeetngdt}',"
        "'${centrObj.mlastmeetngdt}',"
        "${centrObj.mrepayfrom},"
        "${centrObj.mrepayto},"
        "${centrObj.mcurrnoOfmembers},"
        "${centrObj.mcenterstatus},"
        "'${centrObj.mdropoutdate}',"
        "'${centrObj.mlastmonitoringdate}',"
        "'${centrObj.mcreateddt}',"
        "'${centrObj.mcreatedby}',"
        "'${centrObj.mlastupdatedt}',"
        "'${centrObj.mlastupdateby}',"
        "'${centrObj.mgeolocation}',"
        "'${centrObj.mgeolatd}',"
        "'${centrObj.mgeologd}',"
        "${centrObj.missynctocoresys},"
        "'${centrObj.mlastsynsdate}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${centerDetailsMaster}");
    });
  }

  Future updatecountryMaster(CountryDropDownBean bean) async {
    print("trying to insert or replace ${countryMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${countryMaster}( "
        "${TablesColumnFile.cntryCd},"
        "${TablesColumnFile.countryName},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "'${bean.cntryCd}',"
        "'${bean.countryName}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${countryMaster}");
    });
  }

  Future updateStateMaster(StateDropDownList bean) async {
    print("trying to insert or replace ${stateMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${stateMaster}( "
        "${TablesColumnFile.stateCd},"
        "${TablesColumnFile.stateDesc},"
        "${TablesColumnFile.cntryCd},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "'${bean.stateCd}',"
        "'${bean.stateDesc}',"
        "'${bean.cntryCd}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${stateMaster}");
    });
  }

  Future updateDistrictMaster(DistrictDropDownList bean) async {
    print("trying to insert or replace ${districtMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${districtMaster}( "
        "${TablesColumnFile.distCd},"
        "${TablesColumnFile.distDesc},"
        "${TablesColumnFile.stateCd},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "${bean.distCd},"
        "'${bean.distDesc}',"
        "'${bean.stateCd}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${districtMaster}");
    });
  }

  Future updateSubDistrictMaster(SubDistrictDropDownList bean) async {
    print("trying to insert or replace ${subDistrictMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${subDistrictMaster}( "
        "${TablesColumnFile.placeCd},"
        "${TablesColumnFile.placeCdDesc},"
        "${TablesColumnFile.distCd},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "'${bean.placeCd}',"
        "'${bean.placeCdDesc}',"
        "${bean.distCd},"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${subDistrictMaster}");
    });
  }

  Future updateAreaMaster(AreaDropDownList bean, areaCode, placeCode) async {
    //print("trying to insert or replace ${areaMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${areaMaster}( "
        "${TablesColumnFile.areaCd},"
        "${TablesColumnFile.placeCd},"
        "${TablesColumnFile.areaDesc},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "${areaCode},"
        "'${placeCode}',"
        "'${bean.areaDesc}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${areaMaster}");
    });
  }

  Future updateCreditBereauMaster(CreditBereauBean creditBereauBean) async {
    String insertQuery = "INSERT OR REPLACE INTO "
        "${creditBereauMaster}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mqueueno} ,"
        "${TablesColumnFile.mprospectdt} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mprospectname} ,"
        "${TablesColumnFile.mmobno} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.motpverified} ,"
        "${TablesColumnFile.mcbcheckstatus} ,"
        "${TablesColumnFile.mprospectstatus} ,"
        "${TablesColumnFile.madd1} ,"
        "${TablesColumnFile.madd2} ,"
        "${TablesColumnFile.madd3} ,"
        "${TablesColumnFile.mhomeloc} ,"
        "${TablesColumnFile.mareacd} ,"
        "${TablesColumnFile.mvillage} ,"
        "${TablesColumnFile.mdistcd} ,"
        "${TablesColumnFile.mstatecd},"
        "${TablesColumnFile.mcountrycd},"
        "${TablesColumnFile.mpincode} ,"
        "${TablesColumnFile.mcountryoforigin} ,"
        "${TablesColumnFile.mnationality} ,"
        "${TablesColumnFile.mpanno} ,"
        "${TablesColumnFile.mpannodesc} ,"
        "${TablesColumnFile.misuploaded},"
        "${TablesColumnFile.mspousename} ,"
        "${TablesColumnFile.mspouserelation} ,"
        "${TablesColumnFile.mnomineename} ,"
        "${TablesColumnFile.mnomineerelation} ,"
        "${TablesColumnFile.mcreditenqpurposetype} ,"
        "${TablesColumnFile.mcreditequstage} ,"
        "${TablesColumnFile.mcreditreporttransdatetype} ,"
        "${TablesColumnFile.mcreditreporttransid} ,"
        "${TablesColumnFile.mcreditrequesttype} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.mstreet} ,"
        "${TablesColumnFile.mhouse} ,"
        "${TablesColumnFile.mcity} ,"
        "${TablesColumnFile.mstate} ,"
        "${TablesColumnFile.mid1} ,"
        "${TablesColumnFile.mid1desc} ,"
        "${TablesColumnFile.motp},"
        "${TablesColumnFile.mroutedto},"
        "${TablesColumnFile.miscustcreated},"
        "${TablesColumnFile.mtier},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mhighmarkchkdt}"
        " )VALUES("
        "${creditBereauBean.trefno} ,"
        "${creditBereauBean.mrefno} ,"
        "${creditBereauBean.mlbrcode} ,"
        "${creditBereauBean.mqueueno} ,"
        "'${creditBereauBean.mprospectdt}' ,"
        "'${creditBereauBean.mnametitle}' ,"
        "'${creditBereauBean.mprospectname}' ,"
        "${creditBereauBean.mmobno},"
        "'${creditBereauBean.mdob}' ,"
        "${creditBereauBean.motpverified} ,"
        "'${creditBereauBean.mcbcheckstatus}' ,"
        "${creditBereauBean.mprospectstatus} ,"
        "'${creditBereauBean.madd1}' ,"
        "'${creditBereauBean.madd2}' ,"
        "'${creditBereauBean.madd3}' ,"
        "'${creditBereauBean.mhomeloc}' ,"
        "${creditBereauBean.mareacd} ,"
        "'${creditBereauBean.mvillage}' ,"
        "${creditBereauBean.mdistcd} ,"
        "'${creditBereauBean.mstatecd}' ,"
        "'${creditBereauBean.mcountrycd}' ,"
        "${creditBereauBean.mpincode} ,"
        "'${creditBereauBean.mcountryoforigin}' ,"
        "'${creditBereauBean.mnationality}' ,"
        "'${creditBereauBean.mpanno}' ,"
        "'${creditBereauBean.mpannodesc}' ,"
        "${creditBereauBean.misuploaded},"
        "'${creditBereauBean.mspousename}' ,"
        "'${creditBereauBean.mspouserelation}' ,"
        "'${creditBereauBean.mnomineename}' ,"
        "'${creditBereauBean.mnomineerelation}' ,"
        "'${creditBereauBean.mcreditenqpurposetype}' ,"
        "'${creditBereauBean.mcreditequstage}' ,"
        "'${creditBereauBean.mcreditreporttransdatetype}' ,"
        "'${creditBereauBean.mcreditreporttransid}' ,"
        "'${creditBereauBean.mcreditrequesttype}' ,"
        "'${creditBereauBean.mcreateddt}' ,"
        "'${creditBereauBean.mcreatedby}' ,"
        "'${creditBereauBean.mlastupdatedt}' ,"
        "'${creditBereauBean.mlastupdateby}' ,"
        "'${creditBereauBean.mgeolocation}',"
        "'${creditBereauBean.mgeolatd}' ,"
        "'${creditBereauBean.mgeologd}' ,"
        "${creditBereauBean.missynctocoresys} ,"
        "'${creditBereauBean.mlastsynsdate}' ,"
        "'${creditBereauBean.mstreet}' ,"
        "'${creditBereauBean.mhouse}' ,"
        "'${creditBereauBean.mcity}',"
        "'${creditBereauBean.mstate}' ,"
        "'${creditBereauBean.mid1}' ,"
        "'${creditBereauBean.mid1desc}' ,"
        "${creditBereauBean.motp},"
        "'${creditBereauBean.mroutedto}',"
        "${creditBereauBean.miscustcreated},"
        "${creditBereauBean.mtier},"
        "${creditBereauBean.mcustno},"
        "'${creditBereauBean.mhighmarkchkdt}'"
        ")";

    for (var items in insertQuery.split(",")) {
      print(items);
    }
    print("inser query is ${insertQuery}");

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + "idafterinsert");
    });
  }

  Future updateCreditBereauResult(CbResultBean creditBereauResultBean) async {
    print("trying to insert or replace ${creditBereauResultMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${creditBereauResultMaster} ("
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.trefresultsrno} ,"
        "${TablesColumnFile.mrefresultsrno} ,"
        "${TablesColumnFile.mcbcheckstatus} ,"
        "${TablesColumnFile.mdateofissue} ,"
        "${TablesColumnFile.mdateofrequest} ,"
        "${TablesColumnFile.miscustomercreated} ,"
        "${TablesColumnFile.mpreparedfor} ,"
        "${TablesColumnFile.mreportid} ,"
        "${TablesColumnFile.mothrmficnt},"
        "${TablesColumnFile.mloancycle},"
        "${TablesColumnFile.mothrmficurbal} ,"
        "${TablesColumnFile.mothrmfiovrdueamt} ,"
        "${TablesColumnFile.mothrmfidisbamt},"
        "${TablesColumnFile.mtotovrdueaccno} ,"
        "${TablesColumnFile.mmfitotdisbamt} ,"
        "${TablesColumnFile.mmfitotcurrentbal},"
        "${TablesColumnFile.mmfitotovrdueamt} ,"
        "${TablesColumnFile.mtotovrdueamt} ,"
        "${TablesColumnFile.mtotcurrentbal},"
        "${TablesColumnFile.mtotdisbamt}  ,"
        "${TablesColumnFile.mexpsramt}  ,"
        "${TablesColumnFile.mcbresultblob} ,"
        "${TablesColumnFile.mcreateddt} "
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.trefresultsrno} ,"
        "${creditBereauResultBean.mrefresultsrno} ,"
        "'${creditBereauResultBean.mcbcheckstatus}' ,"
        "'${creditBereauResultBean.mdateofissue}' ,"
        "'${creditBereauResultBean.mdateofrequest}' ,"
        "'${creditBereauResultBean.miscustomercreated}' ,"
        "'${creditBereauResultBean.mpreparedfor}' ,"
        "'${creditBereauResultBean.mreportid}' ,"
        "${creditBereauResultBean.mothrmficnt},"
        "${creditBereauResultBean.mloancycle},"
        "${creditBereauResultBean.mothrmficurbal} ,"
        "${creditBereauResultBean.mothrmfiovrdueamt},"
        "${creditBereauResultBean.mothrmfidisbamt},"
        "${creditBereauResultBean.mtotovrdueaccno},"
        "${creditBereauResultBean.mmfitotdisbamt},"
        "${creditBereauResultBean.mmfitotcurrentbal},"
        "${creditBereauResultBean.mmfitotovrdueamt},"
        "${creditBereauResultBean.mtotovrdueamt},"
        "${creditBereauResultBean.mtotcurrentbal},"
        "${creditBereauResultBean.mtotdisbamt},"
        "${creditBereauResultBean.mexpsramt},"
        "'${creditBereauResultBean.mcbresultblob}',"
        "'${creditBereauResultBean.mcreateddt}'"
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(
          id.toString() + "xxx ida fter insert in ${creditBereauResultMaster}");
    });
  }


  Future updateCollateralREMlandandhouseMaster(CollateralREMlandandhouseBean  collateralREMlandandhouseBean) async {
    print("trying to insert or replace ${ CollateralREMlandandhouseMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${CollateralREMlandandhouseMaster} ("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno},"
        "${TablesColumnFile.loanmrefno},"
        "${TablesColumnFile.colleteraltrefno},"
        "${TablesColumnFile.colleteralmrefno},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mtitle},"
        "${TablesColumnFile.mfname},"
        "${TablesColumnFile.mmname},"
        "${TablesColumnFile.mlname},"
        "${TablesColumnFile.maddress1},"
        "${TablesColumnFile.maddress2},"
        "${TablesColumnFile.mcountry},"
        "${TablesColumnFile.mstate},"
        "${TablesColumnFile.mdist},"
        "${TablesColumnFile.msubdist},"
        "${TablesColumnFile.marea},"
        "${TablesColumnFile.mhousebuilttype},"
        "${TablesColumnFile.menvdescription},"
        "${TablesColumnFile.mlotarea},"
        "${TablesColumnFile.mfloorarea},"
        "${TablesColumnFile.mdescofproperty},"
        "${TablesColumnFile.msizeofproperty},"
        "${TablesColumnFile.msizeofpropertyl},"
        "${TablesColumnFile.msizeofpropertyh},"
        "${TablesColumnFile.mtctno},"
        "${TablesColumnFile.msrno},"
        "${TablesColumnFile.mregdate},"
        "${TablesColumnFile.mepebdate},"
        "${TablesColumnFile.mrescodeorremark},"
        "${TablesColumnFile.mepebno},"
        "${TablesColumnFile.mregofdeedslocation},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mcollno},"
        "${TablesColumnFile.mpriorsec},"
        "${TablesColumnFile.mcolltype},"
        "${TablesColumnFile.mcollsubtype},"
        "${TablesColumnFile.mtypeofproperty},"
        "${TablesColumnFile.mltypeofownercerti},"
        "${TablesColumnFile.mhtypeofownercerti},"
        "${TablesColumnFile.mlissuednoprop},"
        "${TablesColumnFile.mhissuednoprop},"
        "${TablesColumnFile.mlissueby},"
        "${TablesColumnFile.mhissueby},"
        "${TablesColumnFile.mlsizeprop},"
        "${TablesColumnFile.mhsizeprop},"
        "${TablesColumnFile.mlnpropborder},"
        "${TablesColumnFile.mhnpropborder},"
        "${TablesColumnFile.mlspropborder},"
        "${TablesColumnFile.mhspropborder},"
        "${TablesColumnFile.mlwpropborder},"
        "${TablesColumnFile.mhwpropborder},"
        "${TablesColumnFile.mlepropborder},"
        "${TablesColumnFile.mhepropborder},"
        "${TablesColumnFile.mllocprop},"
        "${TablesColumnFile.mhlocprop},"
        "${TablesColumnFile.mltitleowener},"
        "${TablesColumnFile.mhtitleowener},"
        "${TablesColumnFile.mllocalauthvalue},"
        "${TablesColumnFile.mhlocalauthvalue},"
        "${TablesColumnFile.mlrealestatecmpnyvalue},"
        "${TablesColumnFile.mhrealestatecmpnyvalue},"
        "${TablesColumnFile.mlaskneighonvalue},"
        "${TablesColumnFile.mhaskneighonvalue},"
        "${TablesColumnFile.mlsumonvalprop},"
        "${TablesColumnFile.mhsumonvalprop},"
        "${TablesColumnFile.mlissuedt},"
        "${TablesColumnFile.mhissuedt}"
        ")VALUES("
        "${collateralREMlandandhouseBean.trefno},"
        "${collateralREMlandandhouseBean.mrefno},"
        "${collateralREMlandandhouseBean.mloantrefno},"
        "${collateralREMlandandhouseBean.mloanmrefno},"
        "${collateralREMlandandhouseBean.colleteraltrefno},"
        "${collateralREMlandandhouseBean.colleteralmrefno},"
        "'${collateralREMlandandhouseBean.mprdacctid}',"
        "'${collateralREMlandandhouseBean.mtitle}',"
        "'${collateralREMlandandhouseBean.mfname}',"
        "'${collateralREMlandandhouseBean.mmname}',"
        "'${collateralREMlandandhouseBean.mlname}',"
        "'${collateralREMlandandhouseBean.maddress1}',"
        "'${collateralREMlandandhouseBean.maddress2}',"
        "'${collateralREMlandandhouseBean.mcountry}',"
        "'${collateralREMlandandhouseBean.mstate}',"
        "'${collateralREMlandandhouseBean.mdist}',"
        "'${collateralREMlandandhouseBean.msubdist}',"
        "'${collateralREMlandandhouseBean.marea}',"
        "'${collateralREMlandandhouseBean.mhousebuilttype}',"
        "'${collateralREMlandandhouseBean.menvdescription}',"
        "${collateralREMlandandhouseBean.mlotarea},"
        "${collateralREMlandandhouseBean.mfloorarea},"
        "'${collateralREMlandandhouseBean.mdescofproperty}',"
        "'${collateralREMlandandhouseBean.msizeofproperty}',"
        "'${collateralREMlandandhouseBean.msizeofpropertyl}',"
        "'${collateralREMlandandhouseBean.msizeofpropertyh}',"
        "${collateralREMlandandhouseBean.mtctno},"
        "${collateralREMlandandhouseBean.msrno},"
        "'${collateralREMlandandhouseBean.mregdate}',"
        "'${collateralREMlandandhouseBean.mepebdate}',"
        "'${collateralREMlandandhouseBean.mrescodeorremark}',"
        "${collateralREMlandandhouseBean.mepebno},"
        "'${collateralREMlandandhouseBean.mregofdeedslocation}',"
        "'${collateralREMlandandhouseBean.mcreateddt}',"
        "'${collateralREMlandandhouseBean.mcreatedby}',"
        "'${collateralREMlandandhouseBean.mlastupdatedt}',"
        "'${collateralREMlandandhouseBean.mlastupdateby}',"
        "'${collateralREMlandandhouseBean.mgeolocation}',"
        "'${collateralREMlandandhouseBean.mgeolatd}',"
        "'${collateralREMlandandhouseBean.mgeologd}',"
        "'${collateralREMlandandhouseBean.mlastsynsdate}',"
        "'${collateralREMlandandhouseBean.merrormessage}',"
        "${collateralREMlandandhouseBean.mcollno},"
        "'${collateralREMlandandhouseBean.mpriorsec}',"
        "'${collateralREMlandandhouseBean.mcolltype}',"
        "'${collateralREMlandandhouseBean.mcollsubtype}',"
        "'${collateralREMlandandhouseBean.mtypeofproperty}',"
        "'${collateralREMlandandhouseBean.mltypeofownercerti}',"
        "'${collateralREMlandandhouseBean.mhtypeofownercerti}',"
        "'${collateralREMlandandhouseBean.mlissuednoprop}',"
        "'${collateralREMlandandhouseBean.mhissuednoprop}',"
        "'${collateralREMlandandhouseBean.mlissueby}',"
        "'${collateralREMlandandhouseBean.mhissueby}',"
        "'${collateralREMlandandhouseBean.mlsizeprop}',"
        "'${collateralREMlandandhouseBean.mhsizeprop}',"
        "'${collateralREMlandandhouseBean.mlnpropborder}',"
        "'${collateralREMlandandhouseBean.mhnpropborder}',"
        "'${collateralREMlandandhouseBean.mlspropborder}',"
        "'${collateralREMlandandhouseBean.mhspropborder}',"
        "'${collateralREMlandandhouseBean.mlwpropborder}',"
        "'${collateralREMlandandhouseBean.mhwpropborder}',"
        "'${collateralREMlandandhouseBean.mlepropborder}',"
        "'${collateralREMlandandhouseBean.mhepropborder}',"
        "'${collateralREMlandandhouseBean.mllocprop}',"
        "'${collateralREMlandandhouseBean.mhlocprop}',"
        "'${collateralREMlandandhouseBean.mltitleowener}',"
        "'${collateralREMlandandhouseBean.mhtitleowener}',"
        "${collateralREMlandandhouseBean.mllocalauthvalue},"
        "${collateralREMlandandhouseBean.mhlocalauthvalue},"
        "${collateralREMlandandhouseBean.mlrealestatecmpnyvalue},"
        "${collateralREMlandandhouseBean.mhrealestatecmpnyvalue},"
        "${collateralREMlandandhouseBean.mlaskneighonvalue},"
        "${collateralREMlandandhouseBean.mhaskneighonvalue},"
        "${collateralREMlandandhouseBean.mlsumonvalprop},"
        "${collateralREMlandandhouseBean.mhsumonvalprop},"
        "'${collateralREMlandandhouseBean.mlissuedt}',"
        "'${collateralREMlandandhouseBean.mhissuedt}'"
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(
          id.toString() + "xxx ida fter insert in ${CollateralREMlandandhouseMaster}");
    });
  }

  Future updateCollateralVehicleMaster(CollateralVehicleBean collateralbean) async {
    print("trying to insert or replace ${collateralVehicleMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${collateralVehicleMaster} ("
        "${TablesColumnFile.msrno}  ,"
        "${TablesColumnFile.mlbrcode}   ,"
        "${TablesColumnFile.mprdacctid}  ,"
        "${TablesColumnFile.msectype}  ,"
        "${TablesColumnFile.trefno}   ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.loantrefno}   ,"
        "${TablesColumnFile.loanmrefno}  ,"
        "${TablesColumnFile.colleteraltrefno}  ,"
        "${TablesColumnFile.colleteralmrefno}  ,"
        "${TablesColumnFile.mbusinessname}  ,"
        "${TablesColumnFile.mownername}  ,"
        "${TablesColumnFile.mtel}  ,"
        "${TablesColumnFile.maddress1}  ,"
        "${TablesColumnFile.maddress2}  ,"
        "${TablesColumnFile.mcountry}  ,"
        "${TablesColumnFile.mstate}  ,"
        "${TablesColumnFile.mdist}   ,"
        "${TablesColumnFile.msubdist}  ,"
        "${TablesColumnFile.marea}   ,"
        "${TablesColumnFile.mvillage}   ,"
        "${TablesColumnFile.mbrand}  ,"
        "${TablesColumnFile.mnoofaxles}   ,"
        "${TablesColumnFile.mtype}  ,"
        "${TablesColumnFile.mnoofcylinder}   ,"
        "${TablesColumnFile.mcolor}  ,"
        "${TablesColumnFile.msizeofcylinder}   ,"
        "${TablesColumnFile.mbodyno}   ,"
        "${TablesColumnFile.menginepower}   ,"
        "${TablesColumnFile.mengineno}   ,"
        "${TablesColumnFile.myearmade}   ,"
        "${TablesColumnFile.mchassisno}  ,"
        "${TablesColumnFile.mmadeby}  ,"
        "${TablesColumnFile.midentitycarno}  ,"
        "${TablesColumnFile.mcarpricing}   ,"
        "${TablesColumnFile.mstdpricing}   ,"
        "${TablesColumnFile.minsurancepricing}   ,"
        "${TablesColumnFile.mpriceafterevaluation}   ,"
        "${TablesColumnFile.mltv}   ,"
        "${TablesColumnFile.mcartype},"
        "${TablesColumnFile.mltvdd},"
        "${TablesColumnFile.mloantovalueltv}  ,"
        "${TablesColumnFile.mwhobelongocarowner}  ,"
        "${TablesColumnFile.mcarlegality}  ,"
        "${TablesColumnFile.mreason}  ,"
        "${TablesColumnFile.mdescription}  ,"
        "${TablesColumnFile.mcarcanbeused}  ,"
        "${TablesColumnFile.mcredittenor}   ,"
        "${TablesColumnFile.mdmirror}  ,"
        "${TablesColumnFile.mddoor}  ,"
        "${TablesColumnFile.mdmirrorbacklock}  ,"
        "${TablesColumnFile.mdcolororspot}  ,"
        "${TablesColumnFile.mfcolorandspot}  ,"
        "${TablesColumnFile.mftireandyan}  ,"
        "${TablesColumnFile.mfcapofsplatter}  ,"
        "${TablesColumnFile.mhmirror}  ,"
        "${TablesColumnFile.mhvent}  ,"
        "${TablesColumnFile.mhlightfarl}  ,"
        "${TablesColumnFile.mhlightfarr}  ,"
        "${TablesColumnFile.mhsignal}  ,"
        "${TablesColumnFile.mhwincap}  ,"
        "${TablesColumnFile.mhheadcap}  ,"
        "${TablesColumnFile.mpmirror}  ,"
        "${TablesColumnFile.mpdoor}  ,"
        "${TablesColumnFile.mpbackmirror}  ,"
        "${TablesColumnFile.mpcolororspot}  ,"
        "${TablesColumnFile.mftcolorandspot}  ,"
        "${TablesColumnFile.mfttanandyan}  ,"
        "${TablesColumnFile.mftcap}  ,"
        "${TablesColumnFile.mftsplattercap}  ,"
        "${TablesColumnFile.mbpmirror}  ,"
        "${TablesColumnFile.mbpdoor}  ,"
        "${TablesColumnFile.mbpcolorandspot}  ,"
        "${TablesColumnFile.mbtcolorandsport}  ,"
        "${TablesColumnFile.mbttanandyan}  ,"
        "${TablesColumnFile.mbtcap}  ,"
        "${TablesColumnFile.mbcbacklightr}  ,"
        "${TablesColumnFile.mbcturnsignal}  ,"
        "${TablesColumnFile.mbcmessagesignal}  ,"
        "${TablesColumnFile.mbcsignal}  ,"
        "${TablesColumnFile.mbcbacklightl}  ,"
        "${TablesColumnFile.mbcbackdoor}  ,"
        "${TablesColumnFile.mbccranes}  ,"
        "${TablesColumnFile.mbctakelock}  ,"
        "${TablesColumnFile.mbcholdlock}  ,"
        "${TablesColumnFile.mbchandcranes}  ,"
        "${TablesColumnFile.mbcreservetire}   ,"
        "${TablesColumnFile.mbcbackmirror}   ,"
        "${TablesColumnFile.mbcantenna}  ,"
        "${TablesColumnFile.mbtlcolororspot}  ,"
        "${TablesColumnFile.mbtltanandyan}  ,"
        "${TablesColumnFile.mbtlcap}  ,"
        "${TablesColumnFile.mbtlsplattercap}  ,"
        "${TablesColumnFile.mbtrcolororspot}  ,"
        "${TablesColumnFile.mbtrtireandyan}  ,"
        "${TablesColumnFile.mbtrcap}  ,"
        "${TablesColumnFile.mbtrsplattercap}  ,"
        "${TablesColumnFile.mibarsun}  ,"
        "${TablesColumnFile.midescriptionbook}  ,"
        "${TablesColumnFile.miautosystem}  ,"
        "${TablesColumnFile.miairconditioner}  ,"
        "${TablesColumnFile.mimirrorremote}  ,"
        "${TablesColumnFile.misafebell}  ,"
        "${TablesColumnFile.mimiddlebox}  ,"
        "${TablesColumnFile.mregdate} ,"
        "${TablesColumnFile.mregexpdate} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mlastsynsdate} "
        ")VALUES("
        " ${collateralbean.msrno}   ,"
        " ${collateralbean.mlbrcode}   ,"
        " '${collateralbean.mprdacctid}'  ,"
        " '${collateralbean.msectype}'  ,"
        " ${collateralbean.trefno}   ,"
        " ${collateralbean.mrefno}  ,"
        " ${collateralbean.mloantrefno}   ,"
        " ${collateralbean.mloanmrefno}  ,"
        " ${collateralbean.colleteraltrefno}  ,"
        " ${collateralbean.colleteralmrefno}  ,"
        " '${collateralbean.mbusinessname}'  ,"
        " '${collateralbean.mownername}'  ,"
        " '${collateralbean.mtel}'  ,"
        " '${collateralbean.maddress1}'  ,"
        " '${collateralbean.maddress2}'  ,"
        " '${collateralbean.mcountry}'  ,"
        " '${collateralbean.mstate}'  ,"
        " '${collateralbean.mdist}'   ,"
        " '${collateralbean.msubdist}'  ,"
        " '${collateralbean.marea}'  ,"
        " '${collateralbean.mvillage}'   ,"
        " '${collateralbean.mbrand}'  ,"
        " ${collateralbean.mnoofaxles}   ,"
        " '${collateralbean.mtype}'  ,"
        " ${collateralbean.mnoofcylinder}   ,"
        " '${collateralbean.mcolor}'  ,"
        " ${collateralbean.msizeofcylinder}   ,"
        " '${collateralbean.mbodyno}'   ,"
        " ${collateralbean.menginepower}   ,"
        "' ${collateralbean.mengineno} '  ,"
        " ${collateralbean.myearmade}   ,"
        " '${collateralbean.mchassisno}'  ,"
        " '${collateralbean.mmadeby}'  ,"
        " '${collateralbean.midentitycarno}'  ,"
        " ${collateralbean.mcarpricing}   ,"
        " ${collateralbean.mstdpricing}   ,"
        " ${collateralbean.minsurancepricing}   ,"
        " ${collateralbean.mpriceafterevaluation}   ,"
        " ${collateralbean.mltv}   ,"
        " '${collateralbean.mcartype}'  ,"
        " '${collateralbean.mltvdd}'  ,"
        " '${collateralbean.mloantovalueltv}'  ,"
        " '${collateralbean.mwhobelongocarowner}'  ,"
        " ${collateralbean.mcarlegality}  ,"
        " '${collateralbean.mreason}'  ,"
        " '${collateralbean.mdescription}'  ,"
        " '${collateralbean.mcarcanbeused}'  ,"
        " '${collateralbean.mcredittenor}'   ,"
        " '${collateralbean.mdmirror}'  ,"
        " '${collateralbean.mddoor}'  ,"
        " '${collateralbean.mdmirrorbacklock}'  ,"
        " '${collateralbean.mdcolororspot}'  ,"
        " '${collateralbean.mfcolorandspot}'  ,"
        " '${collateralbean.mftireandyan}'  ,"
        " '${collateralbean.mfcapofsplatter}'  ,"
        " '${collateralbean.mhmirror}'  ,"
        " '${collateralbean.mhvent}'  ,"
        " '${collateralbean.mhlightfarl}'  ,"
        " '${collateralbean.mhlightfarr}'  ,"
        " '${collateralbean.mhsignal}'  ,"
        " '${collateralbean.mhwincap}'  ,"
        " '${collateralbean.mhheadcap}'  ,"
        " '${collateralbean.mpmirror}'  ,"
        " '${collateralbean.mpdoor}'  ,"
        " '${collateralbean.mpbackmirror}'  ,"
        " '${collateralbean.mpcolororspot}'  ,"
        " '${collateralbean.mftcolorandspot}'  ,"
        " '${collateralbean.mfttanandyan}'  ,"
        " '${collateralbean.mftcap}'  ,"
        " '${collateralbean.mftsplattercap}'  ,"
        " '${collateralbean.mbpmirror}'  ,"
        " '${collateralbean.mbpdoor}'  ,"
        " '${collateralbean.mbpcolorandspot}'  ,"
        " '${collateralbean.mbtcolorandsport}'  ,"
        " '${collateralbean.mbttanandyan}'  ,"
        " '${collateralbean.mbtcap}'  ,"
        " '${collateralbean.mbcbacklightr}'  ,"
        " '${collateralbean.mbcturnsignal}'  ,"
        " '${collateralbean.mbcmessagesignal}'  ,"
        " '${collateralbean.mbcsignal}'  ,"
        " '${collateralbean.mbcbacklightl}'  ,"
        " '${collateralbean.mbcbackdoor}'  ,"
        " '${collateralbean.mbccranes}'  ,"
        " '${collateralbean.mbctakelock}'  ,"
        " '${collateralbean.mbcholdlock}'  ,"
        " '${collateralbean.mbchandcranes}'  ,"
        " '${collateralbean.mbcreservetire}'   ,"
        " '${collateralbean.mbcbackmirror}'   ,"
        " '${collateralbean.mbcantenna}'  ,"
        " '${collateralbean.mbtlcolororspot}'  ,"
        " '${collateralbean.mbtltanandyan}'  ,"
        " '${collateralbean.mbtlcap}'  ,"
        " '${collateralbean.mbtlsplattercap}'  ,"
        " '${collateralbean.mbtrcolororspot}'  ,"
        " '${collateralbean.mbtrtireandyan}'  ,"
        " '${collateralbean.mbtrcap}'  ,"
        " '${collateralbean.mbtrsplattercap}'  ,"
        " '${collateralbean.mibarsun}'  ,"
        " '${collateralbean.midescriptionbook}'  ,"
        " '${collateralbean.miautosystem}'  ,"
        " '${collateralbean.miairconditioner}'  ,"
        " '${collateralbean.mimirrorremote}'  ,"
        " '${collateralbean.misafebell}'  ,"
        " '${collateralbean.mimiddlebox}'  ,"
        "'${collateralbean.mregdate}' ,"
        "'${collateralbean.mregexpdate}' ,"
        "'${collateralbean.mcreateddt}' ,"
        "'${collateralbean.mcreatedby}' ,"
        "'${collateralbean.mlastupdatedt}' ,"
        "'${collateralbean.mlastupdateby}' ,"
        "'${collateralbean.mgeolocation}',"
        "'${collateralbean.mgeolatd}' ,"
        "'${collateralbean.mgeologd}' ,"
        "${collateralbean.missynctocoresys} ,"
        "'${collateralbean.mlastsynsdate}' "
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(
          id.toString() + "xxx ida fter insert in ${creditBereauResultMaster}");
    });
  }






  Future updateCreditBereauLoanDetailsWithLoanSeq(
      CbResultBean creditBereauResultBean, int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${creditBereauLoanDetailsMaster}( "
        "${TablesColumnFile.trefno}  ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.mrefsrno}  ,"
        "${TablesColumnFile.trefsrno}  ,"
        "${TablesColumnFile.maccounttype}  ,"
        "${TablesColumnFile.mcurrentbalance}  ,"
        "${TablesColumnFile.mcustbankacnum}  ,"
        "${TablesColumnFile.mdatereported}  ,"
        "${TablesColumnFile.mdisbursedamount}  ,"
        "${TablesColumnFile.mnameofmfi}  ,"
        "${TablesColumnFile.mnocimagestring}  ,"
        "${TablesColumnFile.moverdueamount}  ,"
        "${TablesColumnFile.mwriteoffamount}"
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.mrefsrno}, "
        "${trefsrno} ,"
        "'${creditBereauResultBean.maccounttype}' ,"
        "${creditBereauResultBean.mcurrentbalance},"
        "'${creditBereauResultBean.mcustbankacnum}' ,"
        "'${creditBereauResultBean.mdatereported}' ,"
        "${creditBereauResultBean.mdisbursedamount} ,"
        "'${creditBereauResultBean.mnameofmfi}' ,"
        "'${creditBereauResultBean.mnocimagestring}' ,"
        "${creditBereauResultBean.moverdueamount} ,"
        "${creditBereauResultBean.mwriteoffamount}"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${creditBereauLoanDetailsMaster}");
    });
  }

  Future updateCreditBereauMasterFromtTrefNo(int trefNo,
      mrefNo,
      String cbCheckStatus,
      int mprospectStatus,
      DateTime lastUpdateDate,
      DateTime highmrkchkdate) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile
        .mrefno} = ${mrefNo} ";

    print("xxxxxxxxxxxxxxquery is here : " +
        "Update $creditBereauMaster SET ${TablesColumnFile.misuploaded} = 1 "
            ",${TablesColumnFile.mlastupdatedt} = '${lastUpdateDate}'"
            ",${TablesColumnFile.mcbcheckstatus} = '${cbCheckStatus}'"
            ", ${TablesColumnFile.mprospectstatus} = ${mprospectStatus} "
            " ${TablesColumnFile.mhighmarkchkdt} ='${highmrkchkdate}' "
            "WHERE $str ");
    var result = await db.rawQuery(
        "Update $creditBereauMaster SET ${TablesColumnFile.misuploaded} = 1 "
            ",${TablesColumnFile.mlastupdatedt} = '${lastUpdateDate}'"
            ",${TablesColumnFile.mcbcheckstatus} = '${cbCheckStatus}'"
            ", ${TablesColumnFile.mprospectstatus} = ${mprospectStatus} "
            " ,${TablesColumnFile.mhighmarkchkdt} = '${highmrkchkdate}' "
            "WHERE $str ");
  }

  Future updateCreditBereauMasterProspectStatusFromTrefNo(int trefNo,
      int mrefNo,
      String routedTo,
      int prospectStatus,
      DateTime mlastUpdatedt,
      lastUpdatedBy) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";
    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mprospectstatus} "
        "= ${prospectStatus} , ${TablesColumnFile.mroutedto} "
        "= '${routedTo}'"
        ",  ${TablesColumnFile.mlastupdateby} = '${lastUpdatedBy}'"
        ",${TablesColumnFile.mlastupdatedt} = '$mlastUpdatedt' WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("CreditBereauMaster Updated");
  }


  Future  updateGaurantorMaster(
      GuarantorDetailsBean guarantorDetailsBean) async {
    print("trying to insert or replace ${gaurantorMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${gaurantorMaster}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.mcustmrefno} ,"
        "${TablesColumnFile.mcusttrefno} ,"
        "${TablesColumnFile.mleadsid} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.msrno} ,"
        "${TablesColumnFile.mapplicanttype} ,"
        "${TablesColumnFile.mexistingcustyn} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mnameofguar} ,"
        "${TablesColumnFile.mgender} ,"
        "${TablesColumnFile.mrelationwithcust} ,"
        "${TablesColumnFile.mrelationsince} ,"
        "${TablesColumnFile.mage} ,"
        "${TablesColumnFile.mphone} ,"
        "${TablesColumnFile.mmobile} ,"
        "${TablesColumnFile.maddress} ,"
        "${TablesColumnFile.mmonthlyincome} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.moccupationtype} ,"
        "${TablesColumnFile.mmainoccupation} ,"
        "${TablesColumnFile.mworkexpinyrs} ,"
        "${TablesColumnFile.mincomeothsources} ,"
        "${TablesColumnFile.mtotalincome} ,"
        "${TablesColumnFile.mhousetype} ,"
        "${TablesColumnFile.mworkingaddress} ,"
        "${TablesColumnFile.mworkphoneno} ,"
        "${TablesColumnFile.mmothermaidenname} ,"
        "${TablesColumnFile.mpromissorynote} ,"
        "${TablesColumnFile.mnationalidtype} ,"
        "${TablesColumnFile.mnationalid} ,"
        "${TablesColumnFile.mnationaliddesc} ,"
        "${TablesColumnFile.maddress2} ,"
        "${TablesColumnFile.maddress3} ,"
        "${TablesColumnFile.maddress4} ,"
        "${TablesColumnFile.mmaritalstatus} ,"
        "${TablesColumnFile.mreligioncd} ,"
        "${TablesColumnFile.meducationalqual} ,"
        "${TablesColumnFile.memailaddr} ,"
        "${TablesColumnFile.memployername} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.merrormessage} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.mrevsrc1} ,"
        "${TablesColumnFile.mrevsrc2} ,"
        "${TablesColumnFile.mnamesrc1} ,"
        "${TablesColumnFile.mnamesrc2} ,"
        "${TablesColumnFile.mpldggurproprty1} ,"
        "${TablesColumnFile.mpldggurproprty2} ,"
        "${TablesColumnFile.mpldggurproprty3} ,"
        "${TablesColumnFile.mrev1} ,"
        "${TablesColumnFile.mrev2} ,"
        "${TablesColumnFile.mexp1} ,"
        "${TablesColumnFile.mexp2} ,"
        "${TablesColumnFile.minc1} ,"
        "${TablesColumnFile.minc2} ,"
        "${TablesColumnFile.mrevtotal} ,"
        "${TablesColumnFile.mexptotal} ,"
        "${TablesColumnFile.minctotal} ,"
        "${TablesColumnFile.msize1} ,"
        "${TablesColumnFile.msize2} ,"
        "${TablesColumnFile.msize3} ,"
        "${TablesColumnFile.mcollvalue1} ,"
        "${TablesColumnFile.mcollvalue2} ,"
        "${TablesColumnFile.mcollvalue3} ,"
        "${TablesColumnFile.mcollvaluetotal} ,"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${guarantorDetailsBean.trefno},"
        "${guarantorDetailsBean.mrefno},"
        "${guarantorDetailsBean.loanmrefno},"
        "${guarantorDetailsBean.loantrefno},"
        "${guarantorDetailsBean.custmrefno},"
        "${guarantorDetailsBean.custtrefno},"
        "'${guarantorDetailsBean.mleadsid}',"
        "'${guarantorDetailsBean.mprdacctid}',"
        "${guarantorDetailsBean.msrno},"
        "${guarantorDetailsBean.mapplicanttype},"
        "'${guarantorDetailsBean.mexistingcustyn}',"
        "${guarantorDetailsBean.mcustno},"
        "'${guarantorDetailsBean.mnameofguar}',"
        "'${guarantorDetailsBean.mgender}',"
        "'${guarantorDetailsBean.mrelationwithcust}',"
        "${guarantorDetailsBean.mrelationsince},"
        "${guarantorDetailsBean.mage},"
        "'${guarantorDetailsBean.mphone}',"
        "'${guarantorDetailsBean.mmobile}',"
        "'${guarantorDetailsBean.maddress}',"
        "${guarantorDetailsBean.mmonthlyincome},"
        "'${guarantorDetailsBean.mdob}',"
        "${guarantorDetailsBean.moccupationtype},"
        "${guarantorDetailsBean.mmainoccupation},"
        "${guarantorDetailsBean.mworkexpinyrs},"
        "${guarantorDetailsBean.mincomeothsources},"
        "${guarantorDetailsBean.mtotalincome},"
        "${guarantorDetailsBean.mhousetype},"
        "'${guarantorDetailsBean.mworkingaddress}',"
        "'${guarantorDetailsBean.mworkphoneno}',"
        "'${guarantorDetailsBean.mmothermaidenname}',"
        "'${guarantorDetailsBean.mpromissorynote}',"
        "${guarantorDetailsBean.mnationalidtype},"
        "${guarantorDetailsBean.mnationalid},"
        "'${guarantorDetailsBean.mnationaliddesc}',"
        "'${guarantorDetailsBean.maddress2}',"
        "'${guarantorDetailsBean.maddress3}',"
        "'${guarantorDetailsBean.maddress4}',"
        "${guarantorDetailsBean.mmaritalstatus},"
        "${guarantorDetailsBean.mreligioncd},"
        "'${guarantorDetailsBean.meducationalqual}',"
        "'${guarantorDetailsBean.memailaddr}',"
        "'${guarantorDetailsBean.memployername}',"
        "'${guarantorDetailsBean.mbusinessname}',"
        "'${guarantorDetailsBean.merrormessage}',"
        "'${guarantorDetailsBean.mcreateddt}',"
        "'${guarantorDetailsBean.mcreatedby}',"
        "'${guarantorDetailsBean.mlastupdatedt}',"
        "'${guarantorDetailsBean.mlastupdateby}',"
        "'${guarantorDetailsBean.mgeolocation}',"
        "'${guarantorDetailsBean.mgeolatd}',"
        "'${guarantorDetailsBean.mgeologd}',"
        "'${guarantorDetailsBean.mlastsynsdate}',"
        "'${guarantorDetailsBean.mrevsrc1}',"
        "'${guarantorDetailsBean.mrevsrc2}',"
        "'${guarantorDetailsBean.mnamesrc1}',"
        "'${guarantorDetailsBean.mnamesrc2}',"
        "'${guarantorDetailsBean.mpldggurproprty1}',"
        "'${guarantorDetailsBean.mpldggurproprty2}',"
        "'${guarantorDetailsBean.mpldggurproprty3}',"
        "${guarantorDetailsBean.mrev1},"
        "${guarantorDetailsBean.mrev2},"
        "${guarantorDetailsBean.mexp1},"
        "${guarantorDetailsBean.mexp2},"
        "${guarantorDetailsBean.minc1},"
        "${guarantorDetailsBean.minc2},"
        "${guarantorDetailsBean.mrevtotal},"
        "${guarantorDetailsBean.mexptotal},"
        "${guarantorDetailsBean.minctotal},"
        "${guarantorDetailsBean.msize1},"
        "${guarantorDetailsBean.msize2},"
        "${guarantorDetailsBean.msize3},"
        "${guarantorDetailsBean.mcollvalue1},"
        "${guarantorDetailsBean.mcollvalue2},"
        "${guarantorDetailsBean.mcollvalue3},"
        "${guarantorDetailsBean.mcollvaluetotal},"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    for (var items in insertQuery.toString().split(",")) {
      print(items);
    }
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${gaurantorMaster}");
    });
  }


  Future updateSavingsCollectionListMaster(
      SavingsListBean savingsCollectionListBean) async {
    print("trying to insert or replace ${savingsCollectionMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${savingsCollectionMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mcollectiondate},"
        "${TablesColumnFile.mcollectedamount},"
        "${TablesColumnFile.mmoduletype},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.mcashflow} ,"
    // "${TablesColumnFile.mentrydate} ,"
        "${TablesColumnFile.mbatchcd} ,"
        "${TablesColumnFile.msetno} ,"
        "${TablesColumnFile.mscrollno} ,"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${savingsCollectionListBean.trefno},"
        "${savingsCollectionListBean.mrefno},"
        "${savingsCollectionListBean.mlbrcode},"
        "'${savingsCollectionListBean.mprdacctid}',"
        "'${savingsCollectionListBean.mcollectiondate}',"
        "${savingsCollectionListBean.mcollectedamount},"
        "${savingsCollectionListBean.mmoduletype},"
        "'${savingsCollectionListBean.mremark}',"
        "'${savingsCollectionListBean.mcashflow} ',"
    // "'${savingsCollectionListBean.mentrydate} ',"
        "'${savingsCollectionListBean.mbatchcd} ',"
        "${savingsCollectionListBean.msetno} ,"
        "${savingsCollectionListBean.mscrollno} ,"
        "'${savingsCollectionListBean.mcreateddt}',"
        "'${savingsCollectionListBean.mcreatedby}',"
        "'${savingsCollectionListBean.mlastupdatedt}',"
        "'${savingsCollectionListBean.mlastupdateby}',"
        "'${savingsCollectionListBean.mgeolocation}',"
        "'${savingsCollectionListBean.mgeolatd}',"
        "'${savingsCollectionListBean.mgeologd}',"
        "'${savingsCollectionListBean.mlastsynsdate}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${savingsCollectionMaster}");
    });
  }


  Future updateMiniStatementMaster(MiniStatementBean miniStatementBean) async {
    print("trying to insert or replace ${miniStatementMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${miniStatementMaster}( "
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.mbramchname},"
        "${TablesColumnFile.mparticulars},"
        "${TablesColumnFile.mlcytrnamt},"
        "${TablesColumnFile.macttotballcy},"
        "${TablesColumnFile.mtotallienfcy},"
        "${TablesColumnFile.mentrydate},"
        "${TablesColumnFile.mdrcr},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${miniStatementBean.mlbrcode},"
        "'${miniStatementBean.mprdacctid}',"
        "'${miniStatementBean.mlongname}',"
        "'${miniStatementBean.mbramchname}',"
        "'${miniStatementBean.mparticulars}',"
        "${miniStatementBean.mlcytrnamt},"
        "${miniStatementBean.macttotballcy},"
        "${miniStatementBean.mtotallienfcy},"
        "'${miniStatementBean.mentrydate}',"
        "'${miniStatementBean.mdrcr}',"
        "'${miniStatementBean.mgeolocation}',"
        "'${miniStatementBean.mgeolatd}',"
        "'${miniStatementBean.mgeologd}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${miniStatementMaster}");
    });
  }


  Future updateSavingsListMaster(SavingsListBean savingsListBean) async {
    print("trying to insert or replace ${savingsMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${savingsMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mcusttrefno},"
        "${TablesColumnFile.mcustmrefno},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.mmobno},"
        "${TablesColumnFile.mprdcd},"
        "${TablesColumnFile.mcurcd},"
        "${TablesColumnFile.mdateopen},"
        "${TablesColumnFile.mdateclosed},"
        "${TablesColumnFile.mfreezetype},"
        "${TablesColumnFile.macctstat},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mactTotbalfcy},"
        "${TablesColumnFile.mtotallienfcy},"
        "${TablesColumnFile.mmoduletype},"
        "${TablesColumnFile.mcenterid},"
        "${TablesColumnFile.mgroupcd},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mcrs},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${savingsListBean.trefno},"
        "${savingsListBean.mrefno},"
        "${savingsListBean.mlbrcode},"
        "${savingsListBean.mcusttrefno},"
        "${savingsListBean.mcustmrefno},"
        "'${savingsListBean.mprdacctid}',"
        "'${savingsListBean.mlongname}',"
        "'${savingsListBean.mmobno}',"
        "'${savingsListBean.mprdcd}',"
        "'${savingsListBean.mcurcd}',"
        "'${savingsListBean.mdateopen}',"
        "'${savingsListBean.mdateclosed}',"
        "${savingsListBean.mfreezetype},"
        "${savingsListBean.macctstat},"
        "${savingsListBean.mcustno},"
        "${savingsListBean.macttotbalfcy},"
        "${savingsListBean.mtotallienfcy},"
        "${savingsListBean.mmoduletype},"
        "${savingsListBean.mcenterid},"
        "${savingsListBean.mgroupcd},"
        "'${savingsListBean.mcreateddt}',"
        "'${savingsListBean.mcreatedby}',"
        "'${savingsListBean.mlastupdatedt}',"
        "'${savingsListBean.mlastupdateby}',"
        "'${savingsListBean.mgeolocation}',"
        "'${savingsListBean.mgeolatd}',"
        "'${savingsListBean.mgeologd}',"
        "'${savingsListBean.mlastsynsdate}',"
        "'${savingsListBean.mcrs}',"
        "'${savingsListBean.merrormessage}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${customerLoanDetailsMaster}");
    });
  }

  Future updateCustomerLoanDetailsMaster(
      CustomerLoanDetailsBean custLoanBean) async {
    print("trying to insert or replace ${customerLoanDetailsMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${customerLoanDetailsMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mappldloanamt},"
        "${TablesColumnFile.mapprvdloanamt},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mcusttrefno},"
        "${TablesColumnFile.mcustmrefno},"
        "${TablesColumnFile.mcustcategory},"
        "${TablesColumnFile.mloanamtdisbd},"
        "${TablesColumnFile.mloandisbdt},"
        "${TablesColumnFile.mleadstatus},"
        "${TablesColumnFile.mleadstatusdesc},"
        "${TablesColumnFile.mexpdt},"
        "${TablesColumnFile.minstamt},"
        "${TablesColumnFile.minststrtdt},"
        "${TablesColumnFile.minterestamount},"
        "${TablesColumnFile.mrepaymentmode},"
        "${TablesColumnFile.mmodeofdisb},"
        "${TablesColumnFile.mperiod},"
        "${TablesColumnFile.mprdcd},"
        "${TablesColumnFile.mcurcd},"
        "${TablesColumnFile.mpurposeofLoan},"
        "${TablesColumnFile.msubpurposeofloan},"
        "${TablesColumnFile.msubpurposeofloandesc},"
        "${TablesColumnFile.mintrate},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mloancycle},"
        "${TablesColumnFile.mfrequency},"
        "${TablesColumnFile.mtypeofloan},"
        "${TablesColumnFile.missecuredloan},"
        "${TablesColumnFile.mrepaymentfreq},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mprdname},"
        "${TablesColumnFile.mcustname},"
        "${TablesColumnFile.mApprovalDesc},"
        "${TablesColumnFile.mappliedasind},"
        "${TablesColumnFile.mmainoccupn} ,"
        "${TablesColumnFile.msuboccupn} ,"
        "${TablesColumnFile.mmainoccupndesc} ,"
        "${TablesColumnFile.msuboccupndesc} ,"
        "${TablesColumnFile.maccno} ,"
        "${TablesColumnFile.minvestment} ,"
        "${TablesColumnFile.mrental} ,"
        "${TablesColumnFile.mowneruse} ,"
        "${TablesColumnFile.mremarks} ,"
        "${TablesColumnFile.merrormessage}"
        ")"
        "VALUES("
        "${custLoanBean.trefno},"
        "${custLoanBean.mrefno},"
        "'${custLoanBean.mleadsid}',"
        "${custLoanBean.mappldloanamt},"
        "${custLoanBean.mapprvdloanamt},"
        "${custLoanBean.mcustno},"
        "${custLoanBean.mcusttrefno},"
        "${custLoanBean.mcustmrefno},"
        "'${custLoanBean.mcustcategory}',"
        "${custLoanBean.mloanamtdisbd},"
        "'${custLoanBean.mloandisbdt}',"
        "${custLoanBean.mleadstatus},"
        "'${custLoanBean.mleadstatusdesc}',"
        "'${custLoanBean.mexpdt}',"
        "${custLoanBean.minstamt},"
        "'${custLoanBean.minststrtdt}',"
        "${custLoanBean.minterestamount},"
        "${custLoanBean.mrepaymentmode},"
        "${custLoanBean.mmodeofdisb},"
        "${custLoanBean.mperiod},"
        "'${custLoanBean.mprdcd}',"
        "'${custLoanBean.mcurcd}',"
        "${custLoanBean.mpurposeofLoan},"
        "'${custLoanBean.msubpurposeofloan}',"
        "'${custLoanBean.msubpurposeofloandesc}',"
        "${custLoanBean.mintrate},"
        "'${custLoanBean.mroutefrom}',"
        "'${custLoanBean.mrouteto}',"
        "'${custLoanBean.mprdacctid}',"
        "${custLoanBean.mloancycle},"
        "'${custLoanBean.mfrequency}',"
        "'${custLoanBean.mtypeofloan}',"
        "'${custLoanBean.missecuredloan}',"
        "'${custLoanBean.mrepaymentfreq}',"
        "'${custLoanBean.mcreateddt}',"
        "'${custLoanBean.mcreatedby}',"
        "'${custLoanBean.mlastupdatedt}',"
        "'${custLoanBean.mlastupdateby}',"
        "'${custLoanBean.mgeolocation}',"
        "'${custLoanBean.mgeolatd}',"
        "'${custLoanBean.mgeologd}',"
       "${custLoanBean.missynctocoresys},"
       // "${0},"
        "'${custLoanBean.mlastsynsdate}',"
        "'${custLoanBean.mprdname}',"
        "'${custLoanBean.mcustname}',"
        "'${custLoanBean.mapprovaldesc}',"
        "'${custLoanBean.mappliedasind}',"
        "'${custLoanBean.mmainoccupn}',"
        "'${custLoanBean.msuboccupn}',"
        "'${custLoanBean.mmainoccupndesc}',"
        "'${custLoanBean.msuboccupndesc}',"
        "'${custLoanBean.maccno}',"
        "'${custLoanBean.minvestment}',"
        "'${custLoanBean.mrental}',"
        "'${custLoanBean.mowneruse}',"
        "'${custLoanBean.mremarks}',"
        "'${custLoanBean.merrormessage}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${customerLoanDetailsMaster}");
    });
  }

  Future updateSettingsMaster(SettingsBean settingbean) async {
    print("trying to insert or replace ${settingsMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${settingsMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.musrcode},"
        "${TablesColumnFile.musrpass} ,"
        "${TablesColumnFile.mipaddress} ,"
        "${TablesColumnFile.mportno} ,"
        "${TablesColumnFile.isHttps} ,"
        "${TablesColumnFile.isPortRequired} ,"
        "${TablesColumnFile.yesno})"
        "VALUES("
        "${settingbean.trefno},"
        "'${settingbean.musrcode}',"
        "'${settingbean.musrpass}' ,"
        "'${settingbean.mipaddress}' ,"
        "'${settingbean.mportno}' ,"
        "${settingbean.isHttps},"
        "${settingbean.isPortRequired},"
        "${0});";
    print("insert query is sasasasasasas" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${settingsMaster}");
    });
  }

  Future updateCustomerLoanUtilizationMaster(
      LoanUtilizationBean loanUtil) async {
    print("trying to insert or replace ${loanUtilizationMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${loanUtilizationMaster}( "
        "${TablesColumnFile.mcustno}  ,"
        "${TablesColumnFile.mcustname} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mpurposeofLoan} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mactualutilization} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.musrname} ,"
        "${TablesColumnFile.mremarks} ,"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${loanUtil.mcustno},"
        "'${loanUtil.mcustname}' ,"
        "${loanUtil.mgroupcd} ,"
        "${loanUtil.mcenterid} ,"
        "'${loanUtil.mpurposeofloan}' ,"
        "'${loanUtil.mprdacctid}' ,"
        "'${loanUtil.mactualutilization}' ,"
        "'${loanUtil.mcreateddt}' ,"
        "'${loanUtil.mlastupdatedt}' ,"
        "'${loanUtil.musrname}' ,"
        "'${loanUtil.mremarks}' ,"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${loanUtilizationMaster}");
    });
  }

  // For updating Term Deposit Master
  Future updateTermDepositMaster(NewTermDepositBean newTermDepositBean) async {
    print("trying to insert or replace ${TermDepositMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${TermDepositMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mlongname} ,"
        "${TablesColumnFile.mcurcd} ,"
        "${TablesColumnFile.mcertdate} ,"
        "${TablesColumnFile.mnoinst } ,"
        "${TablesColumnFile.mnoofmonths} ,"
        "${TablesColumnFile.mnoofdays} ,"
        "${TablesColumnFile.mintrate} ,"
        "${TablesColumnFile.mmatval} ,"
        "${TablesColumnFile.mmatdate} ,"
        "${TablesColumnFile.mreceiptstatus} ,"
        "${TablesColumnFile.mlastrepaydate} ,"
        "${TablesColumnFile.mmainbalfcy} ,"
        "${TablesColumnFile.mintPrvdamtfcy} ,"
        "${TablesColumnFile.mintPaidamtfcy} ,"
        "${TablesColumnFile.mtdsamtfcy} ,"
        "${TablesColumnFile.mtdsyn} ,"
        "${TablesColumnFile.mmodeofdeposit} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mprdcd} ,"
        "${TablesColumnFile.mcrs} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mlastsynsdate}"
        ")"
        "VALUES("
        "${newTermDepositBean.trefno},"
        "${newTermDepositBean.mrefno} ,"
        "${newTermDepositBean.mlbrcode} ,"
        "'${newTermDepositBean.mprdacctId}' ,"
        "'${newTermDepositBean.mnametitle}' ,"
        "'${newTermDepositBean.mlongname}' ,"
        "'${newTermDepositBean.mcurcd}' ,"
        "'${newTermDepositBean.mcertdate}' ,"
        "'${newTermDepositBean.mnoinst}' ,"
        "'${newTermDepositBean.mnoofmonths}' ,"
        "'${newTermDepositBean.mnoofdays}' ,"
        "'${newTermDepositBean.mintrate}' ,"
        "'${newTermDepositBean.mmatval}' ,"
        "'${newTermDepositBean.mmatdate}' ,"
        "'${newTermDepositBean.mreceiptstatus}' ,"
        "'${newTermDepositBean.mlastrepaydate}' ,"
        "'${newTermDepositBean.mmainbalfcy}' ,"
        "'${newTermDepositBean.mintPrvdamtfcy}' ,"
        "'${newTermDepositBean.mintPaidamtfcy}' ,"
        "'${newTermDepositBean.mtdsamtfcy}' ,"
        "'${newTermDepositBean.mtdsyn}' ,"
        "'${newTermDepositBean.mmodeofdeposit}' ,"
        "'${newTermDepositBean.mcustno}' ,"
        "'${newTermDepositBean.mcenterid}' ,"
        "'${newTermDepositBean.mgroupcd}' ,"
        "'${newTermDepositBean.mprdcd}' ,"
        "'${newTermDepositBean.mcrs}' ,"
        "'${newTermDepositBean.mcreateddt}' ,"
        "'${newTermDepositBean.mcreatedby}' ,"
        "'${newTermDepositBean.mlastupdatedt}' ,"
        "'${newTermDepositBean.mlastupdateby}' ,"
        "'${newTermDepositBean.mgeolocation}' ,"
        "'${newTermDepositBean.mgeolatd}' ,"
        "'${newTermDepositBean.mgeologd}' ,"
        "'${newTermDepositBean.mlastsynsdate}' "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${TermDepositMaster}");
    });
  }

  //bSpeedoMeter
  Future updateSpeedoMeterDetailsMaster(SpeedoMeterBean bean) async {
    print(bean);
    print("trying to insert or replace ${speedoMeterMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${speedoMeterMaster}( "
        "${TablesColumnFile.usrName},"
        "${TablesColumnFile.effDate},"
        "${TablesColumnFile.geoLatitude},"
        "${TablesColumnFile.geoLongitude},"
        "${TablesColumnFile.geoLocation},"
        "${TablesColumnFile.startingFromImg},"
        "${TablesColumnFile.endingFromImg},"
        "${TablesColumnFile.startingPoint},"
        "${TablesColumnFile.endingPoint},"
        "${TablesColumnFile.totMeterReading},"
        "${TablesColumnFile.createdAt},"
        "${TablesColumnFile.updatedAt},"
        "${TablesColumnFile.createdBy},"
        "${TablesColumnFile.updatedBy}, "
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "'${bean.usrName}',"
        "'${bean.effDate}',"
        "'${bean.geoLatitude}',"
        "'${bean.geoLongitude}',"
        "'${bean.geoLocation}',"
        "'${bean.startingFromImg}',"
        "'${bean.endingFromImg}',"
        "${bean.startingPoint},"
        "${bean.endingPoint},"
        "${bean.totMeterReading},"
        "'${bean.createdAt}',"
        "'${bean.updatedAt}',"
        "'${bean.createdBy}',"
        "'${bean.updatedBy}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${speedoMeterMaster}");
    });
  }

  Future updateSavingsAccountMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${savingsMaster} SET ${query}");
    });
  }

  Future updateCustomerLoanMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${customerLoanDetailsMaster} SET ${query}");
    });
  }


  Future updateGaurantorMasterForCustomer(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${gaurantorMaster} SET ${query}");
    });
  }

  Future updateDocumentMasterForCustomer(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${DOCUMENTSMASTER} SET ${query}");
    });
  }

  Future updateLoanDetailsStatus(int loanLeTrefNo, int loanMrefno,
      CustomerLoanDetailsBean custLoanBean, DateTime updateDate,String routeTo,
      String routeFrom,String lastUpdatedBy) async {
    var db = await _getDb();
    /*String query;
    if (custLoanBean.mrefno != null && custLoanBean.mrefno > 0) {
        query =
            "Select * from  ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno} = $loanLeTrefNo AND ${TablesColumnFile.mrefno} = ${custLoanBean.mrefno}";

    } else {
        query =
            "Select * from  ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno} = $loanNumber AND ${TablesColumnFile.mcreatedby} = '${custLoanBean.mcreatedby}'";
    }

    print("select query of laon satus upd " + query.toString());
    var db = await _getDb();

    var result = await db.rawQuery(query);*/
    // print("result after " + result.toString());
    String updateQuery;
    if (loanMrefno != null && loanMrefno > 0) {
      updateQuery =
      "UPDATE ${customerLoanDetailsMaster} SET ${TablesColumnFile.mleadstatus} = ${custLoanBean.mleadstatus} ,${TablesColumnFile.mlastupdatedt} = '${updateDate}', "
          " ${TablesColumnFile.mApprovalDesc} ='${custLoanBean.mapprovaldesc}' ,"
          " ${TablesColumnFile.mrouteto} ='${routeTo}' ,   ${TablesColumnFile.mroutefrom} ='${routeFrom}' , "
          " ${TablesColumnFile.mlastupdateby} ='${lastUpdatedBy}' "
          " WHERE "
          " ${TablesColumnFile.trefno} = $loanLeTrefNo AND ${TablesColumnFile.mrefno} = $loanMrefno";
    } else {
      updateQuery =
      "UPDATE ${customerLoanDetailsMaster} SET ${TablesColumnFile.mleadstatus} = ${custLoanBean.mleadstatus}, "
          "${TablesColumnFile.mApprovalDesc} = '${custLoanBean.mapprovaldesc}' ,${TablesColumnFile.mlastupdatedt} = '${updateDate}' "
          ", ${TablesColumnFile.mrouteto} ='${routeTo}' ,   ${TablesColumnFile.mroutefrom} ='${routeFrom}' , "
          " ${TablesColumnFile.mlastupdateby} ='${lastUpdatedBy}' "
          " WHERE ${TablesColumnFile.trefno} = $loanLeTrefNo AND ${TablesColumnFile.mrefno} = 0";
    }

    print(updateQuery);
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(updateQuery);
    });
  }

  Future<bool> checkIfCGT1And2onSameDate(int loanNumber) async {
    bool isCgt2OnSameDate = false;
    var db = await _getDb();
    var result;
    result = await db.rawQuery(
        'SELECT ${TablesColumnFile
            .mleadstatus} FROM ${customerLoanDetailsMaster} WHERE ${TablesColumnFile
            .mleadsid} = ${loanNumber};) ');
    if (result["mleadstatus"] == 5) {
      result = null;
      result = await db.rawQuery(
          'SELECT ${TablesColumnFile
              .createdAt} FROM ${CGT1Master} WHERE ${TablesColumnFile
              .mleadsid} = ${loanNumber};) ');
    }
    DateTime cgt1CreatedDate = DateTime.parse(result[TablesColumnFile.endTime]);
    if (cgt1CreatedDate.isBefore(DateTime.now())) {
      isCgt2OnSameDate = true;
    }
    return isCgt2OnSameDate;
  }

  Future updateCustomerNOCImageMaster(NOCImageBean imageBean) async {
    print("trying to insert or replace ${customerNOCImageMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${customerNOCImageMaster}  "
        "(${TablesColumnFile.trefno} , "
        "${TablesColumnFile.serialNo}  , "
        "${TablesColumnFile.NOCImageString}  , "
        "${TablesColumnFile.createdAt}  , "
        "${TablesColumnFile.mnameofmfi}  , "
        "${TablesColumnFile.updatedAt}   ) "
        "VALUES "
        "(${imageBean.adhaarNo} , "
        "'${imageBean.serialNo}' , "
        "'${imageBean.NOCImageString}'  , "
        "'${imageBean.createdAt}' , "
        "'${imageBean.updatedAt}'  , "
        "'${imageBean.nameOfMFI}'  , "
        "${imageBean.isDataSynced} ); ";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${customerNOCImageMaster}");
    });
  }

  Future<List<CreditBereauBean>> getAllCreditMasterObjectsSynced() async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      CreditBereauBean retBean = new CreditBereauBean();
      List<CreditBereauBean> n = new List<CreditBereauBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile
              .misuploaded} = 1");

      result = await db.rawQuery(
          'SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile
              .misuploaded} = 1');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataProspectbean(result[i]);
          print("exiting from map");
          n.add(retBean);
        }
      } catch (e) {
        print(e.toString());
      }

      return n;
    } catch (e) {
      return null;
    }
  }

  Future<List<SavingsListBean>> getSavingsAccountDetails() async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> SavingsAccountList = new List<SavingsListBean>();
    var result;
    print("query is" + "SELECT *  FROM $savingsMaster ;");
    //result = await db.rawQuery('SELECT *  FROM $savingsMaster WHERE ${TablesColumnFile.mprdacctId} <> null AND  ${TablesColumnFile.mprdacctId} <> "null" ;');
    result = await db.rawQuery(
        'SELECT *  FROM $savingsMaster Order by ${TablesColumnFile
            .mdateopen} DESC ;');
    var result1 = await db
        .rawQuery('SELECT COUNT(*) FROM ${savingsMaster}');
    print("savingsMaster count");
    print(result1);
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindDataSavingsListBean(result[i]);
      print("exiting from map");
      SavingsAccountList.add(retBean);
    }
    return SavingsAccountList;
  }

  Future<List<NewTermDepositBean>> getTermDepositList() async {
    var db = await _getDb();
    NewTermDepositBean retBean = new NewTermDepositBean();
    List<NewTermDepositBean> TermDepositList =
    new List<NewTermDepositBean>();
    var result;
    print("query is" + "SELECT *  FROM $TermDepositMaster ;");
    result =
    await db.rawQuery('SELECT *  FROM $TermDepositMaster  ;');
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindTermDepositListBean(result[i]);
      print("exiting from map");
      TermDepositList.add(retBean);
    }
    return TermDepositList;
  }

  GuarantorDetailsBean bindLoanGuarantorDetailsBean(
      Map<String, dynamic> result) {
    return GuarantorDetailsBean.fromMap(result);
  }

  LoanUtilizationBean bindLoanUtilizationBean(Map<String, dynamic> result) {
    return LoanUtilizationBean.fromMap(result);
  }


  Future<List<GuarantorDetailsBean>> getGaurantorDetailsListOnCustType(String custtype,int trefno,int mrefno) async {
    print("getGaurantorDetailsListOnCustType");
    var db = await _getDb();
    String seleQuery = "";
    GuarantorDetailsBean retBean = new GuarantorDetailsBean();
    List<GuarantorDetailsBean> GaurantorDetailsList =
    new List<GuarantorDetailsBean>();
    var result;
    seleQuery = "Select * from ${gaurantorMaster} WHERE "
        "${TablesColumnFile.loanmrefno + " = " + trefno.toString() }"
        "${mrefno == 0||mrefno == null? "":" AND "+TablesColumnFile.loantrefno+ " = " + mrefno.toString() }"
        "${" AND "+TablesColumnFile.mapplicanttype+ " = " + custtype.toString() }; ";
print(seleQuery);

    result = await db.rawQuery(seleQuery);
print(result);
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      retBean = bindLoanGuarantorDetailsBean(result[i]);
      for (var items in retBean.toString().split(",")) {
        print(items);
      }
      print("exiting from map---------------");
      GaurantorDetailsList.add(retBean);
    }
    return GaurantorDetailsList;
  }


  Future<List<SocialFinancialDetailsBean>> getAccountList(String mcurcd,int mcusttrefno,int mcustmrefno) async {
    print("getAccountList");
    var db = await _getDb();
    String seleQuery = "";
    String cp="CAMBODIA POST BANK Plc%";
    SocialFinancialDetailsBean retBean = new SocialFinancialDetailsBean();
    List<SocialFinancialDetailsBean> SocialFinList =
    new List<SocialFinancialDetailsBean>();
    var result;
    seleQuery = "Select * from ${bankDetailsMaster} WHERE "
        "${TablesColumnFile.trefno + " = " + mcusttrefno.toString() }"
        "${mcustmrefno == 0||mcustmrefno == null? "":" AND "+TablesColumnFile.mrefno+ " = " + mcustmrefno.toString() }"
        "${" AND "+TablesColumnFile.mbankname+ " LIKE '" +cp.toString() }'"
        "${" AND "+TablesColumnFile.mcurcode+ " = '" + mcurcd.toString() }'; ";
    print(seleQuery);

    result = await db.rawQuery(seleQuery);
    print(result);
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      retBean = bindDataCustomerBankDetailsListBean(result[i]);
      for (var items in retBean.toString().split(",")) {
        print(items);
      }
      print("exiting from map---------------");
      SocialFinList.add(retBean);
    }
    return SocialFinList;
  }


  Future<List<GuarantorDetailsBean>> getGaurantorDetailsList(int trefno,int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    GuarantorDetailsBean retBean = new GuarantorDetailsBean();
    List<GuarantorDetailsBean> GaurantorDetailsList =
    new List<GuarantorDetailsBean>();
    var result;
    seleQuery = "Select * from ${gaurantorMaster} WHERE "
        "${TablesColumnFile.loantrefno + " = " + trefno.toString() }"
        "${mrefno == 0||mrefno == null? "":" AND "+TablesColumnFile.loanmrefno+ " = " + mrefno.toString()}; ";


    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      retBean = bindLoanGuarantorDetailsBean(result[i]);
      for (var items in retBean.toString().split(",")) {
        print(items);
      }
      print("exiting from map");
      GaurantorDetailsList.add(retBean);
    }
    return GaurantorDetailsList;
  }


  Future<List<LoanUtilizationBean>> getLoanUtilizationDetails() async {
    var db = await _getDb();
    LoanUtilizationBean retBean = new LoanUtilizationBean();
    List<LoanUtilizationBean> UtilizationList =
    new List<LoanUtilizationBean>();
    var result;
    print("query is" + "SELECT *  FROM $loanUtilizationMaster ;");
    result =
    await db.rawQuery('SELECT *  FROM $loanUtilizationMaster  ;');
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindLoanUtilizationBean(result[i]);
      print("exiting from map");
      UtilizationList.add(retBean);
    }
    return UtilizationList;
  }

  Future<List<LoanUtilizationBean>>
  getLoanUtilizationNotSynced() async {
    var db = await _getDb();
    LoanUtilizationBean retBean = new LoanUtilizationBean();
    List<LoanUtilizationBean> UtilizationList =
    new List<LoanUtilizationBean>();
    var result;
    print("query is" +
        "SELECT *  FROM $loanUtilizationMaster where ${TablesColumnFile
            .isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL; ;");
    result = await db.rawQuery(
        'SELECT *  FROM $loanUtilizationMaster where ${TablesColumnFile
            .isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL; ;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindLoanUtilizationBean(result[i]);
        print("exiting ffrom map");
        UtilizationList.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return UtilizationList;
  }

  Future<List<CreditBereauBean>> getAllCbCheckEligibleProspect() async {
    //try {
    var db = await _getDb();

    print("inside get ALl Objects");
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> n = new List<CreditBereauBean>();

    var result;
    print("query is" +
        "SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile
            .misuploaded}= 0 AND ${TablesColumnFile.motpverified} = 1 ");

    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile
            .misuploaded} = 0 AND ${TablesColumnFile.motpverified} = 1');

    //try {
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindDataProspectbean(result[i]);
      print("exiting from map");
      n.add(retBean);
    }
    /*} catch ( e) {
        print(e.toString());
      }*/

    return n;
    /*} catch (e) {
      return null;
    }*/
  }

  Future<List<CreditBereauBean>> getCreditBereauMasterFromProspectStatus(
      int prospectStatus) async {
    var db = await _getDb();
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> prospectList = new List<CreditBereauBean>();
    var result;

    print("query is" +
        "SELECT *  FROM $creditBereauMaster where ${TablesColumnFile
            .mprospectstatus} >= ${prospectStatus} ;");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauMaster  where ${TablesColumnFile
            .mprospectstatus} >= ${prospectStatus} ');
    try {
      for (int i = 0; i < result.length; i++) {
        for (var items in result[i].toString().split(",")) {}
        print(result[i].runtimeType);
        retBean = bindProspectBean(result[i]);
        print("exiting from map");
        prospectList.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return prospectList;
  }

  Future<List<CreditBereauBean>> getCreditBereauMasterFromIsDataSynced(
      int isDataSynced) async {
    var db = await _getDb();
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> prospectList = new List<CreditBereauBean>();

    var result;

    print("query is" +
        "SELECT *  FROM $creditBereauMaster where ${TablesColumnFile
            .isDataSynced} = ${isDataSynced} ;");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauMaster  where ${TablesColumnFile
            .isDataSynced} = ${isDataSynced} ');
    // try {

    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        //print(result[i]);
        for (var items in result[i].toString().split(",")) {
          //print(items);
        }
        print(result[i].runtimeType);
        retBean = bindProspectBean(result[i]);
        print("exiting from map");
        prospectList.add(retBean);
      }
    }

    /* } catch (e) {
      print(e.toString());
    }*/
    return prospectList;
  }

  CreditBereauBean bindProspectBean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  Future<List<CbResultBean>> getCreditBereauResultNotSynced() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CbResultBean retBean = new CbResultBean();
    List<CbResultBean> prospectList = new List<CbResultBean>();

    /*CreditBereauBean future =await  getMaxSegmentIdentifier(retBean);*/
    //int count = future.segmentIdentifier;
    // print("MaxsegmentIdentifier is"+count.toString());
    var result;

    //if(future!=null) {

    print("query is" +
        "SELECT *  FROM $creditBereauResultMaster where ${TablesColumnFile
            .isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL;");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauResultMaster  where ${TablesColumnFile
            .isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL; ;');
    // try {
    for (int i = 0; i < result.length; i++) {
      //print(result[i]);
      for (var items in result[i].toString().split(",")) {
        //print(items);
      }
      print(result[i].runtimeType);
      retBean = bindCreditBereauResultBean(result[i]);
      print("exiting from map");
      prospectList.add(retBean);
    }
    /* } catch (e) {
      print(e.toString());
    }*/
    return prospectList;
  }

  CbResultBean bindCreditBereauResultBean(Map<String, dynamic> result) {
    return CbResultBean.fromMap(result);
  }

  /* CustomerLoanDetailsBean bindCustomerLoanDetails(Map<String, dynamic> result) {
    return CustomerLoanDetailsBean.fromMap(result);
  }
  Future<List<CustomerLoanDetailsBean>> getCustomerLoanDetails() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CustomerLoanDetailsBean retBean = new CustomerLoanDetailsBean();
    List<CustomerLoanDetailsBean> loanDetailsList = new List<CustomerLoanDetailsBean>();
    */ /*CreditBereauBean future =await  getMaxSegmentIdentifier(retBean);*/ /*
    //int count = future.segmentIdentifier;
    // print("MaxsegmentIdentifier is"+count.toString());
    var result;
    //if(future!=null) {
    print("query is" + "SELECT *  FROM $customerLoanDetailsMaster ");
    result = await db.rawQuery('SELECT *  FROM $customerLoanDetailsMaster ;');
    // try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      retBean = bindCustomerLoanDetails(result[i]);
      print("exiting ffrom map");
      loanDetailsList.add(retBean);
    }
    */ /* } catch (e) {
      print(e.toString());
    }*/ /*
    return loanDetailsList;
  }*/
  GRTBean bindCustomerGRTDetails(Map<String, dynamic> result) {
    return GRTBean.fromMap(result);
  }

  Future<List<GRTBean>> getCustomerGRTDetails(int mrefno, int trefno) async {
    var db = await _getDb();
    GRTBean retBean = new GRTBean();
    List<GRTBean> grtDetailsList = new List<GRTBean>();
    String query =
        "SELECT *  FROM $GRTMaster WHERE ${TablesColumnFile
        .loanmrefno} = ${mrefno} AND ${TablesColumnFile
        .loantrefno} = ${trefno}";
    var result;
    print("query is" + "SELECT *  FROM $GRTMaster ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha grt " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCustomerGRTDetails(result[i]);
        print("exiting ffrom map");
        grtDetailsList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return grtDetailsList;
  }

  CGT2Bean bindCustomerCGT2Details(Map<String, dynamic> result) {
    return CGT2Bean.fromMap(result);
  }

  Future<List<CGT2Bean>> getCustomerCGT2Details(int mrefno, int trefno) async {
    var db = await _getDb();
    CGT2Bean retBean = new CGT2Bean();
    List<CGT2Bean> CGT2DetailsList = new List<CGT2Bean>();
    String query =
        'SELECT *  FROM $CGT2Master  WHERE ${TablesColumnFile
        .loanmrefno} = ${mrefno} AND ${TablesColumnFile
        .loantrefno} = ${trefno}';
    var result;
    print("query is" + "SELECT *  FROM $CGT2Master ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha cgt2 " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCustomerCGT2Details(result[i]);
        print("exiting ffrom map");
        CGT2DetailsList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return CGT2DetailsList;
  }

  CGT1Bean bindCustomerCGT1Details(Map<String, dynamic> result) {
    return CGT1Bean.fromMap(result);
  }

  Future<List<CGT1Bean>> getCustomerCGT1Details(int mrefno, int trefno) async {
    var db = await _getDb();
    CGT1Bean retBean = new CGT1Bean();
    List<CGT1Bean> CGT1DetailsList = new List<CGT1Bean>();
    String query =
        "SELECT *  FROM $CGT1Master  WHERE  ${TablesColumnFile
        .loanmrefno} = ${mrefno} AND ${TablesColumnFile
        .loantrefno} = ${trefno}";
    var result;
    print("query is" + "SELECT *  FROM $CGT1Master ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha cgt1 " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }

        retBean = bindCustomerCGT1Details(result[i]);

        CGT1DetailsList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return CGT1DetailsList;
  }

  /*Future<List<CheckListBean>> getCustomerDisStatusCheckListDetails(int loanNumber, String screenName) async {
    var db = await _getDb();
    CheckListBean checkBean = new CheckListBean();
    List<CheckListBean> checkListBean =  new List<CheckListBean>();
    String query = "SELECT *  FROM $checkListMaster  WHERE  ${TablesColumnFile.loanNumber} = ${loanNumber} AND ${TablesColumnFile.screenName} = '${screenName}' ";
    var result;
    print("query is" + "SELECT *  FROM $CGT1Master ");
    result = await db.rawQuery(query);
    // try {
    for (int i = 0; i < result.length; i++) {
      print("yes yaha " + result[i].toString());
      print(result[i].runtimeType);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      checkBean = bindCustomerDisStatusCheckListDetails(result[i]);
      print("exiting ffrom map");
      checkListBean.add(checkBean);
    }
    // } catch (e) {
    // print(StackTrace.current);
    // debugPrintStack();
    // print(e.toString());
    //}
    return checkListBean;
  }


  CheckListBean bindCustomerDisStatusCheckListDetails(List<Map<String, dynamic>> result) {
    return CheckListBean.fromMap(result[0]);
  }
*/
  Future<CreditBereauBean> showAllCreditMaster() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CreditBereauBean retBean = new CreditBereauBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $creditBereauMaster ');
    var result = await db.rawQuery('SELECT *  FROM $creditBereauMaster ');
    if (result[0] != null) {
      print(result);
      retBean = bindDataCreditBean(result);
    }
    return retBean;
  }

  Future<List<GroupFoundationBean>> getGroupFoundationList() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    GroupFoundationBean retBean = new GroupFoundationBean();
    List<GroupFoundationBean> n = new List<GroupFoundationBean>();
    var result;
    String centerNo = globals.centerNo;
    print("query is" + "SELECT *  FROM $groupFoundationMaster ");
    result = await db.rawQuery(
        "SELECT *  FROM $groupFoundationMaster where ${TablesColumnFile
            .mcenterid} = $centerNo;");

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindGroupFoundationBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }

    return n;
  }

  GroupFoundationBean bindGroupFoundationBean(Map<String, dynamic> result) {
    return GroupFoundationBean.fromMap(result);
  }

  Future<List<CenterDetailsBean>> getCenterFoundationList() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CenterDetailsBean retBean = new CenterDetailsBean();
    List<CenterDetailsBean> n = new List<CenterDetailsBean>();

    /*CreditBereauBean future =await  getMaxSegmentIdentifier(retBean);*/
    //int count = future.segmentIdentifier;
    // print("MaxsegmentIdentifier is"+count.toString());
    var result;

    //if(future!=null) {

    print("query is" + "SELECT *  FROM $centerDetailsMaster ");
    result = await db.rawQuery(
        'SELECT *  FROM $centerDetailsMaster order by ${TablesColumnFile
            .mnextmeetngdt};');

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCenterDetailsBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }

    return n;
  }

  CenterDetailsBean bindCenterDetailsBean(Map<String, dynamic> result) {
    return CenterDetailsBean.fromMap(result);
  }

  Future<List<CountryDropDownBean>> getCountryList() async {
    var db = await _getDb();
    CountryDropDownBean retBean = new CountryDropDownBean();
    List<CountryDropDownBean> n = new List<CountryDropDownBean>();
    var result;
    print("query is" + "SELECT *  FROM $countryMaster ");
    result = await db.rawQuery('SELECT *  FROM $countryMaster ;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCountryDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CountryDropDownBean bindCountryDropDownBean(Map<String, dynamic> result) {
    return CountryDropDownBean.fromMap(result);
  }

  Future<List<StateDropDownList>> getStateList() async {
    var db = await _getDb();
    StateDropDownList retBean = new StateDropDownList();
    List<StateDropDownList> n = new List<StateDropDownList>();
    var result;
    print("query is" + "SELECT *  FROM $stateMaster ");
    result = await db
        .rawQuery("SELECT *  FROM $stateMaster where countryId = '$cntryCd';");
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindStateDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  StateDropDownList bindStateDropDownBean(Map<String, dynamic> result) {
    return StateDropDownList.fromMap(result);
  }

  Future<List<DistrictDropDownList>> getDistrictList() async {
    var db = await _getDb();
    DistrictDropDownList retBean = new DistrictDropDownList();
    List<DistrictDropDownList> n = new List<DistrictDropDownList>();
    var result;
    print("query is" + "SELECT *  FROM $districtMaster ");
    result = await db
        .rawQuery("SELECT *  FROM $districtMaster where stateCd = '$stateCd';");
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindDistrictDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  DistrictDropDownList bindDistrictDropDownBean(Map<String, dynamic> result) {
    return DistrictDropDownList.fromMap(result);
  }

  Future<List<SubDistrictDropDownList>> getSubDistrictList() async {
    var db = await _getDb();
    SubDistrictDropDownList retBean = new SubDistrictDropDownList();
    List<SubDistrictDropDownList> n = new List<SubDistrictDropDownList>();
    var result;
    print("query is" + "SELECT *  FROM $subDistrictMaster ");
    result = await db.rawQuery(
        "SELECT *  FROM $subDistrictMaster where distCd = $distCd;");
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindSubDistrictDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  SubDistrictDropDownList bindSubDistrictDropDownBean(
      Map<String, dynamic> result) {
    return SubDistrictDropDownList.fromMap(result);
  }

  Future<List<AreaDropDownList>> getAreaList() async {
    var db = await _getDb();
    AreaDropDownList retBean = new AreaDropDownList();
    List<AreaDropDownList> n = new List<AreaDropDownList>();
    var result;

    print(
        "query is" + "SELECT *  FROM $areaMaster where placeCd = '$placeCd' ");
    result = await db
        .rawQuery("SELECT *  FROM $areaMaster where placeCd = '$placeCd';");

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindAreaDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  AreaDropDownList bindAreaDropDownBean(Map<String, dynamic> result) {
    return AreaDropDownList.fromMap(result);
  }

  Future<CbResultBean> getCbResult(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";

    var result;
    CbResultBean retBean = new CbResultBean();

    print(
        "query is" + "SELECT *  FROM $creditBereauResultMaster  where ${str}");

    try {
      result = await db
          .rawQuery('SELECT *  FROM $creditBereauResultMaster where ${str};');

      if (result[0] != null) {
        print(result[0]);
        retBean = bindCreditResultBean(result);
      }
      return retBean;
    } catch (e) {
      print(e);
      return null;
    }
  }

  CbResultBean bindCreditResultBean(List<Map<String, dynamic>> result) {
    return CbResultBean.fromMap(result[0]);
  }

  Future<List<CbResultBean>> getLoanDetails(int trefNo, int mrefNo) async {
    var db = await _getDb();

    CbResultBean retBean = new CbResultBean();
    List<CbResultBean> n = new List<CbResultBean>();
    var str =
        "${TablesColumnFile.trefno} = $trefNo AND ${TablesColumnFile
        .mrefno} = $mrefNo  ";

    var result;

    print("query is" +
        "SELECT *  FROM $creditBereauLoanDetailsMaster where ${str} ");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauLoanDetailsMaster  where ${str};');

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindLoanDetailBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print("error in fetching");
    }

    return n;
  }

  CbResultBean bindLoanDetailBean(Map<String, dynamic> result) {
    return CbResultBean.fromMap(result);
  }

  CreditBereauBean bindDataProspectbean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  CreditBereauBean bindDataCreditBean(List<Map<String, dynamic>> result) {
    return CreditBereauBean.fromMap(result[0]);
  }

  Future updateLoginColumn(LoginBean loginBean, String usrCode) async {
    String insertQuery = 'INSERT OR REPLACE INTO '
        '${userMasterTable}'
        '( ${TablesColumnFile.musrcode}  ,'
        '${TablesColumnFile.mcustaccesslvl} ,'
        '${TablesColumnFile.mextnno} ,'
        '${TablesColumnFile.mactiveinstn} ,'
        '${TablesColumnFile.mautologoutperiod} ,'
        '${TablesColumnFile.mautologoutyn} ,'
        '${TablesColumnFile.mbadloginsdt} ,'
        '${TablesColumnFile.memailid} ,'
        '${TablesColumnFile.merror} ,'
        '${TablesColumnFile.merrormessage} ,'
        '${TablesColumnFile.mgrpcd} ,'
        '${TablesColumnFile.misloggedinyn} ,'
        '${TablesColumnFile.mlastpwdchgdt} ,'
        '${TablesColumnFile.mlastsyslidt} ,'
        '${TablesColumnFile.mmaxbadlginperday} ,'
        '${TablesColumnFile.mmaxbadlginperinst} ,'
        '${TablesColumnFile.mmobile} ,'
        '${TablesColumnFile.mnextpwdchgdt} ,'
        '${TablesColumnFile.mnextsyslgindt} ,'
        '${TablesColumnFile.mnoofbadlogins} ,'
        '${TablesColumnFile.mpwdchgforcedyn} ,'
        '${TablesColumnFile.mpwdchgperioddays} ,'
        '${TablesColumnFile.mregdevicemacid} ,'
        '${TablesColumnFile.mreportinguser} ,'
        '${TablesColumnFile.mstatus} ,'
        '${TablesColumnFile.musrbrcode} ,'
        '${TablesColumnFile.musrdesignation} ,'
        '${TablesColumnFile.musrname} ,'
        '${TablesColumnFile.musrpass} ,'
        '${TablesColumnFile.musrshortname} ,'
        '${TablesColumnFile.mReason} ,'
        '${TablesColumnFile.mSusDate} ,'
        '${TablesColumnFile.mJoinDate} ,'
        '${TablesColumnFile.mgender} ,'
        '${TablesColumnFile.mcreateddt} ,'
        '${TablesColumnFile.mcreatedby} ,'
        '${TablesColumnFile.mlastupdatedt} ,'
        '${TablesColumnFile.mlastupdateby} ,'
        '${TablesColumnFile.mgeolocation} ,'
        '${TablesColumnFile.mgeolatd} ,'
        '${TablesColumnFile.mgeologd} ,'
        '${TablesColumnFile.mlastsynsdate})'
        ' VALUES('
        '"${loginBean.musrcode.trim()}",'
        '${loginBean.mcustaccesslvl} ,'
        '${loginBean.mextnno} ,'
        '"${loginBean.mactiveinstn}",'
        '${loginBean.mautologoutperiod} ,'
        '"${loginBean.mautologoutyn}",'
        '"${loginBean.mbadloginsdt}" ,'
        '"${loginBean.memailid}",'
        '${loginBean.merror} ,'
        '"${loginBean.merrormessage}",'
        '${loginBean.mgrpcd} ,'
        '${loginBean.misloggedinyn} ,'
        '"${loginBean.mlastpwdchgdt}" ,'
        '"${loginBean.mlastsyslidt}" ,'
        '${loginBean.mmaxbadlginperday} ,'
        '${loginBean.mmaxbadlginperinst} ,'
        '"${loginBean.mmobile}",'
        '"${loginBean.mnextpwdchgdt}" ,'
        '"${loginBean.mnextsyslgindt}" ,'
        '${loginBean.mnoofbadlogins} ,'
        '"${loginBean.mpwdchgforcedyn}",'
        '${loginBean.mpwdchgperioddays} ,'
        '"${loginBean.mregdevicemacid}",'
        '"${loginBean.mreportinguser}",'
        '${loginBean.mstatus} ,'
        '${loginBean.musrbrcode} ,'
        '"${loginBean.musrdesignation}",'
        '"${loginBean.musrname}",'
        '"${loginBean.musrpass.trim()}",'
        '"${loginBean.musrshortname}",'
        '"${loginBean.mReason}",'
        '"${loginBean.mSusDate}" ,'
        '"${loginBean.mJoinDate}" ,'
        '"${loginBean.mgender}",'
        '"${loginBean.mcreateddt}" ,'
        '"${loginBean.mcreatedby}",'
        '"${loginBean.mlastupdatedt}" ,'
        '"${loginBean.mlastupdateby}",'
        '"${loginBean.mgeolocation}",'
        '"${loginBean.mgeolatd}",'
        '"${loginBean.mgeologd}",'
        '"${loginBean.mlastsynsdate}")';
    print("insert query of login here it is " + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + "idafterinsert");
    });
  }

  Future<LoginBean> getLoginData(LoginBean loginBean) async {
    var db = await _getDb();
    var userPass =
        "${TablesColumnFile.musrpass} = '${loginBean.musrpass.trim()}'";
    var userCode =
        "UPPER(${TablesColumnFile.musrcode}) = '${loginBean.musrcode.trim().toUpperCase()}'";
    LoginBean retBean = new LoginBean();

    print('query is here : ' +
        'SELECT *  FROM $userMasterTable  WHERE $userPass AND $userCode');
    var result = await db.rawQuery(
        'SELECT *  FROM $userMasterTable  WHERE $userPass AND $userCode');
    if (result[0] != null) {
      print(" yes login ofline " + result[0].toString());
      retBean = bindDataLoginBEan(result);
      //  retBean = bindDataLoginBEan(result);
    }
    return retBean;
  }

  LoginBean bindDataLoginBEan(List<Map<String, dynamic>> result) {
    return LoginBean.fromMap(result[0]);
  }

  String creditBereauStructure = "${TablesColumnFile.trefno} ,"
      "${TablesColumnFile.mrefno} ,"
      "${TablesColumnFile.mlbrcode} ,"
      "${TablesColumnFile.mqueueno} ,"
      "${TablesColumnFile.mprospectdt} ,"
      "${TablesColumnFile.mnametitle} ,"
      "${TablesColumnFile.mprospectname} ,"
      "${TablesColumnFile.mmobno} ,"
      "${TablesColumnFile.mdob} ,"
      "${TablesColumnFile.motpverified} ,"
      "${TablesColumnFile.mcbcheckstatus} ,"
      "${TablesColumnFile.mprospectstatus} ,"
      "${TablesColumnFile.madd1} ,"
      "${TablesColumnFile.madd2} ,"
      "${TablesColumnFile.madd3} ,"
      "${TablesColumnFile.mhomeloc} ,"
      "${TablesColumnFile.mareacd} ,"
      "${TablesColumnFile.mvillage} ,"
      "${TablesColumnFile.mdistcd} ,"
      "${TablesColumnFile.mstatecd} ,"
      "${TablesColumnFile.mcountrycd} ,"
      "${TablesColumnFile.mpincode} ,"
      "${TablesColumnFile.mcountryoforigin} ,"
      "${TablesColumnFile.mnationality} ,"
      "${TablesColumnFile.mpanno} ,"
      "${TablesColumnFile.mpannodesc} ,"
      "${TablesColumnFile.misuploaded} ,"
      "${TablesColumnFile.mspousename} ,"
      "${TablesColumnFile.mspouserelation} ,"
      "${TablesColumnFile.mnomineename} ,"
      "${TablesColumnFile.mnomineerelation} ,"
      "${TablesColumnFile.mcreditenqpurposetype} ,"
      "${TablesColumnFile.mcreditequstage} ,"
      "${TablesColumnFile.mcreditreporttransdatetype} ,"
      "${TablesColumnFile.mcreditreporttransid} ,"
      "${TablesColumnFile.mcreditrequesttype} ,"
      "${TablesColumnFile.mcreateddt} ,"
      "${TablesColumnFile.mcreatedby} ,"
      "${TablesColumnFile.mlastupdatedt} ,"
      "${TablesColumnFile.mlastupdateby} ,"
      "${TablesColumnFile.mgeolocation} ,"
      "${TablesColumnFile.mgeolatd} ,"
      "${TablesColumnFile.mgeologd} ,"
      "${TablesColumnFile.missynctocoresys} ,"
      "${TablesColumnFile.mlastsynsdate} ,"
      "${TablesColumnFile.mstreet} ,"
      "${TablesColumnFile.mhouse} ,"
      "${TablesColumnFile.mcity} ,"
      "${TablesColumnFile.mstate} ,"
      "${TablesColumnFile.mid1} ,"
      "${TablesColumnFile.mid1desc},"
      "${TablesColumnFile.motp} ,"
      "${TablesColumnFile.mroutedto} ";

  Future insertDummyCreditMaster(CreditBereauBean creditBean) async {
    var db = await _getDb();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String agentUserName = prefs.get("${TablesColumnFile.usrCode}");
    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (1, 0, 103, 0, '${DateTime
        .now()}', '', 'USHARANI TRIPATHI', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");
    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (2, 0, 103, 0, '${DateTime
        .now()}', '', 'REENA SINGH', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (3, 0, 103, 0, '${DateTime
        .now()}', '', 'SHOBHA PAVAR', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (4, 0, 103, 0, '${DateTime
        .now()}', '', 'SNEHA GURAV', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (5, 0, 103, 0, '${DateTime
        .now()}', '', 'SAVITA VINOD', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (6, 0, 103, 0, '${DateTime
        .now()}', '', 'SANGEETA BAI', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (7, 0, 103, 0, '${DateTime
        .now()}', '', 'ANITA RATIRAM', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (8, 0, 103, 0, '${DateTime
        .now()}', '', 'PUSHPAVATHY S', 9713047396, '${DateTime
        .now()}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 462039, '', '', '965342865489', '', 0, 'Mohit', '', 'Ashok', 'Brother', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'STREET', 'HOUSE', 'CITY', 'STATE', 'Voter ID', 'XVRPK256', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (9, 0, 103, 0, '${DateTime
        .now()}', '', 'ANITA DEVI', 6203261953, '${DateTime.parse(
        "1991-01-01")}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 824207, '', '', '671327728949', '', 0, 'RAJU KUMAR', '', 'RAJU KUMAR', 'Husband', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'MANJHIYAWAN', 'KARAI GAYA', 'PATNA', 'BIHAR', 'Voter ID', 'RAB4062527', 5453, '');");

    await db.rawQuery("insert into $creditBereauMaster($creditBereauStructure)"
        "  values (10, 0, 103, 0, '${DateTime
        .now()}', '', 'KUMARI NIVA VARMA', 8769387697, '${DateTime.parse(
        "1998-01-01")}', 1, '', 2, '', '', '', '', 0, '', 0, '', '', 483385, '', '', '573529135690', '', 0, 'MOTI VARMA', '', 'MOTI VARMA', 'Husband', 'ACCT-ORIG', 'PRE-DISB', '${DateTime
        .now()}', 'Required', 'JOIN', '${DateTime.now()}', 'FO', '${DateTime
        .now()}' ,'FO', '', '', '', 0, '${DateTime
        .now()}', 'BIHTA', 'BIHTA', 'PATNA', 'BIHAR', 'Voter ID', 'XRK0213296', 5453, '');");

    print("xxxxxxinserted in CBM");
  }

  Future<int> getMaxTrefNo() async {
    print("trying to select last row  ${creditBereauMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${creditBereauMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile
        .trefno})  FROM ${creditBereauMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  CreditBereauBean bindDataCreditBereauBean(List<Map<String, dynamic>> result) {
    return CreditBereauBean.fromMap(result[0]);
  }

  Future<CreditBereauBean> deleteDatabase() async {
    var db = await _getDb();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'delete  *  FROM $creditBereauMaster  ');
    var result = await db.rawQuery('Delete FROM $creditBereauMaster ');
    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauLoanDetailsMaster ");
    result = await db.rawQuery('Delete FROM $creditBereauLoanDetailsMaster');

    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauResultMaster ");
    result = await db.rawQuery('Delete FROM $creditBereauResultMaster');
  }

  Future<CreditBereauBean> deleteSelected(CreditBereauBean cbb) async {
    var db = await _getDb();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Delete FROM $creditBereauMaster where  ${TablesColumnFile
            .trefno} = ${cbb.trefno} AND  ${TablesColumnFile.mrefno} = ${cbb
            .mrefno}');
    ;
    var result = await db.rawQuery(
        'Delete FROM $creditBereauMaster where  ${TablesColumnFile
            .trefno} = ${cbb.trefno} AND  ${TablesColumnFile.mrefno} = ${cbb
            .mrefno}');
  }

  Future deleteCbResultData() async {
    var db = await _getDb();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'delete  *  FROM $creditBereauMaster  ');
    var result = await db.rawQuery('Delete FROM $creditBereauResultMaster ');

    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauResultMaster ");

    result = await db.rawQuery('Delete FROM $creditBereauLoanDetailsMaster');
    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauLoanDetailsMaster ");
  }

  //create LookupMasterTable

  Future _createLoanCycleParameterSecondaryMasterTable(Database db) {
    String query = "CREATE TABLE ${LoanCycleParameterSecondaryMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.mcusttype} INTEGER,"
        "${TablesColumnFile.mgrtype} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mruletype} INTEGER,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.muptoamount} REAL,"
        "${TablesColumnFile.mminamount} REAL,"
        "${TablesColumnFile.mmaxamount} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode},${TablesColumnFile
        .mprdcd},${TablesColumnFile.mloancycle},${TablesColumnFile
        .mcusttype},${TablesColumnFile.mgrtype},${TablesColumnFile
        .meffdate},${TablesColumnFile.mfrequency},${TablesColumnFile
        .mruletype},${TablesColumnFile.msrno}))";

    // "PRIMARY KEY (${TablesColumnFile.mlbrcode},${TablesColumnFile.mprdcd},${TablesColumnFile.mloancycle},${TablesColumnFile.mcusttype},${TablesColumnFile.mgrtype},${TablesColumnFile.meffdate},${TablesColumnFile.mfrequency},${TablesColumnFile.mruletype},${TablesColumnFile.msrno})";
    print("primary of Insert Loan Cycle Parameter Secondary Master table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLoanCycleParameterPrimaryMasterTable(Database db) {
    String query = "CREATE TABLE ${LoanCycleParameterPrimaryMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.mcusttype} INTEGER,"
        "${TablesColumnFile.mgrtype} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.mminamount} REAL,"
        "${TablesColumnFile.mmaxamount} REAL,"
        "${TablesColumnFile.mminperiod} INTEGER,"
        "${TablesColumnFile.mmaxperiod} INTEGER,"
        "${TablesColumnFile.mminnoofgrpmems} INTEGER,"
        "${TablesColumnFile.mmaxnoofgrpmems} INTEGER,"
        "${TablesColumnFile.mgender} TEXT,"
        "${TablesColumnFile.mminage} INTEGER,"
        "${TablesColumnFile.mmaxage} INTEGER,"
        "${TablesColumnFile.mgrpcycyn} INTEGER,"
        "${TablesColumnFile.mlogic} INTEGER,"
        "${TablesColumnFile.mtenor} INTEGER,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mincramount} REAL,"
        "${TablesColumnFile.mnoofinstlclosure} INTEGER,"
        "${TablesColumnFile.mmultiplefactor} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile
        .mprdcd}, ${TablesColumnFile.meffdate}))";
    print("primary of Insert Loan Cycle Parameter Primary Master table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createInterestOffsetMasterTable(Database db) {
    String query = "CREATE TABLE ${InterestOffsetMaster} ("
        "${TablesColumnFile.mlbrcode} TEXT,"
        "${TablesColumnFile.mprdcd} INTEGER,"
        "${TablesColumnFile.mloantype} INTEGER,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.mamount} REAL,"
        "${TablesColumnFile.mintrestrate} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile
        .mprdcd}, ${TablesColumnFile.mloantype}, ${TablesColumnFile
        .mloancycle}, ${TablesColumnFile.meffdate}, ${TablesColumnFile
        .msrno}))";
    print("primary of Insert Slab table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  /*Future _createSystemParameterMasterTable(Database db) {
    String query = "CREATE TABLE ${SystemParameterMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcode} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER PRIMARY KEY,"
        "${TablesColumnFile.name} INTEGER,"
        "${TablesColumnFile.mfield1value} TEXT "
        ");";
    print("primary of Insert Slab table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }*/

  Future _createSystemParameterMasterTable(Database db) {
    String query = "CREATE TABLE ${SystemParameterMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mcode} TEXT,"
        "${TablesColumnFile.mcodedesc} TEXT ,"
        "${TablesColumnFile.mcodevalue} TEXT ,"
        "${TablesColumnFile.mcreateddt} DATETIME ,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mcode}))";
    print("system parameter table--" + query.toString());
    //print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createInterestSlabMasterTable(Database db) {
    String query = "CREATE TABLE ${InterestSlabMaster} ("
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.minteffdt} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.mtoamt} REAL,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mmlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mprdcd}, ${TablesColumnFile
        .mcurcd}, ${TablesColumnFile.minteffdt}, ${TablesColumnFile.msrno}))";
    print("primary of Insert Slab table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLookupMasterTable(Database db) {
    String query = "CREATE TABLE ${LookupMaster} ("
        "${TablesColumnFile.mcode} TEXT,"
        "${TablesColumnFile.mcodetype} INTEGER,"
        "${TablesColumnFile.mcodedesc} TEXT,"
        "${TablesColumnFile.mfield1value} TEXT,"
        "${TablesColumnFile.mcodedatatype} INTEGER,"
        "${TablesColumnFile.mcodedatalen} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mcode}, ${TablesColumnFile
        .mcodetype}))";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  //Create Sub LookupMaster table

  Future _createSubLookupMasterTable(Database db) {
    String query = "CREATE TABLE ${SubLookupMaster} ("
        "${TablesColumnFile.mcode} TEXT,"
        "${TablesColumnFile.mcodetype} INTEGER,"
        "${TablesColumnFile.mcodedesc} TEXT,"
        "${TablesColumnFile.mfield1value} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.mcode}, ${TablesColumnFile
        .mcodetype}))";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future createLoanCycleParameterSecondaryInsert(int lbrCode) async {
    //deletSomeUtil();
    var loanCycleParameterSecondaryServices =
    new LoanCycleParameterSecondaryServices();
    var db = await _getDb();
    List<LoanCycleParameterSecondaryBean> LoanCycleParameterSecondaryList =
    new List<LoanCycleParameterSecondaryBean>();
    await loanCycleParameterSecondaryServices
        .getLoanCycleParameterSecondaryData(lbrCode)
        .then((onValue) {
      print(onValue.length);
      LoanCycleParameterSecondaryList = onValue;
    });
    await AppDatabase.get().deletSomeSyncingActivityFromOmni(
        'Loan_Cycle_Parameter_Secondary_Master');
    for (int i = 0; i < LoanCycleParameterSecondaryList.length; i++) {
      print(LoanCycleParameterSecondaryList.length.toString() +
          " LoanCycleParameterSecondaryMaster");
      String insertQuery =
          "INSERT OR REPLACE INTO ${LoanCycleParameterSecondaryMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mloancycle} ,"
          "${TablesColumnFile.mcusttype} ,"
          "${TablesColumnFile.mgrtype} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.mfrequency} ,"
          "${TablesColumnFile.mruletype} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.muptoamount} ,"
          "${TablesColumnFile.mminamount} ,"
          "${TablesColumnFile.mmaxamount} ,"
          "${TablesColumnFile.mlastsynsdate}  )"
          "VALUES"
          "(${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mlbrcode},"
          "'${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mprdcd.trim()}',"
          "${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mloancycle},"
          "${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mcusttype},"
          "${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mgrtype},"
          "'${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.meffdate}',"
          "'${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mfrequency}',"
          "${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.mruletype},"
          "${LoanCycleParameterSecondaryList[i]
          .loanCycleParameterSecondaryComposite.msrno},"
          "${LoanCycleParameterSecondaryList[i].muptoamount},"
          "${LoanCycleParameterSecondaryList[i].mminamount},"
          "${LoanCycleParameterSecondaryList[i].mmaxamount},"
          "'${LoanCycleParameterSecondaryList[i].mlastsynsdate}');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() +
            " id after insert in ${LoanCycleParameterSecondaryMaster}");
      });
    }
  }

  Future createLoanCycleParameterPrimaryInsert(int lbrCode) async {
    //deletSomeUtil();
    var loanCycleParameterPrimaryServices =
    new LoanCycleParameterPrimaryServices();
    var db = await _getDb();
    List<LoanCycleParameterPrimaryBean> LoanCycleParameterPrimaryList =
    new List<LoanCycleParameterPrimaryBean>();
    await loanCycleParameterPrimaryServices
        .getLoanCycleParameterPrimaryData(lbrCode)
        .then((onValue) {
      print(onValue.length);
      LoanCycleParameterPrimaryList = onValue;
    });
    await AppDatabase.get().deletSomeSyncingActivityFromOmni(
        'Loan_Cycle_Parameter_Primary_Master');
    for (int i = 0; i < LoanCycleParameterPrimaryList.length; i++) {
      print(LoanCycleParameterPrimaryList.length.toString() +
          " LoanCycleParameterPrimaryMaster");
      String insertQuery =
          "INSERT OR REPLACE INTO ${LoanCycleParameterPrimaryMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mloancycle} ,"
          "${TablesColumnFile.mcusttype} ,"
          "${TablesColumnFile.mgrtype} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.mminamount} ,"
          "${TablesColumnFile.mmaxamount} ,"
          "${TablesColumnFile.mminperiod} ,"
          "${TablesColumnFile.mmaxperiod} ,"
          "${TablesColumnFile.mminnoofgrpmems} ,"
          "${TablesColumnFile.mmaxnoofgrpmems} ,"
          "${TablesColumnFile.mgender} ,"
          "${TablesColumnFile.mminage} ,"
          "${TablesColumnFile.mmaxage} ,"
          "${TablesColumnFile.mgrpcycyn} ,"
          "${TablesColumnFile.mlogic} ,"
          "${TablesColumnFile.mtenor} ,"
          "${TablesColumnFile.mfrequency} ,"
          "${TablesColumnFile.mincramount} ,"
          "${TablesColumnFile.mnoofinstlclosure} ,"
          "${TablesColumnFile.mmultiplefactor} ,"
          "${TablesColumnFile.mlastsynsdate}   )"
          "VALUES"
          "(${LoanCycleParameterPrimaryList[i]
          .loanCycleParameterPrimaryComposite.mlbrcode},"
          "'${LoanCycleParameterPrimaryList[i]
          .loanCycleParameterPrimaryComposite.mprdcd}',"
          "${LoanCycleParameterPrimaryList[i].mloancycle},"
          "${LoanCycleParameterPrimaryList[i].mcusttype},"
          "${LoanCycleParameterPrimaryList[i].mgrtype},"
          "'${LoanCycleParameterPrimaryList[i]
          .loanCycleParameterPrimaryComposite.meffdate}',"
          "${LoanCycleParameterPrimaryList[i].mminamount},"
          "${LoanCycleParameterPrimaryList[i].mmaxamount},"
          "${LoanCycleParameterPrimaryList[i].mminperiod},"
          "${LoanCycleParameterPrimaryList[i].mmaxperiod},"
          "${LoanCycleParameterPrimaryList[i].mminnoofgrpmems},"
          "${LoanCycleParameterPrimaryList[i].mmaxnoofgrpmems},"
          "'${LoanCycleParameterPrimaryList[i].mgender}',"
          "${LoanCycleParameterPrimaryList[i].mminage},"
          "${LoanCycleParameterPrimaryList[i].mmaxage},"
          "'${LoanCycleParameterPrimaryList[i].mgrpcycyn}',"
          "${LoanCycleParameterPrimaryList[i].mlogic},"
          "${LoanCycleParameterPrimaryList[i].mtenor},"
          "'${LoanCycleParameterPrimaryList[i].mfrequency}',"
          "${LoanCycleParameterPrimaryList[i].mincramount},"
          "${LoanCycleParameterPrimaryList[i].mnoofinstlclosure},"
          "${LoanCycleParameterPrimaryList[i].mmultiplefactor},"
          "'${LoanCycleParameterPrimaryList[i].mlastsynsdate}');";
      try {
        await db.transaction((Transaction txn) async {
          var id = await txn.rawInsert(insertQuery);
          print(id.toString() +
              " id after insert in ${LoanCycleParameterPrimaryMaster}");
        });
      } catch (_) {
        print("exception here ");
      }
    }
  }

  Future createInterestOffsetInsert() async {
    //deletSomeUtil();
    var interestOffsetServices = new InterestOffsetServices();
    var db = await _getDb();
    List<InterestOffsetBean> InterestOffsetList =
    new List<InterestOffsetBean>();
    await interestOffsetServices.getInterestOffset().then((onValue) {
      print(onValue.length);
      InterestOffsetList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('Interest_Offset_Master');
    for (int i = 0; i < InterestOffsetList.length; i++) {
      print(InterestOffsetList.length.toString() + " InterestOffsetMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${InterestOffsetMaster} "
          "(${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mloantype} ,"
          "${TablesColumnFile.mloancycle} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.mamount} ,"
          "${TablesColumnFile.mintrestrate} ,"
          "${TablesColumnFile.mlastsynsdate}  )"
          "VALUES"
          "('${InterestOffsetList[i].interestOffsetComposite.mprdcd}' ,"
          "${InterestOffsetList[i].interestOffsetComposite.mlbrcode},"
          "${InterestOffsetList[i].interestOffsetComposite.mloantype},"
          "${InterestOffsetList[i].interestOffsetComposite.mloancycle} ,"
          "'${InterestOffsetList[i].interestOffsetComposite.meffdate}',"
          "${InterestOffsetList[i].interestOffsetComposite.msrno},"
          "${InterestOffsetList[i].mmonths},"
          "${InterestOffsetList[i].mamount},"
          "${InterestOffsetList[i].mintrestrate},"
          "'${InterestOffsetList[i].mlastsynsdate}');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${InterestOffsetMaster}");
      });
    }
  }

  /*Future createSystemParameterInsert() async {
    //deletSomeUtil();
    var systemParameterServices = new SystemParameterServices();
    var db = await _getDb();
    List<SystemParameterBean> SystemParameterList = new List<SystemParameterBean>();
    await systemParameterServices.getSystemParameterData().then((onValue) {
      print(onValue.length);
      SystemParameterList = onValue;
    });
    for (int i = 0; i < SystemParameterList.length; i++) {
      print(SystemParameterList.length.toString() + " SystemParameterMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${SystemParameterMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mrefno} ,"
          "${TablesColumnFile.mfield1value} )"

          "VALUES"
          "(${SystemParameterList[i].mlbrcode} ,"
          "${SystemParameterList[i].mcode} ,"
          "${SystemParameterList[i].mrefno} ,"
          "'${SystemParameterList[i].mfield1value} ');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${SystemParameterMaster}");
      });
    }

   await setSystemVariables();

  }*/

  Future createSystemParameterInsert() async {
    //deletSomeUtil();
    var systemParameterServices = new SystemParameterServices();
    var db = await _getDb();
    List<SystemParameterBean> SystemParameterList =
    new List<SystemParameterBean>();
    await systemParameterServices.getSystemParameterData().then((onValue) {
      print(onValue.length);
      SystemParameterList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('SystemParameterMaster');

    for (int i = 0; i < SystemParameterList.length; i++) {
      print(SystemParameterList.length.toString() + " SystemParameterMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${SystemParameterMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mcodedesc} ,"
          "${TablesColumnFile.mcodevalue} ,"
          "${TablesColumnFile.mcreateddt})"
          "VALUES"
          "(${SystemParameterList[i].systemParameterCompositeEntity.mlbrcode} ,"
          "'${SystemParameterList[i].systemParameterCompositeEntity.mcode}' ,"
          "'${SystemParameterList[i].mcodedesc} ',"
          "'${SystemParameterList[i].mcodevalue}',"
          "'${SystemParameterList[i].mcreateddt} ');";
      print(insertQuery);
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${SystemParameterMaster}");
      });
    }
  }

  /*Future<CbResultBean> getSystemVariables(int codeType) async {
    var db = await _getDb();
    var str = "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";


    var result;
    CbResultBean retBean = new CbResultBean();


    print(
        "query is" + "SELECT *  FROM $  where ${str}");

    try {
      result = await db
          .rawQuery('SELECT *  FROM $creditBereauResultMaster where ${str};');

      if (result[0] != null) {
        print(result[0]);
        retBean = bindCreditResultBean(result);
      }
      return retBean;
    } catch (e) {
      print(e);
      return null;
    }
  }*/

  Future<SystemParameterBean> getSystemParameter(String codeType,
      int lbrCode) async {
    var db = await _getDb();
    SystemParameterBean retBean = new SystemParameterBean();
    var result;

    result = await db.rawQuery("select * FROM ${SystemParameterMaster} where ${TablesColumnFile.mcode} = '$codeType'  AND ${TablesColumnFile.mlbrcode} = $lbrCode ;");

    try { print("result here is "+result.toString());
    if (result[0] != null) {

      retBean = SystemParameterBean.fromMap(result[0]);
    }

    return retBean;
    } catch (_) {
      print("not matched");
    }
    return retBean;
  }

  Future createInterestSlabInsert() async {
    //deletSomeUtil();
    var interestSlabServices = new InterestSlabServices();
    var db = await _getDb();
    List<InterestSlabBean> InterestSlabList = new List<InterestSlabBean>();
    await interestSlabServices.getInterestSlab().then((onValue) {
      print(onValue.length);
      InterestSlabList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('Interest_Slab_Master');
    for (int i = 0; i < InterestSlabList.length; i++) {
      print(InterestSlabList.length.toString() + " InsertSlabMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${InterestSlabMaster} "
          "(${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mcurcd} ,"
          "${TablesColumnFile.minteffdt} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mtoamt} ,"
          "${TablesColumnFile.mintrate} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.mmlastsynsdate} )"
          "VALUES"
          "('${InterestSlabList[i].intrestSlabComposite.mprdcd != null
          ? InterestSlabList[i].intrestSlabComposite.mprdcd.trim()
          : ""}' ,"
          "'${InterestSlabList[i].intrestSlabComposite.mcurcd}' ,"
          "'${InterestSlabList[i].intrestSlabComposite.minteffdt}' ,"
          "${InterestSlabList[i].intrestSlabComposite.msrno} ,"
          "${InterestSlabList[i].mtoamt},"
          "${InterestSlabList[i].mintrate},"
          "${InterestSlabList[i].mmonths},"
          "'${InterestSlabList[i].mmlastsynsdate}');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${InterestSlabMaster}");
      });
    }
  }

  Future createLookupInsert() async {
    //deletSomeUtil();
    var lookupDataServices = new LookupDataServices();
    var db = await _getDb();
    List<LookupMasterBean> lookupMasterList = new List<LookupMasterBean>();
    await AppDatabase.get().deletSomeSyncingActivityFromOmni('Lookup');
    await lookupDataServices.getLookupData().then((onValue) {
      print(onValue.length);
      lookupMasterList = onValue;
    });

    for (int i = 0; i < lookupMasterList.length; i++) {
      print(lookupMasterList.length.toString() + " lookupMaster");
      print(lookupMasterList[i].mcodedesc.toString() + " mcodedesc");
      print(lookupMasterList[i].lookUpComposite.mcode.toString() + " mcode");
      print(lookupMasterList[i].lookUpComposite.mcodetype.toString() +
          " mcodetype");
      String insertQuery = "INSERT OR REPLACE INTO ${LookupMaster} "
          "(${TablesColumnFile.mcodedesc} ,"
          "${TablesColumnFile.mfield1value} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mcodetype} )"
          "VALUES"
          "('${lookupMasterList[i].mcodedesc != null &&
          lookupMasterList[i].mcodedesc != 'null' ? lookupMasterList[i]
          .mcodedesc.trim()
          .replaceAll('\'', "") : ""}' ,"
          "'${lookupMasterList[i].mfield1value != null &&
          lookupMasterList[i].mfield1value != 'null' ? lookupMasterList[i]
          .mfield1value.trim() : ""}' ,"
          "'${lookupMasterList[i].lookUpComposite != null &&
          lookupMasterList[i].lookUpComposite.mcode != null &&
          lookupMasterList[i].lookUpComposite.mcode != 'null'
          ? lookupMasterList[i].lookUpComposite.mcode.trim()
          : ""}' ,"
          "${lookupMasterList[i].lookUpComposite.mcodetype});";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${LookupMaster}");
      });
    }
  }

  Future createSubLookupInsert() async {
    var syncingSubLookupDataServices = new SyncingSubLookupDataServices();
    var db = await _getDb();
    List<LookupMasterBean> lookupMasterList = new List<LookupMasterBean>();
    await AppDatabase.get().deletSomeSyncingActivityFromOmni('SubLookup');
    await syncingSubLookupDataServices.getSubLookupData().then((onValue) {
      print(onValue.length);
      lookupMasterList = onValue;
    });

    for (int i = 0; i < lookupMasterList.length; i++) {
      print(lookupMasterList.length.toString() + " SublookupMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${SubLookupMaster} "
          "(${TablesColumnFile.mcodedesc} ,"
          "${TablesColumnFile.mfield1value} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mcodetype} )"
          "VALUES"
          "('${lookupMasterList[i].mcodedesc != null &&
          lookupMasterList[i].mcodedesc != 'null' ? lookupMasterList[i]
          .mcodedesc.trim()
          .replaceAll('\'', "") : ""}' ,"
          "'${lookupMasterList[i].mfield1value != null &&
          lookupMasterList[i].mfield1value != null &&
          lookupMasterList[i].mfield1value != 'null' ? lookupMasterList[i]
          .mfield1value : "0"}' ,"
          "'${lookupMasterList[i].lookUpComposite != null &&
          lookupMasterList[i].lookUpComposite.mcode != null &&
          lookupMasterList[i].lookUpComposite.mcode != 'null'
          ? lookupMasterList[i].lookUpComposite.mcode.trim()
          : ""}' ,"
          "${lookupMasterList[i].lookUpComposite.mcodetype});";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${SubLookupMaster}");
      });
    }
  }

  Future createTDRoiInsert(int branch) async {

    var syncingTDRoiDataServices = new SyncingTDRoiDataServices();
    var syncingTDOffsetInterestMasterServices =
    new SyncingTDOffsetInterestMasterServices();
    var db = await _getDb();
    // List<LookupMasterBean> lookupMasterList = new List<LookupMasterBean>();
    List<TDOffsetInterestMasterBean> TDOffsetInterestMasterList =
    new List<TDOffsetInterestMasterBean>();
    List<ProductwiseInterestTableBean> ProductwiseInterestTableList =
    new List<ProductwiseInterestTableBean>();

    try {
      await syncingTDOffsetInterestMasterServices
          .getTDOffsetInterestMasterData(branch)
          .then((onValue) async{
        //TODO for TD specific LBRCode
        print(onValue.length);
        if(onValue!=null){
          await AppDatabase.get()
              .deletSomeSyncingActivityFromOmni('TD_Offset_Interest_Master');
        }
        TDOffsetInterestMasterList = onValue;
      });
    } catch (_) {}


    try {
      await syncingTDRoiDataServices
          .getProductwiseInterestTablePrimaryData(branch)
          .then((onValue) async{
        //TODO for TD Speicific  LBRCode
        print(onValue.length);
        if(onValue!=null){
          await AppDatabase.get()
              .deletSomeSyncingActivityFromOmni('TD_Productwise_interest_table');
        }
        ProductwiseInterestTableList = onValue;
      });
    } catch (_) {}



    // Inserting datea in TDProductwiseInterestTable

    for (int i = 0; i < ProductwiseInterestTableList.length; i++) {
      print(ProductwiseInterestTableList.length.toString() +
          " TDProductwiseInterestTable");
      String insertQuery =
          "INSERT OR REPLACE INTO ${TDProductwiseInterestTable} "
          "(${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mcurcd} ,"
          "${TablesColumnFile.minteffdt} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mdays} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.mintrate} ,"
          "${TablesColumnFile.mpenalintrate} ,"
          "${TablesColumnFile.mlowertollimit} ,"
          "${TablesColumnFile.muppertollimit} ,"
          "${TablesColumnFile.mminrate} ,"
          "${TablesColumnFile.mmaxrate} ,"
          "${TablesColumnFile.mfrommonths} ,"
          "${TablesColumnFile.mtomonths} ,"
          "${TablesColumnFile.mmlastsynsdate} )"
          "VALUES"
          "("
          "${ProductwiseInterestTableList[i].tdIntrestSlabComposite.mprdcd},"
          "'${ProductwiseInterestTableList[i].tdIntrestSlabComposite.mcurcd}',"
          "'${ProductwiseInterestTableList[i].tdIntrestSlabComposite.minteffdt}',"
          "${ProductwiseInterestTableList[i].tdIntrestSlabComposite.msrno},"
          "${ProductwiseInterestTableList[i].mdays},"
          "${ProductwiseInterestTableList[i].mmonths},"
          "${ProductwiseInterestTableList[i].mintrate},"
          "${ProductwiseInterestTableList[i].mpenalintrate},"
          "${ProductwiseInterestTableList[i].mlowertollimit},"
          "${ProductwiseInterestTableList[i].muppertollimit},"
          "${ProductwiseInterestTableList[i].mminrate},"
          "${ProductwiseInterestTableList[i].mmaxrate},"
          "${ProductwiseInterestTableList[i].mfrommonths},"
          "${ProductwiseInterestTableList[i].mtomonths},"
          "'${ProductwiseInterestTableList[i].mmlastsynsdate}'"
          "); ";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() +
            " id after insert in ${TDProductwiseInterestTable}");
      });
    }


    // Inserting datea in Offset Interest Master - for TD
    for (int i = 0; i < TDOffsetInterestMasterList.length; i++) {
      print(TDOffsetInterestMasterList.length.toString() +
          " TDOffsetInterestMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${TDOffsetInterestMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mcurCd} ,"
          "${TablesColumnFile.maccttype} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mdays} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.minvamtfrm} ,"
          "${TablesColumnFile.muptoamt} ,"
          "${TablesColumnFile.moffsetintrate} ,"
          "${TablesColumnFile.mlowertollimit} ,"
          "${TablesColumnFile.muppertollimit} ,"
          "${TablesColumnFile.mmlastsynsdate} )"
          "VALUES"
          "("
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.lBrCode},"
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.prdCd},"
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.CurCd},"
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.acctType},"
          "'${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.effDate}' ,"
          "'${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.srNo}' ,"
          "'${TDOffsetInterestMasterList[i].days}' ,"
          "'${TDOffsetInterestMasterList[i].months}' ,"
          "'${TDOffsetInterestMasterList[i].InvAmtFrm}' ,"
          "'${TDOffsetInterestMasterList[i].UptoAmt}' ,"
          "'${TDOffsetInterestMasterList[i].offSetIntRate}' ,"
          "'${TDOffsetInterestMasterList[i].LowerTolLimit}' ,"
          "'${TDOffsetInterestMasterList[i].UpperTolLimit}' ,"
          "${TDOffsetInterestMasterList[i].mmlastsynsdate} "
          "); ";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${TDOffsetInterestMaster}");
      });
    }
  }

//Customer Formation code start here

  //Create Table LastStyncedDateTime

  Future _createLastSyncedDateTimeMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${lastSyncedDateTimeMaster} ("
        "${TablesColumnFile.id} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.tTabelDesc} TEXT,"
        "${TablesColumnFile.tlastSyncedFromTab} DATETIME,"
        "${TablesColumnFile.tlastSyncedToTab} DATETIME);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table CustomerMasterBasicsDetails
  Future _createCustomerFoundationMasterDetailsTable(Database db) {
    String tableCreationQuery =
        "CREATE TABLE ${customerFoundationMasterDetails} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mfathertitle} TEXT,"
        "${TablesColumnFile.mfatherfname} TEXT,"
        "${TablesColumnFile.mfathermname} TEXT,"
        "${TablesColumnFile.mfatherlname} TEXT,"
        "${TablesColumnFile.mspousetitle} TEXT,"
        "${TablesColumnFile.mhusbandname} TEXT,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.mage} INTEGER,"
        "${TablesColumnFile.mbankacno} TEXT,"
        "${TablesColumnFile.mbankacyn} TEXT,"
        "${TablesColumnFile.mbankifsc} TEXT,"
        "${TablesColumnFile.mbanknamelk} TEXT,"
        "${TablesColumnFile.mbankbranch} TEXT,"
        "${TablesColumnFile.mcuststatus} INTEGER,"
        "${TablesColumnFile.mdropoutdate} DATETIME,"
        "${TablesColumnFile.mmobno} TEXT,"
        "${TablesColumnFile.mpanno} INTEGER,"
        "${TablesColumnFile.mpannodesc} TEXT,"
        "${TablesColumnFile.mtdsyn} TEXT,"
        "${TablesColumnFile.mtdsreasoncd} INTEGER,"
        "${TablesColumnFile.mtdsfrm15subdt} DATETIME,"
        "${TablesColumnFile.memailId} TEXT,"
        "${TablesColumnFile.mcustcategory} TEXT,"
        "${TablesColumnFile.mtier} INTEGER,"
        "${TablesColumnFile.mAdd1} TEXT,"
        "${TablesColumnFile.mAdd2} TEXT,"
        "${TablesColumnFile.mAdd3} TEXT,"
        "${TablesColumnFile.marea} INTEGER,"
        "${TablesColumnFile.mPinCode} TEXT,"
        "${TablesColumnFile.mCounCd} TEXT,"
        "${TablesColumnFile.mCityCd} TEXT, "
        "${TablesColumnFile.mfname} TEXT, "
        "${TablesColumnFile.mmname} TEXT, "
        "${TablesColumnFile.mlname} TEXT, "
        "${TablesColumnFile.mgender} TEXT, "
        "${TablesColumnFile.mrelegion} TEXT, "
        "${TablesColumnFile.mRuralUrban} TEXT, "
        "${TablesColumnFile.mcaste} TEXT, "
        "${TablesColumnFile.mqualification} TEXT, "
        "${TablesColumnFile.moccupation} INTEGER, "
        "${TablesColumnFile.mLandType} TEXT, "
        "${TablesColumnFile.mmaritialStatus} INTEGER, "
        "${TablesColumnFile.mTypeOfId} INTEGER, "
        "${TablesColumnFile.mIdDesc} TEXT, "
        "${TablesColumnFile.mInsuranceCovYN} TEXT, "
        "${TablesColumnFile.mTypeofCoverage} INTEGER, "
        "${TablesColumnFile.mcreateddt} DATETIME, "
        "${TablesColumnFile.mcreatedby} TEXT, "
        "${TablesColumnFile.mlastupdatedt} DATETIME, "
        "${TablesColumnFile.mlastupdateby} TEXT, "
        "${TablesColumnFile.mgeolocation} TEXT, "
        "${TablesColumnFile.mgeolatd} TEXT, "
        "${TablesColumnFile.mgeologd} TEXT, "
        "${TablesColumnFile.missynctocoresys} INTEGER, "
        "${TablesColumnFile.mlastsynsdate} DATETIME, "
        "${TablesColumnFile.ifYesThen} TEXT,"
        "${TablesColumnFile.mOccBuisness} TEXT,"
        "${TablesColumnFile.mShopName} TEXT,"
        "${TablesColumnFile.mShpAdd} TEXT,"
        "${TablesColumnFile.mYrsInBz} INTEGER,"
        "${TablesColumnFile.mregNum} TEXT,"
    /* "${TablesColumnFile.mid1} TEXT,"
        "${TablesColumnFile.mid2} TEXT,"*/
        "${TablesColumnFile.mhouse} TEXT,"
        "${TablesColumnFile.mAgricultureType} TEXT,"
        "${TablesColumnFile.mIsMbrGrp} INTEGER,"
        "${TablesColumnFile.mLoanAgreed} INTEGER,"
        "${TablesColumnFile.mGend} INTEGER,"
        "${TablesColumnFile.mInsurance} INTEGER,"
    //"${TablesColumnFile.mRegion} INTEGER,"
        "${TablesColumnFile.mConstruct} INTEGER,"
        "${TablesColumnFile.mToilet} INTEGER,"
    /*"${TablesColumnFile.mBankAccYN} INTEGER,"*/
        "${TablesColumnFile.mhousBizSp} INTEGER,"
        "${TablesColumnFile.mBzRegs} INTEGER,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.misCbCheckDone} INTEGER,"
        "${TablesColumnFile.mBzTrnd} INTEGER,"
        "${TablesColumnFile.mcentername} TEXT,"
        "${TablesColumnFile.mgroupname} TEXT,"
        "${TablesColumnFile.mexpsramt} REAL,"
        "${TablesColumnFile.mcbcheckrprtdt} DATETIME,"
        "${TablesColumnFile.motpvrfdno} TEXT,"
        "${TablesColumnFile.mprofileind} TEXT,"
        "${TablesColumnFile.mhusdob} DATETIME, "
        "${TablesColumnFile.mid1issuedate} DATETIME, "
        "${TablesColumnFile.mid2issuedate} DATETIME, "
        "${TablesColumnFile.mid1expdate} DATETIME, "
        "${TablesColumnFile.mid2expdate} DATETIME, "
        "${TablesColumnFile.mlangofcust} TEXT,"
        "${TablesColumnFile.mmainoccupn} TEXT,"
        "${TablesColumnFile.msuboccupn} TEXT,"
        "${TablesColumnFile.msecoccupatn} INTEGER,"
        "${TablesColumnFile.mmainoccupndesc} TEXT,"
        "${TablesColumnFile.msuboccupndesc} TEXT,"
        "${TablesColumnFile.misselfemp} TEXT,"
        "${TablesColumnFile.mnametitle2} TEXT,"
        "${TablesColumnFile.mlongname2} TEXT,"
        "${TablesColumnFile.mfname2} TEXT, "
        "${TablesColumnFile.mmname2} TEXT, "
        "${TablesColumnFile.mlname2} TEXT, "
        "${TablesColumnFile.mnationality} TEXT,"
        "${TablesColumnFile.mid3issuedate} DATETIME,"
        "${TablesColumnFile.mid3expdate} DATETIME, "
        "${TablesColumnFile.missngautryt1} TEXT, "
        "${TablesColumnFile.missngautryt2} TEXT, "
        "${TablesColumnFile.missngautryt3} TEXT,"
        "${TablesColumnFile.mtypeofid3} INTEGER,"
        "${TablesColumnFile.middesc3} TEXT,"
        "${TablesColumnFile.macctbal} REAL,"
        "${TablesColumnFile.misearngmembr} TEXT ,"
        "${TablesColumnFile.misstudyingmembr} TEXT,"
        "${TablesColumnFile.mmemberno} TEXT,"
        "${TablesColumnFile.mischldrn} TEXT,"
        "${TablesColumnFile.mbusinessname} TEXT,"
        "${TablesColumnFile.mtarget} TEXT,"
        "${TablesColumnFile.mownership} TEXT,"
        "${TablesColumnFile.mresstatus} TEXT,"
        "${TablesColumnFile.miscpemp} TEXT,"
        "${TablesColumnFile.mrankofemp} TEXT,"
        "${TablesColumnFile.mempid} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
        ");";
    return db.transaction((Transaction txn) async {
      txn.execute(tableCreationQuery);
    });
  }


  //Create Table Address Details

  Future _createCustomerFoundationAddressDetailsBeanTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${customerFoundationAddressMasterDetails} ("
        "${TablesColumnFile.taddrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.maddressrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.maddrType} INTEGER,"
        "${TablesColumnFile.maddr1} TEXT,"
        "${TablesColumnFile.maddr2} TEXT,"
        "${TablesColumnFile.maddr3} TEXT,"
        "${TablesColumnFile.mpinCd} INTEGER,"
        "${TablesColumnFile.mtel1} TEXT,"
        "${TablesColumnFile.mtel2} TEXT,"
        "${TablesColumnFile.mcityCd} TEXT,"
        "${TablesColumnFile.mfax1} TEXT,"
        "${TablesColumnFile.mfax2} TEXT,"
        "${TablesColumnFile.mcountryCd} TEXT,"
        "${TablesColumnFile.marea} INTEGER,"
        "${TablesColumnFile.mHouseType} INTEGER,"
        "${TablesColumnFile.mRntLeasAmt} REAL,"
        "${TablesColumnFile.mRntLeasDep} REAL,"
        "${TablesColumnFile.mContLeasExp} DATETIME,"
        "${TablesColumnFile.mRoofCond} INTEGER,"
        "${TablesColumnFile.mUtils} INTEGER,"
        "${TablesColumnFile.mAreaType} INTEGER,"
        "${TablesColumnFile.mLandmark} TEXT,"
        "${TablesColumnFile.mstate} TEXT,"
        "${TablesColumnFile.mYearStay} INTEGER,"
        "${TablesColumnFile.mWardNo} TEXT,"
        "${TablesColumnFile.mMobile} TEXT,"
        "${TablesColumnFile.mEmail} TEXT,"
        "${TablesColumnFile.mPattaName} TEXT,"
        "${TablesColumnFile.mRelationship} TEXT,"
        "${TablesColumnFile.mSourceOfDep} INTEGER,"
        "${TablesColumnFile.mInstAmount} REAL,"
        "${TablesColumnFile.mToietYN} TEXT,"
        "${TablesColumnFile.mNoOfRooms} INTEGER,"
        "${TablesColumnFile.mSpouseYearsStay} INTEGER,"
        "${TablesColumnFile.mDistCd} INTEGER,"
        "${TablesColumnFile.mvillage} INTEGER,"
        "${TablesColumnFile.mCookFuel} INTEGER,"
        "${TablesColumnFile.mSecMobile} TEXT,"
        "${TablesColumnFile.mThana} TEXT,"
        "${TablesColumnFile.mPost} TEXT,"
        "${TablesColumnFile.mplacecd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mownership} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.taddrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table FamilyDetails
  Future _createCustomerFoundationFamilyDetailsTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${customerFoundationFamilyMasterDetails} ("
        "${TablesColumnFile.tfamilyrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mfamilyrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mname} TEXT,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mfname} TEXT,"
        "${TablesColumnFile.mmname} TEXT,"
        "${TablesColumnFile.mlname} TEXT,"
        "${TablesColumnFile.mnicno} TEXT,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.mage} INTEGER,"
        "${TablesColumnFile.meducation} TEXT,"
        "${TablesColumnFile.mmemberno} TEXT,"
        "${TablesColumnFile.moccuptype} INTEGER,"
        "${TablesColumnFile.mincome} REAL,"
        "${TablesColumnFile.mhealthstatus} INTEGER,"
        "${TablesColumnFile.mrelationwithcust} TEXT,"
        "${TablesColumnFile.mreverseRelationship} TEXT,"
        "${TablesColumnFile.maritalstatus} TEXT,"
        "${TablesColumnFile.mcontrforhouseexp} REAL,"
        "${TablesColumnFile.macidntlinsurance} TEXT,"
        "${TablesColumnFile.mnomineeyn} TEXT,"
        "${TablesColumnFile.misearngmembr} INTEGER,"
        "${TablesColumnFile.misleavingwithappcnt} INTEGER,"
        "${TablesColumnFile.misstudyingmembr} INTEGER,"
        "${TablesColumnFile.mdesignation} TEXT,"
        "${TablesColumnFile.mprofession} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tfamilyrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }



  //Create Table BankDetails
  Future _createCustomerFoundationBankDetailsTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${bankDetailsMaster} ("
        "${TablesColumnFile.tbanktrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mbanktrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.maccno} TEXT,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.maccstatus} TEXT,"
        "${TablesColumnFile.migyn} TEXT,"
        "${TablesColumnFile.mcurcode} TEXT,"
        "${TablesColumnFile.mbankname} TEXT,"
        "${TablesColumnFile.mbranch} TEXT,"
        "${TablesColumnFile.maccbal} REAL,"
        "${TablesColumnFile.misusefordis} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tbanktrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }


  //Create Table Borrowing Detials

  Future _createCustomerFoundationBorrowingDetailsTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${customerFoundationBorrowingMasterDetails} ("
        "${TablesColumnFile.tborrowingrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mborrowingrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mnameofborrower} TEXT,"
        "${TablesColumnFile.msource} TEXT,"
        "${TablesColumnFile.mpurpose} TEXT,"
        "${TablesColumnFile.mamount} REAL,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.memiamt} REAL,"
        "${TablesColumnFile.moutstandingamt} REAL,"
        "${TablesColumnFile.mmemberno} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.mloanDate} DATETIME,"
        "${TablesColumnFile.mrepaymentDate} DATETIME,"
        "${TablesColumnFile.mloanwthUs} TEXT,"
        "${TablesColumnFile.macctno} TEXT,"
        "${TablesColumnFile.mperiod} INTEGER,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.mrestructrdloan} TEXT,"
        "${TablesColumnFile.msvngamount} REAL,"
        "${TablesColumnFile.mremark} TEXT,"
        "${TablesColumnFile.mmodeofdisb} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tborrowingrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  // Create Table TERM DEPOSIT MASTER
  Future _createTermDepositMasterTable(Database db) {
    print("ujk's  table >>>>>>>>>");
    String query = "CREATE TABLE ${TermDepositMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.mcertdate} DATETIME,"
        "${TablesColumnFile.mnoinst} INTEGER,"
        "${TablesColumnFile.mnoofmonths} INTEGER,"
        "${TablesColumnFile.mnoofdays} INTEGER,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mmatval} REAL,"
        "${TablesColumnFile.mmatdate} DATETIME,"
        "${TablesColumnFile.mreceiptstatus} INTEGER,"
        "${TablesColumnFile.mlastrepaydate} DATETIME,"
        "${TablesColumnFile.mmainbalfcy} REAL,"
        "${TablesColumnFile.mintPrvdamtfcy} REAL,"
        "${TablesColumnFile.mintPaidamtfcy} REAL,"
        "${TablesColumnFile.mtdsamtfcy} REAL,"
        "${TablesColumnFile.mtdsyn} TEXT,"
        "${TablesColumnFile.mmodeofdeposit} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcrs} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno}))";
    print("primary of term deposit table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  // Create Table TD PRODUCTWISE INTEREST TABLE
  Future _createTDProductwiseInterestTable(Database db) {
    print("TDProductwiseInterestTable   >>>>>>>>>");
    String query = "CREATE TABLE ${TDProductwiseInterestTable} ("
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.minteffdt} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mdays} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mpenalintrate} REAL,"
        "${TablesColumnFile.mlowertollimit} REAL,"
        "${TablesColumnFile.muppertollimit} REAL,"
        "${TablesColumnFile.mminrate} REAL,"
        "${TablesColumnFile.mmaxrate} REAL,"
        "${TablesColumnFile.mfrommonths} INTEGER,"
        "${TablesColumnFile.mtomonths} INTEGER,"
        "${TablesColumnFile.mmlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mprdcd}, ${TablesColumnFile.mcurcd}, ${TablesColumnFile.minteffdt}))";
    print("primary of TDProductwiseInterestTable");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  // Create Table TD OFFSET INTERES TMASTER

  Future _createTDOffsetInterestMaster(Database db) {
    print("_createTDOffsetInterestMaster   >>>>>>>>>");
    String query = "CREATE TABLE ${TDOffsetInterestMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mprdcd} TEXT ,"
        "${TablesColumnFile.mcurCd} TEXT,"
        "${TablesColumnFile.maccttype} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mdays} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.minvamtfrm} REAL,"
        "${TablesColumnFile.muptoamt} REAL,"
        "${TablesColumnFile.moffsetintrate} REAL,"
        "${TablesColumnFile.mlowertollimit} REAL,"
        "${TablesColumnFile.muppertollimit} REAL,"
        "${TablesColumnFile.mmlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mprdcd}, ${TablesColumnFile.maccttype}, ${TablesColumnFile.meffdate}))";
    print("primary of TDOffsetInterestMaster");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createCustomerBusinessDetailMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${customerBusinessDetailMaster} ("
        "${TablesColumnFile.tbussdetailsrefno} INTEGER ,"
        "${TablesColumnFile.mbussdetailsrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcusactivitytype} TEXT,"
        "${TablesColumnFile.mbusinessname} TEXT,"
        "${TablesColumnFile.mbusaddress1} TEXT,"
        "${TablesColumnFile.mbusaddress2} TEXT,"
        "${TablesColumnFile.mbusaddress3} TEXT,"
        "${TablesColumnFile.mbusaddress4} TEXT,"
        "${TablesColumnFile.mbuscity} TEXT,"
        "${TablesColumnFile.mdistcd} INTEGER,"
        "${TablesColumnFile.mbusstate} TEXT,"
        "${TablesColumnFile.mbuscountry} TEXT,"
        "${TablesColumnFile.mbusarea} INTEGER,"
        "${TablesColumnFile.mbusvillage} INTEGER,"
        "${TablesColumnFile.mbuslandmark} TEXT,"
        "${TablesColumnFile.mbuspin} INTEGER,"
        "${TablesColumnFile.mbusyrsmnths} INTEGER,"
        "${TablesColumnFile.mregisteredyn} TEXT,"
        "${TablesColumnFile.mregistrationno} TEXT,"
        "${TablesColumnFile.mbusothtomanageabsyn} TEXT,"
        "${TablesColumnFile.mbusothmanagername} TEXT,"
        "${TablesColumnFile.mbusothmanagerrel} INTEGER,"
        "${TablesColumnFile.mbusmonthlyincome} REAL,"
        "${TablesColumnFile.mbusseasonalityjan} TEXT,"
        "${TablesColumnFile.mbusseasonalityfeb} TEXT,"
        "${TablesColumnFile.mbusseasonalitymar} TEXT,"
        "${TablesColumnFile.mbusseasonalityapr} TEXT,"
        "${TablesColumnFile.mbusseasonalitymay} TEXT,"
        "${TablesColumnFile.mbusseasonalityjun} TEXT,"
        "${TablesColumnFile.mbusseasonalityjul} TEXT,"
        "${TablesColumnFile.mbusseasonalityaug} TEXT,"
        "${TablesColumnFile.mbusseasonalitysep} TEXT,"
        "${TablesColumnFile.mbusseasonalityoct} TEXT,"
        "${TablesColumnFile.mbusseasonalitynov} TEXT,"
        "${TablesColumnFile.mbusseasonalitydec} TEXT,"
        "${TablesColumnFile.mbushighsales} REAL,"
        "${TablesColumnFile.mbusmediumsales} REAL,"
        "${TablesColumnFile.mbuslowsales} REAL,"
        "${TablesColumnFile.mbushighincome} REAL,"
        "${TablesColumnFile.mbusmediumincom} REAL,"
        "${TablesColumnFile.mbuslowincome} REAL,"
        "${TablesColumnFile.mbusmonthlytotaleval} REAL,"
        "${TablesColumnFile.mbusmonthlytotalverif} REAL,"
        "${TablesColumnFile.mbusincludesurcalcyn} TEXT,"
        "${TablesColumnFile.mbusnhousesameplaceyn} TEXT,"
        "${TablesColumnFile.mbusinesstrend} TEXT,"
        "${TablesColumnFile.mmonthlyincome} REAL,"
        "${TablesColumnFile.mtotalmonthlyincome} REAL,"
        "${TablesColumnFile.mbusinessexpense} REAL,"
        "${TablesColumnFile.mhousehldexpense} REAL,"
        "${TablesColumnFile.mmonthlyemi} REAL,"
        "${TablesColumnFile.mincomeemiratio} REAL,"
        "${TablesColumnFile.mnetamount} REAL,"
        "${TablesColumnFile.mpercentage} REAL,"
        "${TablesColumnFile.mposition} TEXT,"
        "${TablesColumnFile.mdepartment} TEXT,"
        "${TablesColumnFile.mempfrom} DATETIME,"
        "${TablesColumnFile.mempto} DATETIME,"
        "${TablesColumnFile.mincomefromothrsrc} REAL,"
        "${TablesColumnFile.mdateofincorporation} DATETIME ,"
        "${TablesColumnFile.mbusinessownerandshareholdingpercentage} REAL,"
        "${TablesColumnFile.mtotalmanpower} INTEGER,"
        "${TablesColumnFile.mtotalman} INTEGER,"
        "${TablesColumnFile.mtotalwomen} INTEGER,"
        "${TablesColumnFile.mcompanycategory} TEXT,"
        "${TablesColumnFile.mbusstype} TEXT,"
        "${TablesColumnFile.mmanagerdetails} TEXT,"
        "${TablesColumnFile.mcapital} REAL,"
        "${TablesColumnFile.mcostofgoodssold} REAL,"
        "${TablesColumnFile.moperationexpenditure} REAL,"
        "${TablesColumnFile.mnetprofit} REAL,"
        "${TablesColumnFile.misselfemp} TEXT,"
        "${TablesColumnFile.mbuslocownership} INTEGER,"
        "${TablesColumnFile.mprofession} TEXT,"
        "${TablesColumnFile.msrcname} TEXT,"
        "${TablesColumnFile.mnoofempincmpny} INTEGER,"
        "${TablesColumnFile.myrsofexpinyrs} INTEGER,"
        "${TablesColumnFile.myrsofexpinmnths} INTEGER,"
        "${TablesColumnFile.mmobile} TEXT,"
        "${TablesColumnFile.mstatusofemp} TEXT,"
        "${TablesColumnFile.mtagtmrkt} TEXT,"
        "${TablesColumnFile.mstrtgy} TEXT,"
        "${TablesColumnFile.mbussprocss} TEXT,"
        "${TablesColumnFile.mcomptrmekt} TEXT,"
        "${TablesColumnFile.misprimarysrcincome} TEXT,"
        "${TablesColumnFile.miscpemp} TEXT,"
        "${TablesColumnFile.mrankofemp} TEXT,"
        "${TablesColumnFile.mcompanyname} TEXT,"
        "${TablesColumnFile.mbussstatus} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tbussdetailsrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table ImagesMaster
  Future _createImageMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${imageMaster} ("
          "${TablesColumnFile.tImgrefno} INTEGER ,"
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mImgrefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.imageType} TEXT,"
          "${TablesColumnFile.imageSubType} TEXT,"
          "${TablesColumnFile.desc} TEXT,"
          "${TablesColumnFile.imageString} TEXT,"
          "${TablesColumnFile.customerNumber} INTEGER,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
          .mrefno},${TablesColumnFile.tImgrefno})"
          "FOREIGN KEY(${TablesColumnFile
          .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
          .mrefno}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TablesColumnFile
          .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
          .trefno}) ON DELETE CASCADE);");
    });
  }

  Future _createBusinessExpenseMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${businessExpenseMaster} ("
        "${TablesColumnFile.tbusinexpendrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mbusinexpenrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mbusinexpntype} TEXT,"
        "${TablesColumnFile.mbusinevaluationamt} REAL,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tbusinexpendrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createHouseExpenseMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${houseExpenseMaster} ("
        "${TablesColumnFile.thoushldexpendrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mhoushldexpenrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mhoushldexpntype} TEXT,"
        "${TablesColumnFile.mhoushldevaluationamt} REAL,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.thoushldexpendrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createAssetDetailMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${assetDetailMaster} ("
        "${TablesColumnFile.tassetdetrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.massetdetrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mitem} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tassetdetrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createFixedAssetMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${fixedAssetMaster} ("
        "${TablesColumnFile.tfixedassetrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mfixedassetrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mland} INTEGER,"
        "${TablesColumnFile.mlandpresentamt} REAL,"
        "${TablesColumnFile.mlandnextmonthamount} REAL,"
        "${TablesColumnFile.mbuildng} INTEGER,"
        "${TablesColumnFile.mbuildngpresentamt} REAL,"
        "${TablesColumnFile.mbuildngnextmonthamount} REAL,"
        "${TablesColumnFile.mmachnryorequp} INTEGER,"
        "${TablesColumnFile.mmachnryorequppresentamt} REAL,"
        "${TablesColumnFile.mmachnryorequpnextmonthamount} REAL,"
        "${TablesColumnFile.mmeansandtransprt} INTEGER,"
        "${TablesColumnFile.mmeansandtransprtpresentamt} REAL,"
        "${TablesColumnFile.mmeansandtransprtnextmonthamount} REAL,"
        "${TablesColumnFile.mothrs} INTEGER,"
        "${TablesColumnFile.mothrspresentamt} REAL,"
        "${TablesColumnFile.mothrsnextmonthamount} REAL,"
        "${TablesColumnFile.msumpresentamt} REAL,"
        "${TablesColumnFile.msumnextmonthamount} REAL,"
        "${TablesColumnFile.mfromdate} DATETIME,"
        "${TablesColumnFile.mtodate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tfixedassetrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createCurrentAssetMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${currentAssetMaster} ("
        "${TablesColumnFile.tcurrentassetrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mcurrentassetrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcash} INTEGER,"
        "${TablesColumnFile.mcashpresentamt} REAL,"
        "${TablesColumnFile.mcashnextmonthamount} REAL,"
        "${TablesColumnFile.maccntrecvbl} INTEGER,"
        "${TablesColumnFile.maccntrecvblpresentamt} REAL,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} REAL,"
        "${TablesColumnFile.minventry} INTEGER,"
        "${TablesColumnFile.minventrypresentamt} REAL,"
        "${TablesColumnFile.minventrynextmonthamount} REAL,"
        "${TablesColumnFile.mprepaid} INTEGER,"
        "${TablesColumnFile.mprepaidpresentamt} REAL,"
        "${TablesColumnFile.mprepaidnextmonthamount} REAL,"
        "${TablesColumnFile.mothrs} INTEGER,"
        "${TablesColumnFile.mothrspresentamt} REAL,"
        "${TablesColumnFile.mothrsnextmonthamount} REAL,"
        "${TablesColumnFile.msumpresentamt} REAL,"
        "${TablesColumnFile.msumnextmonthamount} REAL,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tcurrentassetrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createLongTermLiabilitiesMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${longTermLiabilitiesMaster} ("
        "${TablesColumnFile.tlngtrmliabiltyrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mlngtrmliabiltyrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"

        "${TablesColumnFile.mcash} INTEGER,"
        "${TablesColumnFile.mcashpresentamt} REAL,"
        "${TablesColumnFile.mcashnextmonthamount} REAL,"
        "${TablesColumnFile.maccntrecvbl} INTEGER,"
        "${TablesColumnFile.maccntrecvblpresentamt} REAL,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} REAL,"
        "${TablesColumnFile.msumpresentamt} REAL,"
        "${TablesColumnFile.msumnextmonthamount} REAL,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tlngtrmliabiltyrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createShortTermLiabilitiesMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${shortTermLiabilitiesMaster} ("
        "${TablesColumnFile.tshrttrmliabiltyrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mshrttrmliabiltyrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
    //  "${TablesColumnFile.mshrttrmliabilty} INTEGER,"

        "${TablesColumnFile.mcash} INTEGER,"
        "${TablesColumnFile.mcashpresentamt} REAL,"
        "${TablesColumnFile.mcashnextmonthamount} REAL,"
        "${TablesColumnFile.maccntrecvbl} INTEGER,"
        "${TablesColumnFile.maccntrecvblpresentamt} REAL,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} REAL,"

        "${TablesColumnFile.mfield3} INTEGER,"
        "${TablesColumnFile.mfield3presentamt} REAL,"
        "${TablesColumnFile.mfield3nextmonthamount} REAL,"
        "${TablesColumnFile.mfield4} INTEGER,"
        "${TablesColumnFile.mfield4presentamt} REAL,"
        "${TablesColumnFile.mfield4nextmonthamount} REAL,"

        "${TablesColumnFile.msumpresentamt} REAL,"
        "${TablesColumnFile.msumnextmonthamount} REAL,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tshrttrmliabiltyrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createEquityMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${equityMaster} ("
        "${TablesColumnFile.tequityrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mequityrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
    //"${TablesColumnFile.mequity} INTEGER,"
        "${TablesColumnFile.mcash} INTEGER,"
        "${TablesColumnFile.mcashpresentamt} REAL,"
        "${TablesColumnFile.mcashnextmonthamount} REAL,"
        "${TablesColumnFile.maccntrecvbl} INTEGER,"
        "${TablesColumnFile.maccntrecvblpresentamt} REAL,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} REAL,"
        "${TablesColumnFile.msumpresentamt} REAL,"
        "${TablesColumnFile.msumnextmonthamount} REAL,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tequityrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createIncomeStatementMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${incomeStatementMaster} ("
        "${TablesColumnFile.tincomerefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mincomerefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mtotalrevenuep} REAL,"
        "${TablesColumnFile.mtotalrevenuenm} REAL,"
        "${TablesColumnFile.mgrossprofitfirstp} REAL,"
        "${TablesColumnFile.mgrossprofitfirstnm} REAL,"
        "${TablesColumnFile.mrevenuefirstp} REAL,"
        "${TablesColumnFile.mrevenuefirstnm} REAL,"
        "${TablesColumnFile.mgoodcostfirstp} REAL,"
        "${TablesColumnFile.mgoodcostfirstnm} REAL,"
        "${TablesColumnFile.mgrossprofitsecondp} REAL,"
        "${TablesColumnFile.mgrossprofitsecondnm} REAL,"
        "${TablesColumnFile.mrevenuesecondp} REAL,"
        "${TablesColumnFile.mrevenuesecondnm} REAL,"
        "${TablesColumnFile.mgoodcostsecondp} REAL,"
        "${TablesColumnFile.mgoodcostsecondnm} REAL,"
        "${TablesColumnFile.motherrevenuep} REAL,"
        "${TablesColumnFile.motherrevenuenm} REAL,"
        "${TablesColumnFile.mtotalopexpp} REAL,"
        "${TablesColumnFile.mtotalopexpnm} REAL,"
        "${TablesColumnFile.mopexpfirstp} REAL,"
        "${TablesColumnFile.mopexpfirstnm} REAL,"
        "${TablesColumnFile.mpersonalexpfirstp} REAL,"
        "${TablesColumnFile.mpersonalexpfirstnm} REAL,"
        "${TablesColumnFile.mgeneralexpfirstp} REAL,"
        "${TablesColumnFile.mgeneralexpfirstnm} REAL,"
        "${TablesColumnFile.motherexpfirstp} REAL,"
        "${TablesColumnFile.motherexpfirstnm} REAL,"
        "${TablesColumnFile.mopexpsecondp} REAL,"
        "${TablesColumnFile.mopexpsecondnm} REAL,"
        "${TablesColumnFile.mpersonalexpsecondp} REAL,"
        "${TablesColumnFile.mpersonalexpsecondnm} REAL,"
        "${TablesColumnFile.mgeneralexpsecondp} REAL,"
        "${TablesColumnFile.mgeneralexpsecondnm} REAL,"
        "${TablesColumnFile.motherexpsecondp} REAL,"
        "${TablesColumnFile.motherexpsecondnm} REAL,"
        "${TablesColumnFile.mtaxexpp} REAL,"
        "${TablesColumnFile.mtaxexpnm} REAL,"
        "${TablesColumnFile.mnetincomep} REAL,"
        "${TablesColumnFile.mnetincomenm} REAL,"
        "${TablesColumnFile.mfromdate} DATETIME,"
        "${TablesColumnFile.mtodate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tincomerefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createFinancialStatementMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${financialStatementMaster} ("
        "${TablesColumnFile.tfinancialstmntrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mfinancialstmntrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mgrossprofitmargin} REAL,"
        "${TablesColumnFile.mcurrentratio} REAL,"
        "${TablesColumnFile.mdebtratio} REAL,"
        "${TablesColumnFile.mtotcurasset} REAL,"
        "${TablesColumnFile.mtotcurliabilities} REAL,"
        "${TablesColumnFile.mworkngcapital} REAL,"
        "${TablesColumnFile.mavginventory} REAL,"
        "${TablesColumnFile.mavgaccreceivables} REAL,"
        "${TablesColumnFile.mavgaccpayables} REAL,"
        "${TablesColumnFile.mcogs} REAL,"
        "${TablesColumnFile.msales} REAL,"
        "${TablesColumnFile.mpurchases} REAL,"
        "${TablesColumnFile.minvconperiod} REAL,"
        "${TablesColumnFile.mrecconperiod} REAL,"
        "${TablesColumnFile.mpayconperiod} REAL,"
        "${TablesColumnFile.mworkngcapitalcycle} REAL,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.tfinancialstmntrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }






////////////////////////////////////////

  Future _createTotalExpendtrMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${totalExpndtrMaster} ("
        "${TablesColumnFile.ttotlexpntrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mtotlexpnmrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mlivngexpns } REAL,"
        "${TablesColumnFile.mtotlcommexpns } REAL,"
        "${TablesColumnFile.meduexpns } REAL,"
        "${TablesColumnFile.mmedexpns } REAL,"
        "${TablesColumnFile.mtotlfamexpns } REAL,"
        "${TablesColumnFile.mloanservexpns } REAL,"
        "${TablesColumnFile.mcredcrdexpns } REAL,"
        "${TablesColumnFile.mrntlexpns } REAL,"
        "${TablesColumnFile.mlghtwtrexpns } REAL,"
        "${TablesColumnFile.mvechtrnsprtexpns } REAL,"
        "${TablesColumnFile.mothrexpns } REAL,"
        "${TablesColumnFile.mothrdebtrepymntexpns } REAL,"
        "${TablesColumnFile.mtotldebtexpns } REAL,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile
        .mrefno},${TablesColumnFile.ttotlexpntrefno})"
        "FOREIGN KEY(${TablesColumnFile
        .mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile
        .trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile
        .trefno}) ON DELETE CASCADE);";
    print(createTableQuery.toString());
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future updateCgt1QaMaster(CheckListCGT1Bean checkCgt1Bean,
      int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();
    String insertQuery = "INSERT OR REPLACE INTO ${cgt1QaMaster}  "
        "("
        "${TablesColumnFile.tclcgt1refno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mclcgt1refno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mquestionid},"
        "${TablesColumnFile.manschecked}"
        ")"
        "VALUES "
        "("
        "${idValue},"
        "${checkCgt1Bean.mrefno},"
        "${checkCgt1Bean.trefno} ,"
        "${checkCgt1Bean.mclcgt1refno},"
        "'${checkCgt1Bean.mleadsid}' ,"
        "'${checkCgt1Bean.mquestionid}' ,"
        "${checkCgt1Bean.manschecked} "
        "); ";
    print(insertQuery);
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  Future updateCgt2QaMaster(CheckListCGT2Bean checkCgt2Bean,
      int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${cgt2QaMaster}  "
        "("
        "${TablesColumnFile.tclcgt2refno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mclcgt2refno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mquestionid},"
        "${TablesColumnFile.manschecked}"
        ")"
        "VALUES "
        "("
        "${idValue},"
        "${checkCgt2Bean.mrefno},"
        "${checkCgt2Bean.trefno} ,"
        "${checkCgt2Bean.mclcgt2refno},"
        "'${checkCgt2Bean.mtabletleadid}' ,"
        "'${checkCgt2Bean.mquestionid}' ,"
        "${checkCgt2Bean.manschecked} "
        "); ";


    print("insert qery in cgt2 questio list  ${insertQuery}");
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  Future updateGrtQaMaster(CheckListGRTBean checkGrtBean, int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();

    print("trying to insert or replace ${grtQaMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${grtQaMaster}  "
        "("
        "${TablesColumnFile.tclgrtrefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mclgrtrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mquestionid},"
        "${TablesColumnFile.manschecked}"
        ")"
        "VALUES "
        "("
        "${idValue},"
        "${checkGrtBean.mrefno},"
        "${checkGrtBean.trefno},"
        "${checkGrtBean.mclgrtrefno},"
        "'${checkGrtBean.mleadsid}' ,"
        "'${checkGrtBean.mquestionid}' ,"
        "${checkGrtBean.manschecked} "
        "); ";
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  //CGT insert
  //search
  Future updateCGT1Master(CGT1Bean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${CGT1Master}  "
        "("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcgt1doneby},"
        "${TablesColumnFile.mstarttime},"
        "${TablesColumnFile.mendtime},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate}"
        ")"
        "VALUES "
        "("
        "${bean.trefno},"
        "${bean.mrefno},"
        "${bean.loantrefno},"
        "${bean.loanmrefno},"
        "${bean.mleadsid},"
        "'${bean.mcgt1doneby}',"
        "'${bean.mstarttime}',"
        "'${bean.mendtime}',"
        "'${bean.mroutefrom}',"
        "'${bean.mrouteto}',"
        "'${bean.mremarks}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
        "${bean.missynctocoresys},"
        "'${bean.mlastsynsdate}'"
        "); ";
    print("Ban cgt1 " + insertQuery.toString());

    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  Future updateCGT2Master(CGT2Bean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${CGT2Master}  "
        "("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcgt2doneby},"
        "${TablesColumnFile.mstarttime},"
        "${TablesColumnFile.mendtime},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate}"
        ")"
        "VALUES "
        "("
        "${bean.trefno},"
        "${bean.mrefno},"
        "${bean.loantrefno},"
        "${bean.loanmrefno},"
        "${bean.mleadsid},"
        "'${bean.mcgt2doneby}',"
        "'${bean.mstarttime}',"
        "'${bean.mendtime}',"
        "'${bean.mroutefrom}',"
        "'${bean.mrouteto}',"
        "'${bean.mremarks}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
        "${bean.missynctocoresys},"
        "'${bean.mlastsynsdate}'"
        "); ";
    print("Ban cgt1 " + insertQuery.toString());


    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${CGT2Master}");
    });
  }

  Future updateGRTMaster(GRTBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${GRTMaster}  "
        "("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mgrtdoneby},"
        "${TablesColumnFile.mstarttime},"
        "${TablesColumnFile.mendtime},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.midtype1status},"
        "${TablesColumnFile.midtype2status},"
        "${TablesColumnFile.midtype3status},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mhouseVerifiImg}"
        ")"
        "VALUES "
        "("
        "${bean.trefno},"
        "${bean.mrefno},"
        "${bean.loantrefno},"
        "${bean.loanmrefno},"
        "${bean.mleadsid},"
        "'${bean.mgrtdoneby}',"
        "'${bean.mstarttime}',"
        "'${bean.mendtime}',"
        "'${bean.mroutefrom}',"
        "'${bean.mrouteto}',"
        "'${bean.mremarks}',"
        "'${bean.midtype1status}',"
        "'${bean.midtype2status}',"
        "'${bean.midtype3status}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
        "${bean.missynctocoresys},"
        "'${bean.mlastsynsdate}',"
        "'${bean.mhouseVerifiImg}'"
        "); ";
    print("insert query is" + insertQuery);
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${GRTMaster}");
    });
  }

  //Grt ends

  //select customer IsDataSynced
  Future<List<CreditBereauBean>> selectProspectListIsDataSynced(
      DateTime lastSyncFromTab) async {
    String selectQueryIsDataSynced = lastSyncFromTab != null &&
        !(lastSyncFromTab == "null")
        ? "SELECT * FROM ${creditBereauMaster}  WHERE ${TablesColumnFile
        .mcreateddt}  > '${lastSyncFromTab}' OR ${TablesColumnFile
        .mlastupdatedt}  > '${lastSyncFromTab}'"
        : "SELECT * FROM ${creditBereauMaster}";

    print("select query is ${selectQueryIsDataSynced}");

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<CreditBereauBean> listbean = new List<CreditBereauBean>();
    CreditBereauBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CreditBereauBean();
        bean = bindDataProspectbean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<CbResultBean> getCreditBereauResultIsSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();
    CbResultBean bean;

    String selectQuery =
        "SELECT * FROM ${creditBereauResultMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${creditBereauResultMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    try {
      print("Credit Bereau result me");
      if (result.isNotEmpty) {
        bean = new CbResultBean();
        bean = bindCreditBereauResultBean(result[0]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    print("returned value is $bean");
    return bean;
  }

  //select CBResultLoan IsDataSynced
  Future<List<CbResultBean>> selectCreditBereauLoanListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${creditBereauLoanDetailsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${creditBereauLoanDetailsMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<CbResultBean> listbean = new List<CbResultBean>();
    CbResultBean bean;
    try {
      print("Credit Bereau Loan Details Master m");
      for (int i = 0; i < result.length; i++) {
        bean = new CbResultBean();
        bean = bindCreditBereauResultBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<CGT1Bean>> selectCGT1ListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CGT1Bean retBean = new CGT1Bean();
    List<CGT1Bean> n = new List<CGT1Bean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${CGT1Master}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${CGT1Master}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      retBean = bindDataCGT1ListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }

  Future<List<CGT2Bean>> selectCGT2ListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CGT2Bean retBean = new CGT2Bean();
    List<CGT2Bean> n = new List<CGT2Bean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? "SELECT * FROM ${CGT2Master}  WHERE ${TablesColumnFile
        .mlastupdatedt}  > '$lastSyncDateTime' "
        : "SELECT * FROM ${CGT2Master}";

    print(selectQueryIsDataSynced);
    result = await db.rawQuery(selectQueryIsDataSynced);


    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindDataCGT2ListBean(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

/*
  CGT2Bean bindDataCGT2ListBean(Map<String, dynamic> result) {
    return CGT2Bean.fromMap(result);
  }*/

/*


  //select CGT isSynced0
  Future<List<CGT1Bean>> selectCGT1ListIsDataSynced(
      int isDatSynced) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${CGT1Master}  WHERE isDataSynced  = $isDatSynced');

    List<CGT1Bean> listbean = new List<CGT1Bean>();
    CGT1Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT1Bean();
        bean = bindDataCGT1ListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }
*/

  CGT1Bean bindDataCGT1ListBean(Map<String, dynamic> result) {
    return CGT1Bean.fromMap(result);
  }

  //select CGT2 isSynced0
  Future<List<CGT2Bean>> selectCGT2ListIsDataSynced(int isDatSynced) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${CGT2Master}  WHERE isDataSynced  = $isDatSynced');

    List<CGT2Bean> listbean = new List<CGT2Bean>();
    CGT2Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT2Bean();
        bean = bindDataCGT2ListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  CGT2Bean bindDataCGT2ListBean(Map<String, dynamic> result) {
    return CGT2Bean.fromMap(result);
  }

  Future<List<GRTBean>> selectGRTListIsDataSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    GRTBean retBean = new GRTBean();
    List<GRTBean> n = new List<GRTBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${GRTMaster}  WHERE ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${GRTMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      retBean = bindDataGRTListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }

  GRTBean bindDataGRTListBean(Map<String, dynamic> result) {
    return GRTBean.fromMap(result);
  }

  //select checklistData
  /*Future<List<CheckListBean>> selectCheckListIsDataSynced(
      int isDatSynced,String loanNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${checkListMaster}  WHERE isDataSynced  = $isDatSynced AND ${TablesColumnFile.loanNumber} = $loanNumber');

    List<CheckListBean> listbean = new List<CheckListBean>();
    CheckListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListBean();
        bean = bindDataCheckListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  CheckListBean bindDataCheckListBean(Map<String, dynamic> result) {
    return CheckListBean.fromMap(result);
  }*/

  Future<List<CheckListCGT1Bean>> selectCheckListCGT1IsDataSynced(int trefno,
      int mrefno) async {
    var db = await _getDb();
    String selQuery =
        'SELECT * FROM ${cgt1QaMaster}  WHERE ${TablesColumnFile
        .trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno';
    //String selQuery = 'SELECT * FROM ${cgt1QaMaster}';
    var result = await db.rawQuery(selQuery);
    List<CheckListCGT1Bean> cgt1listbean = new List<CheckListCGT1Bean>();
    CheckListCGT1Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListCGT1Bean();
        bean = bindDataCheckListCGT1Bean(result[i]);
        cgt1listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return cgt1listbean;
  }

  CheckListCGT1Bean bindDataCheckListCGT1Bean(Map<String, dynamic> result) {
    return CheckListCGT1Bean.fromMap(result);
  }

  Future<List<CheckListCGT2Bean>> selectCheckListCGT2IsDataSynced(int trefno,
      int mrefno) async {
    var db = await _getDb();
    String selQuery =
        'SELECT * FROM ${cgt2QaMaster}  WHERE ${TablesColumnFile
        .trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno';

    var result = await db.rawQuery(selQuery);
    List<CheckListCGT2Bean> cgt2listbean = new List<CheckListCGT2Bean>();
    CheckListCGT2Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListCGT2Bean();
        bean = bindDataCheckListCGT2Bean(result[i]);
        cgt2listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return cgt2listbean;
  }

  CheckListCGT2Bean bindDataCheckListCGT2Bean(Map<String, dynamic> result) {
    return CheckListCGT2Bean.fromMap(result);
  }

  Future<List<CheckListGRTBean>> selectCheckListGRTIsDataSynced(int trefno,
      int mrefno) async {
    var db = await _getDb();
    String selQuery =
        'SELECT * FROM ${grtQaMaster}  WHERE ${TablesColumnFile
        .trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno';
    //String selQuery = 'SELECT * FROM ${grtQaMaster}';
    var result = await db.rawQuery(selQuery);
    List<CheckListGRTBean> grtlistbean = new List<CheckListGRTBean>();
    CheckListGRTBean bean;
    print("nksjkjsldjsnldsn" + result.toString());
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListGRTBean();
        bean = bindDataCheckListGRTBean(result[i]);
        grtlistbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return grtlistbean;
  }

/*
  Future<List<CheckListGRTBean>> selectCheckListGRTIsDataSynced(
      String loanNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${grtQaMaster}  WHERE ${TablesColumnFile.mleadsid} = "$loanNumber"');
    List<CheckListGRTBean> grtlistbean = new List<CheckListGRTBean>();
    CheckListGRTBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListGRTBean();
        bean = bindDataCheckListGRTBean(result[i]);
        grtlistbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return grtlistbean;
  }*/
  CheckListGRTBean bindDataCheckListGRTBean(Map<String, dynamic> result) {
    return CheckListGRTBean.fromMap(result);
  }

  //Generate Customer Number of Tab
  Future<int> generateCustomerNumber() async {
    print("trying to select last row  ${customerFoundationMasterDetails}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationMasterDetails}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile
        .trefno})  FROM ${customerFoundationMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  Future<int> generateAccountNumber() async {
    print("trying to select last row  ${savingsMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${savingsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile
        .trefno})  FROM ${savingsMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  //Insert Customer Basics details
  Future<int> updateCustomerFoundationMasterDetailsTable(CustomerListBean bean,
      bool fromServer) async {
    /* bean.CreatedDate = DateTime.now();
       bean.UpdatedatedDate = DateTime.now();*/
    List<int> retValue;
    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationMasterDetails} "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mlongname} ,"
        "${TablesColumnFile.mfathertitle} ,"
        "${TablesColumnFile.mfatherfname} ,"
        "${TablesColumnFile.mfathermname} ,"
        "${TablesColumnFile.mfatherlname} ,"
        "${TablesColumnFile.mspousetitle} ,"
        "${TablesColumnFile.mhusbandname} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.mage} ,"
        "${TablesColumnFile.mbankacno} ,"
        "${TablesColumnFile.mbankacyn} ,"
        "${TablesColumnFile.mbankifsc} ,"
        "${TablesColumnFile.mbanknamelk} ,"
        "${TablesColumnFile.mbankbranch} ,"
        "${TablesColumnFile.mcuststatus} ,"
        "${TablesColumnFile.mdropoutdate} ,"
        "${TablesColumnFile.mmobno} ,"
        "${TablesColumnFile.mpanno} ,"
        "${TablesColumnFile.mpannodesc} ,"
        "${TablesColumnFile.mtdsyn} ,"
        "${TablesColumnFile.mtdsreasoncd} ,"
        "${TablesColumnFile.mtdsfrm15subdt} ,"
        "${TablesColumnFile.memailId} ,"
        "${TablesColumnFile.mcustcategory} ,"
        "${TablesColumnFile.mtier} ,"
        "${TablesColumnFile.mAdd1} ,"
        "${TablesColumnFile.mAdd2} ,"
        "${TablesColumnFile.mAdd3} ,"
        "${TablesColumnFile.marea} ,"
        "${TablesColumnFile.mPinCode} ,"
        "${TablesColumnFile.mCounCd} ,"
        "${TablesColumnFile.mCityCd} , "
        "${TablesColumnFile.mfname} , "
        "${TablesColumnFile.mmname} , "
        "${TablesColumnFile.mlname} , "
        "${TablesColumnFile.mgender} , "
        "${TablesColumnFile.mrelegion} , "
        "${TablesColumnFile.mRuralUrban} , "
        "${TablesColumnFile.mcaste} , "
        "${TablesColumnFile.mqualification} , "
        "${TablesColumnFile.moccupation} , "
        "${TablesColumnFile.mLandType} , "
        "${TablesColumnFile.mmaritialStatus} , "
        "${TablesColumnFile.mTypeOfId} , "
        "${TablesColumnFile.mIdDesc} , "
        "${TablesColumnFile.mInsuranceCovYN} , "
        "${TablesColumnFile.mTypeofCoverage} , "
        "${TablesColumnFile.mcreateddt} , "
        "${TablesColumnFile.mcreatedby} , "
        "${fromServer == true ? TablesColumnFile.mlastupdatedt + "," : ""}  "
        "${TablesColumnFile.mlastupdateby} , "
        "${TablesColumnFile.mgeolocation} , "
        "${TablesColumnFile.mgeolatd} , "
        "${TablesColumnFile.mgeologd} , "
        "${TablesColumnFile.missynctocoresys} , "
        "${TablesColumnFile.ifYesThen},"
        "${TablesColumnFile.mShopName},"
        "${TablesColumnFile.mShpAdd},"
        "${TablesColumnFile.mYrsInBz},"
        "${TablesColumnFile.mregNum},"
    /*"${TablesColumnFile.mid1},"
        "${TablesColumnFile.mid2},"*/
        "${TablesColumnFile.mhouse},"
        "${TablesColumnFile.mAgricultureType},"
        "${TablesColumnFile.mIsMbrGrp},"
        "${TablesColumnFile.mLoanAgreed},"
        "${TablesColumnFile.mGend},"
        "${TablesColumnFile.mInsurance},"
    //"${TablesColumnFile.mRegion},"
        "${TablesColumnFile.mConstruct},"
        "${TablesColumnFile.mToilet},"
    /*"${TablesColumnFile.mBankAccYN},"*/
        "${TablesColumnFile.mhousBizSp},"
        "${TablesColumnFile.mBzRegs},"
        "${TablesColumnFile.mBzTrnd},"
        "${TablesColumnFile.mcentername},"
        "${TablesColumnFile.mgroupname},"
        "${TablesColumnFile.misCbCheckDone},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mexpsramt}, "
        "${TablesColumnFile.mcbcheckrprtdt} , "
        "${TablesColumnFile.motpvrfdno}, "
        "${TablesColumnFile.mprofileind},"
        "${TablesColumnFile.mhusdob},"
        "${TablesColumnFile.mid1issuedate} , "
        "${TablesColumnFile.mid2issuedate} , "
        "${TablesColumnFile.mid1expdate} , "
        "${TablesColumnFile.mid2expdate} , "
        "${TablesColumnFile.mlangofcust},"
        "${TablesColumnFile.mmainoccupn},"
        "${TablesColumnFile.msuboccupn},"
        "${TablesColumnFile.msecoccupatn},"
        "${TablesColumnFile.mmainoccupndesc},"
        "${TablesColumnFile.mnametitle2} ,"
        "${TablesColumnFile.mlongname2} ,"
        "${TablesColumnFile.mfname2} , "
        "${TablesColumnFile.mmname2} , "
        "${TablesColumnFile.mlname2} , "
        "${TablesColumnFile.mnationality} , "
        "${TablesColumnFile.mid3issuedate} ,"
        "${TablesColumnFile.mid3expdate} , "
        "${TablesColumnFile.missngautryt1} , "
        "${TablesColumnFile.missngautryt2} , "
        "${TablesColumnFile.missngautryt3} ,"
        "${TablesColumnFile.mtypeofid3} ,"
        "${TablesColumnFile.middesc3} ,"
        "${TablesColumnFile.macctbal} ,"
        "${TablesColumnFile.misearngmembr} ,"
        "${TablesColumnFile.misstudyingmembr} ,"
        "${TablesColumnFile.mmemberno} ,"
        "${TablesColumnFile.mischldrn} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.mtarget} ,"
        "${TablesColumnFile.mownership} ,"
        "${TablesColumnFile.mresstatus} ,"
        "${TablesColumnFile.miscpemp} ,"
        "${TablesColumnFile.mrankofemp} ,"
        "${TablesColumnFile.mempid} ,"
        "${TablesColumnFile.msuboccupndesc})"
        "VALUES"
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "${bean.mlbrcode} ,"
        "${bean.mcenterid} ,"
        "${bean.mgroupcd} ,"
        "'${bean.mnametitle}' ,"
        "'${bean.mlongname}' ,"
        "'${bean.mfathertitle}' ,"
        "'${bean.mfatherfname}' ,"
        "'${bean.mfathermname}' ,"
        "'${bean.mfatherlname}' ,"
        "'${bean.mspousetitle}' ,"
        "'${bean.mhusbandname}' ,"
        "'${bean.mdob}' ,"
        "${bean.mage} ,"
        "'${bean.mbankacno}' ,"
        "'${bean.mbankacyn}' ,"
        "'${bean.mbankifsc}' ,"
        "'${bean.mbanknamelk}' ,"
        "'${bean.mbankbranch}' ,"
        "${bean.mcuststatus} ,"
        "'${bean.mdropoutdate}' ,"
        "'${bean.mmobno}' ,"
        "${bean.mpanno} ,"
        "'${bean.mpannodesc}' ,"
        "'${bean.mtdsyn}' ,"
        "${bean.mtdsreasoncd} ,"
        "'${bean.mtdsfrm15subdt}' ,"
        "'${bean.memailId}',"
        "'${bean.mcustcategory}' ,"
        "${bean.mtier} ,"
        "'${bean.mAdd1}' ,"
        "'${bean.mAdd2}' ,"
        "'${bean.mAdd3}' ,"
        "${bean.mArea} ,"
        "'${bean.mPinCode}' ,"
        "'${bean.mCounCd}' ,"
        "'${bean.mCityCd}' ,"
        "'${bean.mfname}' ,"
        "'${bean.mmname}' ,"
        "'${bean.mlname}' ,"
        "'${bean.mgender}' ,"
        "'${bean.mrelegion}' ,"
        "'${bean.mRuralUrban}' ,"
        "'${bean.mcaste}' ,"
        "'${bean.mqualification}' ,"
        "${bean.moccupation} ,"
        "'${bean.mLandType}' ,"
        "${bean.mmaritialStatus} ,"
        "${bean.mTypeOfId} ,"
        "'${bean.mIdDesc}' ,"
        "'${bean.mInsuranceCovYN}' ,"
        "${bean.mTypeofCoverage} ,"
        "'${bean.mcreateddt}' ,"
        "'${bean.mcreatedby}' ,"
        "${fromServer == true
        ? "'" + bean.mlastupdatedt.toString() + "',"
        : ""} "
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}' ,"
        "'${bean.mgeolatd}' ,"
        "'${bean.mgeologd}' ,"
        "${bean.missynctocoresys} ,"
        " '${bean.ifYesThen}' , "
        " '${bean.mShopName}' , "
        " '${bean.mShpAdd}' , "
        "${bean.mYrsInBz}, "
        " '${bean.mregNum}' , "
    /*" '${bean.mid1}' , "
        " '${bean.mid2}' , "*/
        " '${bean.mHouse}' , "
        " '${bean.mAgricultureType}' , "
        "${bean.mIsMbrGrp} , "
        "${bean.mLoanAgreed} , "
        "${bean.mGend} , "
        "${bean.mInsurance} , "
    //"${bean.mRegion} , "
        "${bean.mConstruct} , "
        "${bean.mToilet} , "
    /*"${bean.mBankAccYN} , "*/
        "${bean.mhousBizSp} , "
        "${bean.mBzRegs} , "
        "${bean.mBzTrnd}, "
        "'${bean.mcentername}',"
        "'${bean.mgroupname}',"
        "${bean.misCbCheckDone}, "
        "'${bean.merrormessage}',"
        "'${bean.mlastsynsdate}',"
        "${bean.mexpsramt} , "
        "'${bean.mcbcheckrprtdt}',"
        "'${bean.motpvrfdno}', "
        "'${bean.mprofileind}',"
        "'${bean.mhusdob}',"
        "'${bean.mid1issuedate}',"
        "'${bean.mid2issuedate}',"
        "'${bean.mid1expdate}',"
        "'${bean.mid2expdate}',"
        "'${bean.mlangofcust}',"
        "'${bean.mmainoccupn}',"
        "'${bean.msuboccupn}',"
        "${bean.msecoccupatn} , "
        "'${bean.mmainoccupndesc}',"
        "'${bean.mnametitle2}' ,"
        "'${bean.mlongname2}' ,"
        "'${bean.mfname2}' ,"
        "'${bean.mmname2}' ,"
        "'${bean.mlname2}' ,"
        "'${bean.mnationality}' ,"
        "'${bean.mid3issuedate}' ,"
        "'${bean.mid3expdate}' ,"
        "'${bean.missngautryt1}' ,"
        "'${bean.missngautryt2}' ,"
        "'${bean.missngautryt3}' ,"
        "${bean.mtypeofid3} ,"
        "'${bean.middesc3}' ,"
        "${bean.macctbal} ,"
        "'${bean.misearngmembr}',"
        "'${bean.misstudyingmembr}',"
        "'${bean.mmemberno}',"
        "'${bean.mischldrn}',"
        "'${bean.mbusinessname}',"
        "'${bean.mtarget}',"
        "'${bean.mownership}',"
        "'${bean.mresstatus}',"
        "'${bean.miscpemp}',"
        "'${bean.mrankofemp}',"
        "'${bean.mempid}',"
        "'${bean.msuboccupndesc}');";
    print("insert query Customer Formation" + insertQuery);
    int id;
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${customerFoundationMasterDetails}");
    });

    await db.transaction((Transaction txn) async {
      insertQuery = "SELECT last_insert_rowid();";
      var result = await txn.rawQuery(insertQuery);
      print(id.toString() +
          " id after insert in ${customerFoundationMasterDetails}");
      print("value of toooooooo1" + result.toString());
      for (Map<String, dynamic> item in result) {
        retValue = item.values.cast<int>().toList();
      }
    });
    return retValue[0];
  }

/*
  //Generate Family ref Number of Tab
  Future<int> generateFamilyRefNumber() async {
    print(
        "trying to select last row  ${"multiline"}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationFamilyMasterDetails}"
        " WHERE   ${TablesColumnFile.tfamilyrefno} = (SELECT MAX(${TablesColumnFile.tfamilyrefno})  FROM ${customerFoundationFamilyMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.tfamilyrefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }*/

  //Insert Family Basics details
  Future<int> updateCustomerFoundationFamilyDetailsTable(
      FamilyDetailsBean familyDetailsBean) async {
    var db = await _getDb();

    //int tfamilyrefno = await generateFamilyRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationFamilyMasterDetails} "
        "(${TablesColumnFile.tfamilyrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mfamilyrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mlongname} ,"
        "${TablesColumnFile.mfname} ,"
        "${TablesColumnFile.mmname} ,"
        "${TablesColumnFile.mlname} ,"
        "${TablesColumnFile.mnicno} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.mage} ,"
        "${TablesColumnFile.meducation} ,"
        "${TablesColumnFile.mmemberno} ,"
        "${TablesColumnFile.moccuptype} ,"
        "${TablesColumnFile.mincome} ,"
        "${TablesColumnFile.mhealthstatus} ,"
        "${TablesColumnFile.mrelationwithcust} ,"
        "${TablesColumnFile.mreverseRelationship} ,"
        "${TablesColumnFile.maritalstatus} ,"
        "${TablesColumnFile.mcontrforhouseexp} ,"
        "${TablesColumnFile.macidntlinsurance} ,"
        "${TablesColumnFile.misearngmembr},"
        "${TablesColumnFile.misstudyingmembr},"
        "${TablesColumnFile.misleavingwithappcnt} ,"
        "${TablesColumnFile.mdesignation} ,"
        "${TablesColumnFile.mprofession} ,"
        "${TablesColumnFile.mnomineeyn} )"
        "VALUES"
        "(${familyDetailsBean.tfamilyrefno} ,"
        "${familyDetailsBean.trefno} ,"
        "${familyDetailsBean.mfamilyrefno} ,"
        "${familyDetailsBean.mrefno} ,"
        "${familyDetailsBean.mcustno} ,"
        "'${familyDetailsBean.mnametitle}' ,"
        "'${familyDetailsBean.mlongname}' ,"
        "'${familyDetailsBean.mfname}' ,"
        "'${familyDetailsBean.mmname}' ,"
        "'${familyDetailsBean.mlname}' ,"
        "'${familyDetailsBean.mnicno}' ,"
        "'${familyDetailsBean.mdob}' ,"
        "${familyDetailsBean.mage} ,"
        "'${familyDetailsBean.meducation}' ,"
        "'${familyDetailsBean.mmemberno}' ,"
        "${familyDetailsBean.moccuptype} ,"
        "${familyDetailsBean.mincome} ,"
        "${familyDetailsBean.mhealthstatus} ,"
        "'${familyDetailsBean.mrelationwithcust}' ,"
        "'${familyDetailsBean.mreverseRelationship}' ,"
        "'${familyDetailsBean.maritalstatus}' ,"
        "${familyDetailsBean.mcontrforhouseexp} ,"
        "'${familyDetailsBean.macidntlinsurance}' ,"
        "${familyDetailsBean.misearngmembr} ,"
        "${familyDetailsBean.misstudyingmembr} ,"
        "${familyDetailsBean.misleavingwithappcnt} ,"
        "'${familyDetailsBean.mdesignation}' ,"
        "'${familyDetailsBean.mprofession}' ,"
        "'${familyDetailsBean.mnomineeyn}');";
    print("insert query is family Details " + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationFamilyMasterDetails}");
    });
    return idAfterInsert;
  }



  Future<int> updateCustomerFoundationBankDetailsTable(
      SocialFinancialDetailsBean socialFinancialDetailsBean) async {
    var db = await _getDb();

    //int tfamilyrefno = await generateFamilyRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${bankDetailsMaster} "
        "(${TablesColumnFile.tbanktrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mbanktrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.maccno} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.maccstatus} ,"
        "${TablesColumnFile.migyn} ,"
        "${TablesColumnFile.mcurcode} ,"
        "${TablesColumnFile.mbankname} ,"
        "${TablesColumnFile.mbranch} ,"
        "${TablesColumnFile.maccbal} ,"
        "${TablesColumnFile.misusefordis} )"
        "VALUES"
        "(${socialFinancialDetailsBean.tbanktrefno} ,"
        "${socialFinancialDetailsBean.trefno} ,"
        "${socialFinancialDetailsBean.mbanktrefno} ,"
        "${socialFinancialDetailsBean.mrefno} ,"
        "'${socialFinancialDetailsBean.maccno}' ,"
        "'${socialFinancialDetailsBean.mcreatedby}' ,"
        "'${socialFinancialDetailsBean.maccstatus}' ,"
        "'${socialFinancialDetailsBean.migyn}' ,"
        "'${socialFinancialDetailsBean.mcurcode}' ,"
        "'${socialFinancialDetailsBean.mbankname}' ,"
        "'${socialFinancialDetailsBean.mbranch}' ,"
        "${socialFinancialDetailsBean.maccbal} ,"
        "'${socialFinancialDetailsBean.misusefordis}');";
    print("insert query is bank Details " + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${bankDetailsMaster}");
    });
    return idAfterInsert;
  }



//Insert Family Basics details List start point
  Future<int> updateCustomerFoundationFamilyDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int custtfamref = 0;
    for (FamilyDetailsBean item in custListBean.familyDetailsList) {
      item.mrefno = custListBean.mrefno;
      custtfamref++;
      item.tfamilyrefno = custtfamref;
      id = await updateCustomerFoundationFamilyDetailsTable(item);
    }
    return id;
  }



  Future<int> updateCustomerFoundationBankDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int custtsfref = 0;
    for (SocialFinancialDetailsBean item in custListBean.socialFinancialList) {
      item.mrefno = custListBean.mrefno;
      custtsfref++;
      item.tbanktrefno = custtsfref;
      id = await updateCustomerFoundationBankDetailsTable(item);
    }
    return id;
  }





  Future<int> updateCustomerFoundationBusinessDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int custtbusref = 0;
    for (CustomerBusinessDetailsBean item in custListBean.customerBusinessDetailsBean) {
      item.mrefno = custListBean.mrefno;
      custtbusref++;
      item.tbussdetailsrefno = custtbusref;
      print("Items of boil "+item.toString());
      id = await updateCustomerFoundationBusinessDetailsTable(item);
    }
    return id;
  }
/*
  //Generate Address ref Number of Tab
  Future<int> generateAddressRefNumber() async {
    print(
        "trying to select last row  ${"multiline taddrefno"}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationAddressMasterDetails}"
        " WHERE   ${TablesColumnFile.taddrefno} = (SELECT MAX(${TablesColumnFile.taddrefno})  FROM ${customerFoundationAddressMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.taddrefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }*/

  ///Insert Address Basics details
  Future<int> updateCustomerFoundationAddressDetailsBeanTable(
      AddressDetailsBean addressDetailsBean) async {
    var db = await _getDb();
    // int tAddressrefno = await generateAddressRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationAddressMasterDetails} "
        "(${TablesColumnFile.taddrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.maddressrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.maddrType} ,"
        "${TablesColumnFile.maddr1} ,"
        "${TablesColumnFile.maddr2} ,"
        "${TablesColumnFile.maddr3} ,"
        "${TablesColumnFile.mpinCd} ,"
        "${TablesColumnFile.mtel1} ,"
        "${TablesColumnFile.mtel2} ,"
        "${TablesColumnFile.mcityCd} ,"
        "${TablesColumnFile.mfax1} ,"
        "${TablesColumnFile.mfax2} ,"
        "${TablesColumnFile.mcountryCd} ,"
        "${TablesColumnFile.marea} ,"
        "${TablesColumnFile.mHouseType} ,"
        "${TablesColumnFile.mRntLeasAmt} ,"
        "${TablesColumnFile.mRntLeasDep} ,"
        "${TablesColumnFile.mContLeasExp} ,"
        "${TablesColumnFile.mRoofCond} ,"
        "${TablesColumnFile.mUtils} ,"
        "${TablesColumnFile.mAreaType} ,"
        "${TablesColumnFile.mLandmark} ,"
        "${TablesColumnFile.mstate} ,"
        "${TablesColumnFile.mYearStay} ,"
        "${TablesColumnFile.mWardNo} ,"
        "${TablesColumnFile.mMobile} ,"
        "${TablesColumnFile.mEmail} ,"
        "${TablesColumnFile.mPattaName} ,"
        "${TablesColumnFile.mRelationship} ,"
        "${TablesColumnFile.mSourceOfDep} ,"
        "${TablesColumnFile.mInstAmount} ,"
        "${TablesColumnFile.mToietYN} ,"
        "${TablesColumnFile.mNoOfRooms} ,"
        "${TablesColumnFile.mSpouseYearsStay} ,"
        "${TablesColumnFile.mDistCd} ,"
        "${TablesColumnFile.mvillage} ,"
        "${TablesColumnFile.mCookFuel} ,"
        "${TablesColumnFile.mSecMobile} ,"
        "${TablesColumnFile.mThana},"
        "${TablesColumnFile.mPost},"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mownership} ,"
        "${TablesColumnFile.mplacecd} )"
        "VALUES"
        "(${addressDetailsBean.taddrefno} ,"
        "${addressDetailsBean.trefno},"
        "${addressDetailsBean.maddressrefno} ,"
        "${addressDetailsBean.mrefno} ,"
        "${addressDetailsBean.mcustno} ,"
        "${addressDetailsBean.maddrType} ,"
        "'${addressDetailsBean.maddr1}' ,"
        "'${addressDetailsBean.maddr2}' ,"
        "'${addressDetailsBean.maddr3}' ,"
        "${addressDetailsBean.mpinCd},"
        "'${addressDetailsBean.mtel1}' ,"
        "'${addressDetailsBean.mtel2}' ,"
        "'${addressDetailsBean.mcityCd}' ,"
        "'${addressDetailsBean.mfax1}',"
        "'${addressDetailsBean.mfax2}' ,"
        "'${addressDetailsBean.mcountryCd}' ,"
        "${addressDetailsBean.marea} ,"
        "${addressDetailsBean.mHouseType} ,"
        "${addressDetailsBean.mRntLeasAmt} ,"
        "${addressDetailsBean.mRntLeasDep} ,"
        "'${addressDetailsBean.mContLeasExp}',"
        "${addressDetailsBean.mRoofCond} ,"
        "${addressDetailsBean.mUtils} ,"
        "${addressDetailsBean.mAreaType} ,"
        "'${addressDetailsBean.mLandmark}',"
        "'${addressDetailsBean.mState}' ,"
        "${addressDetailsBean.mYearStay} ,"
        "'${addressDetailsBean.mWardNo}' ,"
        "'${addressDetailsBean.mMobile}' ,"
        "'${addressDetailsBean.mEmail}' ,"
        "'${addressDetailsBean.mPattaName}' ,"
        "'${addressDetailsBean.mRelationship}',"
        "${addressDetailsBean.mSourceOfDep} ,"
        "${addressDetailsBean.mInstAmount} ,"
        "'${addressDetailsBean.mToietYN}' ,"
        "${addressDetailsBean.mNoOfRooms},"
        "${addressDetailsBean.mSpouseYearsStay} ,"
        "${addressDetailsBean.mDistCd} ,"
        "${addressDetailsBean.mvillage} ,"
        "${addressDetailsBean.mCookFuel} ,"
        "'${addressDetailsBean.mSecMobile}',"
        "'${addressDetailsBean.mThana}' ,"
        "'${addressDetailsBean.mPost}' ,"
        "'${addressDetailsBean.mgeologd}' ,"
        "'${addressDetailsBean.mgeolatd}' ,"
        "'${addressDetailsBean.mownership}' ,"
        "'${addressDetailsBean.mplacecd}' );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationAddressMasterDetails}");
    });
    return idAfterInsert;
  }

//Insert Family Basics details List start point
  Future<int> updateCustomerFoundationAddressDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int taddref = 0;
    for (AddressDetailsBean item in custListBean.addressDetails) {
      item.mrefno = custListBean.mrefno;
      taddref++;
      item.taddrefno = taddref;
      id = await updateCustomerFoundationAddressDetailsBeanTable(item);
    }
    return id;
  }

/*
  //Generate Borrowing ref Number of Tab
  Future<int> generateBorrowingRefNumber() async {
    print(
        "trying to select last row  ${"multiline taddrefno"}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationBorrowingMasterDetails}"
        " WHERE   ${TablesColumnFile.tborrowingrefno} = (SELECT MAX(${TablesColumnFile.tborrowingrefno})  FROM ${customerFoundationBorrowingMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.taddrefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }*/

//Insert Borrowing Basics details
  Future<int> updateCustomerFoundationBorrowingDetailsTable(
      BorrowingDetailsBean borrowingDetails) async {
    var db = await _getDb();
    //int tBorrowingrefno = await generateBorrowingRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationBorrowingMasterDetails} "
        "(${TablesColumnFile.tborrowingrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mborrowingrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mnameofborrower} ,"
        "${TablesColumnFile.msource} ,"
        "${TablesColumnFile.mpurpose} ,"
        "${TablesColumnFile.mamount} ,"
        "${TablesColumnFile.mintrate} ,"
        "${TablesColumnFile.memiamt} ,"
        "${TablesColumnFile.moutstandingamt} ,"
        "${TablesColumnFile.mmemberno} ,"
        "${TablesColumnFile.mloanDate},"
        "${TablesColumnFile.mrepaymentDate},"
        "${TablesColumnFile.mloanwthUs},"
        "${TablesColumnFile.macctno} ,"
        "${TablesColumnFile.mperiod} ,"
        "${TablesColumnFile.mfrequency} ,"
        "${TablesColumnFile.mcurcd} ,"
        "${TablesColumnFile.mrestructrdloan} ,"
        "${TablesColumnFile.msvngamount} ,"
        "${TablesColumnFile.mremark} ,"
        "${TablesColumnFile.mmodeofdisb} ,"
        "${TablesColumnFile.mloancycle} )"
        "VALUES"
        "(${borrowingDetails.tborrowingrefno} ,"
        "${borrowingDetails.trefno},"
        "${borrowingDetails.mborrowingrefno} ,"
        "${borrowingDetails.mrefno} ,"
        "${borrowingDetails.mcustno} ,"
        "'${borrowingDetails.mnameofborrower}' ,"
        "'${borrowingDetails.msource}' ,"
        "'${borrowingDetails.mpurpose}' ,"
        "${borrowingDetails.mamount} ,"
        "${borrowingDetails.mintrate} ,"
        "${borrowingDetails.memiamt} ,"
        "${borrowingDetails.moutstandingamt} ,"
        "'${borrowingDetails.mmemberno}' ,"
        "'${borrowingDetails.mloanDate}' ,"
        "'${borrowingDetails.mrepaymentDate}' ,"
        "'${borrowingDetails.mloanwthUs}',"
        "'${borrowingDetails.macctno}' ,"
        "${borrowingDetails.mperiod} ,"
        "'${borrowingDetails.mfrequency}',"
        "'${borrowingDetails.mcurcd}',"
        "'${borrowingDetails.mrestructrdloan}',"
        "${borrowingDetails.msvngamount} ,"
        "'${borrowingDetails.mremark}' ,"
        "'${borrowingDetails.mmodeofdisb}' ,"
        "${borrowingDetails.mloancycle});";

    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationBorrowingMasterDetails}");
    });
    return idAfterInsert;
  }

  //Insert Business Basics details
  Future<int> updateCustomerFoundationBusinessDetailsTable(
      CustomerBusinessDetailsBean customerBusinessDetailsBean) async {
    var db = await _getDb();
    String insertQuery =
        "INSERT OR REPLACE INTO ${customerBusinessDetailMaster} "
        "(${TablesColumnFile.tbussdetailsrefno}  ,"
        "${TablesColumnFile.mbussdetailsrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcusactivitytype} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.mbusaddress1} ,"
        "${TablesColumnFile.mbusaddress2} ,"
        "${TablesColumnFile.mbusaddress3} ,"
        "${TablesColumnFile.mbusaddress4} ,"
        "${TablesColumnFile.mbuscity} ,"
        "${TablesColumnFile.mdistcd} ,"
        "${TablesColumnFile.mbusstate} ,"
        "${TablesColumnFile.mbuscountry} ,"
        "${TablesColumnFile.mbusarea} ,"
        "${TablesColumnFile.mbusvillage} ,"
        "${TablesColumnFile.mbuslandmark} ,"
        "${TablesColumnFile.mbuspin} ,"
        "${TablesColumnFile.mbusyrsmnths} ,"
        "${TablesColumnFile.mregisteredyn} ,"
        "${TablesColumnFile.mregistrationno} ,"
        "${TablesColumnFile.mbusothtomanageabsyn} ,"
        "${TablesColumnFile.mbusothmanagername} ,"
        "${TablesColumnFile.mbusothmanagerrel} ,"
        "${TablesColumnFile.mbusmonthlyincome} ,"
        "${TablesColumnFile.mbusseasonalityjan} ,"
        "${TablesColumnFile.mbusseasonalityfeb} ,"
        "${TablesColumnFile.mbusseasonalitymar} ,"
        "${TablesColumnFile.mbusseasonalityapr} ,"
        "${TablesColumnFile.mbusseasonalitymay} ,"
        "${TablesColumnFile.mbusseasonalityjun} ,"
        "${TablesColumnFile.mbusseasonalityjul} ,"
        "${TablesColumnFile.mbusseasonalityaug} ,"
        "${TablesColumnFile.mbusseasonalitysep} ,"
        "${TablesColumnFile.mbusseasonalityoct} ,"
        "${TablesColumnFile.mbusseasonalitynov} ,"
        "${TablesColumnFile.mbusseasonalitydec} ,"
        "${TablesColumnFile.mbushighsales} ,"
        "${TablesColumnFile.mbusmediumsales} ,"
        "${TablesColumnFile.mbuslowsales} ,"
        "${TablesColumnFile.mbushighincome} ,"
        "${TablesColumnFile.mbusmediumincom} ,"
        "${TablesColumnFile.mbuslowincome} ,"
        "${TablesColumnFile.mbusmonthlytotaleval} ,"
        "${TablesColumnFile.mbusmonthlytotalverif} ,"
        "${TablesColumnFile.mbusincludesurcalcyn} ,"
        "${TablesColumnFile.mbusnhousesameplaceyn} ,"
        "${TablesColumnFile.mbusinesstrend} ,"
        "${TablesColumnFile.mmonthlyincome} ,"
        "${TablesColumnFile.mtotalmonthlyincome} ,"
        "${TablesColumnFile.mbusinessexpense} ,"
        "${TablesColumnFile.mhousehldexpense} ,"
        "${TablesColumnFile.mmonthlyemi} ,"
        "${TablesColumnFile.mincomeemiratio} ,"
        "${TablesColumnFile.mnetamount} ,"
        "${TablesColumnFile.mposition} ,"
        "${TablesColumnFile.mdepartment} ,"
        "${TablesColumnFile.mempfrom} ,"
        "${TablesColumnFile.mempto} ,"
        "${TablesColumnFile.mincomefromothrsrc} ,"
        "${TablesColumnFile.mdateofincorporation} ,"
        "${TablesColumnFile.mbusinessownerandshareholdingpercentage} ,"
        "${TablesColumnFile.mtotalmanpower} ,"
        "${TablesColumnFile.mtotalman} ,"
        "${TablesColumnFile.mtotalwomen} ,"
        "${TablesColumnFile.mcompanycategory} ,"
        "${TablesColumnFile.mbusstype} ,"
        "${TablesColumnFile.mmanagerdetails} ,"
        "${TablesColumnFile.mcapital} ,"
        "${TablesColumnFile.mcostofgoodssold} ,"
        "${TablesColumnFile.moperationexpenditure} ,"
        "${TablesColumnFile.mnetprofit} ,"
        "${TablesColumnFile.misselfemp} ,"
        "${TablesColumnFile.mbuslocownership} ,"
        "${TablesColumnFile.msrcname} ,"
        "${TablesColumnFile.mprofession} ,"
        "${TablesColumnFile.mnoofempincmpny} ,"
        "${TablesColumnFile.myrsofexpinyrs} ,"
        "${TablesColumnFile.myrsofexpinmnths} ,"
        "${TablesColumnFile.mmobile} ,"
        "${TablesColumnFile.mstatusofemp} ,"
        "${TablesColumnFile.mtagtmrkt} ,"
        "${TablesColumnFile.mstrtgy} ,"
        "${TablesColumnFile.mbussprocss} ,"
        "${TablesColumnFile.mcomptrmekt} ,"
        "${TablesColumnFile.misprimarysrcincome} ,"
        "${TablesColumnFile.mcompanyname} ,"
        "${TablesColumnFile.mbussstatus} ,"
        "${TablesColumnFile.miscpemp} ,"
        "${TablesColumnFile.mrankofemp} ,"
        "${TablesColumnFile.mpercentage} )"
        "VALUES"
        "(${customerBusinessDetailsBean.tbussdetailsrefno} ,"
        "${customerBusinessDetailsBean.mbussdetailsrefno},"
        "${customerBusinessDetailsBean.trefno} ,"
        "${customerBusinessDetailsBean.mrefno} ,"
        "'${customerBusinessDetailsBean.mcusactivitytype}' ,"
        "'${customerBusinessDetailsBean.mbusinessname}' ,"
        "'${customerBusinessDetailsBean.mbusaddress1}' ,"
        "'${customerBusinessDetailsBean.mbusaddress2}' ,"
        "'${customerBusinessDetailsBean.mbusaddress3}' ,"
        "'${customerBusinessDetailsBean.mbusaddress4}' ,"
        "'${customerBusinessDetailsBean.mbuscity}' ,"
        "${customerBusinessDetailsBean.mdistcd} ,"
        "'${customerBusinessDetailsBean.mbusstate}' ,"
        "'${customerBusinessDetailsBean.mbuscountry}' ,"
        "${customerBusinessDetailsBean.mbusarea} ,"
        "${customerBusinessDetailsBean.mbusvillage} ,"
        "'${customerBusinessDetailsBean.mbuslandmark}',"
        "${customerBusinessDetailsBean.mbuspin} ,"
        "${customerBusinessDetailsBean.mbusyrsmnths},"
        "'${customerBusinessDetailsBean.mregisteredyn}',"
        "'${customerBusinessDetailsBean.mregistrationno}',"
        "'${customerBusinessDetailsBean.mbusothtomanageabsyn}',"
        "'${customerBusinessDetailsBean.mbusothmanagername}',"
        "${customerBusinessDetailsBean.mbusothmanagerrel},"
        "${customerBusinessDetailsBean.mbusmonthlyincome},"
        "'${customerBusinessDetailsBean.mbusseasonalityjan}',"
        "'${customerBusinessDetailsBean.mbusseasonalityfeb}',"
        "'${customerBusinessDetailsBean.mbusseasonalitymar}',"
        "'${customerBusinessDetailsBean.mbusseasonalityapr}',"
        "'${customerBusinessDetailsBean.mbusseasonalitymay}',"
        "'${customerBusinessDetailsBean.mbusseasonalityjun}',"
        "'${customerBusinessDetailsBean.mbusseasonalityjul}',"
        "'${customerBusinessDetailsBean.mbusseasonalityaug}',"
        "'${customerBusinessDetailsBean.mbusseasonalitysep}',"
        "'${customerBusinessDetailsBean.mbusseasonalityoct}',"
        "'${customerBusinessDetailsBean.mbusseasonalitynov}',"
        "'${customerBusinessDetailsBean.mbusseasonalitydec}',"
        "${customerBusinessDetailsBean.mbushighsales},"
        "${customerBusinessDetailsBean.mbusmediumsales},"
        "${customerBusinessDetailsBean.mbuslowsales},"
        "${customerBusinessDetailsBean.mbushighincome},"
        "${customerBusinessDetailsBean.mbusmediumincom},"
        "${customerBusinessDetailsBean.mbuslowincome},"
        "${customerBusinessDetailsBean.mbusmonthlytotaleval},"
        "${customerBusinessDetailsBean.mbusmonthlytotalverif},"
        "'${customerBusinessDetailsBean.mbusincludesurcalcyn}',"
        "'${customerBusinessDetailsBean
        .mbusnhousesameplaceyn}',"
        "'${customerBusinessDetailsBean.mbusinesstrend}',"
        "${customerBusinessDetailsBean.mmonthlyincome},"
        "${customerBusinessDetailsBean.mtotalmonthlyincome},"
        "${customerBusinessDetailsBean.mbusinessexpense},"
        "${customerBusinessDetailsBean.mhousehldexpense},"
        "${customerBusinessDetailsBean.mmonthlyemi},"
        "${customerBusinessDetailsBean.mincomeemiratio},"
        "${customerBusinessDetailsBean.mnetamount},"
        "'${customerBusinessDetailsBean.mposition}',"
        "'${customerBusinessDetailsBean.mdepartment}',"
        "'${customerBusinessDetailsBean.mempfrom}',"
        "'${customerBusinessDetailsBean.mempto}',"
        "${customerBusinessDetailsBean.mincomefromothrsrc},"
        "'${customerBusinessDetailsBean.mdateofincorporation}',"
        "${customerBusinessDetailsBean.mbusinessownerandshareholdingpercentage} ,"
        "${customerBusinessDetailsBean.mtotalmanpower} ,"
        "${customerBusinessDetailsBean.mtotalman} ,"
        "${customerBusinessDetailsBean.mtotalwomen} ,"
        "'${customerBusinessDetailsBean.mcompanycategory}' ,"
        "'${customerBusinessDetailsBean.mbusstype}' ,"
        "'${customerBusinessDetailsBean.mmanagerdetails} ',"
        "${customerBusinessDetailsBean.mcapital} ,"
        "${customerBusinessDetailsBean.mcostofgoodssold} ,"
        "${customerBusinessDetailsBean.moperationexpenditure} ,"
        "${customerBusinessDetailsBean.mnetprofit} ,"
        "'${customerBusinessDetailsBean.misselfemp}' ,"
        "${customerBusinessDetailsBean.mbuslocownership} ,"
        "'${customerBusinessDetailsBean.msrcname}' ,"
        "'${customerBusinessDetailsBean.mprofession}' ,"
        "${customerBusinessDetailsBean.mnoofempincmpny} ,"
        "${customerBusinessDetailsBean.myrsofexpinyrs} ,"
        "${customerBusinessDetailsBean.myrsofexpinmnths} ,"
        "'${customerBusinessDetailsBean.mmobile}' ,"
        "'${customerBusinessDetailsBean.mstatusofemp}' ,"
        "'${customerBusinessDetailsBean.mtagtmrkt}' ,"
        "'${customerBusinessDetailsBean.mstrtgy}' ,"
        "'${customerBusinessDetailsBean.mbussprocss}' ,"
        "'${customerBusinessDetailsBean.mcomptrmekt}' ,"
        "'${customerBusinessDetailsBean.misprimarysrcincome}' ,"
        "'${customerBusinessDetailsBean.mcompanyname}' ,"
        "'${customerBusinessDetailsBean.mbussstatus}' ,"
        "'${customerBusinessDetailsBean.miscpemp}' ,"
        "'${customerBusinessDetailsBean.mrankofemp}' ,"
        "${customerBusinessDetailsBean.mpercentage});";

    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationBorrowingMasterDetails}");
    });
    return idAfterInsert;
  }
/*
  Future<int> updateCustomerFoundationBusinessDetailsTableFromMiddleware(
      CustomerListBean custBussDetails) async {
    var db = await _getDb();
    print("details bean of business : " +
        custBussDetails.customerBusinessDetailsBean.toString());
    CustomerBusinessDetailsBean customerBusinessDetailsBean =
        custBussDetails.customerBusinessDetailsBean;
    // customerBusinessDetailsBean.tbussdetailsrefno=1;
    String insertQuery =
        "INSERT OR REPLACE INTO ${customerBusinessDetailMaster} "
        "(${TablesColumnFile.tbussdetailsrefno}  ,"
        "${TablesColumnFile.mbussdetailsrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcusactivitytype} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.mbusaddress1} ,"
        "${TablesColumnFile.mbusaddress2} ,"
        "${TablesColumnFile.mbusaddress3} ,"
        "${TablesColumnFile.mbusaddress4} ,"
        "${TablesColumnFile.mbuscity} ,"
        "${TablesColumnFile.mdistcd} ,"
        "${TablesColumnFile.mbusstate} ,"
        "${TablesColumnFile.mbuscountry} ,"
        "${TablesColumnFile.mbusarea} ,"
        "${TablesColumnFile.mbusvillage} ,"
        "${TablesColumnFile.mbuslandmark} ,"
        "${TablesColumnFile.mbuspin} ,"
        "${TablesColumnFile.mbusyrsmnths} ,"
        "${TablesColumnFile.mregisteredyn} ,"
        "${TablesColumnFile.mregistrationno} ,"
        "${TablesColumnFile.mbusothtomanageabsyn} ,"
        "${TablesColumnFile.mbusothmanagername} ,"
        "${TablesColumnFile.mbusothmanagerrel} ,"
        "${TablesColumnFile.mbusmonthlyincome} ,"
        "${TablesColumnFile.mbusseasonalityjan} ,"
        "${TablesColumnFile.mbusseasonalityfeb} ,"
        "${TablesColumnFile.mbusseasonalitymar} ,"
        "${TablesColumnFile.mbusseasonalityapr} ,"
        "${TablesColumnFile.mbusseasonalitymay} ,"
        "${TablesColumnFile.mbusseasonalityjun} ,"
        "${TablesColumnFile.mbusseasonalityjul} ,"
        "${TablesColumnFile.mbusseasonalityaug} ,"
        "${TablesColumnFile.mbusseasonalitysep} ,"
        "${TablesColumnFile.mbusseasonalityoct} ,"
        "${TablesColumnFile.mbusseasonalitynov} ,"
        "${TablesColumnFile.mbusseasonalitydec} ,"
        "${TablesColumnFile.mbushighsales} ,"
        "${TablesColumnFile.mbusmediumsales} ,"
        "${TablesColumnFile.mbuslowsales} ,"
        "${TablesColumnFile.mbushighincome} ,"
        "${TablesColumnFile.mbusmediumincom} ,"
        "${TablesColumnFile.mbuslowincome} ,"
        "${TablesColumnFile.mbusmonthlytotaleval} ,"
        "${TablesColumnFile.mbusmonthlytotalverif} ,"
        "${TablesColumnFile.mbusincludesurcalcyn} ,"
        "${TablesColumnFile.mbusnhousesameplaceyn} ,"
        "${TablesColumnFile.mbusinesstrend} )"
        "VALUES"
        "(${1} ,"
        "${customerBusinessDetailsBean.mbussdetailsrefno},"
        "${customerBusinessDetailsBean.trefno} ,"
        "${custBussDetails.mrefno} ,"
        "${customerBusinessDetailsBean.mcusactivitytype} ,"
        "'${customerBusinessDetailsBean.mbusinessname}' ,"
        "'${customerBusinessDetailsBean.mbusaddress1}' ,"
        "'${customerBusinessDetailsBean.mbusaddress2}' ,"
        "'${customerBusinessDetailsBean.mbusaddress3}' ,"
        "'${customerBusinessDetailsBean.mbusaddress4}' ,"
        "'${customerBusinessDetailsBean.mbuscity}' ,"
        "${customerBusinessDetailsBean.mdistcd} ,"
        "'${customerBusinessDetailsBean.mbusstate}' ,"
        "'${customerBusinessDetailsBean.mbuscountry}' ,"
        "${customerBusinessDetailsBean.mbusarea} ,"
        "${customerBusinessDetailsBean.mbusvillage} ,"
        "'${customerBusinessDetailsBean.mbuslandmark}',"
        "${customerBusinessDetailsBean.mbuspin} ,"
        "${customerBusinessDetailsBean.mbusyrsmnths},"
        "'${customerBusinessDetailsBean.mregisteredyn}',"
        "'${customerBusinessDetailsBean.mregistrationno}',"
        "'${customerBusinessDetailsBean.mbusothtomanageabsyn}',"
        "'${customerBusinessDetailsBean.mbusothmanagername}',"
        "${customerBusinessDetailsBean.mbusothmanagerrel},"
        "${customerBusinessDetailsBean.mbusmonthlyincome},"
        "'${customerBusinessDetailsBean.mbusseasonalityjan}',"
        "'${customerBusinessDetailsBean.mbusseasonalityfeb}',"
        "'${customerBusinessDetailsBean.mbusseasonalitymar}',"
        "'${customerBusinessDetailsBean.mbusseasonalityapr}',"
        "'${customerBusinessDetailsBean.mbusseasonalitymay}',"
        "'${customerBusinessDetailsBean.mbusseasonalityjun}',"
        "'${customerBusinessDetailsBean.mbusseasonalityjul}',"
        "'${customerBusinessDetailsBean.mbusseasonalityaug}',"
        "'${customerBusinessDetailsBean.mbusseasonalitysep}',"
        "'${customerBusinessDetailsBean.mbusseasonalityoct}',"
        "'${customerBusinessDetailsBean.mbusseasonalitynov}',"
        "'${customerBusinessDetailsBean.mbusseasonalitydec}',"
        "${customerBusinessDetailsBean.mbushighsales},"
        "${customerBusinessDetailsBean.mbusmediumsales},"
        "${customerBusinessDetailsBean.mbuslowsales},"
        "${customerBusinessDetailsBean.mbushighincome},"
        "${customerBusinessDetailsBean.mbusmediumincom},"
        "${customerBusinessDetailsBean.mbuslowincome},"
        "${customerBusinessDetailsBean.mbusmonthlytotaleval},"
        "${customerBusinessDetailsBean.mbusmonthlytotalverif},"
        "'${customerBusinessDetailsBean.mbusincludesurcalcyn}',"
        "'${customerBusinessDetailsBean.mbusnhousesameplaceyn}',"
        "'${customerBusinessDetailsBean.mbusinesstrend}');";

    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationBorrowingMasterDetails}");
    });
    return idAfterInsert;
  }*/


  //Insert Borrowing Basics details List start point
  Future<int> updateCustomerFoundationBorrowingDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int custtborref = 0;
    for (BorrowingDetailsBean item in custListBean.borrowingDetailsBean) {
      print("custListBean.borrowingDetailsBean");
      item.mrefno = custListBean.mrefno;
      custtborref++;
      item.tborrowingrefno = custtborref;
      id = await updateCustomerFoundationBorrowingDetailsTable(item);
    }
    return id;
  }
/*
// business and house hold expense detail
  Future<int> updateCustomerBusinessExpenseBeanTable(
      BusinessExpenditureDetailsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${businessExpenseMaster} "
        "(${TablesColumnFile.tbusinexpendrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mbusinexpenrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mbusinexpntype} ,"
        "${TablesColumnFile.mbusinevaluationamt} )"
        "VALUES"
        "(${bean.tbusinexpendrefno} ,"
        "${bean.trefno},"
        "${bean.mbusinexpenrefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "'${bean.mbusinexpntype}' ,"
        "${bean.mbusinevaluationamt}  );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${businessExpenseMaster}");
    });
    return idAfterInsert;
  }*/

/*
  Future<int> updateCustomerBusinessExpenseDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int businexpendrefno = 0;
    for (BusinessExpenditureDetailsBean item
    in custListBean.businessExpendDetailsList) {
      item.mrefno = custListBean.mrefno;
      businexpendrefno++;
      item.tbusinexpendrefno = businexpendrefno;
      id = await updateCustomerBusinessExpenseBeanTable(item);
    }
    return id;
  }
*/

 /* Future<int> updateCustomerHouseholdExpenseBeanTable(
      HouseholdExpenditureDetailsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${houseExpenseMaster} "
        "(${TablesColumnFile.thoushldexpendrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mhoushldexpenrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mhoushldexpntype} ,"
        "${TablesColumnFile.mhoushldevaluationamt} )"
        "VALUES"
        "(${bean.thoushldexpendrefno} ,"
        "${bean.trefno},"
        "${bean.mhoushldexpenrefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "'${bean.mhoushldexpntype}' ,"
        "${bean.mhoushldevaluationamt}  );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${houseExpenseMaster}");
    });
    return idAfterInsert;
  }*/

 /* Future<int> updateCustomerHouseholdExpenseDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int hhexpendrefno = 0;
    for (HouseholdExpenditureDetailsBean item
    in custListBean.householdExpendDetailsList) {
      item.mrefno = custListBean.mrefno;
      hhexpendrefno++;
      item.thoushldexpendrefno = hhexpendrefno;
      id = await updateCustomerHouseholdExpenseBeanTable(item);
    }
    return id;
  }*/

  Future<List<NewTermDepositBean>> selectTDListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&

        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${TermDepositMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile
        .mprdacctid} IS NULL'
        : 'SELECT * FROM ${TermDepositMaster} ; ';

    print(selectQueryIsDataSynced);
    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<NewTermDepositBean> listbean = new List<NewTermDepositBean>();
    NewTermDepositBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new NewTermDepositBean();
        bean = bindDataTDListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  NewTermDepositBean bindDataTDListBean(Map<String, dynamic> result) {
    NewTermDepositBean savingsListBean = new NewTermDepositBean();
    return NewTermDepositBean.fromMap(result);
  }

  Future<int> updateCustomerAssetBeanTable(AssetDetailsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${assetDetailMaster} "
        "(${TablesColumnFile.tassetdetrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.massetdetrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mitem} )"
        "VALUES"
        "(${bean.tassetdetrefno} ,"
        "${bean.trefno},"
        "${bean.massetdetrefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "${bean.mitem}  );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${assetDetailMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerAssetDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int assetrefno = 0;
    for (AssetDetailsBean item in custListBean.assetDetailsList) {
      item.mrefno = custListBean.mrefno;
      assetrefno++;
      item.tassetdetrefno = assetrefno;
      id = await updateCustomerAssetBeanTable(item);
    }
    return id;
  }

  Future<int> updateCustomerFixedAssetBeanTable(FixedAssetsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${fixedAssetMaster} "
        "(${TablesColumnFile.tfixedassetrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mfixedassetrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mland} ,"
        "${TablesColumnFile.mlandpresentamt} ,"
        "${TablesColumnFile.mlandnextmonthamount} ,"
        "${TablesColumnFile.mbuildng} ,"
        "${TablesColumnFile.mbuildngpresentamt} ,"
        "${TablesColumnFile.mbuildngnextmonthamount} ,"
        "${TablesColumnFile.mmachnryorequp} ,"
        "${TablesColumnFile.mmachnryorequppresentamt} ,"
        "${TablesColumnFile.mmachnryorequpnextmonthamount} ,"
        "${TablesColumnFile.mmeansandtransprt} ,"
        "${TablesColumnFile.mmeansandtransprtpresentamt} ,"
        "${TablesColumnFile.mmeansandtransprtnextmonthamount} ,"
        "${TablesColumnFile.mothrs} ,"
        "${TablesColumnFile.mothrspresentamt} ,"
        "${TablesColumnFile.mothrsnextmonthamount} ,"
        "${TablesColumnFile.msumpresentamt} ,"
        "${TablesColumnFile.mfromdate} ,"
        "${TablesColumnFile.mtodate} ,"
        "${TablesColumnFile.msumnextmonthamount} )"
        "VALUES"
        "(${bean.tfixedassetrefno} ,"
        "${bean.trefno},"
        "${bean.mfixedassetrefno},"
        "${bean.mrefno},"
        "${bean.mcustno},"
        "${bean.mland},"
        "${bean.mlandpresentamt},"
        "${bean.mlandnextmonthamount},"
        "${bean.mbuildng},"
        "${bean.mbuildngpresentamt},"
        "${bean.mbuildngnextmonthamount},"
        "${bean.mmachnryorequp},"
        "${bean.mmachnryorequppresentamt},"
        "${bean.mmachnryorequpnextmonthamount},"
        "${bean.mmeansandtransprt},"
        "${bean.mmeansandtransprtpresentamt},"
        "${bean.mmeansandtransprtnextmonthamount},"
        "${bean.mothrs},"
        "${bean.mothrspresentamt},"
        "${bean.mothrsnextmonthamount},"
        "${bean.msumpresentamt},"
        "'${bean.mfromdate}',"
        "'${bean.mtodate}',"
        "${bean.msumnextmonthamount}  );";
    print("insert query fixed asset master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${fixedAssetMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerFixedAssetListTable(
      CustomerListBean custListBean) async {
    int id;
    int assetrefno = 0;
    //for (FixedAssetsBean item in custListBean.fixedAssetsList) {
    //item.mrefno = custListBean.mrefno;
    assetrefno++;
    // item.tfixedassetrefno = assetrefno;
    if(custListBean.fixedAssetsList!=null) {
      id =
      await updateCustomerFixedAssetBeanTable(custListBean.fixedAssetsList);
    }

    return id;
  }

  Future<int> updateCustomerCurrentAssetBeanTable(CurrentAssetsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${currentAssetMaster} "
        "(${TablesColumnFile.tcurrentassetrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mcurrentassetrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcash} ,"
        "${TablesColumnFile.mcashpresentamt} ,"
        "${TablesColumnFile.mcashnextmonthamount} ,"
        "${TablesColumnFile.maccntrecvbl} ,"
        "${TablesColumnFile.maccntrecvblpresentamt} ,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} ,"
        "${TablesColumnFile.minventry} ,"
        "${TablesColumnFile.minventrypresentamt} ,"
        "${TablesColumnFile.minventrynextmonthamount} ,"
        "${TablesColumnFile.mprepaid} ,"
        "${TablesColumnFile.mprepaidpresentamt} ,"
        "${TablesColumnFile.mprepaidnextmonthamount} ,"
        "${TablesColumnFile.mothrs} ,"
        "${TablesColumnFile.mothrspresentamt} ,"
        "${TablesColumnFile.mothrsnextmonthamount} ,"
        "${TablesColumnFile.msumpresentamt} ,"
        "${TablesColumnFile.msumnextmonthamount} )"
        "VALUES"
        "(${bean.tcurrentassetrefno} ,"
        "${bean.trefno},"
        "${bean.mcurrentassetrefno},"
        "${bean.mrefno},"
        "${bean.mcustno},"
        "${bean.mcash},"
        "${bean.mcashpresentamt},"
        "${bean.mcashnextmonthamount},"
        "${bean.maccntrecvbl},"
        "${bean.maccntrecvblpresentamt},"
        "${bean.maccntrecvblnextmonthamount},"
        "${bean.minventry},"
        "${bean.minventrypresentamt},"
        "${bean.minventrynextmonthamount},"
        "${bean.mprepaid},"
        "${bean.mprepaidpresentamt},"
        "${bean.mprepaidnextmonthamount},"
        "${bean.mothrs},"
        "${bean.mothrspresentamt},"
        "${bean.mothrsnextmonthamount},"
        "${bean.msumpresentamt},"
        "${bean.msumnextmonthamount}  );";
    print("insert query current asset master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${currentAssetMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerCurrentAssetListTable(
      CustomerListBean custListBean) async {
    int id;
    int assetrefno = 0;
    // for (CurrentAssetsBean item in custListBean.currentAssetsList) {
    //  item.mrefno = custListBean.mrefno;
    //  assetrefno++;
    //  item.tcurrentassetrefno = assetrefno;
    if(custListBean.currentAssetsList!=null) {
      id =
      await updateCustomerCurrentAssetBeanTable(custListBean.currentAssetsList);
    }
    //  }
    return id;
  }

  Future<int> updateCustomerLongTermLiabilitiesBeanTable(LongTermLiabilitiesBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${longTermLiabilitiesMaster} "
        "(${TablesColumnFile.tlngtrmliabiltyrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mlngtrmliabiltyrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcash} ,"
        "${TablesColumnFile.mcashpresentamt} ,"
        "${TablesColumnFile.mcashnextmonthamount} ,"
        "${TablesColumnFile.maccntrecvbl} ,"
        "${TablesColumnFile.maccntrecvblpresentamt} ,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} ,"

        "${TablesColumnFile.msumpresentamt} ,"
        "${TablesColumnFile.msumnextmonthamount} )"
        "VALUES"
        "(${bean.tlngtrmliabiltyrefno} ,"
        "${bean.trefno},"
        "${bean.mlngtrmliabiltyrefno},"
        "${bean.mrefno},"
        "${bean.mcustno},"
        "${bean.mcash},"
        "${bean.mcashpresentamt},"
        "${bean.mcashnextmonthamount},"
        "${bean.maccntrecvbl},"
        "${bean.maccntrecvblpresentamt},"
        "${bean.maccntrecvblnextmonthamount},"
        "${bean.msumpresentamt},"
        "${bean.msumnextmonthamount}  );";
    print("insert query long term liability master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${longTermLiabilitiesMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerLongTermLiabilitiesListTable(
      CustomerListBean custListBean) async {
    int id;
    int liabilityrefno = 0;
    //for (LongTermLiabilitiesBean item in custListBean.longTermLiabilitiesList) {
    // item.mrefno = custListBean.mrefno;
    //liabilityrefno++;
    // item.tlngtrmliabiltyrefno = liabilityrefno;
    if(custListBean.longTermLiabilitiesList!=null) {
      id = await updateCustomerLongTermLiabilitiesBeanTable(
          custListBean.longTermLiabilitiesList);
    }
    //}
    return id;
  }

  Future<int> updateCustomerShortTermLiabilitiesBeanTable(ShortTermLiabilitiesBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${shortTermLiabilitiesMaster} "
        "(${TablesColumnFile.tshrttrmliabiltyrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mshrttrmliabiltyrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcash} ,"
        "${TablesColumnFile.mcashpresentamt} ,"
        "${TablesColumnFile.mcashnextmonthamount} ,"
        "${TablesColumnFile.maccntrecvbl} ,"
        "${TablesColumnFile.maccntrecvblpresentamt} ,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} ,"
        "${TablesColumnFile.mfield3} ,"
        "${TablesColumnFile.mfield3presentamt} ,"
        "${TablesColumnFile.mfield3nextmonthamount} ,"
        "${TablesColumnFile.mfield4} ,"
        "${TablesColumnFile.mfield4presentamt} ,"
        "${TablesColumnFile.mfield4nextmonthamount} ,"
        "${TablesColumnFile.msumpresentamt} ,"
        "${TablesColumnFile.msumnextmonthamount} )"
        "VALUES"
        "(${bean.tshrttrmliabiltyrefno} ,"
        "${bean.trefno},"
        "${bean.mshrttrmliabiltyrefno},"
        "${bean.mrefno},"
        "${bean.mcustno},"
        "${bean.mcash},"
        "${bean.mcashpresentamt},"
        "${bean.mcashnextmonthamount},"
        "${bean.maccntrecvbl},"
        "${bean.maccntrecvblpresentamt},"
        "${bean.maccntrecvblnextmonthamount},"
        "${bean.mfield3} ,"
        "${bean.mfield3presentamt} ,"
        "${bean.mfield3nextmonthamount} ,"
        "${bean.mfield4} ,"
        "${bean.mfield4presentamt} ,"
        "${bean.mfield4nextmonthamount} ,"
        "${bean.msumpresentamt},"
        "${bean.msumnextmonthamount}  );";
    print("insert query short term liability master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${shortTermLiabilitiesMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerShortTermLiabilitiesListTable(
      CustomerListBean custListBean) async {
    int id;
    int liabilityrefno = 0;
    //for (ShortTermLiabilitiesBean item in custListBean.shortTermLiabilitiesList) {
    // item.mrefno = custListBean.mrefno;
    //liabilityrefno++;
    // item.tshrttrmliabiltyrefno = liabilityrefno;
    if(custListBean.shortTermLiabilitiesList!=null) {
      id = await updateCustomerShortTermLiabilitiesBeanTable(
          custListBean.shortTermLiabilitiesList);
    }
    // }
    return id;
  }

  Future<int> updateCustomerEquityBeanTable(EquityBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${equityMaster} "
        "(${TablesColumnFile.tequityrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mequityrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcash} ,"
        "${TablesColumnFile.mcashpresentamt} ,"
        "${TablesColumnFile.mcashnextmonthamount} ,"
        "${TablesColumnFile.maccntrecvbl} ,"
        "${TablesColumnFile.maccntrecvblpresentamt} ,"
        "${TablesColumnFile.maccntrecvblnextmonthamount} ,"
        "${TablesColumnFile.msumpresentamt} ,"
        "${TablesColumnFile.msumnextmonthamount} )"
        "VALUES"
        "(${bean.tequityrefno} ,"
        "${bean.trefno},"
        "${bean.mequityrefno},"
        "${bean.mrefno},"
        "${bean.mcustno},"
        "${bean.mcash},"
        "${bean.mcashpresentamt},"
        "${bean.mcashnextmonthamount},"
        "${bean.maccntrecvbl},"
        "${bean.maccntrecvblpresentamt},"
        "${bean.maccntrecvblnextmonthamount},"
        "${bean.msumpresentamt},"
        "${bean.msumnextmonthamount}  );";
    print("insert query equity master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${equityMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerEquityListTable(
      CustomerListBean custListBean) async {
    int id;
    int equityrefno = 0;
    // for (EquityBean item in custListBean.equityList) {
    //  item.mrefno = custListBean.mrefno;
    //  equityrefno++;
    // item.tequityrefno = equityrefno;
    if(custListBean.equityList!=null) {
      id = await updateCustomerEquityBeanTable(custListBean.equityList);
    }
    // }
    return id;
  }

  Future<int> updateCustomerIncomeStatementBeanTable(CustomerListBean bean) async {
    var db = await _getDb();
    print("App Db insert income");
    String insertQuery = "INSERT OR REPLACE INTO ${incomeStatementMaster} "
        "(${TablesColumnFile.tincomerefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mincomerefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mtotalrevenuep} ,"
        "${TablesColumnFile.mtotalrevenuenm} ,"
        "${TablesColumnFile.mgrossprofitfirstp} ,"
        "${TablesColumnFile.mgrossprofitfirstnm} ,"
        "${TablesColumnFile.mrevenuefirstp} ,"
        "${TablesColumnFile.mrevenuefirstnm} ,"
        "${TablesColumnFile.mgoodcostfirstp} ,"
        "${TablesColumnFile.mgoodcostfirstnm} ,"
        "${TablesColumnFile.mgrossprofitsecondp} ,"
        "${TablesColumnFile.mgrossprofitsecondnm} ,"
        "${TablesColumnFile.mrevenuesecondp} ,"
        "${TablesColumnFile.mrevenuesecondnm} ,"
        "${TablesColumnFile.mgoodcostsecondp} ,"
        "${TablesColumnFile.mgoodcostsecondnm} ,"
        "${TablesColumnFile.motherrevenuep} ,"
        "${TablesColumnFile.motherrevenuenm} ,"
        "${TablesColumnFile.mtotalopexpp} ,"
        "${TablesColumnFile.mtotalopexpnm} ,"
        "${TablesColumnFile.mopexpfirstp} ,"
        "${TablesColumnFile.mopexpfirstnm} ,"
        "${TablesColumnFile.mpersonalexpfirstp} ,"
        "${TablesColumnFile.mpersonalexpfirstnm} ,"
        "${TablesColumnFile.mgeneralexpfirstp} ,"
        "${TablesColumnFile.mgeneralexpfirstnm} ,"
        "${TablesColumnFile.motherexpfirstp} ,"
        "${TablesColumnFile.motherexpfirstnm} ,"
        "${TablesColumnFile.mopexpsecondp} ,"
        "${TablesColumnFile.mopexpsecondnm} ,"
        "${TablesColumnFile.mpersonalexpsecondp} ,"
        "${TablesColumnFile.mpersonalexpsecondnm} ,"
        "${TablesColumnFile.mgeneralexpsecondp} ,"
        "${TablesColumnFile.mgeneralexpsecondnm} ,"
        "${TablesColumnFile.motherexpsecondp} ,"
        "${TablesColumnFile.motherexpsecondnm} ,"
        "${TablesColumnFile.mtaxexpp} ,"
        "${TablesColumnFile.mtaxexpnm} ,"
        "${TablesColumnFile.mnetincomep} ,"
        "${TablesColumnFile.mfromdate} ,"
        "${TablesColumnFile.mtodate} ,"
        "${TablesColumnFile.mnetincomenm} )"
        "VALUES"
        "(${bean.incomeStatementList.tincomerefno} ,"
        "${bean.incomeStatementList.trefno},"
        "${bean.incomeStatementList.mincomerefno},"
        "${bean.incomeStatementList.mrefno},"
        "${bean.incomeStatementList.mcustno},"
        "${bean.incomeStatementList.mtotalrevenuep},"
        "${bean.incomeStatementList.mtotalrevenuenm},"
        "${bean.incomeStatementList.mgrossprofitfirstp},"
        "${bean.incomeStatementList.mgrossprofitfirstnm},"
        "${bean.incomeStatementList.mrevenuefirstp},"
        "${bean.incomeStatementList.mrevenuefirstnm},"
        "${bean.incomeStatementList.mgoodcostfirstp},"
        "${bean.incomeStatementList.mgoodcostfirstnm},"
        "${bean.incomeStatementList.mgrossprofitsecondp},"
        "${bean.incomeStatementList.mgrossprofitsecondnm},"
        "${bean.incomeStatementList.mrevenuesecondp},"
        "${bean.incomeStatementList.mrevenuesecondnm},"
        "${bean.incomeStatementList.mgoodcostsecondp},"
        "${bean.incomeStatementList.mgoodcostsecondnm},"
        "${bean.incomeStatementList.motherrevenuep},"
        "${bean.incomeStatementList.motherrevenuenm},"
        "${bean.incomeStatementList.mtotalopexpp},"
        "${bean.incomeStatementList.mtotalopexpnm},"
        "${bean.incomeStatementList.mopexpfirstp},"
        "${bean.incomeStatementList.mopexpfirstnm},"
        "${bean.incomeStatementList.mpersonalexpfirstp},"
        "${bean.incomeStatementList.mpersonalexpfirstnm},"
        "${bean.incomeStatementList.mgeneralexpfirstp},"
        "${bean.incomeStatementList.mgeneralexpfirstnm},"
        "${bean.incomeStatementList.motherexpfirstp},"
        "${bean.incomeStatementList.motherexpfirstnm},"
        "${bean.incomeStatementList.mopexpsecondp},"
        "${bean.incomeStatementList.mopexpsecondnm},"
        "${bean.incomeStatementList.mpersonalexpsecondp},"
        "${bean.incomeStatementList.mpersonalexpsecondnm},"
        "${bean.incomeStatementList.mgeneralexpsecondp},"
        "${bean.incomeStatementList.mgeneralexpsecondnm},"
        "${bean.incomeStatementList.motherexpsecondp},"
        "${bean.incomeStatementList.motherexpsecondnm},"
        "${bean.incomeStatementList.mtaxexpp},"
        "${bean.incomeStatementList.mtaxexpnm},"
        "${bean.incomeStatementList.mnetincomep},"
        "'${bean.incomeStatementList.mfromdate}',"
        "'${bean.incomeStatementList.mtodate}',"
        "${bean.incomeStatementList.mnetincomenm}  );";
    print("insert query income statement master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${incomeStatementMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerFinancialStatementBeanTable(CustomerListBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${financialStatementMaster} "
        "(${TablesColumnFile.tfinancialstmntrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mfinancialstmntrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mgrossprofitmargin} ,"
        "${TablesColumnFile.mcurrentratio} ,"
        "${TablesColumnFile.mdebtratio} ,"
        "${TablesColumnFile.mtotcurasset} ,"
        "${TablesColumnFile.mtotcurliabilities} ,"
        "${TablesColumnFile.mworkngcapital} ,"
        "${TablesColumnFile.mavginventory} ,"
        "${TablesColumnFile.mavgaccreceivables} ,"
        "${TablesColumnFile.mavgaccpayables} ,"
        "${TablesColumnFile.mcogs} ,"
        "${TablesColumnFile.msales} ,"
        "${TablesColumnFile.mpurchases} ,"
        "${TablesColumnFile.minvconperiod} ,"
        "${TablesColumnFile.mrecconperiod} ,"
        "${TablesColumnFile.mpayconperiod} ,"
        "${TablesColumnFile.mworkngcapitalcycle} )"
        "VALUES"
        "(${bean.financialStmntList.tfinancialstmntrefno} ,"
        "${bean.financialStmntList.trefno},"
        "${bean.financialStmntList.mfinancialstmntrefno},"
        "${bean.financialStmntList.mrefno},"
        "${bean.financialStmntList.mcustno},"
        "${bean.financialStmntList.mgrossprofitmargin},"
        "${bean.financialStmntList.mcurrentratio},"
        "${bean.financialStmntList.mdebtratio},"
        "${bean.financialStmntList.mtotcurasset},"
        "${bean.financialStmntList.mtotcurliabilities},"
        "${bean.financialStmntList.mworkngcapital},"
        "${bean.financialStmntList.mavginventory},"
        "${bean.financialStmntList.mavgaccreceivables},"
        "${bean.financialStmntList.mavgaccpayables},"
        "${bean.financialStmntList.mcogs},"
        "${bean.financialStmntList.msales},"
        "${bean.financialStmntList.mpurchases},"
        "${bean.financialStmntList.minvconperiod},"
        "${bean.financialStmntList.mrecconperiod},"
        "${bean.financialStmntList.mpayconperiod},"
        "${bean.financialStmntList.mworkngcapitalcycle}  );";
    print("insert query financial statement master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${financialStatementMaster}");
    });
    return idAfterInsert;
  }

  //Insert ImageMaster
  Future updateImageMaster(ImageBean listImgBean, int tImagerefNo) async {
    var db = await _getDb();

    print(listImgBean.imgString.toString());
    String insertQuery = "INSERT OR REPLACE INTO ${imageMaster} "
        "( ${TablesColumnFile.tImgrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mImgrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.imageType}  ,"
        "${TablesColumnFile.imageSubType}  ,"
        "${TablesColumnFile.desc},"
        "${TablesColumnFile.imageString})"
        "VALUES"
        "(${tImagerefNo} ,"
        "${listImgBean.trefno} ,"
        "${listImgBean.mImgrefno} ,"
        "${listImgBean.mrefno} ,"
        "'${listImgBean.imgType}' ,"
        "'${listImgBean.imgSubType}' ,"
        "'${listImgBean.desc}' ,"
        "'${listImgBean.imgString}' );";

    print("insert query is ${insertQuery}");

    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${imageMaster}");
    });
  }

  //ends

  SavingsListBean bindDataSavingsListBean(Map<String, dynamic> result) {
    SavingsListBean savingsListBean = new SavingsListBean();
    return SavingsListBean.fromMap(result);
  }

  LoanUtilizationBean bindDataLoanUtilizationBean(Map<String, dynamic> result) {
    LoanUtilizationBean loanUtilizationBean = new LoanUtilizationBean();
    return LoanUtilizationBean.fromMap(result);
  }

  //Select Customer BindData
  CustomerListBean bindDataCustomerListBean(Map<String, dynamic> result) {
    CustomerListBean customerListBean = new CustomerListBean();
    return CustomerListBean.fromMap(result, false);
  }


  //Select Customer BindData After sync to server
  CustomerListBean bindDataSyncdCustomerListBean(Map<String, dynamic> result) {
    return CustomerListBean.fromMapMiddlewareFroMrefNoOnly(result, false);
  }

  Future<List<SavingsListBean>> selectSavingsList(int mcenterid, int mgroupid,
      int mcustno, int mprdcd) async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> n = new List<SavingsListBean>();
    var result;

    String seleQuery = "";

    if (mcustno != 0 && mcustno != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mcustno + " = " + mcustno.toString() }"
          "${mprdcd == 0||mprdcd == null? "":" AND "+TablesColumnFile.mprdcd+ " = " + mprdcd.toString()} "
          "${mcenterid == 0||mcenterid == null? "":" AND "+TablesColumnFile.mcenterid+ " = " + mcenterid.toString()}"
          "${mgroupid == 0||mgroupid == null? "":" AND "+TablesColumnFile.mgroupcd + " = " + mgroupid.toString() } "
          " AND ${TablesColumnFile.mprdacctid} IS NOT NULL AND ${TablesColumnFile.mprdacctid} <> '' AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    }

    else if (mprdcd != 0 && mprdcd != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mprdcd+ " = " + mprdcd.toString() }"
          "${mcustno == 0||mcustno == null? "":" AND "+TablesColumnFile.mcustno+ " = " + mcustno.toString()}"
          "${mcenterid == 0||mcenterid == null? "":" AND "+TablesColumnFile.mcenterid+ " = " + mcenterid.toString()}"
          "${mgroupid == 0||mgroupid == null? "":" AND "+TablesColumnFile.mgroupcd + " = " + mgroupid.toString() } "
          " AND ${TablesColumnFile.mprdacctid} IS NOT NULL AND ${TablesColumnFile.mprdacctid} <> ''  AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    }

    else if (mcenterid != 0 && mcenterid != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mprdcd == 0||mprdcd == null? "":" AND "+TablesColumnFile.mprdcd+ " = " + mprdcd.toString()}"
          "${mcustno == 0||mcustno == null? "":" AND "+TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mgroupid == 0||mgroupid == null? "":" AND "+TablesColumnFile.mgroupcd+ " = " + mgroupid.toString() } "
          " AND ${TablesColumnFile.mprdacctid} IS NOT NULL AND ${TablesColumnFile.mprdacctid} <> ''  AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    }
    else if (mgroupid != 0 && mgroupid != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mgroupcd + " = " + mgroupid.toString() }"
          "${mprdcd == 0||mprdcd == null? "":" AND "+TablesColumnFile.mprdcd+ " = " + mprdcd.toString()}"
          "${mcenterid == 0||mcenterid == null? "":" AND "+TablesColumnFile.mcenterid+ " = " + mcenterid.toString()}"
          "${mcustno == 0||mcustno == null? "":" AND "+TablesColumnFile.mcustno + " = " + mcustno.toString()  } "
          " AND ${TablesColumnFile.mprdacctid} IS NOT NULL AND ${TablesColumnFile.mprdacctid} <> ''  AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    }
    else{
      seleQuery = "Select * from ${savingsMaster} WHERE ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3";
    }

    result = await db.rawQuery(seleQuery);


    try {
      for (int i = 0; i < result.length; i++) {
        /*      print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);*/
        retBean = SavingsListBean.fromMap(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<SavingsListBean>> selectSavingsListForWithdrawl() async {
    var db = await _getDb();
    var result =
    // await db.rawQuery("SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.mcenterid}=$mcenterid OR ${TablesColumnFile.mgroupcd}=$mgroupid OR ${TablesColumnFile.mcustno}=${mcustno} AND ${TablesColumnFile.mprdcd}=${mprdcd.toString()} AND ${TablesColumnFile.mprdacctId} IS NOT NULL AND ${TablesColumnFile.mprdacctId} != 'null'");
    await db.rawQuery(
        "SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile
            .mprdacctid} IS NOT NULL AND ${TablesColumnFile
            .mprdacctid} != 'null'");

    var result1 = await db.rawQuery(
        "SELECT COUNT(*) FROM ${savingsMaster}  WHERE ${TablesColumnFile
            .mprdacctid} IS NOT NULL AND ${TablesColumnFile
            .mprdacctid} != 'null'");
    print("savings list count");
    print("result" + result.toString());
    print(result1);
    List<SavingsListBean> listbean = new List<SavingsListBean>();
    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        //print("result" + result[i].toString());
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Select CustomerList
  Future<List<CustomerListBean>> selectCustomerList() async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationMasterDetails} Order by ${TablesColumnFile
            .mlastupdatedt} DESC');
    var result1 = await db
        .rawQuery('SELECT COUNT(*) FROM ${customerFoundationMasterDetails}');
    print("customer count");
    print(result1);
    List<CustomerListBean> listbean = new List<CustomerListBean>();
    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        //print("result" + result[i].toString());
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Select SpeedoMeter BindData
  SpeedoMeterBean bindDataSpeedoMeterListBean(Map<String, dynamic> result) {
    SpeedoMeterBean speedoMeterBean = new SpeedoMeterBean();
    return SpeedoMeterBean.fromMap(result);
  }

  //Select SpeedoMeterList
  Future<List<SpeedoMeterBean>> selectSpeedoMeterList() async {
    var db = await _getDb();
    String query = 'SELECT * FROM ${speedoMeterMaster}';
    print(query);
    var result = await db.rawQuery(query);
    print(result);
    List<SpeedoMeterBean> listbean = new List<SpeedoMeterBean>();
    SpeedoMeterBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SpeedoMeterBean();
        bean = bindDataSpeedoMeterListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select single customer images
  Future<CustomerListBean> selectSingleCustomer(int loanTebRefno,
      int loanMrefno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationMasterDetails} where ${TablesColumnFile
            .trefno} = $loanTebRefno AND ${TablesColumnFile
            .mrefno} = $loanMrefno');

    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<ImageBean>> selectSingleCustomerImages(int loanTebRefno,
      int loanMrefno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${imageMaster} where ${TablesColumnFile
            .trefno} = $loanTebRefno AND ${TablesColumnFile
            .mrefno} = $loanMrefno');

    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<SavingsListBean>> selectSavingsCollectionListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${savingsCollectionMaster}  WHERE ${TablesColumnFile
        .mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${savingsCollectionMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<SavingsListBean> listbean = new List<SavingsListBean>();
    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<SavingsListBean>> selectSavingsListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    /*  ? 'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile.trefno}>0'
        : 'SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.trefno}>0 ';*/
        ? 'SELECT * FROM ${savingsMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${savingsMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<SavingsListBean> listbean = new List<SavingsListBean>();
    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }


  Future<List<LoanUtilizationBean>> selectLoanUtilListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    /*  ? 'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile.trefno}>0'
        : 'SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.trefno}>0 ';*/
        ? 'SELECT * FROM ${loanUtilizationMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${loanUtilizationMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<LoanUtilizationBean> listbean = new List<LoanUtilizationBean>();
    LoanUtilizationBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new LoanUtilizationBean();
        bean = bindLoanUtilizationBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select customer based on last synced date time
  Future<List<CustomerListBean>> selectCustomerListIsDataSynced(
      DateTime lastSyncDateTime) async {
    print("lastSyncDateTime");
    print(lastSyncDateTime);
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    //? 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        ? 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${customerFoundationMasterDetails}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<CustomerListBean> listbean = new List<CustomerListBean>();
    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }


  Future<LoanUtilizationBean> selectLoanUtilizationListOnUsername(
      String musername) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${loanUtilizationMaster}  WHERE  ${TablesColumnFile
        .musrname}  = "${musername}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    LoanUtilizationBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new LoanUtilizationBean();
        bean = bindDataLoanUtilizationBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<SavingsListBean> selectSavingsListOnTref(int trefno,
      String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //select customer based on Tref
  Future<List<CustomerListBean>> selectCustomerOnTref(int trefno,
      String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerListBean bean;
    List<CustomerListBean> beanList = new List<CustomerListBean>();
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataSyncdCustomerListBean(result[i]);
        beanList.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return beanList;
  }


  Future<CustomerListBean> selectCustomerOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    CustomerListBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<List<CustomerBusinessDetailsBean>> selectCustomerBussinessDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${customerBusinessDetailMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${customerBusinessDetailMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<CustomerBusinessDetailsBean> listbean = new List<CustomerBusinessDetailsBean>();
    CustomerBusinessDetailsBean bean;
    try {
      print("bussiness mai");
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerBusinessDetailsBean();
        bean = bindDataCustomerBussDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }


  //select FamilyList
  Future<List<FamilyDetailsBean>> selectCustomerFamilyDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${customerFoundationFamilyMasterDetails}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${customerFoundationFamilyMasterDetails}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<FamilyDetailsBean> listbean = new List<FamilyDetailsBean>();
    FamilyDetailsBean bean;
    try {
      print("family mai");
      for (int i = 0; i < result.length; i++) {
        bean = new FamilyDetailsBean();
        bean = bindDataCustomerFamilyDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }




  //select BankList
  Future<List<SocialFinancialDetailsBean>> selectCustomerBankDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${bankDetailsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${bankDetailsMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<SocialFinancialDetailsBean> listbean = new List<SocialFinancialDetailsBean>();
    SocialFinancialDetailsBean bean;
   // try {
      print("bank mai");
      for (int i = 0; i < result.length; i++) {
        bean = new SocialFinancialDetailsBean();
        bean = bindDataCustomerBankDetailsListBean(result[i]);
        listbean.add(bean);
      }
  /*  } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }*/
    return listbean;
  }



  // select household and business expenditure

/*
  Future<List<BusinessExpenditureDetailsBean>>
  selectCustomerBusinessExpenseListIsDataSynced(int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<BusinessExpenditureDetailsBean> listbean =
    new List<BusinessExpenditureDetailsBean>();
    BusinessExpenditureDetailsBean bean;
    try {
      print("business expenditure mai");
      for (int i = 0; i < result.length; i++) {
        bean = new BusinessExpenditureDetailsBean();
        bean = bindDataCustomerBusinessExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }
*/

 /* BusinessExpenditureDetailsBean bindDataCustomerBusinessExpenseListBean(
      Map<String, dynamic> result) {
    return BusinessExpenditureDetailsBean.fromMap(result);
  }*/

 /* Future<List<HouseholdExpenditureDetailsBean>>
  selectCustomerHouseholdExpenseListIsDataSynced(int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<HouseholdExpenditureDetailsBean> listbean =
    new List<HouseholdExpenditureDetailsBean>();
    HouseholdExpenditureDetailsBean bean;
    try {
      print("household expenditure mai");
      for (int i = 0; i < result.length; i++) {
        bean = new HouseholdExpenditureDetailsBean();
        bean = bindDataCustomerHouseholdExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }*/

/*  HouseholdExpenditureDetailsBean bindDataCustomerHouseholdExpenseListBean(
      Map<String, dynamic> result) {
    return HouseholdExpenditureDetailsBean.fromMap(result);
  }*/

  Future<List<AssetDetailsBean>> selectCustomerAssetDetailListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${assetDetailMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${assetDetailMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<AssetDetailsBean> listbean = new List<AssetDetailsBean>();
    AssetDetailsBean bean;
    try {
      print("asset detail mai");
      for (int i = 0; i < result.length; i++) {
        bean = new AssetDetailsBean();
        bean = bindDataCustomerAssetDetailListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  AssetDetailsBean bindDataCustomerAssetDetailListBean(
      Map<String, dynamic> result) {
    return AssetDetailsBean.fromMap(result);
  }

  Future<FixedAssetsBean> selectCustomerFixedAssetListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${fixedAssetMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${fixedAssetMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<FixedAssetsBean> listbean = new List<FixedAssetsBean>();
    FixedAssetsBean bean;
    try {
      print("inside fixed assset");
      for (int i = 0; i < result.length; i++) {
        bean = new FixedAssetsBean();
        bean = bindDataCustomerFixedAssetListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  FixedAssetsBean bindDataCustomerFixedAssetListBean(
      Map<String, dynamic> result) {
    return FixedAssetsBean.fromMap(result);
  }

  Future<CurrentAssetsBean> selectCustomerCurrentAssetListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${currentAssetMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${currentAssetMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<CurrentAssetsBean> listbean = new List<CurrentAssetsBean>();
    CurrentAssetsBean bean;
    try {
      print("inside current assset");
      for (int i = 0; i < result.length; i++) {
        bean = new CurrentAssetsBean();
        bean = bindDataCustomerCurrentAssetListBean(result[i]);

      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  CurrentAssetsBean bindDataCustomerCurrentAssetListBean(
      Map<String, dynamic> result) {
    return CurrentAssetsBean.fromMap(result);
  }

  Future<LongTermLiabilitiesBean> selectCustomerLongTermLiabilitiesListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${longTermLiabilitiesMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${longTermLiabilitiesMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<LongTermLiabilitiesBean> listbean = new List<LongTermLiabilitiesBean>();
    LongTermLiabilitiesBean bean;
    try {
      print("inside long term liability");
      for (int i = 0; i < result.length; i++) {
        bean = new LongTermLiabilitiesBean();
        bean = bindDataCustomerLongTermLiabilitiesListBean(result[i]);

      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  LongTermLiabilitiesBean bindDataCustomerLongTermLiabilitiesListBean(
      Map<String, dynamic> result) {
    return LongTermLiabilitiesBean.fromMap(result);
  }

  Future<ShortTermLiabilitiesBean> selectCustomerShortTermLiabilitiesListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${shortTermLiabilitiesMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${shortTermLiabilitiesMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<ShortTermLiabilitiesBean> listbean = new List<ShortTermLiabilitiesBean>();
    ShortTermLiabilitiesBean bean;
    try {
      print("inside short term liability");
      for (int i = 0; i < result.length; i++) {
        bean = new ShortTermLiabilitiesBean();
        bean = bindDataCustomerShortTermLiabilitiesListBean(result[i]);

      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  ShortTermLiabilitiesBean bindDataCustomerShortTermLiabilitiesListBean(
      Map<String, dynamic> result) {
    return ShortTermLiabilitiesBean.fromMap(result);
  }

  Future<EquityBean> selectCustomerEquityListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${equityMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${equityMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<EquityBean> listbean = new List<EquityBean>();
    EquityBean bean;
    try {
      print("inside equity");
      for (int i = 0; i < result.length; i++) {
        bean = new EquityBean();
        bean = bindDataCustomerEquityListBean(result[i]);
        //listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  EquityBean bindDataCustomerEquityListBean(
      Map<String, dynamic> result) {
    return EquityBean.fromMap(result);
  }

  Future<IncomeStatementBean> selectCustomerIncomeStatementListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${incomeStatementMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);

    IncomeStatementBean bean;
    try {
      print("inside income statement");
      for (int i = 0; i < result.length; i++) {
        bean = new IncomeStatementBean();
        print(result[i]);
        bean = bindDataCustomerIncomeStatementListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  IncomeStatementBean bindDataCustomerIncomeStatementListBean(
      Map<String, dynamic> result) {
    return IncomeStatementBean.fromMap(result);
  }

  Future<FinancialStmntBean> selectCustomerFinancialStatementListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${financialStatementMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);

    FinancialStmntBean bean;
    try {
      print("inside financial statement");
      for (int i = 0; i < result.length; i++) {
        bean = new FinancialStmntBean();
        print(result[i]);
        bean = bindDataCustomerFinancialStatementListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  FinancialStmntBean bindDataCustomerFinancialStatementListBean(
      Map<String, dynamic> result) {
    return FinancialStmntBean.fromMap(result);
  }

  //select Borrowing IsDataSynced
  Future<List<BorrowingDetailsBean>>
  selectCustomerBorrowingDetailsListIsDataSynced(int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${customerFoundationBorrowingMasterDetails}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<BorrowingDetailsBean> listbean = new List<BorrowingDetailsBean>();
    BorrowingDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new BorrowingDetailsBean();
        bean = bindDataCustomerBorrowingDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select AddressDetailsBean IsDataSynced
  Future<List<AddressDetailsBean>> selectCustomerAddressDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${customerFoundationAddressMasterDetails}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<AddressDetailsBean> listbean = new List<AddressDetailsBean>();
    AddressDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new AddressDetailsBean();
        bean = bindDataCustomerAddressDetailsBeanListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select ImagesMaster IsDataSynced
  Future<List<ImageBean>> selectImagesListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${imageMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindDataImagessListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select BusinessDetails IsDataSynced


  Future<List<CustomerBusinessDetailsBean>> selectCustomerBussinessDetails(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${customerBusinessDetailMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);
    List<CustomerBusinessDetailsBean> listbean = new List<CustomerBusinessDetailsBean>();
    CustomerBusinessDetailsBean bean;

    try {
      print("Business Details mai");
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerBusinessDetailsBean();
        print(result[i]);
        bean = bindDataCustomerBussDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Bind CustomerBusinessDetailsBean
  CustomerBusinessDetailsBean bindDataCustomerBussDetailsListBean(
      Map<String, dynamic> result) {
    return CustomerBusinessDetailsBean.fromMap(result);
  }

  //Bind ImageMaster
  ImageBean bindDataImagessListBean(Map<String, dynamic> result) {
    return ImageBean.fromMap(result);
  }

  FamilyDetailsBean bindDataCustomerFamilyDetailsListBean(
      Map<String, dynamic> result) {
    return FamilyDetailsBean.fromMap(result);
  }


  SocialFinancialDetailsBean bindDataCustomerBankDetailsListBean(
      Map<String, dynamic> result) {
    return SocialFinancialDetailsBean.fromMap(result);
  }

  //select FamilyMasterList
  Future<List<FamilyDetailsBean>> selectCustomerFamilyDetailsList(
      String customerNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationFamilyMasterDetails} WHERE customerNumberOfTab  = $customerNumber');

    List<FamilyDetailsBean> listbean = new List<FamilyDetailsBean>();
    FamilyDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new FamilyDetailsBean();
        bean = bindDataCustomerFamilyDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Bind BorrowingDetails
  BorrowingDetailsBean bindDataCustomerBorrowingDetailsListBean(
      Map<String, dynamic> result) {
    return BorrowingDetailsBean.fromMap(result);
  }

  //select BorrowingDetails
  Future<List<BorrowingDetailsBean>> selectCustomerBorrowingDetailsList(
      String customerNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationBorrowingMasterDetails} WHERE customerNumberOfTab  = $customerNumber');

    List<BorrowingDetailsBean> listbean = new List<BorrowingDetailsBean>();
    BorrowingDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new BorrowingDetailsBean();
        bean = bindDataCustomerBorrowingDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //bind Address
  AddressDetailsBean bindDataCustomerAddressDetailsBeanListBean(
      Map<String, dynamic> result) {
    return AddressDetailsBean.fromMap(result);
  }

  // select AddressDetailsBean
  Future<List<AddressDetailsBean>> selectCustomerAddressDetailsList(
      String customerNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationAddressMasterDetails} WHERE customerNumberOfTab  = $customerNumber');

    List<AddressDetailsBean> listbean = new List<AddressDetailsBean>();
    AddressDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new AddressDetailsBean();
        bean = bindDataCustomerAddressDetailsBeanListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //bind images
  ImageBean bindImageListBean(Map<String, dynamic> result) {
    return ImageBean.fromMap(result);
  }

  //select imageMaster
  Future<List<ImageBean>> selectImageList(String customerNumber,
      String type) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${imageMaster} WHERE customerNumberOfTab  = $customerNumber  AND imageSubType = '$type'");

    List<ImageBean> listBean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listBean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listBean;
  }

  Future updateSavingsMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${savingsMaster} SET ${query}");
    });
  }

  Future updateCustomerMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn
          .rawQuery("UPDATE ${customerFoundationMasterDetails} SET ${query}");
    });
  }

  Future updateFamily(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Family --- UPDATE ${customerFoundationFamilyMasterDetails} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${customerFoundationFamilyMasterDetails} SET ${query}");
    });
  }

  Future updateBank(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Family --- UPDATE ${bankDetailsMaster} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${bankDetailsMaster} SET ${query}");
    });
  }


  Future updateBorrowing(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Borrowing --- UPDATE ${customerFoundationBorrowingMasterDetails} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${customerFoundationBorrowingMasterDetails} SET ${query}");
    });
  }

  Future updateAddress(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Address --- UPDATE ${customerFoundationAddressMasterDetails} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${customerFoundationAddressMasterDetails} SET ${query}");
    });
  }

  Future updateBussinessDetail(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Business --- UPDATE ${customerBusinessDetailMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${customerBusinessDetailMaster} SET ${query}");
    });
  }

  Future updateImage(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Image --- UPDATE ${imageMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${imageMaster} SET ${query}");
    });
  }

  //customer ends here

  Future<List<CreditBereauBean>> getNonSmsVerifiedCreditMasterObjects() async {
    var db = await _getDb();
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> n = new List<CreditBereauBean>();
    var str = "${TablesColumnFile.motpverified} = 0";

    var result;

    print("query is" + "SELECT *  FROM $creditBereauMaster where ${str} ");
    result =
    await db.rawQuery('SELECT *  FROM $creditBereauMaster  where ${str};');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCreditBereauBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    print(n.length);
    return n;
  }

  CreditBereauBean bindCreditBereauBean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  Future<String> verifyCreditBereauSmsResult(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile
        .mrefno} = ${mrefNo}";

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Update $creditBereauMaster SET ${TablesColumnFile
            .motpverified} = 1 WHERE $str ');
    var result = await db.rawQuery(
        'Update $creditBereauMaster SET ${TablesColumnFile
            .motpverified} = 1 WHERE $str ');

    print("CreditBereauMaster Updated");
  }

  Future<String> updateCreditBereauSmsOTP(int contactNo, int OTP, int trefNo,
      int mrefNo, DateTime lastUpdateDate) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Update $creditBereauMaster SET ${TablesColumnFile
            .motp} = ${OTP},${TablesColumnFile
            .mlastupdatedt} = "${lastUpdateDate}" WHERE $str ');
    var result = await db.rawQuery(
        "Update $creditBereauMaster SET ${TablesColumnFile
            .motp} = ${OTP} ,${TablesColumnFile
            .mlastupdatedt} = '${lastUpdateDate}' WHERE $str ");

    print("CreditBereauMaster Updated");

    print(result.toString());
    return (result.toString());
  }

  Future updateTDMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn
          .rawQuery("UPDATE ${TermDepositMaster} SET ${query}");
    });
  }


  Future<NewTermDepositBean> selectTermDepositOnTref(int trefno,
      String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${TermDepositMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    NewTermDepositBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new NewTermDepositBean();
        bean = bindTermDepositListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  NewTermDepositBean bindTermDepositListBean(Map<String, dynamic> result) {
    NewTermDepositBean savingsListBean = new NewTermDepositBean();
    return NewTermDepositBean.fromMap(result);
  }

  Future<int> getSMSOTP(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile
        .mrefno} = ${mrefNo}  ";
    CreditBereauBean cbbbBean = new CreditBereauBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Select ${TablesColumnFile
            .motp} from ${creditBereauMaster} WHERE $str');
    var result = await db.rawQuery(
        'Select ${TablesColumnFile
            .motp} from ${creditBereauMaster} WHERE $str ');

    print("CreditBereauMaster Updated");

    try {
      if (result[0] != null) {
        return result[0][TablesColumnFile.motp];
      }

      print("going for check");
      return result[0]['check'];
    } catch (e) {
      print("inside catches");
      return null;
    }
  }

  Future<String> getCenterName(int mcenterid) async {
    var db = await _getDb();
    var result;

    print("query is" +
        "SELECT ${TablesColumnFile
            .mcentername}  FROM $centerDetailsMaster WHERE ${TablesColumnFile
            .mcenterid} = $mcenterid");
    result = await db.rawQuery(
        'SELECT ${TablesColumnFile
            .mcentername}  FROM $centerDetailsMaster WHERE ${TablesColumnFile
            .mcenterid} = $mcenterid;');

    print("getCenterName ${result}");

    try {
      if (result.length > 0) {
        return result[0]["mcentername"].toString();
      }

      return result[0]['check'];
    } catch (e) {
      print("inside catches");
      return null;
    }
  }

  Future<String> getGroupName(int mgroupcd) async {
    var db = await _getDb();
    var result;

    print("query is" +
        "SELECT ${TablesColumnFile
            .mgroupname}  FROM $groupFoundationMaster WHERE ${TablesColumnFile
            .mgroupid} = $mgroupcd");
    result = await db.rawQuery(
        'SELECT ${TablesColumnFile
            .mgroupname}  FROM $groupFoundationMaster WHERE ${TablesColumnFile
            .mgroupid} = $mgroupcd;');

    print("getCenterName ${result}");

    try {
      if (result.length > 0) {
        return result[0]["mgroupname"].toString();
      }

      return result[0]['check'];
    } catch (e) {
      print("inside catches");
      return null;
    }
  }

//customer formation code ends here

  Future<List<ProductBean>> getProductList(int moduleType,
      int branchCode,int isInd) async {
    var db = await _getDb();
    ProductBean retBean = new ProductBean();
    List<ProductBean> n = new List<ProductBean>();

    var result;
    //if(future!=null) {
    print("query is" +
        "SELECT *  FROM $productMaster WHERE ${TablesColumnFile
            .mmoduletype} = $moduleType AND ${TablesColumnFile
            .mlbrcode} = $branchCode");
    result = await db.rawQuery(
        'SELECT *  FROM $productMaster WHERE ${TablesColumnFile
            .mmoduletype} = $moduleType AND ${TablesColumnFile
            .mlbrcode} = $branchCode;');

    if(moduleType==30){
      if(isInd ==0) {
        result = await db.rawQuery(
            'SELECT *  FROM $productMaster WHERE ${TablesColumnFile
                .mmoduletype} = $moduleType AND ${TablesColumnFile
                .mlbrcode} = $branchCode AND ${TablesColumnFile
                .mdivisiontype} IN ("I","B");');
      }else{
        result = await db.rawQuery(
            'SELECT *  FROM $productMaster WHERE ${TablesColumnFile
                .mmoduletype} = $moduleType AND ${TablesColumnFile
                .mlbrcode} = $branchCode AND ${TablesColumnFile
                .mdivisiontype} IN ("G","B");');
      }
    }
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindProduct(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  ProductBean bindProduct(Map<String, dynamic> result) {
    return ProductBean.fromJson(result);
  }

//fo getting id type which is there in sublookup table (MIS D001107 )
  Future<List<LookupBeanData>> getFromSubLookupDataFromLocalDb(
      int codeType) async {
    var db = await _getDb();
    LookupBeanData retBean = new LookupBeanData();
    List<LookupBeanData> n = new List<LookupBeanData>();
    var result;

   // print("query is" + "SELECT *  FROM $SubLookupMaster ");
    result = await db.rawQuery(
        'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile
            .mcodetype},${TablesColumnFile.mcode},${TablesColumnFile
            .mfield1value} from ${SubLookupMaster} where ${TablesColumnFile
            .mcodetype} = $codeType ;');
    try {
      for (int i = 0; i < result.length; i++) {
  /*      print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }*/
        print(result[i].runtimeType);
        retBean = LookupBeanData.fromJson(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<SubLookupForSubPurposeOfLoan>>
  getSunPurposeOfLoanListFromSubLookpTable(int hardcodedValue,
      int position) async {
    var db = await _getDb();

    SubLookupForSubPurposeOfLoan retBean = new SubLookupForSubPurposeOfLoan();
    List<SubLookupForSubPurposeOfLoan> n =
    new List<SubLookupForSubPurposeOfLoan>();
    var result;
   // print("SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position}");

    result = await db.rawQuery(
        'SELECT *  FROM $SubLookupMaster where ${TablesColumnFile
            .mcodetype}  = ${hardcodedValue + position} Order by ${TablesColumnFile
            .mcode} DESC ;');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindPurposeOfLoan(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  SubLookupForSubPurposeOfLoan bindPurposeOfLoan(Map<String, dynamic> result) {
    return SubLookupForSubPurposeOfLoan.fromMap(result);
  }

  Future updateProductMaster(ProductBean prodObj) async {
    print("trying to insert or replace ${productMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${productMaster} ("
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdCd},"
        "${TablesColumnFile.mname},"
        "${TablesColumnFile.mintrate},"
        "${TablesColumnFile.mmoduletype},"
        "${TablesColumnFile.mcurCd},"
        "${TablesColumnFile.mnoofguaranter},"
        "${TablesColumnFile.mdivisiontype},"
        "${TablesColumnFile.mlastsynsdate})"
        "VALUES"
        "(${prodObj.productComposieEntity.mlbrcode},"
        "'${prodObj.productComposieEntity.mprdcd}',"
        "'${prodObj.mname}',"
        "${prodObj.mintrate},"
        "${prodObj.mmoduletype},"
        "'${prodObj.mcurCd}',"
        "${prodObj.mnoofguaranter},"
        "'${prodObj.mdivisiontype}',"
        "'${prodObj.mlastsynsdate}'"
        ");";

    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${productMaster}");
    });
  }

  Future<List<CustomerLoanDetailsBean>> getCustomerLoanDetails(int type) async {
    var db = await _getDb();
    CustomerLoanDetailsBean retBean = new CustomerLoanDetailsBean();
    List<CustomerLoanDetailsBean> loanDetailsList =
    new List<CustomerLoanDetailsBean>();
    /*String query =type=="LoanApp"? "SELECT *  FROM $customerLoanDetailsMaster":"SELECT *  FROM $customerLoanDetailsMaster WHERE ${TablesColumnFile.mleadstatus} = '${type}'";*/
    String query = type == 0
        ? "SELECT *  FROM $customerLoanDetailsMaster Order by ${TablesColumnFile
        .mlastupdatedt} DESC"
        : "SELECT *  FROM $customerLoanDetailsMaster WHERE ${TablesColumnFile
        .mleadstatus} = '${type}' Order by ${TablesColumnFile
        .mlastupdatedt} DESC";
    var result;

    print("query is" + "SELECT *  FROM $customerLoanDetailsMaster ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindCustomerLoanDetails(result[i]);
        loanDetailsList.add(retBean);
      }
    } catch (e) {

    }
    // await new Future.delayed(new Duration(seconds: 5));
    return loanDetailsList;
  }

  Future<List<CustomerLoanDetailsBean>> getCustomerLoanDetailsNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CustomerLoanDetailsBean retBean = new CustomerLoanDetailsBean();
    List<CustomerLoanDetailsBean> n = new List<CustomerLoanDetailsBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    //? 'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        ? 'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${customerLoanDetailsMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCustomerLoanDetails(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CustomerLoanDetailsBean bindCustomerLoanDetails(Map<String, dynamic> result) {
    return CustomerLoanDetailsBean.fromMap(result);
  }

/*  SavingsListBean bindSavingsList(Map<String, dynamic> result) {
    return SavingsListBean.fromMap(result);
  }*/
/*
  Future<List<SavingsListBean>> getSavingsListNotSynced() async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> n = new List<SavingsListBean>();
    var result;
    print("query is" +
        "SELECT *  FROM $savingsMaster where ${TablesColumnFile.isDataSynced}= 0 OR ${TablesColumnFile.isDataSynced} IS NULL ");
    result = await db.rawQuery(
        'SELECT *  FROM $savingsMaster where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} IS NULL;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindSavingsList(result[i]);
        print("exiting from map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }
*/

  Future<List<SpeedoMeterBean>> getSpeedoMeterDetailsNotSynced() async {
    var db = await _getDb();
    SpeedoMeterBean retBean = new SpeedoMeterBean();
    List<SpeedoMeterBean> n = new List<SpeedoMeterBean>();
    var result;
    print("query is" +
        "SELECT *  FROM $speedoMeterMaster where ${TablesColumnFile
            .isDataSynced}= 0 OR ${TablesColumnFile.isDataSynced} IS NULL ");
    result = await db.rawQuery(
        'SELECT *  FROM $speedoMeterMaster where ${TablesColumnFile
            .isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} IS NULL;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindSpeedoMeterDetails(result[i]);
        print("exiting from map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  SpeedoMeterBean bindSpeedoMeterDetails(Map<String, dynamic> result) {
    return SpeedoMeterBean.fromMap(result);
  }

  Future updateSavingsListIsDataSynced(DateTime mcreateddt,
      DateTime mlastupdatedt) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${savingsMaster} SET ${TablesColumnFile
              .isDataSynced} = '${1}' WHERE ${TablesColumnFile
              .mcreateddt} = '${mcreateddt}' AND ${TablesColumnFile
              .mlastupdatedt}='${mlastupdatedt}' ");
    });
  }

  Future updateSpeedometerIsDataSynced(String userName, DateTime dt) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${speedoMeterMaster} SET ${TablesColumnFile
              .isDataSynced} = '${1}' WHERE ${TablesColumnFile
              .usrName} = '${userName}' AND ${TablesColumnFile
              .effDate} = '${dt}'");
    });
  }

  Future<int> getMaxCustomerAccountNumber() async {
    print("trying to select last row  ${savingsMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${savingsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile
        .trefno})  FROM ${savingsMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  //Generate Customer Number of Tab
  Future<int> getMaxCustomerLoanNumber() async {
    String insertQuery = "SELECT *"
        "FROM    ${customerLoanDetailsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile
        .trefno})  FROM ${customerLoanDetailsMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  /*
  Future<CustomerLoanDetailsBean> getMaxCustomerLoanNumber() async {
    var db = await _getDb();
    var result;
    CustomerLoanDetailsBean custLoanObj = new CustomerLoanDetailsBean();
    print("entering database");
    try {

      result = await db.rawQuery(
          'SELECT max(${TablesColumnFile.trefno}) as loanNumber  FROM $customerLoanDetailsMaster ');

      print(result);
      var map = new Map();

      if (result[0] != null) {
        custLoanObj =
            CustomerLoanDetailsBean(trefno: result[0]['loanNumber']);
        if(custLoanObj.trefno==null){
          custLoanObj=null;
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
    return custLoanObj;
  }*/

  Future updateAll() async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${customerFoundationMasterDetails} SET ${TablesColumnFile
              .isDataSynced} = '${0}' ");
    });
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${imageMaster} SET ${TablesColumnFile
              .isDataSynced} = '${0}' ");
    });
  }

  Future<List<SavingsListBean>> getSavingsList() async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> n = new List<SavingsListBean>();
    var result;

    print("query saving wali" + "SELECT *  FROM $savingsCollectionMaster ");
    result = await db.rawQuery('select * from ${SavingsListBean} ');
    //  try {
    print("print data savings list" + result.toString());
    for (int i = 0; i < result.length; i++) {
      print("appdatabase " + result[i].toString());
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      print(result[i].runtimeType);
      //retBean = SavingsListBean.fromMap(result[i],null);
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }
    */
    return n;
  }

  Future<List<SettingsBean>> getApiUrl() async {
    var db = await _getDb();
    SettingsBean retBean = new SettingsBean();
    List<SettingsBean> n = new List<SettingsBean>();
    var result;

    print("query is jasja" + "SELECT *  FROM $settingsMaster ");
    result = await db.rawQuery('select * from ${settingsMaster} ');
    //  try {
    print("print data settings" + result.toString());
    for (int i = 0; i < result.length; i++) {
      print("appdatabase " + result[i].toString());
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      print(result[i].runtimeType);
      retBean = SettingsBean.fromJson(result[i]);
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }
    */
    return n;
  }

  Future<List<LookupBeanData>> getLookupDataFromLocalDb(int codeType) async {
    var db = await _getDb();
    LookupBeanData retBean = new LookupBeanData();
    List<LookupBeanData> n = new List<LookupBeanData>();
    var result;

    //print("query is" + "SELECT *  FROM $LookupMaster ");
    result = await db.rawQuery(
        'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile
            .mcodetype},${TablesColumnFile.mcode},${TablesColumnFile
            .mfield1value} from lookup_master where ${TablesColumnFile
            .mcodetype} = $codeType ORDER BY ${TablesColumnFile.mcodedesc} ;');
    try {
      for (int i = 0; i < result.length; i++) {
   /*     print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);*/
        retBean = LookupBeanData.fromJson(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future deletSomeUtil() async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${customerFoundationMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${imageMaster} ");
    });
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          "Delete FROM ${customerFoundationBorrowingMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn
          .rawDelete("Delete FROM ${customerFoundationAddressMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn
          .rawDelete("Delete FROM ${customerFoundationFamilyMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn
          .rawDelete("Delete FROM ${bankDetailsMaster} ");
    });
  }

  Future deletSomeLoanUtil() async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          "Delete FROM ${customerLoanDetailsMaster} Where loanNumber in (2,1,3)");
    });
  }

  Future<String> getImageStringPath(String imageString) async {
    print("image String is ${imageString}");
    if (imageString != null &&
        imageString != "null" &&
        imageString.trim() != "") {
      Uint8List bytes = base64.decode(imageString);
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath =
          '${extDir.path}/Pictures/eco_los/syncedNOCImage';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${timestamp()}.jpg';
      File file = new File(filePath);

      await file.writeAsBytes(bytes);
      return filePath;
    }

    return "";
  }

  Future insertStaticTablesLastSyncedMaster(
      List<LastSyncedDateTime> staticValues, int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${TablesColumnFile
            .id} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile
            .id} = $idValue');
    bool isInsert = false;
    int id;
    try {
      if (result[0][TablesColumnFile.id].toString() != null) {
        id = result[0][TablesColumnFile.id];
        isInsert = true;
      }
    } catch (_) {
      print("exception here ");
    }

    print("trying to insert or replace ${lastSyncedDateTimeMaster}");
    if (!isInsert) {
      for (int i = 0; i < staticValues.length; i++) {
        String insertQuery =
            "INSERT OR REPLACE INTO ${lastSyncedDateTimeMaster}  "
            "(${TablesColumnFile.id},"
            "${TablesColumnFile.tTabelDesc},"
            "${TablesColumnFile.tlastSyncedFromTab},"
            "${TablesColumnFile.tlastSyncedToTab})"
            "VALUES "
            "("
            "${staticValues[i].id},"
            "'${staticValues[i].tTabelDesc}',"
            "'${staticValues[i].tlastSyncedFromTab}',"
            "'${staticValues[i].tlastSyncedToTab}'); ";

        await db.transaction((Transaction txn) async {
          int id = await txn.rawInsert(insertQuery);
        });
      }
    }
  }

  Future<DateTime> selectStaticTablesLastSyncedMaster(int idValue,
      bool toMiddleware) async {
    print("trying toinsert or replace $idValue");
    String selectQuery = toMiddleware
        ? 'SELECT ${TablesColumnFile
        .tlastSyncedToTab} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile
        .id} = $idValue'
        : 'SELECT ${TablesColumnFile
        .tlastSyncedFromTab} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile
        .id} = $idValue';
    var db = await _getDb();
    var result = await db.rawQuery(selectQuery);

    try {
      if (result[0].length > 0 && toMiddleware
          ? result[0][TablesColumnFile.tlastSyncedToTab].toString() != null
          : result[0][TablesColumnFile.tlastSyncedFromTab].toString() != null) {
        return DateTime.parse(toMiddleware
            ? result[0][TablesColumnFile.tlastSyncedToTab]
            : result[0][TablesColumnFile.tlastSyncedFromTab]);
      }
    } catch (_) {
      print("exception here ");
    }
  }

  Future<Null> updateStaticTablesLastSyncedMaster(int idValue) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "UPDATE ${lastSyncedDateTimeMaster} SET ${TablesColumnFile
            .tlastSyncedFromTab} = '${DateTime.now()}' WHERE ${TablesColumnFile
            .id} = ${idValue}");

    var result1 =
    await db.rawQuery('SELECT * FROM ${lastSyncedDateTimeMaster}');
    print("query -- updateStaticTablesLastSyncedMaster");
    print(result1.toString());
    // try {
    /* if (result[0][TablesColumnFile.tlastSyncedFromTab].toString() != null) {
      //return DateTime.parse(result[0][TablesColumnFile.tlastSyncedFromTab]);
    }*/
    /*} catch (_) {
    print("exception here ");
  }*/
  }

  Future<Null> updateStaticTablesLastSyncedMasterGetFromServer(int idValue,
      DateTime updateDateimeAfterUpdate) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "UPDATE ${lastSyncedDateTimeMaster} SET ${TablesColumnFile
            .tlastSyncedToTab} = '${updateDateimeAfterUpdate}' WHERE ${TablesColumnFile
            .id} = ${idValue}");

    print(result);
    var result1 =
    await db.rawQuery('SELECT * FROM ${lastSyncedDateTimeMaster}');
    print("query -- updateStaticTablesLastSyncedMaster");
    print(result1.toString());
  }

  Future deletSomeSyncingActivityFromOmni(String forWhat) async {
    var db = await _getDb();
    String deleteQueryFor = "";
    if (forWhat == 'Center') {
      deleteQueryFor = "Delete FROM ${centerDetailsMaster}";
    } else if (forWhat == 'Group') {
      deleteQueryFor = "Delete FROM ${groupFoundationMaster}";
    } else if (forWhat == 'Lookup') {
      deleteQueryFor = "Delete FROM ${LookupMaster}";
    } else if (forWhat == 'SubLookup') {
      deleteQueryFor = "Delete FROM ${SubLookupMaster}";
    } else if (forWhat == 'Product') {
      deleteQueryFor = "Delete FROM ${productMaster}";
    } else if (forWhat == 'Collection') {
      deleteQueryFor = "Delete FROM ${collectionMaster}";
    } else if (forWhat == 'Loan_Cycle_Parameter_Secondary_Master') {
      deleteQueryFor = "Delete FROM ${LoanCycleParameterSecondaryMaster}";
    } else if (forWhat == 'Loan_Cycle_Parameter_Primary_Master') {
      deleteQueryFor = "Delete FROM ${LoanCycleParameterPrimaryMaster}";
    } else if (forWhat == 'Interest_Offset_Master') {
      deleteQueryFor = "Delete FROM ${InterestOffsetMaster}";
    } else if (forWhat == 'Interest_Slab_Master') {
      deleteQueryFor = "Delete FROM ${InterestSlabMaster}";
    } else if (forWhat == 'collectedLoansAmtMaster') {
      deleteQueryFor = "Delete FROM ${collectedLoansAmtMaster}";
    } else if (forWhat == 'SystemParameterMaster') {
      deleteQueryFor = "Delete FROM ${SystemParameterMaster}";
    } else if (forWhat == 'Loan_Approval_limit_Master') {
      deleteQueryFor = "Delete FROM ${loanApprovalLimitMaster}";
    }else if (forWhat == 'Branch_Master') {
      deleteQueryFor = "Delete FROM ${branchMaster}";
    }else if (forWhat == 'TD_Productwise_interest_table') {
      deleteQueryFor = "Delete FROM ${TDProductwiseInterestTable}";
    }else if (forWhat == 'TD_Offset_Interest_Master') {
      deleteQueryFor = "Delete FROM ${TDOffsetInterestMaster}";
    }else if (forWhat == 'Get_Hbs_Users') {
      deleteQueryFor = "Delete FROM ${GETHBSUSERS}";
    }
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(deleteQueryFor);
    });
  }

  Future<double> selectSlabIntRate(String prdCode, String mcurcd,
      double appliedAmout, int mlbrCd, int installment, int loanCycle) async {
    String selectSlabRoiQuery =
    'SELECT   ${TablesColumnFile.mintrate} FROM ${InterestSlabMaster} WHERE '
        '${TablesColumnFile.mprdcd} = "${prdCode}"  AND ${TablesColumnFile.mcurcd} = "${mcurcd}" '
        'AND ${TablesColumnFile.minteffdt} = (SELECT max(${TablesColumnFile.minteffdt}) FROM '
        '${InterestSlabMaster} WHERE ${TablesColumnFile.mprdcd} = "${prdCode}" AND ${TablesColumnFile.mcurcd}'
        ' = "${mcurcd}") AND  ${TablesColumnFile.mmonths} >= $installment AND ${TablesColumnFile.mtoamt} >= $appliedAmout  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';
    print(selectSlabRoiQuery);
    try {
      double salbInt = 0.0;
      var db = await _getDb();
      var result = await db.rawQuery(selectSlabRoiQuery);
      if (result.length > 0 && result[0] != null) {
        salbInt = result[0][TablesColumnFile.mintrate];
      }

      String selectOffsetRoiQuery =
          'SELECT  ${TablesColumnFile.mintrestrate} FROM ${InterestOffsetMaster} WHERE '
          '${TablesColumnFile.mlbrcode} = "${mlbrCd}" AND ${TablesColumnFile.mprdCd} = $prdCode AND '
          '${TablesColumnFile.mloantype} = 1 AND ${TablesColumnFile.mloancycle} = $loanCycle   AND '
          '${TablesColumnFile.meffdate} = (SELECT max(${TablesColumnFile.meffdate}) FROM '
          '${InterestOffsetMaster} WHERE ${TablesColumnFile.mlbrcode} = ${mlbrCd} AND '
          '${TablesColumnFile.mprdcd} = "$prdCode" AND ${TablesColumnFile.mloantype} = 1 AND '
          '${TablesColumnFile.mloancycle} = $loanCycle)   AND ${TablesColumnFile.mmonths} >= $installment AND '
          '${TablesColumnFile.mamount} >= $appliedAmout  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

      print("selectSlabRoiQuery " + selectSlabRoiQuery.toString());
      print("selectOffsetRoiQuery " + selectOffsetRoiQuery.toString());

      double offsetInt = 0.0;
      result = await db.rawQuery(selectOffsetRoiQuery);
      print("print data " + result.toString());
      if (result.length > 0 && result[0] != null) {
        offsetInt = result[0][TablesColumnFile.mintrestrate];
      } else {
        selectOffsetRoiQuery =
        'SELECT  ${TablesColumnFile.mintrestrate} FROM ${InterestOffsetMaster} WHERE '
            '${TablesColumnFile.mlbrcode} = "${mlbrCd}" AND ${TablesColumnFile.mprdCd} = $prdCode AND '
            '${TablesColumnFile.mloantype} = 1 AND ${TablesColumnFile.mloancycle} = 99   AND '
            '${TablesColumnFile.meffdate} = (SELECT max(${TablesColumnFile.meffdate}) FROM '
            '${InterestOffsetMaster} WHERE ${TablesColumnFile.mlbrcode} = ${mlbrCd} AND '
            '${TablesColumnFile.mprdcd} = "$prdCode" AND ${TablesColumnFile.mloantype} = 1 AND '
            '${TablesColumnFile.mloancycle} = 99)   AND ${TablesColumnFile.mmonths} >= $installment AND '
            '${TablesColumnFile.mamount} >= $appliedAmout  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

        result = await db.rawQuery(selectOffsetRoiQuery);

        print("selectOffsetRoiQuery99 " + selectOffsetRoiQuery.toString());

        if (result.length > 0 && result[0] != null) {
          offsetInt = result[0][TablesColumnFile.mintrestrate];
        }
      }

      return salbInt + (offsetInt);
    } catch (_) {
      print("exception here ");
    }
  }

  void bubbleSortAlgo(List<InterestSlabBean> interestSlabBean) {
    int mainListLength = interestSlabBean.length;
    for (int firstElement = 0;
    firstElement < mainListLength - 1;
    firstElement++)
      for (int compareNext = 0;
      compareNext < mainListLength - firstElement - 1;
      compareNext++)
        if (interestSlabBean[compareNext].mtoamt >
            interestSlabBean[compareNext + 1].mtoamt &&
            interestSlabBean[compareNext]
                .minteffdt
                .isAfter(interestSlabBean[compareNext + 1].minteffdt)) {
          // swap arr[j+1] and arr[i]
          InterestSlabBean temp = interestSlabBean[compareNext];
          interestSlabBean[compareNext] = interestSlabBean[compareNext + 1];
          interestSlabBean[compareNext + 1] = temp;
        }
  }

  Future<DateTime> selectlastSyncedDateTimeToTab(int idValue) async {
    print("trying fetch  $idValue");
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${TablesColumnFile
            .tlastSyncedToTab} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile
            .id} = $idValue');

    try {
      if (result[0][TablesColumnFile.tlastSyncedToTab] != null &&
          result[0][TablesColumnFile.tlastSyncedToTab] != 'null') {
        return DateTime.parse(result[0][TablesColumnFile.tlastSyncedToTab]);
      } else {
        print("Returning null");
        return null;
      }
    } catch (_) {
      print("exception here ");
    }
  }

  Future<CreditBereauBean> checkTrefMref(int trefNo, int mrefNo) async {
    CreditBereauBean bean;
    var db = await _getDb();
    String query =
        'SELECT *  FROM ${creditBereauMaster} where ${TablesColumnFile
        .trefno} = $trefNo And '
        '${TablesColumnFile.mrefno} = $mrefNo';

    print(query);
    var result = await db.rawQuery(query);

    print("result");

    try {
      print("Credit Bereau me");
      if (result.isNotEmpty) {
        bean = bindCreditBereauBean(result[0]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }

    return bean;
  }

  Future updateCreditBereauMasterMrefFromTref(CreditBereauBean cbb, int trefNo,
      int mrefNo, DateTime mlastSynsDate, bool alreadyExist) async {
    var db = await _getDb();
    var str = alreadyExist == true
        ? " ${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile
        .mrefno} = ${mrefNo}"
        : " ${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile
        .mrefno} = 0";

    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mrefno} = ${mrefNo} "
        ",${TablesColumnFile.mlastsynsdate} = '$mlastSynsDate' WHERE $str";
    print(" heyyy update query is $query");

    var result = await db.rawQuery(query);

    print("CreditBereauMaster Updated");
  }

  Future updateCreditBereauMasterlstUpdtDate(DateTime lastSynsDate, int trefNo,
      int mrefNo) async {
    var db = await _getDb();
    var str =
        " ${TablesColumnFile.trefno} = $trefNo AND ${TablesColumnFile
        .mrefno} = $mrefNo";

    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mrefno} = ${mrefNo} "
        ",${TablesColumnFile.mlastsynsdate} = '$lastSynsDate' WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("CreditBereauMaster Updated For ABM ");
  }

  Future updatelastSyncDateTimeMasterFromTab(DateTime lastSyncedFromTab,
      int id) async {
    var db = await _getDb();
    var str = "${TablesColumnFile.id} = $id";

    String query =
        "Update $lastSyncedDateTimeMaster SET ${TablesColumnFile
        .tlastSyncedFromTab} = '$lastSyncedFromTab' "
        " WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("last Synced Master Updated ");
  }

  Future updatelastSyncDateTimeMasterToTab(DateTime tLastSyncedToTab,
      int id) async {
    var db = await _getDb();
    var str = "${TablesColumnFile.id} = $id";

    String query =
        "Update $lastSyncedDateTimeMaster SET ${TablesColumnFile
        .tlastSyncedToTab} = '$tLastSyncedToTab' "
        " WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("last Synced To Tab  Master Updated ");
  }

  Future updateCreditBereauLoanDetailsForImage(
      CbResultBean creditBereauResultBean, int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${creditBereauLoanDetailsMaster}( "
        "${TablesColumnFile.trefno}  ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.mrefsrno}  ,"
        "${TablesColumnFile.trefsrno}  ,"
        "${TablesColumnFile.maccounttype}  ,"
        "${TablesColumnFile.mcurrentbalance}  ,"
        "${TablesColumnFile.mcustbankacnum}  ,"
        "${TablesColumnFile.mdatereported}  ,"
        "${TablesColumnFile.mdisbursedamount}  ,"
        "${TablesColumnFile.mnameofmfi}  ,"
        "${TablesColumnFile.mnocimagestring}  ,"
        "${TablesColumnFile.moverdueamount}  ,"
        "${TablesColumnFile.mwriteoffamount}"
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.mrefsrno}, "
        "${trefsrno} ,"
        "'${creditBereauResultBean.maccounttype}' ,"
        "${creditBereauResultBean.mcurrentbalance} ,"
        "'${creditBereauResultBean.mcustbankacnum}' ,"
        "'${creditBereauResultBean.mdatereported}' ,"
        "${creditBereauResultBean.mdisbursedamount} ,"
        "'${creditBereauResultBean.mnameofmfi}' ,"
        "'${await getImageStringPath(
        creditBereauResultBean.mnocimagestring)}' ,"
        "${creditBereauResultBean.moverdueamount} ,"
        "${creditBereauResultBean.mwriteoffamount} "
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${creditBereauLoanDetailsMaster}");
    });
  }

  Future updateCreditBereauLoanDetailsTrefSrNo(
      CbResultBean creditBereauResultBean, int trefsrno,
      bool alreadyExist) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery;


    if (alreadyExist == false) {
      insertQuery =
      "Update ${creditBereauLoanDetailsMaster}  SET ${TablesColumnFile
          .mrefsrno} =  ${creditBereauResultBean.mrefsrno},"
          "${TablesColumnFile.mrefno} = ${creditBereauResultBean.mrefno}"
          " WHERE ${TablesColumnFile.trefno} = ${creditBereauResultBean
          .trefno}  AND "
          " ${TablesColumnFile.mrefno} =  0 "
          "AND ${TablesColumnFile.trefsrno} =  ${trefsrno}"
          ";";
    }
    else {
      insertQuery =
      "Update ${creditBereauLoanDetailsMaster}  SET ${TablesColumnFile
          .mrefsrno} =  ${creditBereauResultBean.mrefsrno}"
          " WHERE ${TablesColumnFile.trefno} = ${creditBereauResultBean
          .trefno}  AND "
          " ${TablesColumnFile.mrefno} = ${creditBereauResultBean.mrefno} "
          " AND ${TablesColumnFile.trefsrno} =  ${trefsrno}"
          ";";
    }

    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${creditBereauLoanDetailsMaster}");
    });
  }

  Future searchMrefTref(int mrefno, int trefno) async {
    String searchQuery =
        "SELECT * FROM ${creditBereauMaster} WHERE ${TablesColumnFile
        .mrefno} = ${mrefno}  "
        "AND ${TablesColumnFile.trefno} = $trefno";

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(searchQuery);
      print(id.toString() +
          " Search query after ${creditBereauLoanDetailsMaster}");
    });
  }

  Future updateCrdtBreuMastrPrspctStatus(int trefNo, int mrefNo,
      int prospectStatus, DateTime mlastUpdatedt, DateTime lastSynsDate) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";
    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mprospectstatus} "
        "= ${prospectStatus} , ${TablesColumnFile.mlastsynsdate} "
        "= '${lastSynsDate}',${TablesColumnFile
        .mlastupdatedt} = '$mlastUpdatedt' WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("CreditBereauMaster Updated");
  }

  Future trialrun(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";
    String query1 = "delete from  $creditBereauResultMaster "
        "where ${TablesColumnFile.trefno}  = $trefNo AND  ${TablesColumnFile
        .mrefno} = ${mrefNo} ";
    String query2 = "delete from  $creditBereauLoanDetailsMaster "
        "where ${TablesColumnFile.trefno}  = $trefNo AND  ${TablesColumnFile
        .mrefno} = ${mrefNo} ";

    String query3 =
        "update ${creditBereauMaster} set ${TablesColumnFile
        .misuploaded} = 0  ,"
        "${TablesColumnFile.mrefno} = 0  ,${TablesColumnFile
        .mlastsynsdate} = '${DateTime.now()}',"
        "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' "
        "where ${TablesColumnFile.trefno}  = $trefNo";
    print("xxxxxxxxxxxxxxquery is here : " + query1);
    var result = await db.rawQuery(query1);
    result = await db.rawQuery(query2);
    result = await db.rawQuery(query3);
    print("CreditBereauMaster Updated");
  }

  Future updateCreditBereauResultTrefSrNo(CbResultBean creditBereauResultBean,
      int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "Update ${creditBereauResultMaster}  SET ${TablesColumnFile
        .mrefno} =  ${creditBereauResultBean.mrefno}"
        " WHERE ${TablesColumnFile.trefno} = ${creditBereauResultBean
        .trefno}  AND "
        " ${TablesColumnFile.mrefno} = 0"
        ";";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${creditBereauResultMaster}");
    });
  }

  /*Future updateWithDelCreditBereauResult(CbResultBean creditBereauResultBean) async {
    print("trying to insert or replace ${creditBereauResultMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${creditBereauResultMaster} ("
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.trefresultsrno} ,"
        "${TablesColumnFile.mrefresultsrno} ,"
        "${TablesColumnFile.mcbcheckstatus} ,"
        "${TablesColumnFile.mdateofissue} ,"
        "${TablesColumnFile.mdateofrequest} ,"
        "${TablesColumnFile.miscustomercreated} ,"
        "${TablesColumnFile.mpreparedfor} ,"
        "${TablesColumnFile.mreportid} ,"
        "${TablesColumnFile.mothrmficnt},"
        "${TablesColumnFile.mloancycle},"
        "${TablesColumnFile.mothrmficurbal} ,"
        "${TablesColumnFile.mothrmfiovrdueamt} ,"
        "${TablesColumnFile.mothrmfidisbamt},"
        "${TablesColumnFile.mtotovrdueaccno} ,"
        "${TablesColumnFile.mmfitotdisbamt} ,"
        "${TablesColumnFile.mmfitotcurrentbal},"
        "${TablesColumnFile.mmfitotovrdueamt} ,"
        "${TablesColumnFile.mtotovrdueamt} ,"
        "${TablesColumnFile.mtotcurrentbal},"
        "${TablesColumnFile.mtotdisbamt}  ,"
        "${TablesColumnFile.mexpsramt}  ,"
        "${TablesColumnFile.mcreateddt} "
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.trefresultsrno} ,"
        "${creditBereauResultBean.mrefresultsrno} ,"
        "'${creditBereauResultBean.mcbcheckstatus}' ,"
        "'${creditBereauResultBean.mdateofissue}' ,"
        "'${creditBereauResultBean.mdateofrequest}' ,"
        "'${creditBereauResultBean.miscustomercreated}' ,"
        "'${creditBereauResultBean.mpreparedfor}' ,"
        "'${creditBereauResultBean.mreportid}' ,"
        "${creditBereauResultBean.mothrmficnt},"
        "${creditBereauResultBean.mloancycle},"
        "${creditBereauResultBean.mothrmficurbal} ,"
        "${creditBereauResultBean.mothrmfiovrdueamt},"
        "${creditBereauResultBean.mothrmfidisbamt},"
        "${creditBereauResultBean.mtotovrdueaccno},"
        "${creditBereauResultBean.mmfitotdisbamt},"
        "${creditBereauResultBean.mmfitotcurrentbal},"
        "${creditBereauResultBean.mmfitotovrdueamt},"
        "${creditBereauResultBean.mtotovrdueamt},"
        "${creditBereauResultBean.mtotcurrentbal},"
        "${creditBereauResultBean.mtotdisbamt},"
        "${creditBereauResultBean.mexpsramt},"
        "'${creditBereauResultBean.mcreateddt}'"
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }


    String delQuery = "Delete FROM ${creditBereauResultMaster} WHERE  ${TablesColumnFile.trefno} = ${creditBereauResultBean.trefno}"
        "AND ${TablesColumnFile.mrefno} = 0   ";



    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(

      id.toString() + "xxx ida fter insert in ${creditBereauResultMaster}");
    });

    try {
      await db.rawQuery(delQuery);
    }catch(_){
      print("No object Found");
    }
  }*/

  Future<int> getMinMrefNoCreditBereauMaster(int trefNo) async {
    int minMref;

    var db = await _getDb();
    var str = "${TablesColumnFile.trefno} = ${trefNo} ";
    String query =
        "SELECT MIN(${TablesColumnFile.mrefno}) AS ${TablesColumnFile.mrefno} "
        "FROM  $creditBereauMaster  WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    try {
      var result = await db.rawQuery(query);
      print(result);
      minMref = result[0][TablesColumnFile.mrefno];
    } catch (_) {
      print("returning null");
    }

    return minMref;
  }

  Future updateCreditBereauMasterMrefFromminMref(CreditBereauBean cbb,
      int trefNo, int mrefNo, DateTime mlastSynsDate) async {
    var db = await _getDb();
    var str =
        " ${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile
        .mrefno} = 0";

    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mrefno} = ${mrefNo} "
        ", ${TablesColumnFile.mprospectstatus} = ${cbb.mprospectstatus} "
        " ,  ${TablesColumnFile.mlastupdatedt} = '${cbb.mlastupdatedt}'"
        ",  ${TablesColumnFile.mlastupdateby} = '${cbb.mlastupdateby}'"
        ",${TablesColumnFile.mlastsynsdate} = '$mlastSynsDate' WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("CreditBereauMaster Updated");
  }

/*
  Future updateCreditBereauLoanImageWithLoanSeq(
      CbResultBean creditBereauResultBean, int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${creditBereauLoanDetailsMaster}( "
        "${TablesColumnFile.trefno}  ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.mrefsrno}  ,"
        "${TablesColumnFile.trefsrno}  ,"
        "${TablesColumnFile.maccounttype}  ,"
        "${TablesColumnFile.mcurrentbalance}  ,"
        "${TablesColumnFile.mcustbankacnum}  ,"
        "${TablesColumnFile.mdatereported}  ,"
        "${TablesColumnFile.mdisbursedamount}  ,"
        "${TablesColumnFile.mnameofmfi}  ,"
        "${TablesColumnFile.mnocimagestring}  ,"
        "${TablesColumnFile.moverdueamount}  ,"
        "${TablesColumnFile.mwriteoffamount}"
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.mrefsrno}, "
        "${trefsrno} ,"
        "'${creditBereauResultBean.maccounttype}' ,"
        "${creditBereauResultBean.mcurrentbalance},"
        "'${creditBereauResultBean.mcustbankacnum}' ,"
        "'${creditBereauResultBean.mdatereported}' ,"
        "${creditBereauResultBean.mdisbursedamount} ,"
        "'${creditBereauResultBean.mnameofmfi}' ,"
        "'${creditBereauResultBean.mnocimagestring}' ,"
        "${creditBereauResultBean.moverdueamount} ,"
        "${creditBereauResultBean.mwriteoffamount}"
        ");";
    print("insert query is" + insertQuery);


}
*/

  //select CGT1 based on Tref
  Future<CGT1Bean> selectCGT1OnTref(int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CGT1Master}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CGT1Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT1Bean();
        bean = bindDataCGT1ListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateCGT1MasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT1Master} SET ${query}");
    });
  }

  Future updateCGT1QAMasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${cgt1QaMaster} SET ${query}");
    });
  }

  Future<CGT2Bean> selectCGT2OnTref(int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CGT2Master}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CGT2Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT2Bean();
        bean = bindDataCGT2ListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateCGT2MasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT2Master} SET ${query}");
    });
  }

  Future updateCGT2QAMasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${cgt2QaMaster} SET ${query}");
    });
  }

  Future<GRTBean> selectGRTOnTref(int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${GRTMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    GRTBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GRTBean();
        bean = bindDataGRTListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateGRTMasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${GRTMaster} SET ${query}");
    });
  }

  Future updateGRTQAMasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${grtQaMaster} SET ${query}");
    });
  }

  Future updateCG1WhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT1Master} SET ${query}");
    });
  }

  Future updateCG2WhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT2Master} SET ${query}");
    });
  }

  Future updateGRTWhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${GRTMaster} SET ${query}");
    });
  }

/*  //select FamilyList
  Future<List<HouseholdExpenditureDetailsBean>>
  selectCustomerHouseHoldExpDetailsListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<HouseholdExpenditureDetailsBean> listbean =
    new List<HouseholdExpenditureDetailsBean>();
    HouseholdExpenditureDetailsBean bean;
    try {
      print("family mai");
      for (int i = 0; i < result.length; i++) {
        bean = new HouseholdExpenditureDetailsBean();
        bean = bindDataCustomerHouseholdExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }*/

 /* //select FamilyList
  Future<List<BusinessExpenditureDetailsBean>>
  selectCustomerBussHoldExpDetailsListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile
            .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<BusinessExpenditureDetailsBean> listbean =
    new List<BusinessExpenditureDetailsBean>();
    BusinessExpenditureDetailsBean bean;
    try {
      print("family mai");
      for (int i = 0; i < result.length; i++) {
        bean = new BusinessExpenditureDetailsBean();
        bean = bindDataCustomerBusinessExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }*/

  Future updateBussExpDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Business Expense --- UPDATE ${businessExpenseMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${businessExpenseMaster} SET ${query}");
    });
  }

  Future updateHouseHolddExpDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Borrowing --- UPDATE ${houseExpenseMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${houseExpenseMaster} SET ${query}");
    });
  }

  Future updateHouseHoldExpDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Household Expense --- UPDATE ${houseExpenseMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${houseExpenseMaster} SET ${query}");
    });
  }

  Future updateAssetDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Asset Detail --- UPDATE ${assetDetailMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${assetDetailMaster} SET ${query}");
    });
  }

  Future updateFixedAsset(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Fixed Asset Detail --- UPDATE ${fixedAssetMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${fixedAssetMaster} SET ${query}");
    });
  }

  Future updateCurrentAsset(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Current Asset Detail --- UPDATE ${currentAssetMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${currentAssetMaster} SET ${query}");
    });
  }

  Future updateLongTermLiabilities(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Long Term Liability Detail --- UPDATE ${longTermLiabilitiesMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${longTermLiabilitiesMaster} SET ${query}");
    });
  }

  Future updateShortTermLiabilities(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Short Term Liability Detail --- UPDATE ${shortTermLiabilitiesMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${shortTermLiabilitiesMaster} SET ${query}");
    });
  }

  Future updateEquity(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Equity Detail --- UPDATE ${equityMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${equityMaster} SET ${query}");
    });
  }

  Future updateIncomeStatement(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Income Statement Detail --- UPDATE ${incomeStatementMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${incomeStatementMaster} SET ${query}");
    });
  }

  Future updateFinancialStatement(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Financial Statement Detail --- UPDATE ${financialStatementMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${financialStatementMaster} SET ${query}");
    });
  }


  Future updateCreditBereauMasterisCuCrtd(String mpanNo, String imdDesc,
      int iscustCretedFlag, int custNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.mpanno} = '${mpanNo}' OR ${TablesColumnFile
        .mpanno} = '${imdDesc}' OR "
        "${TablesColumnFile.mid1desc} = '${mpanNo}' OR ${TablesColumnFile
        .mid1desc} = '${imdDesc}'";
    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.miscustcreated} "
        "= ${iscustCretedFlag}"
        ", ${TablesColumnFile.mcustno}  = ${custNo}"
        " WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print(result);
    print("CreditBereauMaster Updated");
  }

  Future<CustomerListBean> custTrefMrefFromId(String mpanNo,
      String mid1) async {
    var db = await _getDb();
    CustomerListBean bean;
    var str =
        "${TablesColumnFile.mpannodesc} = '${mpanNo}' OR ${TablesColumnFile
        .mpannodesc} = '${mid1}' OR "
        "${TablesColumnFile.mIdDesc} = '${mpanNo}' OR ${TablesColumnFile
        .mIdDesc} = '${mid1}'";
    String query =
        "SELECT * FROM ${customerFoundationMasterDetails}  where $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("customer Foundation mater select query");

    try {
      bean = new CustomerListBean();
      bean = bindDataCustomerListBean(result[0]);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<StateDropDownList> getState(stateCd) async {
    var db = await _getDb();
    StateDropDownList bean;
    var str = "${TablesColumnFile.stateCd} = '${stateCd}' ";
    String query = "SELECT * FROM ${stateMaster}  where $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    try {
      print(result[0].runtimeType);
      bean = bindStateDropDownBean(result[0]);
    } catch (e) {
      print(e.toString());
    }
    return bean;
  }

  Future<DistrictDropDownList> getdist(distCd) async {
    var db = await _getDb();
    DistrictDropDownList bean;
    var str = "${TablesColumnFile.distCd} = '${distCd}' ";
    String query = "SELECT * FROM ${districtMaster}  where $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    try {
      print(result[0].runtimeType);
      bean = bindDistrictDropDownBean(result[0]);
    } catch (e) {
      print(e.toString());
    }
    return bean;
  }

  Future<CustomerListBean> updateCustHighRprtDate(String mpanNo, String mid1,
      double expsrAmt, DateTime mcbcheckrprtdt, int cbCheckStat) async {
    var db = await _getDb();
    CustomerListBean bean;
    var str =
        "${TablesColumnFile.mpannodesc} = '${mpanNo}' OR ${TablesColumnFile
        .mpannodesc} = '${mid1}' OR "
        "${TablesColumnFile.mIdDesc} = '${mpanNo}' OR ${TablesColumnFile
        .mIdDesc} = '${mid1}'";
    String query = "UPDATE ${customerFoundationMasterDetails} SET "
        "${TablesColumnFile.mexpsramt} = $expsrAmt "
        ",${TablesColumnFile.misCbCheckDone} = $cbCheckStat"
        ",${TablesColumnFile.mcbcheckrprtdt} = '$mcbcheckrprtdt' "
        "WHERE $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("customer Foundation mater update query");

    return bean;
  }

  Future<String> getQuesDesc(int mcodetype, String mitem) async {
    var db = await _getDb();

    var result;
    LookupBeanData bean;
    print("query is" +
        "select * from  ${LookupMaster} where ${TablesColumnFile
            .mcodetype} =  $mcodetype AND ${TablesColumnFile
            .mcode} = '${mitem}' ");
    await db.transaction((Transaction txn) async {
      result = await txn.rawQuery(
          "select * from  ${LookupMaster} where ${TablesColumnFile
              .mcodetype} =  $mcodetype AND ${TablesColumnFile
              .mcode} = '${mitem}' ");
    });

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        bean = LookupBeanData.fromJson(result[i]);
        break;
      }
    } catch (e) {
      print(e.toString());
    }
    return bean != null && bean.mcodedesc != null && bean.mcodedesc != 'null'
        ? bean.mcodedesc
        : "";
  }

  Future<String> getAnswerDesc(int mcodetype, String mitem) async {
    var db = await _getDb();
    var result;
    LookupBeanData bean;
    print("query is" +
        "select * from  ${SubLookupMaster} where ${TablesColumnFile
            .mcodetype} =  $mcodetype AND ${TablesColumnFile
            .mcode} = '${mitem}' ");
    await db.transaction((Transaction txn) async {
      result = await txn.rawQuery(
          "select * from  ${SubLookupMaster} where ${TablesColumnFile
              .mcodetype} =  $mcodetype AND ${TablesColumnFile
              .mcode} = '${mitem}' ");
    });

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        bean = LookupBeanData.fromJson(result[i]);
        break;
      }
    } catch (e) {
      print(e.toString());
    }
    return bean != null && bean.mcodedesc != null && bean.mcodedesc != 'null'
        ? bean.mcodedesc
        : "";
  }

  Future<CreditBereauBean> getLastProspectFromId(String mpanNo,
      String mid1) async {
    var db = await _getDb();
    CreditBereauBean bean;
    var str =
        "${TablesColumnFile.mpanno} = '${mpanNo}' OR ${TablesColumnFile
        .mpanno} = '${mid1}' OR "
        "${TablesColumnFile.mid1desc} = '${mpanNo}' OR ${TablesColumnFile
        .mid1desc} = '${mid1}'";
    String query = "SELECT * FROM ${creditBereauMaster}  where $str  "
        "ORDER BY ${TablesColumnFile.mcreateddt} DESC ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("Credit Bereau Master updated");

    try {
      bean = bindCreditBereauBean(result[0]);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //collection master

  Future<List<CollectionMasterBean>> getCollectionMasterDataFromLocalDb(
      int mcenterid,
      int mgroupid,
      DateTime fromDate,
      DateTime toDate,
      int mcustno,
      int mprdcd,
      bool memOfGrpYN) async {
    var db = await _getDb();
    CollectionMasterBean retBean = new CollectionMasterBean();
    List<CollectionMasterBean> n = new List<CollectionMasterBean>();
    var result;

    String seleQuery = "";

    if (mcustno != 0 && mcustno != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mcustno + " = " + mcustno.toString() }"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " +
          TablesColumnFile.mprdcd + " = " + mprdcd.toString()} "
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " +
          TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " +
          TablesColumnFile.mgroupid + " = " + mgroupid.toString()} ";
      "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind +
          " <> 'Y'"} ; ";
    }

    else if (mprdcd != 0 && mprdcd != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mprdcd + " = " + mprdcd.toString() }"
          "${mcustno == 0 || mcustno == null ? "" : " AND " +
          TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " +
          TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " +
          TablesColumnFile.mgroupid + " = " + mgroupid.toString()} ";
      "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind +
          " <> 'Y'"} ; ";
    }

    else if (mcenterid != 0 && mcenterid != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " +
          TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " +
          TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " +
          TablesColumnFile.mgroupid + " = " + mgroupid.toString() }  ";
      "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind +
          " <> 'Y'"} ; ";
    }
    else if (mgroupid != 0 && mgroupid != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mgroupid + " = " + mgroupid.toString() }"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " +
          TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " +
          TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " +
          TablesColumnFile.mcustno + " = " + mcustno.toString()} "
          "${memOfGrpYN == true ? "" : " AND " +
          TablesColumnFile.mappliedasind + " <> 'Y'"} ; ";
    }


    if (memOfGrpYN != null && memOfGrpYN == false) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mappliedasind + " = 'Y'" }"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " +
          TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " +
          TablesColumnFile.mcustno + " = " + mcustno.toString()} ; ";
    }

    print("seleQuery" + seleQuery);
    if (seleQuery != null && seleQuery != "") {
      result = await db.rawQuery(seleQuery);
    }

    try {
      if (result.length > 0 && result[0] != null) {
        for (int i = 0; i < result.length; i++) {
          retBean = CollectionMasterBean.fromMap(result[i]);
          n.add(retBean);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future createCollectionInsert(
      CollectionMasterBean collectionMasterBean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${collectionMaster} "
        "(${TablesColumnFile.masondate} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.macctstat} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupid} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mfocode} ,"
        "${TablesColumnFile.mleadsid} ,"
        "${TablesColumnFile.mloancycle} ,"
        "${TablesColumnFile.midealbaldate} ,"
        "${TablesColumnFile.modamt} ,"
        "${TablesColumnFile.memiamt} ,"
        "${TablesColumnFile.mcurrentdue} ,"
        "${TablesColumnFile.midealbal} ,"
        "${TablesColumnFile.memino} ,"
        "${TablesColumnFile.mexpdate} ,"
        "${TablesColumnFile.mexpprnpaid} ,"
        "${TablesColumnFile.mexpintpaid} ,"
        "${TablesColumnFile.mpaidprn} ,"
        "${TablesColumnFile.mpaidint} ,"
        "${TablesColumnFile.mprnos} ,"
        "${TablesColumnFile.mintos} ,"
        "${TablesColumnFile.mclosint} ,"
        "${TablesColumnFile.mappliedasind} ,"
        "${TablesColumnFile.mcreateddt} , "
        "${TablesColumnFile.mcreatedby} , "
        "${TablesColumnFile.mlastupdatedt} , "
        "${TablesColumnFile.mlastupdateby} , "
        "${TablesColumnFile.mgeolocation} , "
        "${TablesColumnFile.mgeolatd} , "
        "${TablesColumnFile.mgeologd} , "
        "${TablesColumnFile.mprdcd} , "
        "${TablesColumnFile.mfrequency} , "
        "${TablesColumnFile.mlongname} , "
        "${TablesColumnFile.mlastopendate} , "
        "${TablesColumnFile.mexcesspaid} ,"
        "${TablesColumnFile.msdbal} ,"
        "${TablesColumnFile.malmeffdate} )"
        "VALUES"
        "('${collectionMasterBean.masondate} ',"
        "${collectionMasterBean.mlbrcode} ,"
        "'${collectionMasterBean.mprdacctid}' ,"
        "${collectionMasterBean.macctstat} ,"
        "${collectionMasterBean.mcenterid} ,"
        "${collectionMasterBean.mgroupid} ,"
        "${collectionMasterBean.mcustno} ,"
        "'${collectionMasterBean.mfocode}' ,"
        "'${collectionMasterBean.mleadsid}' ,"
        "${collectionMasterBean.mloancycle} ,"
        "'${collectionMasterBean.midealbaldate}' ,"
        "${collectionMasterBean.modamt} ,"
        "${collectionMasterBean.memiamt} ,"
        "${collectionMasterBean.mcurrentdue} ,"
        "${collectionMasterBean.midealbal} ,"
        "${collectionMasterBean.memino} ,"
        "'${collectionMasterBean.mexpdate} ',"
        "${collectionMasterBean.mexpprnpaid} ,"
        "${collectionMasterBean.mexpintpaid} ,"
        "${collectionMasterBean.mpaidprn} ,"
        "${collectionMasterBean.mpaidint} ,"
        "${collectionMasterBean.mprnos} ,"
        "${collectionMasterBean.mintos} ,"
        "${collectionMasterBean.mclosint} ,"
        "'${collectionMasterBean.mappliedasind}' ,"
        "'${collectionMasterBean.mcreateddt}' ,"
        "'${collectionMasterBean.mcreatedby}' ,"
        "'${collectionMasterBean.mlastupdatedt}' ,"
        "'${collectionMasterBean.mlastupdateby}',"
        "'${collectionMasterBean.mgeolocation}' ,"
        "'${collectionMasterBean.mgeolatd}' ,"
        "'${collectionMasterBean.mgeologd}' ,"
        "'${collectionMasterBean.mprdcd}' ,"
        "'${collectionMasterBean.mfrequency}' ,"
        "'${collectionMasterBean.mlongname}' ,"
        "'${collectionMasterBean.mlastopendate}' ,"
        "${collectionMasterBean.mexcesspaid} ,"
        "${collectionMasterBean.msdbal} ,"
        "'${collectionMasterBean.malmeffdate}' );";

    await db.transaction((Transaction txn) async {
      var id = await txn.rawInsert(insertQuery);
    });
  }

  Future createCollectedAmtInsert(
      CollectionMasterBean collectionMasterBean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${collectedLoansAmtMaster} "
        "(${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupid} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mfocode} ,"
        "${TablesColumnFile.memino} ,"
        "${TablesColumnFile.malmeffdate} ,"
        "${TablesColumnFile.madjfrmsd} ,"
        "${TablesColumnFile.madjfrmexcss} ,"
        "${TablesColumnFile.mpaidbygrp} ,"
        "${TablesColumnFile.mattndnc} ,"
        "${TablesColumnFile.mremarks} ,"
        "${TablesColumnFile.mcollamt} ,"
        "${TablesColumnFile.mcreateddt} , "
        "${TablesColumnFile.mcreatedby} , "
        "${TablesColumnFile.midealbaldate} , "
        "${TablesColumnFile.mlastupdatedt} , "
        "${TablesColumnFile.mlastupdateby} , "
        "${TablesColumnFile.mgeolocation} , "
        "${TablesColumnFile.mgeolatd} , "
        "${TablesColumnFile.mbatchcd} , "
        "${TablesColumnFile.mgeologd} )"
        "VALUES"
        "(${collectionMasterBean.mlbrcode} ,"
        "'${collectionMasterBean.mprdacctid}' ,"
        "${collectionMasterBean.mcenterid} ,"
        "${collectionMasterBean.mgroupid} ,"
        "${collectionMasterBean.mcustno} ,"
        "'${collectionMasterBean.mfocode}' ,"
        "${collectionMasterBean.memino} ,"
        "'${collectionMasterBean.malmeffdate}' ,"
        "${collectionMasterBean.madjFrmSD} ,"
        "${collectionMasterBean.madjfrmexcss} ,"
        "${collectionMasterBean.mpaidByGrp} ,"
        "${collectionMasterBean.mattendence} ,"
        "'${collectionMasterBean.mremarks}' ,"
        "${collectionMasterBean.mcollAmt} ,"
        "'${collectionMasterBean.mcreateddt}' ,"
        "'${collectionMasterBean.mcreatedby}' ,"
        "'${collectionMasterBean.midealbaldate}' ,"
        "'${collectionMasterBean.mlastupdatedt}' ,"
        "'${collectionMasterBean.mlastupdateby}',"
        "'${collectionMasterBean.mgeolocation}' ,"
        "'${collectionMasterBean.mgeolatd}' ,"
        "'${collectionMasterBean.mbatchcd}',"
        "'${collectionMasterBean.mgeologd}' );";


    await db.transaction((Transaction txn) async {
      var id = await txn.rawInsert(insertQuery);
    });
  }

  Future<List<CollectionMasterBean>> getDailyColletedNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollectionMasterBean retBean = new CollectionMasterBean();
    List<CollectionMasterBean> n = new List<CollectionMasterBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${collectedLoansAmtMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${collectedLoansAmtMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindDailyColleted(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CollectionMasterBean bindDailyColleted(Map<String, dynamic> result) {
    return CollectionMasterBean.fromMap(result);
  }

  Future<List<LoanCycleParameterSecondaryBean>> selectMaxLoanAmtCanApply(
      String prdCode, int loanCycle, int mlbrcd, String mfrequ) async {
    String selectMaxLoanAmtCanApply =
        'SELECT   * FROM ${LoanCycleParameterSecondaryMaster} WHERE '
        '${TablesColumnFile.mlbrcode} = ${mlbrcd}  AND ${TablesColumnFile
        .mloancycle} = ${loanCycle} '
        'AND ${TablesColumnFile.mprdcd} = "${prdCode
        .trim()}" AND ${TablesColumnFile
        .mfrequency} = "${mfrequ}" order by ${TablesColumnFile
        .meffdate} desc limit 2';

    try {
      List<LoanCycleParameterSecondaryBean>
      listLoanCycleParameterSecondaryBean =
      new List<LoanCycleParameterSecondaryBean>();
      var db = await _getDb();
      var result = await db.rawQuery(selectMaxLoanAmtCanApply);
      print("cycle amt " + selectMaxLoanAmtCanApply);

      if (result.length > 0 && result[0] != null) {
        for (int i = 0; i < result.length; i++) {
          var bean = LoanCycleParameterSecondaryBean.fromLocalDb(result[i]);
          listLoanCycleParameterSecondaryBean.add(bean);
        }
      } else {
        selectMaxLoanAmtCanApply =
        'SELECT   * FROM ${LoanCycleParameterSecondaryMaster} WHERE '
            '${TablesColumnFile.mlbrcode} = ${mlbrcd}  AND ${TablesColumnFile
            .mloancycle} = 99 '
            'AND ${TablesColumnFile.mprdcd} = "${prdCode
            .trim()}" AND ${TablesColumnFile
            .mfrequency} = "${mfrequ}" order by ${TablesColumnFile
            .meffdate} desc limit 2';


        result = await db.rawQuery(selectMaxLoanAmtCanApply);


        if (result.length > 0 && result[0] != null) {
          for (int i = 0; i < result.length; i++) {
            var bean = LoanCycleParameterSecondaryBean.fromLocalDb(result[i]);
            listLoanCycleParameterSecondaryBean.add(bean);
          }
        }
      }
      print("cycle amt " + selectMaxLoanAmtCanApply);
      return listLoanCycleParameterSecondaryBean;
    } catch (_) {
      print("exception here ");
    }
  }

// calculating the Terrm deposit Rate of Interest
// according to number of days and number of months
  Future<double> getTDRateOfInterestTenure(
      int mnoofdays, int mnoofmonths) async {
    String selectSlabRoiQuery =
        'SELECT   ${TablesColumnFile.mintrate} FROM ${TDProductwiseInterestTable} WHERE '
        '${TablesColumnFile.mdays} = "${mnoofdays}"  AND ${TablesColumnFile.mmonths} = "${mnoofmonths}" '
        'AND ${TablesColumnFile.minteffdt} = (SELECT max(${TablesColumnFile.minteffdt}) FROM '
        '${TDProductwiseInterestTable} WHERE ${TablesColumnFile.mdays} = "${mnoofdays}" AND ${TablesColumnFile.mmonths}'
        ' = "${mnoofmonths}")  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

    print(selectSlabRoiQuery);
     try {
    double salbInt = 0.0;
    double salbofInt = 0.0;
    var db = await _getDb();
    var result = await db.rawQuery(selectSlabRoiQuery);
    if (result.length > 0 && result[0] != null) {
      salbInt = result[0][TablesColumnFile.mintrate];
    }

    String selectTDOffsetRoiQuery =
        'SELECT   ${TablesColumnFile.moffsetintrate} FROM ${TDOffsetInterestMaster} WHERE '
        '${TablesColumnFile.mdays} = "${mnoofdays}"  AND ${TablesColumnFile.mmonths} = "${mnoofmonths}" '
        'AND ${TablesColumnFile.meffdate} = (SELECT max(${TablesColumnFile.meffdate}) FROM '
        '${TDOffsetInterestMaster} WHERE ${TablesColumnFile.mdays} = "${mnoofdays}" AND ${TablesColumnFile.mmonths}'
        ' = "${mnoofmonths}")  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';


    result = await db.rawQuery(selectTDOffsetRoiQuery);
    if (result.length > 0 && result[0] != null) {
      salbofInt = result[0][TablesColumnFile.moffsetintrate];
    }

    return salbInt + (salbofInt);
     } catch (_) {
      print("exception here ");
    }
  }

  // calculating the Terrm deposit Rate of Interest
// according to number of days and number of months PLUS Amount
  Future<double> getTDRateOfInterestTenureAndAmount(
      int mnoofdays, int mnoofmonths, double mmainbalfcy) async {
    String selectSlabRoiQuery =
        'SELECT   ${TablesColumnFile.mintrate} FROM ${TDProductwiseInterestTable} WHERE '
        '${TablesColumnFile.mdays} = "${mnoofdays}"  AND ${TablesColumnFile.mmonths} = "${mnoofmonths}" '
        'AND ${TablesColumnFile.minteffdt} = (SELECT max(${TablesColumnFile.minteffdt}) FROM '
        '${TDProductwiseInterestTable} WHERE ${TablesColumnFile.mdays} = "${mnoofdays}" AND ${TablesColumnFile.mmonths}'
        ' = "${mnoofmonths}") AND ${TablesColumnFile.mpenalintrate} >= $mmainbalfcy ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

    print(selectSlabRoiQuery);
    //  try {
    double salbInt = 0.0;
    double salbofInt = 0.0;
    var db = await _getDb();
    var result = await db.rawQuery(selectSlabRoiQuery);
    if (result.length > 0 && result[0] != null) {
      salbInt = result[0][TablesColumnFile.mintrate];
    }

    String selectTDOffsetRoiQuery =
        'SELECT   ${TablesColumnFile.moffsetintrate} FROM ${TDOffsetInterestMaster} WHERE '
        '${TablesColumnFile.mdays} = "${mnoofdays}"  AND ${TablesColumnFile.mmonths} = "${mnoofmonths}" '
        'AND ${TablesColumnFile.effDate} = (SELECT max(${TablesColumnFile.effDate}) FROM '
        '${TDOffsetInterestMaster} WHERE ${TablesColumnFile.mdays} = "${mnoofdays}" AND ${TablesColumnFile.mmonths}'
        ' = "${mnoofmonths}") AND ${TablesColumnFile.muptoamt} >= $mmainbalfcy ORDER BY ${TablesColumnFile.msrno} LIMIT 1';


    result = await db.rawQuery(selectTDOffsetRoiQuery);
    if (result.length > 0 && result[0] != null) {
      salbofInt = result[0][TablesColumnFile.moffsetintrate];
    }

    return salbInt + (salbofInt);
    /* } catch (_) {
      print("exception here ");
    }*/
  }


  Future<LoginBean> getLoginPass(LoginBean loginBean) async {
    var db = await _getDb();
    var userCode = "${TablesColumnFile.musrcode} = '${loginBean.musrcode}'";
    LoginBean retBean = new LoginBean();

    print('query is here : ' +
        'SELECT * FROM $userMasterTable  WHERE  $userCode');
    var result =
    await db.rawQuery('SELECT * FROM $userMasterTable  WHERE  $userCode');
    try{
      if (result[0] != null) {
        print(result[0]);
        retBean = bindDataLoginBEan(result);
        // retBean = bindDataLoginBEan(result);
      }
    }catch(_){
      print("Exception Occured");
    }
    return retBean;
  }

  Future updateUserPassword(LoginBean loginBean) async {
    var db = await _getDb();
    String query =
        "Update ${userMasterTable} set ${TablesColumnFile.musrpass} = '${loginBean.musrpass}' "
        " Where  ${TablesColumnFile.musrcode} = '${loginBean.musrcode}' ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print(result);
  }

  Future<CreditBereauBean> getPrspctFrmMrefAndTerf(int mrefno,
      int trefno) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${creditBereauMaster} WHERE ${TablesColumnFile
        .mrefno} = ${mrefno} AND "
        " ${TablesColumnFile.trefno} = ${trefno} ";

    print("select query is ${selectQueryIsDataSynced}");

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    CreditBereauBean bean;
    try {
      if (result != null && result.isNotEmpty)
        bean = bindDataProspectbean(result[0]);
      else
        bean = null;
    } catch (_) {
      print(error.toString());
    }
    return bean;
  }


  //select customer based on Tref
  Future<CustomerLoanDetailsBean> selectCustomerLoanOnTref(int trefno,
      String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerLoanDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanDetailsBean();
        bean = bindCustomerLoanDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<CustomerLoanDetailsBean> selectLoanOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    CustomerLoanDetailsBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanDetailsBean();
        bean = bindCustomerLoanDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<int> generateTDNumber() async {
    print("trying to select last row  ${TermDepositMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${TermDepositMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile
        .trefno})  FROM ${TermDepositMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  Future<CustomerListBean> getCustomerByTrefAndMref(int trefno,
      int mrefno) async {
    var db = await _getDb();

    String query = 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile
        .trefno}  = $trefno'
        ' AND ${TablesColumnFile.mrefno}  = $mrefno ;';
    print(query);
    var result = await db.rawQuery(query);
    print("result result "+result.toString());

    CustomerListBean bean;
    try {
      if (result.isNotEmpty)
        bean = bindDataCustomerListBean(result[0]);
      else {
        print("result is ${result}");
      }
    }
    catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future _createLoanApprovalLimitMasterTable(Database db) {
    String query = "CREATE TABLE ${loanApprovalLimitMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mgrpcd} INTEGER,"
        "${TablesColumnFile.musercode} TEXT,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mlimitamt} REAL,"
        "${TablesColumnFile.moverduedays} INTEGER,"
        "${TablesColumnFile.mloanacmindrbal} REAL,"
        "${TablesColumnFile.mloanacmincrbal} REAL,"
        "${TablesColumnFile.mwriteoffamat} REAL,"
        "${TablesColumnFile.mcheqlimitamt} REAL,"
        "${TablesColumnFile.mminintrate} REAL,"
        "${TablesColumnFile.mmaxintrate} REAL,"
        "${TablesColumnFile.mremarks} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode},${TablesColumnFile
        .mgrpcd},${TablesColumnFile.musercode},${TablesColumnFile.msrno}))";
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future createLoanApprovalLimitInsert(int lbrCode, String musercode,
      int mgrpcd) async {
    //deletSomeUtil();
    var loanApprovalLimitService = new LoanApprovalLimitService();
    var db = await _getDb();
    List<LoanApprovalLimitBean> loanApprovalLimitList = new List<
        LoanApprovalLimitBean>();
    await loanApprovalLimitService.getLoanApprovalLimitData(
        lbrCode, musercode, mgrpcd)
        .then((onValue) {
      print(onValue.length);
      loanApprovalLimitList = onValue;
    });
    await AppDatabase.get().deletSomeSyncingActivityFromOmni(
        'Loan_Approval_limit_Master');
    for (int i = 0; i < loanApprovalLimitList.length; i++) {
      String insertQuery =
          "INSERT OR REPLACE INTO ${loanApprovalLimitMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mgrpcd} ,"
          "${TablesColumnFile.musercode} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mlimitamt} ,"
          "${TablesColumnFile.moverduedays} ,"
          "${TablesColumnFile.mloanacmindrbal} ,"
          "${TablesColumnFile.mloanacmincrbal} ,"
          "${TablesColumnFile.mwriteoffamat} ,"
          "${TablesColumnFile.mcheqlimitamt} ,"
          "${TablesColumnFile.mminintrate} ,"
          "${TablesColumnFile.mmaxintrate} ,"
          "${TablesColumnFile.mremarks}  )"
          "VALUES"
          "(${loanApprovalLimitList[i].loanApprovalLimitComposite.mlbrcode},"
          "${loanApprovalLimitList[i].loanApprovalLimitComposite.mgrpcd},"
          "'${loanApprovalLimitList[i].loanApprovalLimitComposite.musercode}',"
          "${loanApprovalLimitList[i].loanApprovalLimitComposite.msrno},"
          "'${loanApprovalLimitList[i].mprdcd}',"
          "${loanApprovalLimitList[i].mlimitamt},"
          "${loanApprovalLimitList[i].moverduedays},"
          "${loanApprovalLimitList[i].mloanacmindrbal},"
          "${loanApprovalLimitList[i].mloanacmincrbal},"
          "${loanApprovalLimitList[i].mwriteoffamat},"
          "${loanApprovalLimitList[i].mcheqlimitamt},"
          "${loanApprovalLimitList[i].mminintrate},"
          "${loanApprovalLimitList[i].mmaxintrate},"
          "'${loanApprovalLimitList[i].mremarks}');";

      print("insert query is" + insertQuery);
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
      });
    }
  }


  Future<double> getLoanApprovalLimit(String mprdcd, String musercode) async {
    var db = await _getDb();
    LoanApprovalLimitBean loanApprovalLimitBean;
    try {
      String query = 'SELECT * FROM ${loanApprovalLimitMaster}  WHERE ${TablesColumnFile
          .mprdcd}  = "${mprdcd.trim()}"  AND ${TablesColumnFile
          .musercode}  = "${musercode.trim()}" ;';
      print(query);
      var result = await db.rawQuery(query);

      if (result.isNotEmpty)
        loanApprovalLimitBean = bindDataLoanApprovalLimitBean(result[0]);
      else {
        String query = 'SELECT * FROM ${loanApprovalLimitMaster}  WHERE ${TablesColumnFile
            .mprdcd}  = "${mprdcd.trim()}"  ;';
        print(query);
        var result = await db.rawQuery(query);
        loanApprovalLimitBean = bindDataLoanApprovalLimitBean(result[0]);
      }
    }
    catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    if (loanApprovalLimitBean != null &&
        loanApprovalLimitBean.mlimitamt != null) {
      return loanApprovalLimitBean.mlimitamt;
    } else {
      return 0.0;
    }
  }

  LoanApprovalLimitBean bindDataLoanApprovalLimitBean(
      Map<String, dynamic> result) {
    return LoanApprovalLimitBean.fromLocalDb(result);
  }


  Future<double> getUnsyncedDailyCollectedLaonAmt(String mprdacctid) async {
    var db = await _getDb();
    CollectionMasterBean collectionMasterBean;
    double unSyncedAmt = 0.0;
    try {
      String query = 'SELECT * FROM ${collectedLoansAmtMaster}  WHERE ${TablesColumnFile
          .mprdacctid}  = "${mprdacctid.trim()}"  ;';
      print(query);
      var result = await db.rawQuery(query);

      if (result.isNotEmpty)
        try {
          for (int i = 0; i < result.length; i++) {
            collectionMasterBean = CollectionMasterBean.fromMap(result[i]);
            if (collectionMasterBean.mcollAmt != null) {
              unSyncedAmt += collectionMasterBean.mcollAmt;
            }
          }
        } catch (e) {
          print(e.toString());
        }
      return unSyncedAmt;
    }
    catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
  }


  Future<CenterDetailsBean> getSingleCenter(int mcenterid) async {
    var db = await _getDb();

    CenterDetailsBean retBean = new CenterDetailsBean();

    var result;
    print("query is" + "SELECT *  FROM $centerDetailsMaster ");
    result = await db.rawQuery(
        'SELECT *  FROM $centerDetailsMaster where  ${TablesColumnFile
            .mcenterid} = ${mcenterid};');

    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindCenterDetailsBean(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }

    return retBean;
  }


  Future<LookupBeanData> getLookupDataPurposeOfLoanFromLocalDb(int codeType,
      String code) async {
    var db = await _getDb();
    LookupBeanData retBean = new LookupBeanData();
    List<LookupBeanData> n = new List<LookupBeanData>();
    var result;

    print("query is" + "SELECT *  FROM $LookupMaster ");
    result = await db.rawQuery(
        'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile
            .mcodetype},${TablesColumnFile.mcode},${TablesColumnFile
            .mfield1value} from lookup_master where ${TablesColumnFile
            .mcodetype} = $codeType  AND ${TablesColumnFile
            .mcode} = "$code" ORDER BY ${TablesColumnFile.mcodedesc} ;');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = LookupBeanData.fromJson(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<CountryDropDownBean> getCountryNameViaCountryCode(
      String cntryCd) async {
    var db = await _getDb();
    CountryDropDownBean retBean = new CountryDropDownBean();
    List<CountryDropDownBean> n = new List<CountryDropDownBean>();
    var result;

    print("query is" + "SELECT *  FROM $countryMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile
            .countryName} from Country_Master where ${TablesColumnFile
            .cntryCd} = "$cntryCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = CountryDropDownBean.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }


  Future<StateDropDownList> getStateNameViaStateCode(String stateCd) async {
    var db = await _getDb();
    StateDropDownList retBean = new StateDropDownList();
    List<StateDropDownList> n = new List<StateDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $stateMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile
            .stateDesc} from State_Master where ${TablesColumnFile
            .stateCd} = "$stateCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = StateDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<DistrictDropDownList> getDistrictNameViaDistrictCode(
      String distCd) async {
    var db = await _getDb();
    DistrictDropDownList retBean = new DistrictDropDownList();
    List<DistrictDropDownList> n = new List<DistrictDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $districtMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile
            .distDesc} from District_Master where ${TablesColumnFile
            .distCd} = "$distCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = DistrictDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<SubDistrictDropDownList> getPlaceNameViaPlaceCode(
      String placeCd) async {
    var db = await _getDb();
    SubDistrictDropDownList retBean = new SubDistrictDropDownList();
    List<SubDistrictDropDownList> n = new List<SubDistrictDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $subDistrictMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile
            .placeCdDesc} from SubDistrict_Master where ${TablesColumnFile
            .placeCd} = "$placeCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = SubDistrictDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<AreaDropDownList> getAreaNameViaAreaCode(String areaCd) async {
    var db = await _getDb();
    AreaDropDownList retBean = new AreaDropDownList();
    List<AreaDropDownList> n = new List<AreaDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $areaMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile
            .areaDesc} from Area_Master where ${TablesColumnFile
            .areaCd} = "$areaCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = AreaDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<ProductBean> getProductOnPrdCd(int moduleType, int branchCode,
      String mprdcd) async {
    var db = await _getDb();
    ProductBean retBean = new ProductBean();


    var result;

    result = await db.rawQuery(
        "SELECT *  FROM $productMaster WHERE ${TablesColumnFile
            .mmoduletype} = $moduleType AND ${TablesColumnFile
            .mlbrcode} = $branchCode AND ${TablesColumnFile
            .mprdcd} = '${mprdcd}' ;");
    print("SELECT *  FROM $productMaster WHERE ${TablesColumnFile
        .mmoduletype} = $moduleType AND ${TablesColumnFile
        .mlbrcode} = $branchCode AND ${TablesColumnFile
        .mprdcd} = '${mprdcd}' ;");
    try {
      print("result result "+result.toString());
      for (int i = 0; i < result.length; i++) {
        retBean = bindProduct(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }
  GuarantorDetailsBean bindGuarantorDetails(Map<String, dynamic> result) {
    return GuarantorDetailsBean.fromMap(result);
  }

  Future<GuarantorDetailsBean> selectGuarantorOnTref(int trefno,
      String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    GuarantorDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GuarantorDetailsBean();
        bean = bindGuarantorDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }



  Future<GuarantorDetailsBean> selectGuarantorOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    GuarantorDetailsBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GuarantorDetailsBean();
        bean = bindGuarantorDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<List<GuarantorDetailsBean>> getGuarantorsNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    GuarantorDetailsBean retBean = new GuarantorDetailsBean();
    List<GuarantorDetailsBean> n = new List<GuarantorDetailsBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${gaurantorMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindGuarantorDetails(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future updateGuarantorMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${gaurantorMaster} SET ${query}");
    });
  }
  Future<int> generateTrefnoForGuarantor() async {
    print("trying to select last row  ${gaurantorMaster}");
    String insertQuery = "SELECT *""FROM    ${gaurantorMaster}"" WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${gaurantorMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }
  Future updateBranchMaster(BranchMasterBean brnchObj) async {
    print("trying to insert or replace ${branchMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${branchMaster} ("
        "${TablesColumnFile.mpbrcode}  ,"
        "${TablesColumnFile.mname} ,"
        "${TablesColumnFile.mshortname} ,"
        "${TablesColumnFile.madd1} ,"
        "${TablesColumnFile.madd2} ,"
        "${TablesColumnFile.madd3} ,"
        "${TablesColumnFile.mcitycd} ,"
        "${TablesColumnFile.mpincode} ,"
        "${TablesColumnFile.mcountrycd} ,"
        "${TablesColumnFile.mbranchtype} ,"
        "${TablesColumnFile.mtele1} ,"
        "${TablesColumnFile.mtele2} ,"
        "${TablesColumnFile.mfaxno1} ,"
        "${TablesColumnFile.mswiftaddr} ,"
        "${TablesColumnFile.mpostcode} ,"
        "${TablesColumnFile.mweekoff1} ,"
        "${TablesColumnFile.mweekoff2} ,"
        "${TablesColumnFile.mparentbrcode} ,"
        "${TablesColumnFile.mbranchtype1} ,"
        "${TablesColumnFile.mbranchcat} ,"
        "${TablesColumnFile.mformatndt} ,"
        "${TablesColumnFile.mdistrict} ,"
        "${TablesColumnFile.mbrnmanager} ,"
        "${TablesColumnFile.mstate} ,"
        "${TablesColumnFile.mmingroupmembers} ,"
        "${TablesColumnFile.mmaxgroupmembers} ,"
        "${TablesColumnFile.msector} ,"
        "${TablesColumnFile.mbranchemailid} ,"
        "${TablesColumnFile.mbiccode} ,"
        "${TablesColumnFile.mlegacybrncd} ,"
        "${TablesColumnFile.mlatitude} ,"
        "${TablesColumnFile.mlongitude} ,"
        "${TablesColumnFile.mlastopendate}  )"
        "VALUES"
        "(${brnchObj.mpbrcode},"
        "'${brnchObj.mname}',"
        "'${brnchObj.mshortname}',"
        "'${brnchObj.madd1}',"
        "'${brnchObj.madd2}',"
        "'${brnchObj.madd3}',"
        "'${brnchObj.mcitycd}',"
        "${brnchObj.mpincode},"
        "'${brnchObj.mcountrycd}',"
        "${brnchObj.mbranchtype},"
        "'${brnchObj.mtele1}',"
        "'${brnchObj.mtele2}',"
        "'${brnchObj.mfaxno1}',"
        "'${brnchObj.mswiftaddr}',"
        "'${brnchObj.mpostcode}',"
        "${brnchObj.mweekoff1},"
        "${brnchObj.mweekoff2},"
        "${brnchObj.mparentbrcode},"
        "${brnchObj.mbranchtype1},"
        "${brnchObj.mbranchcat},"
        "'${brnchObj.mformatndt}',"
        "'${brnchObj.mdistrict}',"
        "'${brnchObj.mbrnmanager}',"
        "'${brnchObj.mstate}',"
        "${brnchObj.mmaxgroupmembers},"
        "${brnchObj.mmingroupmembers},"
        "${brnchObj.msector},"
        "'${brnchObj.mbranchemailid}',"
        "'${brnchObj.mbiccode}',"
        "'${brnchObj.mlegacybrncd}',"
        "${brnchObj.mlatitude},"
        "${brnchObj.mlongitude},"
        "'${brnchObj.mlastopendate}'"
        ");";

    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${productMaster}");
    });
  }


  Future<BranchMasterBean> getBranchNameOnPbrCd(int branchCd) async {
    var db = await _getDb();
    BranchMasterBean retBean = new BranchMasterBean();
    var result;

    result = await db.rawQuery(
        "SELECT *  FROM $branchMaster WHERE ${TablesColumnFile
            .mpbrcode} = $branchCd ;");
    print("SELECT *  FROM $branchMaster WHERE ${TablesColumnFile
        .mpbrcode} = $branchCd ;" + result.toString() + result.length.toString() );
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindBranch(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }



  BranchMasterBean bindBranch(Map<String, dynamic> result) {
    return BranchMasterBean.fromMiddleware(result);
  }


  Future _createCollateralsMaster(Database db) {
    String query = "CREATE TABLE ${collateralsMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.loantrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mcollateralsid} TEXT,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mapplicanttype} TEXT,"
        "${TablesColumnFile.mrelationwithcust} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mcollatrlTyp} TEXT,"
        "${TablesColumnFile.mcollatrlcat} TEXT,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mfname} TEXT, "
        "${TablesColumnFile.mmname} TEXT, "
        "${TablesColumnFile.mlname} TEXT, "
        "${TablesColumnFile.minsurance} TEXT,"
        "${TablesColumnFile.mcolltrltitle} TEXT,"
        "${TablesColumnFile.mnameoftitledoc} TEXT,"
        "${TablesColumnFile.mcollbookno} TEXT,"
        "${TablesColumnFile.mcollpageno} TEXT,"
        "${TablesColumnFile.mplaceofuse} TEXT,"
        "${TablesColumnFile.mwithdrawcond} TEXT,"
        "${TablesColumnFile.misappctprimary} TEXT,"
        "${TablesColumnFile.mislmap} TEXT,"
        "${TablesColumnFile.mnoofattchmnt} TEXT,"
        "${TablesColumnFile.msubcolltrl} TEXT,"
        "${TablesColumnFile.msubocolltrldesc} TEXT,"
        "${TablesColumnFile.msubcolltrlcat} TEXT,"
        "${TablesColumnFile.msubocolltrlcatdesc} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno}))";
    print("primary of gaurantor table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }


Future<int> getMaxCollateralREMlandandhouseTrefNo() async {
    print("trying to select last row  ${CollateralREMlandandhouseMaster}");
    String insertQuery = "SELECT *""FROM    ${CollateralREMlandandhouseMaster}"" WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${CollateralREMlandandhouseMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }


  Future  updateCollateralsMaster(
      CollateralBasicSelectionBean collateralBasicSelectionBean) async {
    String insertQuery = "INSERT OR REPLACE INTO ${collateralsMaster}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mcollateralsid} ,"
        "${TablesColumnFile.mleadsid} ,"
        "${TablesColumnFile.msrno} ,"
        "${TablesColumnFile.mcustno}, "
        "${TablesColumnFile.mapplicanttype} ,"
        "${TablesColumnFile.mrelationwithcust} ,"
        "${TablesColumnFile.merrormessage} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mcollatrlTyp} ,"
        "${TablesColumnFile.mcollatrlcat} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mfname} , "
        "${TablesColumnFile.mmname} , "
        "${TablesColumnFile.mlname} , "
        "${TablesColumnFile.minsurance} ,"
        "${TablesColumnFile.mcolltrltitle} ,"
        "${TablesColumnFile.misappctprimary} ,"
        "${TablesColumnFile.mislmap} ,"
        "${TablesColumnFile.mnoofattchmnt} ,"
        "${TablesColumnFile.mnameoftitledoc} ,"
        "${TablesColumnFile.mcollbookno} ,"
        "${TablesColumnFile.mcollpageno} ,"
        "${TablesColumnFile.mplaceofuse} ,"
        "${TablesColumnFile.mwithdrawcond} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.isDataSynced} ,"
        "${TablesColumnFile.msubcolltrl} ,"
        "${TablesColumnFile.msubocolltrldesc} ,"
        "${TablesColumnFile.msubcolltrlcat} ,"
        "${TablesColumnFile.msubocolltrlcatdesc} "
        ")"
        "VALUES("
        "${collateralBasicSelectionBean.trefno},"
        "${collateralBasicSelectionBean.mrefno},"
        "${collateralBasicSelectionBean.loanmrefno},"
        "${collateralBasicSelectionBean.loantrefno},"
        "'${collateralBasicSelectionBean.mprdacctid}',"
        "'${collateralBasicSelectionBean.mcollateralsid}',"
        "'${collateralBasicSelectionBean.mleadsid}',"
        "${collateralBasicSelectionBean.msrno},"
        "${collateralBasicSelectionBean.mcustno},"
        "'${collateralBasicSelectionBean.mapplicanttype}',"
        "'${collateralBasicSelectionBean.mrelationwithcust}',"
        "'${collateralBasicSelectionBean.merrormessage}',"
        "'${collateralBasicSelectionBean.mcreateddt}',"
        "'${collateralBasicSelectionBean.mcreatedby}',"
        "'${collateralBasicSelectionBean.mlastupdatedt}',"
        "'${collateralBasicSelectionBean.mlastupdateby}',"
        "'${collateralBasicSelectionBean.mgeolocation}',"
        "'${collateralBasicSelectionBean.mgeolatd}',"
        "'${collateralBasicSelectionBean.mgeologd}',"
        "'${collateralBasicSelectionBean.collatrlTyp}',"
        "'${collateralBasicSelectionBean.collatrlcat}',"
        "'${collateralBasicSelectionBean.nametitle}',"
        "'${collateralBasicSelectionBean.mfname}',"
        "'${collateralBasicSelectionBean.mmname}',"
        "'${collateralBasicSelectionBean.mlname}',"
        "'${collateralBasicSelectionBean.insurance}',"
        "'${collateralBasicSelectionBean.colltrltitle}',"
        "'${collateralBasicSelectionBean.misappctprimary}',"
        "'${collateralBasicSelectionBean.mislmap}',"
        "'${collateralBasicSelectionBean.mnoofattchmnt}',"
        "'${collateralBasicSelectionBean.mnameoftitledoc}',"
        "'${collateralBasicSelectionBean.mcollbookno}',"
        "'${collateralBasicSelectionBean.mcollpageno}',"
        "'${collateralBasicSelectionBean.mplaceofuse}',"
        "'${collateralBasicSelectionBean.mwithdrawcond}',"
        "'${collateralBasicSelectionBean.mlastsynsdate}',"
        "${0},"
        "'${collateralBasicSelectionBean.msubcolltrl}',"
        "'${collateralBasicSelectionBean.msubocolltrldesc}',"
        "'${collateralBasicSelectionBean.msubcolltrlcat}',"
        "'${collateralBasicSelectionBean.msubocolltrlcatdesc}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${gaurantorMaster}");
    });
  }

Future<int> getMaxCollateralVehicleTrefNo() async {
      print("trying to select last row  ${collateralVehicleMaster}");
      String insertQuery = "SELECT *""FROM    ${collateralVehicleMaster}"" WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${collateralVehicleMaster});";
      var db = await _getDb();
      int retValue;
      try {
        await db.transaction((Transaction txn) async {
          var result = await txn.rawQuery(insertQuery);
          retValue = result[0][TablesColumnFile.trefno];
        });
      } catch (_) {
        retValue = 0;
      }
      return retValue + 1;
    }
  Future<int> generateTrefnoForCollaterals() async {
    print("trying to select last row  ${collateralsMaster}");
    String insertQuery = "SELECT *""FROM    ${collateralsMaster}"" WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${collateralsMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }


  Future<List<CollateralBasicSelectionBean>> getCollatrlDetailsList(int trefno,int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    CollateralBasicSelectionBean retBean = new CollateralBasicSelectionBean();
    List<CollateralBasicSelectionBean> collateralBasicSelectionBean =
    new List<CollateralBasicSelectionBean>();
    var result;
    seleQuery = "Select * from ${collateralsMaster} WHERE "
        "${TablesColumnFile.loantrefno + " = " + trefno.toString() }"
        "${mrefno == 0||mrefno == null? "":" AND "+TablesColumnFile.loanmrefno+ " = " + mrefno.toString()}; ";


    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindLoanCollatrlDetailsBean(result[i]);
      print("exiting from map");
      collateralBasicSelectionBean.add(retBean);
    }
    return collateralBasicSelectionBean;
  }
  Future<List<DocumentCollectorBean>> getDocumentListonTrefno(int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    DocumentCollectorBean retBean = new DocumentCollectorBean();
    List<DocumentCollectorBean> documentCollectorBean =
    new List<DocumentCollectorBean>();
    var result;
    seleQuery = "Select * from ${DOCUMENTSMASTER} WHERE "
        "${TablesColumnFile.loantrefno + " = " + mrefno.toString() }; ";


    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindDataDocumentCollectorListBean(result[i]);
      print("exiting from map");
      documentCollectorBean.add(retBean);
    }
    return documentCollectorBean;
  }


  Future<List<DocumentCollectorBean>> getDocumentList(int trefno,int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    DocumentCollectorBean retBean = new DocumentCollectorBean();
    List<DocumentCollectorBean> documentCollectorBean =
    new List<DocumentCollectorBean>();
    var result;
    seleQuery = "Select * from ${DOCUMENTSMASTER} WHERE "
        "${TablesColumnFile.loantrefno + " = " + trefno.toString() }"
        "${mrefno == 0||mrefno == null? "":" AND "+TablesColumnFile.loanmrefno+ " = " + mrefno.toString()}; ";


    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindDataDocumentCollectorListBean(result[i]);
      print("exiting from map");
      documentCollectorBean.add(retBean);
    }
    return documentCollectorBean;
  }




  CollateralBasicSelectionBean bindLoanCollatrlDetailsBean(
      Map<String, dynamic> result) {
    return CollateralBasicSelectionBean.fromMap(result);
  }



  Future updateGuranterWhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${gaurantorMaster} SET ${query}");
    });
  }


 Future<List<CollateralVehicleBean>> selectCollateralVehicleListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollateralVehicleBean retBean = new CollateralVehicleBean();
    List<CollateralVehicleBean> n = new List<CollateralVehicleBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${collateralVehicleMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${collateralVehicleMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

     try {
    for (int i = 0; i < result.length; i++) {
      /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
      // print(result[i].runtimeType);
      retBean = bindDataCollateralVehicleListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }
  Future<List<CollateralREMlandandhouseBean>> selectCollateralREMListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollateralREMlandandhouseBean retBean = new CollateralREMlandandhouseBean();
    List<CollateralREMlandandhouseBean> n = new List<CollateralREMlandandhouseBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${CollateralREMlandandhouseMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${CollateralREMlandandhouseMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
      // print(result[i].runtimeType);
      retBean = bindDataCollateralREMListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }
  CollateralREMlandandhouseBean bindDataCollateralREMListBean(Map<String, dynamic> result) {
    return CollateralREMlandandhouseBean.fromMap(result);
  }
  CollateralVehicleBean bindDataCollateralVehicleListBean(Map<String, dynamic> result) {
    return CollateralVehicleBean.fromMap(result);
  }



  //select collateralVehicleMaster based on Tref
  Future<CollateralVehicleBean> selectCollateralVehicleBeanOnCollateralMTrefAndTrefno(int trefno, int mrefno,String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralVehicleMaster}  WHERE ${TablesColumnFile
        .colleteraltrefno}  = $trefno And ${TablesColumnFile
        .colleteralmrefno}  = $mrefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    if (result.length > 0 && result[0] != null) {

    }else{
      selectQueryIsDataSynced =
      'SELECT * FROM ${collateralVehicleMaster}   WHERE ${TablesColumnFile
          .colleteraltrefno}  = $trefno  And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}"';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    CollateralVehicleBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralVehicleBean();
        bean = bindDataCollateralVehicleListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future updateCollateralVehicleMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralVehicleMaster} SET ${query}");
    });
  }




  Future<CollateralREMlandandhouseBean> selectCollateralREMBeanOnCollateralMTrefAndTrefno(int trefno, int mrefno,String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CollateralREMlandandhouseMaster}   WHERE ${TablesColumnFile
        .colleteraltrefno}  = $trefno And ${TablesColumnFile
        .colleteralmrefno}  = $mrefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    if (result.length > 0 && result[0] != null) {

    }else{
      selectQueryIsDataSynced =
      'SELECT * FROM ${CollateralREMlandandhouseMaster}   WHERE ${TablesColumnFile
          .colleteraltrefno}  = $trefno  And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}"';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    CollateralREMlandandhouseBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralREMlandandhouseBean();
        bean = bindDataCollateralREMListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }



  Future updateCollateralREMMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CollateralREMlandandhouseMaster} SET ${query}");
    });
  }

  Future<int> getMaxCollateralREMTrefNo() async {
    print("trying to select last row  ${CollateralREMlandandhouseMaster}");
    String insertQuery = "SELECT * FROM    ${CollateralREMlandandhouseMaster} WHERE  "
    " ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${CollateralREMlandandhouseMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }


  //select collateralVehicleMaster based on Tref
  Future<CollateralVehicleBean> selectCollateralVehicleBeanOnMTrefAndTrefno(int trefno,String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralVehicleMaster}   WHERE ${TablesColumnFile
        .trefno}  = $trefno  And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);


    CollateralVehicleBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralVehicleBean();
        bean = bindDataCollateralVehicleListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<CollateralVehicleBean> selectCollateralVehicleOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralVehicleMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    CollateralVehicleBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${collateralVehicleMaster}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralVehicleBean();
        bean = bindDataCollateralVehicleListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<List<CollateralBasicSelectionBean>> selectCollateralMasterListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollateralBasicSelectionBean retBean = new CollateralBasicSelectionBean();
    List<CollateralBasicSelectionBean> n = new List<CollateralBasicSelectionBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${collateralsMaster}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${collateralsMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

     try {
    for (int i = 0; i < result.length; i++) {
      /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
      // print(result[i].runtimeType);
      retBean = bindDataCollateralBasicListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CollateralBasicSelectionBean bindDataCollateralBasicListBean(Map<String, dynamic> result) {
    return CollateralBasicSelectionBean.fromMap(result);
  }

  Future updateCollateralBasicMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralsMaster} SET ${query}");
    });
  }


  //select collateralVehicleMaster based on Tref
  Future<CollateralBasicSelectionBean> selectCollateralBasicBeanOnMTrefAndTrefno(int trefno,String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralsMaster}   WHERE ${TablesColumnFile
        .trefno}  = $trefno  And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);


    CollateralBasicSelectionBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralBasicSelectionBean();
        bean = bindDataCollateralBasicListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<CollateralBasicSelectionBean> selectCollateralBasicOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    CollateralBasicSelectionBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${collateralsMaster}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralBasicSelectionBean();
        bean = bindDataCollateralBasicListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future updateCollateralBasicWhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralsMaster} SET ${query}");
    });
  }

  Future updateCollateralVehicleWhileBasicCollSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralVehicleMaster} SET ${query}");
    });
  }



  Future<int> updateCustomerTotalExpendtrBeanTable(CustomerListBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${totalExpndtrMaster} "
        "(${TablesColumnFile.ttotlexpntrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mtotlexpnmrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mlivngexpns } ,"
        "${TablesColumnFile.mtotlcommexpns } ,"
        "${TablesColumnFile.meduexpns } ,"
        "${TablesColumnFile.mmedexpns } ,"
        "${TablesColumnFile.mtotlfamexpns } ,"
        "${TablesColumnFile.mloanservexpns } ,"
        "${TablesColumnFile.mcredcrdexpns } ,"
        "${TablesColumnFile.mrntlexpns } ,"
        "${TablesColumnFile.mlghtwtrexpns } ,"
        "${TablesColumnFile.mvechtrnsprtexpns } ,"
        "${TablesColumnFile.mothrexpns } ,"
        "${TablesColumnFile.mothrdebtrepymntexpns } ,"
        "${TablesColumnFile.mtotldebtexpns} )"
        "VALUES"
        "(${bean.totalExpenditureDetailsBean.ttotlexpntrefno} ,"
        "${bean.totalExpenditureDetailsBean.trefno},"
        "${bean.totalExpenditureDetailsBean.mtotlexpnmrefno},"
        "${bean.totalExpenditureDetailsBean.mrefno},"
        "${bean.totalExpenditureDetailsBean.mcustno},"
        "${bean.totalExpenditureDetailsBean.mlivngexpns },"
        "${bean.totalExpenditureDetailsBean.mtotlcommexpns },"
        "${bean.totalExpenditureDetailsBean.meduexpns },"
        "${bean.totalExpenditureDetailsBean.mmedexpns },"
        "${bean.totalExpenditureDetailsBean.mtotlfamexpns },"
        "${bean.totalExpenditureDetailsBean.mloanservexpns },"
        "${bean.totalExpenditureDetailsBean.mcredcrdexpns },"
        "${bean.totalExpenditureDetailsBean.mrntlexpns },"
        "${bean.totalExpenditureDetailsBean.mlghtwtrexpns },"
        "${bean.totalExpenditureDetailsBean.mvechtrnsprtexpns },"
        "${bean.totalExpenditureDetailsBean.mothrexpns },"
        "${bean.totalExpenditureDetailsBean.mothrdebtrepymntexpns },"
        "${bean.totalExpenditureDetailsBean.mtotldebtexpns}  );";
    print("insert query financial statement master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print("totalExpndtrMaster  Detail ---  ${insertQuery}");
      print(idAfterInsert.toString() +
          " id after insert in ${totalExpndtrMaster}");
    });
    return idAfterInsert;
  }

  Future updateTotalExpndtr(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("totalExpndtrMaster  Detail --- UPDATE ${totalExpndtrMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${totalExpndtrMaster} SET ${query}");
    });
  }


  Future<TotalExpenditureDetailsBean> selectCustomerTotalExpndtrListIsDataSynced(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${totalExpndtrMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);

    TotalExpenditureDetailsBean bean;
    try {
      print("inside totalExpndtrMaster statement");
      for (int i = 0; i < result.length; i++) {
        bean = new TotalExpenditureDetailsBean();
        print(result[i]);
        bean = bindDataCustomerTotalExpndtrListBean(result[i]);
        print("CCCCCCCCCCCCCCCCC"+bean.toString());
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  TotalExpenditureDetailsBean bindDataCustomerTotalExpndtrListBean(
      Map<String, dynamic> result) {
    return TotalExpenditureDetailsBean.fromMap(result);
  }


  //select CollateralREMlandandhouseMaster based on Tref
  Future<CollateralREMlandandhouseBean> selectCollateralREMBeanOnTref(int trefno,String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CollateralREMlandandhouseMaster}   WHERE ${TablesColumnFile
        .trefno}  = $trefno  And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);


    CollateralREMlandandhouseBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralREMlandandhouseBean();
        bean = bindDataCollateralREMListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<CollateralREMlandandhouseBean> selectCollateralREMOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CollateralREMlandandhouseMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    CollateralREMlandandhouseBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${CollateralREMlandandhouseMaster}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralREMlandandhouseBean();
        bean = bindDataCollateralREMListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateESMSMaster(
      ESMSBean eSMSBean) async {
    print("trying to insert or replace ${ESMSMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${ESMSMaster}( "
        "${TablesColumnFile.tesmsrefno}  ,"
        "${TablesColumnFile.mesmsrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mexclistchecked} ,"
        "${TablesColumnFile.misbrwrinlist} ,"
        "${TablesColumnFile.mnontrgtcust} ,"
        "${TablesColumnFile.misbrwrinnontrgt} ,"
        "${TablesColumnFile.mairemssn} ,"
        "${TablesColumnFile.maeapplglrequire} ,"
        "${TablesColumnFile.maecmplncstatus} ,"
        "${TablesColumnFile.maeevediance} ,"
        "${TablesColumnFile.mwastewater} ,"
        "${TablesColumnFile.mwwapplglrequire} ,"
        "${TablesColumnFile.mwwcmplncstatus} ,"
        "${TablesColumnFile.mwwevediance} ,"
        "${TablesColumnFile.msolidnhrdauswaste} ,"
        "${TablesColumnFile.mshapplglrequire} ,"
        "${TablesColumnFile.mshcmplncstatus} ,"
        "${TablesColumnFile.mshevediance} ,"
        "${TablesColumnFile.mhrdzchemnfule} ,"
        "${TablesColumnFile.mhcapplglrequire} ,"
        "${TablesColumnFile.mhccmplncstatus} ,"
        "${TablesColumnFile.mhcevediance} ,"
        "${TablesColumnFile.mrescnsmpt} ,"
        "${TablesColumnFile.mnuisance} ,"
        "${TablesColumnFile.mdust} ,"
        "${TablesColumnFile.mtrafficcongandobs} ,"
        "${TablesColumnFile.mvibration} ,"
        "${TablesColumnFile.mfumes} ,"
        "${TablesColumnFile.modours} ,"
        "${TablesColumnFile.mnoise} ,"
        "${TablesColumnFile.mnocomissue} ,"
        "${TablesColumnFile.mnodesigperson} ,"
        "${TablesColumnFile.mdispandressetle} ,"
        "${TablesColumnFile.mlandacqreq} ,"
        "${TablesColumnFile.mnoissue} ,"
        "${TablesColumnFile.marchimp} ,"
        "${TablesColumnFile.msiteofcultural} ,"
        "${TablesColumnFile.mcomplaintsfromneig} ,"
        "${TablesColumnFile.mimpactofindgenous} ,"
        "${TablesColumnFile.mimpactonlocal} ,"
        "${TablesColumnFile.mnorecognitionofemp} ,"
        "${TablesColumnFile.mlabourunion} ,"
        "${TablesColumnFile.mnolabissue} ,"
        "${TablesColumnFile.mnopersonalprotectiveEquip} ,"
        "${TablesColumnFile.mnoprocessforemployees} ,"
        "${TablesColumnFile.mchildoffrcdlabour} ,"
        "${TablesColumnFile.mempblwminage} ,"
        "${TablesColumnFile.mpayblwminwage} ,"
        "${TablesColumnFile.munequalOpp} ,"
        "${TablesColumnFile.minadequatetermsofemp} ,"
        "${TablesColumnFile.minediquateworkingcond} ,"
        "${TablesColumnFile.muinadequateemployeehealth} ,"
        "${TablesColumnFile.mnontarget} ,"
        "${TablesColumnFile.mcategoryc} ,"
        "${TablesColumnFile.mcategoryb} ,"
        "${TablesColumnFile.mcategorya} ,"
        "${TablesColumnFile.mcomntfrmoff} ,"
        "${TablesColumnFile.mdecision} ,"
        "${TablesColumnFile.mdsitrequiretorefroff} ,"
        "${TablesColumnFile.msign} ,"
        "${TablesColumnFile.mnameofoff} ,"
        "${TablesColumnFile.date} "

        ")"
        "VALUES("
        "${eSMSBean.tesmsrefno} ,"
        "${eSMSBean.mesmsrefno} ,"
        "${eSMSBean.trefno} ,"
        "${eSMSBean.mrefno} ,"
        "'${eSMSBean.mexclistchecked}',"
        "'${eSMSBean.misbrwrinlist}',"
        "'${eSMSBean.mnontrgtcust}' ,"
        "'${eSMSBean.misbrwrinnontrgt}' ,"
        "'${eSMSBean.mairemssn}',"
        "'${eSMSBean.maeapplglrequire}' ,"
        "'${eSMSBean.maecmplncstatus} ',"
        "'${eSMSBean.maeevediance}',"
        "'${eSMSBean.mwastewater}',"
        "'${eSMSBean.mwwapplglrequire}' ,"
        "'${eSMSBean.mwwcmplncstatus} ',"
        "'${eSMSBean.mwwevediance}',"
        "'${eSMSBean.msolidnhrdauswaste}',"
        "'${eSMSBean.mshapplglrequire}',"
        "'${eSMSBean.mshcmplncstatus}',"
        "'${eSMSBean.mshevediance}',"
        "'${eSMSBean.mhrdzchemnfule}' ,"
        "'${eSMSBean.mhcapplglrequire}' ,"
        "'${eSMSBean.mhccmplncstatus}',"
        "'${eSMSBean.mhcevediance}',"
        "'${eSMSBean.mrescnsmpt}',"
        "'${eSMSBean.mnuisance}',"
        "'${eSMSBean.mdust}' ,"
        "'${eSMSBean.mtrafficcongandobs}' ,"
        "'${eSMSBean.mvibration}' ,"
        "'${eSMSBean.mfumes}' ,"
        "'${eSMSBean.modours}' ,"
        "'${eSMSBean.mnoise}' ,"
        "'${eSMSBean.mnocomissue}' ,"
        "'${eSMSBean.mnodesigperson}' ,"
        "'${eSMSBean.mdispandressetle}' ,"
        "'${eSMSBean.mlandacqreq}' ,"
        "'${eSMSBean.mnoissue}' ,"
        "'${eSMSBean.marchimp}' ,"
        "'${eSMSBean.msiteofcultural}' ,"
        "'${eSMSBean.mcomplaintsfromneig}' ,"
        "'${eSMSBean.mimpactofindgenous}' ,"
        "'${eSMSBean.mimpactonlocal}' ,"
        "'${eSMSBean.mnorecognitionofemp}' ,"
        "'${eSMSBean.mlabourunion}' ,"
        "'${eSMSBean.mnolabissue}' ,"
        "'${eSMSBean.mnopersonalprotectiveEquip}' ,"
        "'${eSMSBean.mnoprocessforemployees}' ,"
        "'${eSMSBean.mchildoffrcdlabour}' ,"
        "'${eSMSBean.mempblwminage}' ,"
        "'${eSMSBean.mpayblwminwage}' ,"
        "'${eSMSBean.munequalOpp}' ,"
        "'${eSMSBean.minadequatetermsofemp}' ,"
        "'${eSMSBean.minediquateworkingcond}' ,"
        "'${eSMSBean.muinadequateemployeehealth}' ,"
        "'${eSMSBean.mnontarget}' ,"
        "'${eSMSBean.mcategoryc}' ,"
        "'${eSMSBean.mcategoryb}' ,"
        "'${eSMSBean.mcategorya}' ,"
        "'${eSMSBean.mcomntfrmoff}' ,"
        "'${eSMSBean.mdecision}' ,"
        "'${eSMSBean.mdsitrequiretorefroff}' ,"
        "'${eSMSBean.msign}' ,"
        "'${eSMSBean.mnameofoff}' ,"
        "'${eSMSBean.date}' "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${ESMSMaster}");
    });
  }



  Future updateRiskRatingsMaster(
      RiskRatingsBean riskRatingsBean) async {
    print("trying to insert or replace ${RISKRATINGSMASTER}");
    String insertQuery = "INSERT OR REPLACE INTO ${RISKRATINGSMASTER}( "
        "${TablesColumnFile.triskratingsrefno}  ,"
        "${TablesColumnFile.mriskratingsrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mtypeofaccount} ,"
        "${TablesColumnFile.macctno} ,"
        "${TablesColumnFile.mcifno} ,"
        "${TablesColumnFile.vmpurposeofacct} ,"
        "${TablesColumnFile.mcountryrisk} ,"
        "${TablesColumnFile.mvisaperiod} ,"
        "${TablesColumnFile.mvisavalid} ,"
        "${TablesColumnFile.mvisatype} ,"
        "${TablesColumnFile.mnatureofbuss} ,"
        "${TablesColumnFile.mhwwsacctopn} ,"
        "${TablesColumnFile.mnetwrth} ,"
        "${TablesColumnFile.mexpectedvalue} ,"
        "${TablesColumnFile.mnooftransmnthly} ,"
        "${TablesColumnFile.mhighnetwrth} ,"
        "${TablesColumnFile.mprcdservrskque1} "
        ")"
        "VALUES("
        "${riskRatingsBean.triskratingsrefno} ,"
        "${riskRatingsBean.mriskratingsrefno} ,"
        "${riskRatingsBean.trefno} ,"
        "${riskRatingsBean.mrefno} ,"
        "'${riskRatingsBean.mtypeofaccount}',"
        "'${riskRatingsBean.macctno}',"
        "'${riskRatingsBean.mcifno}' ,"
        "'${riskRatingsBean.vmpurposeofacct}',"
        "'${riskRatingsBean.mcountryrisk}',"
        "'${riskRatingsBean.mvisaperiod}' ,"
        "'${riskRatingsBean.mvisavalid}',"
        "'${riskRatingsBean.mvisatype}' ,"
        "'${riskRatingsBean.mnatureofbuss} ',"
        "'${riskRatingsBean.mhwwsacctopn}',"
        "'${riskRatingsBean.mnetwrth}',"
        "'${riskRatingsBean.mexpectedvalue}' ,"
        "'${riskRatingsBean.mnooftransmnthly} ',"
        "'${riskRatingsBean.mhighnetwrth}',"
        "'${riskRatingsBean.mprcdservrskque1}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${RISKRATINGSMASTER}");
    });
  }

  Future<ESMSBean> selectCustomerESMSDetails(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${ESMSMaster}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);

    ESMSBean bean;
    try {
      print("ESMS Details mai");
      for (int i = 0; i < result.length; i++) {
        bean = new ESMSBean();

        for(var i in result[i].toString().split(",")){
          print("result is $i");
        }
        print(result[i]);
        bean = bindDataCustomerESMSBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<RiskRatingsBean> selectCustomerRiskRatingsDetails(int tRefNo,
      int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${RISKRATINGSMASTER}  WHERE ${TablesColumnFile
        .trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);

    RiskRatingsBean bean;
    try {
      print("RISKRATINGSMASTER Details mai");
      for (int i = 0; i < result.length; i++) {
        bean = new RiskRatingsBean();

        for(var i in result[i].toString().split(",")){
          print("result is $i");
        }
        print("result is $i"+result[i].toString());
        bean = bindDataCustomerRiskRatingsBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }



  ESMSBean bindDataCustomerESMSBean(
      Map<String, dynamic> result) {
    return ESMSBean.fromMap(result);
  }

  RiskRatingsBean bindDataCustomerRiskRatingsBean(
      Map<String, dynamic> result) {
    return RiskRatingsBean.fromMap(result);
  }

  Future updateRiskRatings(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("ESMS --- UPDATE ${RISKRATINGSMASTER} SET ${query}");
      await txn.rawQuery("UPDATE ${RISKRATINGSMASTER} SET ${query}");
    });
  }

  Future updateESMS(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("ESMS --- UPDATE ${ESMSMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${ESMSMaster} SET ${query}");
    });
  }


  Future<CustomerLoanDetailsBean> selectCustomerLoanOnTrefAndMrefno(int trefno,
      int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mrefno}  = $mrefno';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    /*print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());*/

    CustomerLoanDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanDetailsBean();
        bean = bindCustomerLoanDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<ChartsBean>> getChartsDetailsList() async {
    var db = await _getDb();
    String seleQuery = "";
    ChartsBean retBean = new ChartsBean();
    List<ChartsBean> chartsBeanList =
    new List<ChartsBean>();
    var result;
    seleQuery = "Select * from ${CHARTMASTER};";
    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {
        print(items.toString());
      }

      retBean = bindChartsDetailsBean(result[i]);
      print("exiting from map");
      chartsBeanList.add(retBean);
    }
    return chartsBeanList;
  }

  ChartsBean bindChartsDetailsBean(Map<String, dynamic> result) {
    return ChartsBean.fromMap(result);
  }

  Future updateChartsMaster(
      ChartsBean chartsBean) async {
    print("trying to insert or replace ${CHARTMASTER}");
    String insertQuery = "INSERT OR REPLACE INTO ${CHARTMASTER}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mchartid} ,"
        "${TablesColumnFile.mtitle} ,"
        "${TablesColumnFile.mxcatg} ,"
        "${TablesColumnFile.mycatg} ,"
        "${TablesColumnFile.mquery} ,"
        "${TablesColumnFile.mtype} "
        ")"
        "VALUES("
        "${chartsBean.trefno} ,"
        "${chartsBean.mrefno} ,"
        "'${chartsBean.mchartid}',"
        "'${chartsBean.mtitle}',"
        "'${chartsBean.mxcatg}',"
        "'${chartsBean.mycatg}',"
        "'${chartsBean.mquery}',"
        "'${chartsBean.mtype}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${CHARTMASTER}");
    });
  }

  Future<List<AxisBean>> getQuery(ChartsBean bean) async{
    var db = await _getDb();

    List<AxisBean> salesDataList = new List<AxisBean>();
    var  result;
    if(!bean.mquery.contains("Query"))

      try {
        result = await db.rawQuery(bean.mquery);
        for (int i = 0; i < result.length; i++) {
          print(result[i]);
          var xcat = result[i][bean.mxcatg];
          var ycat = result[i][bean.mycatg];
          print("xcat"+xcat.toString()+ "xcat"+ycat.toString());
          xcat =xcat==null || xcat.trim()=='null'?"Blank":xcat;
          ycat =ycat==null || ycat==0?1:ycat;
          print("xcat"+xcat.toString()+ "xcat"+ycat.toString());
          AxisBean salesData = new AxisBean(xcat ,ycat );
          salesDataList.add(salesData);

        }
      }catch(_){}


    return salesDataList;
  }

  Future<List<HbsUserBean>> getHbsUsers() async {
    var db = await _getDb();

    HbsUserBean retBean = new HbsUserBean();
    List<HbsUserBean> n =
    new List<HbsUserBean>();
    var result;
    // print("SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position}");

    result = await db.rawQuery(
        'SELECT *  FROM $GETHBSUSERS ;');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindHbsUser(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  HbsUserBean bindHbsUser(result) {
    return HbsUserBean.fromMap(result);
  }


  Future updateDocumentsMasters(DocumentCollectorBean bean) async {
    print("trying to insert or replace ${DOCUMENTSMASTER}");
    String insertQuery = "INSERT OR REPLACE INTO ${DOCUMENTSMASTER}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mforeignindicator} ,"
        "${TablesColumnFile.mdoctno} ,"
        "${TablesColumnFile.mcustname} ,"
        "${TablesColumnFile.mcustno} ,"

        "${TablesColumnFile.mcusttrefno},"
        "${TablesColumnFile.mcustmrefno},"
        "${TablesColumnFile.missuingauth} ,"
        "${TablesColumnFile.missuedate} ,"
        "${TablesColumnFile.mexpdate} ,"
        "${TablesColumnFile.mexecutiondate} ,"
        "${TablesColumnFile.mimgtype} ,"
        "${TablesColumnFile.mcustomertype} ,"
        "${TablesColumnFile.mimgtypedesc} ,"
        "${TablesColumnFile.mimgsubtype} ,"
        "${TablesColumnFile.mcomment} ,"
        "${TablesColumnFile.merrormessage} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        //"${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.imgstring} ,"
        "${TablesColumnFile.mremarks} ) "
        "VALUES "
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "${bean.loantrefno} ,"
        "${bean.loanmrefno} ,"
        "'${bean.mforeignindicator}' ,"
        "'${bean.mdoctno}',"
        "'${bean.mcustname}',"
        "${bean.mcustno},"
        "${bean.custtrefno},"
        "${bean.custmrefno},"
        "'${bean.missuingauth}' ,"
        "'${bean.missuedate}' ,"
        "'${bean.mexpdate}' ,"
        "'${bean.mexecutiondate}' ,"
        "'${bean.mimgtype}' ,"
        "'${bean.mcustomertype}' ,"
        "'${bean.mimgtypedesc}' ,"
        "'${bean.mimgsubtype}' ,"
        "'${bean.mcomment}' ,"
        "'${bean.merrormessage}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
       // "'${bean.mlastsynsdate}',"
        "'${bean.imgstring}',"
        "'${bean.mremarks}'   ); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${DOCUMENTSMASTER}");
    });
  }


  Future<int> generateTrefnoForDocuments() async {
    print("trying to select last row  ${DOCUMENTSMASTER}");
    String insertQuery = "SELECT *""FROM    ${DOCUMENTSMASTER}"" WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${DOCUMENTSMASTER});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }


  //select CollateralREMlandandhouseMaster based on Tref
  Future<DocumentCollectorBean> selectDocumentsBeanOnTref(int trefno,String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${DOCUMENTSMASTER}   WHERE ${TablesColumnFile
        .trefno}  = $trefno  And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);


    DocumentCollectorBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DocumentCollectorBean();
        bean = bindDataDocumentCollectorListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<DocumentCollectorBean> selectDocumentOnTrefANDMrefno(int trefno,
      String mCreatedBy,int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${DOCUMENTSMASTER}  WHERE ${TablesColumnFile
        .trefno}  = $trefno And ${TablesColumnFile
        .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    DocumentCollectorBean bean;
    if (result.isEmpty) {

      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${DOCUMENTSMASTER}  WHERE ${TablesColumnFile
          .trefno}  = $trefno And ${TablesColumnFile
          .mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DocumentCollectorBean();
        bean = bindDataDocumentCollectorListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  DocumentCollectorBean bindDataDocumentCollectorListBean(Map<String, dynamic> result) {
    return DocumentCollectorBean.fromMap(result);
  }

  Future updateDocumentMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${DOCUMENTSMASTER} SET ${query}");
    });
  }



  Future<List<DocumentCollectorBean>> selectDocumentListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    DocumentCollectorBean retBean = new DocumentCollectorBean();
    List<DocumentCollectorBean> n = new List<DocumentCollectorBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${DOCUMENTSMASTER}  WHERE  ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${DOCUMENTSMASTER}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
      // print(result[i].runtimeType);
      retBean = bindDataDocumentCollectorListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }


  Future updateDocumentWhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${DOCUMENTSMASTER} SET ${query}");
    });
  }

  Future<List<DocumentCollectorBean>> getDocuments(int trefno,int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    DocumentCollectorBean retBean = new DocumentCollectorBean();
    List<DocumentCollectorBean> documentCollectorBean =
    new List<DocumentCollectorBean>();
    var result;
    seleQuery = "Select * from ${DOCUMENTSMASTER} WHERE "
        "${TablesColumnFile.loantrefno + " = " + trefno.toString() }"
        "${mrefno == 0||mrefno == null? "":" AND "+TablesColumnFile.loanmrefno+ " = " + mrefno.toString()}; ";


    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {

      retBean = bindDataDocumentCollectorListBean(result[i]);
      print("exiting from map");
      documentCollectorBean.add(retBean);
    }
    return documentCollectorBean;
  }

  Future<List<ImageBean>> getFingerList(int trefno,
      int mrefno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${imageMaster} where ${TablesColumnFile
            .trefno} = $trefno AND ${TablesColumnFile
            .mrefno} = $mrefno AND ${TablesColumnFile
            .imageType} = "FingerPrint" ');
    print("result"+result.toString());
    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }


  Future  deleCollateral(String query) async{
      var db = await _getDb();
print("query"+query);
      await db.transaction((Transaction txn) async {
        await txn
            .rawDelete("Delete FROM ${query}");
      });


  }



  Future  deleBussDetails(int mrefno,int trefno) async{
    var db = await _getDb();
   print ("Inside Buss Delete");

    await db.rawDelete(
        'DELETE FROM ${customerBusinessDetailMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleImageMaster(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Image Delete");

    await db.rawDelete(
        'DELETE FROM ${imageMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleAssetDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside asset Delete");

    await db.rawDelete(
        'DELETE FROM ${assetDetailMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleFixedAssetDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside fixed asset Delete");

    await db.rawDelete(
        'DELETE FROM ${fixedAssetMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleCurrentAssetDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside current asset Delete");

    await db.rawDelete(
        'DELETE FROM ${currentAssetMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleLongTermLiability(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside LTL Delete");

    await db.rawDelete(
        'DELETE FROM ${longTermLiabilitiesMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleShortTermLiability(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside STL Delete");

    await db.rawDelete(
        'DELETE FROM ${shortTermLiabilitiesMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleEquity(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Equity Delete");

    await db.rawDelete(
        'DELETE FROM ${equityMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleincmStatement(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside INCOM Delete");

    await db.rawDelete(
        'DELETE FROM ${incomeStatementMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  delefinStatement(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Fin Delete");

    await db.rawDelete(
        'DELETE FROM ${financialStatementMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleESMS(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside ESMS Delete");

    await db.rawDelete(
        'DELETE FROM ${ESMSMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleriskrating(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside risk Delete");

    await db.rawDelete(
        'DELETE FROM ${RISKRATINGSMASTER} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deletotalexp(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Total exp Delete");

    await db.rawDelete(
        'DELETE FROM ${totalExpndtrMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleBorrowDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Fam Delete");

    await db.rawDelete(
        'DELETE FROM ${customerFoundationBorrowingMasterDetails} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleCustMaster(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Customer Delete");

    await db.rawDelete(
        'DELETE FROM ${customerFoundationMasterDetails} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleAddDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Address Delete");

    await db.rawDelete(
        'DELETE FROM ${customerFoundationAddressMasterDetails} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleFamDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Fam Delete");

    await db.rawDelete(
        'DELETE FROM ${customerFoundationFamilyMasterDetails} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleBankDetails(int mrefno,int trefno) async{
    var db = await _getDb();
    print ("Inside Bank Delete");

    await db.rawDelete(
        'DELETE FROM ${bankDetailsMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  deleDocDetails(int mrefno,int trefno) async{

    var db = await _getDb();
    print ("Inside doc Delete");

    await db.rawDelete(
        'DELETE FROM ${DOCUMENTSMASTER} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }
  Future  updateDocDate(int mrefno,int trefno, DateTime todayDate) async{

    var db = await _getDb();
    print ("Inside doc Update");

    await db.rawDelete(
        "UPDATE ${DOCUMENTSMASTER} SET ${TablesColumnFile.mlastupdatedt} = '${todayDate}' WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;");

  }
  Future  updateGuarantorDate(int mrefno,int trefno, DateTime todayDate) async{

    var db = await _getDb();
    print ("Inside guarantor Update");

    await db.rawDelete(
        "UPDATE ${gaurantorMaster} SET ${TablesColumnFile.mlastupdatedt} = '${todayDate}' WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;");

  }
  Future  deleGuarantorDetails(int trefno,int mrefno) async{


    var db = await _getDb();
    print ("Inside guar Delete");

    await db.rawDelete(
        'DELETE FROM ${gaurantorMaster} WHERE ${TablesColumnFile
            .mrefno}=$mrefno AND ${TablesColumnFile
            .trefno}=$trefno;');

  }

  Future<DocumentCollectorBean> isThisTypeOfDocPresent(String custtype,String imgtype) async {
    String selectQueryIsDataSynced =
        "Select * from ${DOCUMENTSMASTER} WHERE "
        "${TablesColumnFile.mcustomertype + " = " + custtype.toString() }"
        "${" AND "+TablesColumnFile.mimgtype+ " = " + imgtype.toString()}; ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    DocumentCollectorBean bean;



    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DocumentCollectorBean();
        bean = bindDataDocumentCollectorListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<DocumentCollectorBean> isThisTypeOfDocPresentcust(String custtype,String imgtype, int custtref, int custmtrf) async {
    String selectQueryIsDataSynced =
        "Select * from ${DOCUMENTSMASTER} WHERE "
        "${TablesColumnFile.mcustomertype + " = " + custtype.toString() }"
        "${" AND "+TablesColumnFile.mcusttrefno + " = " + custtref.toString() }"
        "${" AND "+TablesColumnFile.mcustmrefno + " = " + custmtrf.toString() }"
        "${" AND "+TablesColumnFile.mimgtype+ " = " + imgtype.toString()}; ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());


    DocumentCollectorBean bean;



    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DocumentCollectorBean();
        bean = bindDataDocumentCollectorListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }
}