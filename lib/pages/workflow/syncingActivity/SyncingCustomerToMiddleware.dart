import 'dart:convert';
import 'dart:io';

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
import 'package:eco_los/pages/workflow/syncingActivity/CheckExistingCustomerFromMiddleware.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';

import 'package:path_provider/path_provider.dart';

class SyncingCustomertoMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};
  List<FamilyDetailsBean> customerFamilyDetailsList = List();

  List<SocialFinancialDetailsBean> customerBankDetailsList = List();

  List<BorrowingDetailsBean> customerBorrowingDetailsList = List();
  List<AddressDetailsBean> customerAddressDetailsList = List();
  List<CustomerBusinessDetailsBean> customerBusinessDetailsBean = List();

  ESMSBean customerESMSBean = new ESMSBean();
  RiskRatingsBean customerRiskRatingsBean = new RiskRatingsBean();
  List<BusinessExpenditureDetailsBean> businessExpendDetailsList = List();
  List<HouseholdExpenditureDetailsBean> householdExpendDetailsList = List();
  List<AssetDetailsBean> assetDetailsList = List();

  CustomerCheckBean custCheckObj = new CustomerCheckBean();
  FixedAssetsBean fixedAssetsList = FixedAssetsBean();
  CurrentAssetsBean currentAssetsList = CurrentAssetsBean();
  LongTermLiabilitiesBean longTermLiabilitiesList = LongTermLiabilitiesBean();
  ShortTermLiabilitiesBean shortTermLiabilitiesList =
      ShortTermLiabilitiesBean();
  EquityBean equityList = EquityBean();
  IncomeStatementBean incomeStatemntBean = new IncomeStatementBean();
  FinancialStmntBean financialStatemntBean = new FinancialStmntBean();
  TotalExpenditureDetailsBean totalExpenditureDetailsBean =
      new TotalExpenditureDetailsBean();
  List<ImageBean> imageList = List();
  List listCust = List();
  bool isForSingleCustomer = false;
  int mrefnoGeneratedForSingleCustomer = 0;
  DateTime lastSyncedToServerDaeTime = null;

  Future<Null> syncedDataToMiddleware(String json) async {
   try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      print("returned data is $bodyValue");
      if (bodyValue == "404") {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerListBean> obj = parsed
            .map<CustomerListBean>((json) =>
                CustomerListBean.fromMapMiddlewareFroMrefNoOnly(json, true))
            .toList();
        List<int> updatedInTabCust = new List<int>();
       /* List<CustomerListBean> obj = new List<CustomerListBean>();

        await parsed.map<CustomerListBean>((json) async{
          CustomerListBean addBean = null;
          json.forEach((f) {
          try {
            print("fffffffffffffffff "+f.toString());
            addBean =  CustomerListBean.fromMapMiddlewareFroMrefNoOnly(f, true);
          }catch(_){}
          });
             obj.add(addBean);
         });*/


        for (int cust = 0; cust < obj.length; cust++) {
          print("xxxxxxx  returned Cust no is ${obj[cust].mcustno}");

          print("print que : " +
              obj[cust].mrefno.toString() +
              " : " +
              obj[cust].trefno.toString());
          try{
          /*await AppDatabase.get()
              .selectCustomerOnTref(obj[cust].trefno, obj[cust].mcreatedby)
              .then((List<CustomerListBean> customerData) async {*/
            await AppDatabase.get()
                .selectCustomerOnTrefANDMrefno(obj[cust].trefno, obj[cust].mcreatedby,obj[cust].mrefno)
                .then((CustomerListBean customerData) async {
            String updateCustQuery = "";
            String updateFamQuery = "";
            String updateBankQuery = "";
            String updateBorroQuery = "";
            String updateAddrQuery = "";
            String updateBusinessQuery = "";
            String updateImageQuery = "";
            String updateAssetQuery = "";
            String updateFixedAssetQuery = "";
            String updateCurrentAssetQuery = "";
            String updateLngTrmLiabQuery = "";
            String updateShrtTrmLiabQuery = "";
            String updateEquityQuery = "";
            String updateIncmStmtQuery = "";
            String updateFinStmtQuery = "";
            String updateTotlExpQuery = "";
            String updateESMSQuery = "";
            String updateRiskRatingsQuery = "";

            bool isSyncingFirstTime = false;
            //print("customerData.length" + customerData.length.toString());
            /*for (int checkIfMrefnoZero = 0; checkIfMrefnoZero <
                customerData.length; checkIfMrefnoZero++) {
            */  print("(customerData[checkIfMrefnoZero].mrefno " +
                  customerData.mrefno.toString());
              if (obj[cust] != null &&
                  obj[cust].mrefno != null &&
                  (customerData.mrefno == null ||
                      customerData.mrefno == 0)) {
                isSyncingFirstTime = true;
                updateCustQuery = "${TablesColumnFile.mcustno} = ${obj[cust]
                    .mcustno},${TablesColumnFile.mlastsynsdate} = '${DateTime
                    .now()}' ,${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now().subtract(Duration(minutes: 1))}' , ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno}, ${TablesColumnFile
                    .merrormessage} = '${obj[cust]
                    .merrormessage}'  WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}"
                    " AND ${TablesColumnFile.mrefno} = 0";
                //break;
              } else{
                updateCustQuery = "${TablesColumnFile.mcustno} = ${obj[cust]
                    .mcustno}, ${TablesColumnFile.mlastsynsdate} = '${DateTime
                    .now()}' ,${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now().subtract(
                    Duration(minutes: 1))}' WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }
          //  }

            if (!isSyncingFirstTime) {
              }


            print("update cust " + updateCustQuery);
            if (updateCustQuery != null) {
              await AppDatabase.get().updateCustomerMaster(updateCustQuery);
            }

            //updating loans details here with new generated mrefno
            if (isSyncingFirstTime) {
              String updateQueryLoan =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mcustmrefno} = ${obj[cust]
                  .mrefno} WHERE ${TablesColumnFile.mcusttrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                  .mcreatedby}'";
              await AppDatabase.get().updateCustomerLoanMaster(updateQueryLoan);
            }
            if (isSyncingFirstTime) {
              String updateQuerySavings =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mcustmrefno} = ${obj[cust]
                  .mrefno} WHERE ${TablesColumnFile.mcusttrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                  .mcreatedby}'";
              await AppDatabase.get()
                  .updateSavingsAccountMaster(updateQuerySavings);
            }

            if (isSyncingFirstTime) {
              String updateQuerySavings =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mcustmrefno} = ${obj[cust]
                  .mrefno} WHERE ${TablesColumnFile.mcusttrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                  .mcreatedby}'";
              await AppDatabase.get()
                  .updateGaurantorMasterForCustomer(updateQuerySavings);
            }


            if (isSyncingFirstTime) {
              String updateQuerySavings =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mcustmrefno} = ${obj[cust]
                  .mrefno} WHERE ${TablesColumnFile.mcusttrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                  .mcreatedby}'";
              await AppDatabase.get()
                  .updateDocumentMasterForCustomer(updateQuerySavings);
            }
            for (int famList = 0;
            famList < obj[cust].familyDetailsList.length;
            famList++) {
              try {
                if (isSyncingFirstTime) {
                  updateFamQuery =
                  "${TablesColumnFile.mfamilyrefno} = ${obj[cust]
                      .familyDetailsList[famList]
                      .mfamilyrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                      .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust]
                      .trefno}";
                } else {
                  updateFamQuery =
                  "${TablesColumnFile.mfamilyrefno} = ${obj[cust]
                      .familyDetailsList[famList]
                      .mfamilyrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateCustQuery != null) {
                  await AppDatabase.get().updateFamily(updateFamQuery);
                }
              } catch (_) {}
            }




            for (int bankList = 0;
            bankList < obj[cust].socialFinancialList.length;
            bankList++) {
              try {
                if (isSyncingFirstTime) {
                  updateBankQuery =
                  "${TablesColumnFile.mbanktrefno} = ${obj[cust]
                      .socialFinancialList[bankList]
                      .mbanktrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                      .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust]
                      .trefno}";
                } else {
                  updateBankQuery =
                  "${TablesColumnFile.mbanktrefno} = ${obj[cust]
                      .socialFinancialList[bankList]
                      .mbanktrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateCustQuery != null) {
                  await AppDatabase.get().updateBank(updateBankQuery);
                }
              } catch (_) {}
            }





            for (int addrList = 0;
            addrList < obj[cust].addressDetails.length;
            addrList++) {
              try {
                if (isSyncingFirstTime) {
                  updateAddrQuery =
                  "${TablesColumnFile.maddressrefno} = ${obj[cust]
                      .addressDetails[addrList]
                      .maddressrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                      .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust]
                      .trefno}";
                } else {
                  updateAddrQuery =
                  "${TablesColumnFile.maddressrefno} = ${obj[cust]
                      .addressDetails[addrList]
                      .maddressrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateAddrQuery != null) {
                  print("updateAddrQuery" + updateAddrQuery);
                  await AppDatabase.get().updateAddress(updateAddrQuery);
                }
              } catch (_) {}
            }

            for (int borroList = 0;
            borroList < obj[cust].borrowingDetailsBean.length;
            borroList++) {
              try {
                if (isSyncingFirstTime) {
                  updateBorroQuery =
                  "${TablesColumnFile.mborrowingrefno} = ${obj[cust]
                      .borrowingDetailsBean[borroList]
                      .mborrowingrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                      .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                      .trefno}";
                } else {
                  updateBorroQuery =
                  "${TablesColumnFile.mborrowingrefno} = ${obj[cust]
                      .borrowingDetailsBean[borroList]
                      .mborrowingrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateBorroQuery != null) {
                  await AppDatabase.get().updateBorrowing(updateBorroQuery);
                }
              } catch (_) {}
            }
            //asset detail
            for (int assetList = 0;
            assetList < obj[cust].assetDetailsList.length;
            assetList++) {
              try {
                if (isSyncingFirstTime) {
                  updateAssetQuery =
                  "${TablesColumnFile.massetdetrefno} = ${obj[cust]
                      .assetDetailsList[assetList]
                      .massetdetrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                      .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust]
                      .trefno}";
                } else {
                  updateAssetQuery =
                  "${TablesColumnFile.massetdetrefno} = ${obj[cust]
                      .assetDetailsList[assetList]
                      .massetdetrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateAssetQuery != null) {
                  await AppDatabase.get().updateAssetDetails(updateAssetQuery);
                }
              } catch (_) {}
            }

            for (int busList = 0;
            busList < obj[cust].customerBusinessDetailsBean.length;
            busList++) {
              try {
                if (isSyncingFirstTime) {
                  updateBusinessQuery =
                  "${TablesColumnFile.mbussdetailsrefno} = ${obj[cust]
                      .customerBusinessDetailsBean[busList]
                      .mbussdetailsrefno},${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} WHERE  ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                } else {
                  updateBusinessQuery =
                  "${TablesColumnFile.mbussdetailsrefno} = ${obj[cust]
                      .customerBusinessDetailsBean[busList]
                      .mbussdetailsrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateCustQuery != null) {
                  await AppDatabase.get()
                      .updateBussinessDetail(updateBusinessQuery);
                }
              } catch (_) {}
            }

            //}

            //update image
            for (int imageList = 0;
            imageList < obj[cust].imageMaster.length;
            imageList++) {
              try {
                if (isSyncingFirstTime) {
                  updateImageQuery =
                  "${TablesColumnFile.mImgrefno} = ${obj[cust]
                      .imageMaster[imageList].mImgrefno},${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                } else {
                  updateImageQuery =
                  "${TablesColumnFile.mImgrefno} = ${obj[cust]
                      .imageMaster[imageList]
                      .mImgrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cust].trefno}";
                }

                if (updateImageQuery != null) {
                  await AppDatabase.get().updateImage(updateImageQuery);
                }
              } catch (_) {}
            }

            //fixed asset detail
            try {
              if (isSyncingFirstTime) {
                updateFixedAssetQuery =
                "${TablesColumnFile.mfixedassetrefno} = ${obj[cust]
                    .fixedAssetsList.mfixedassetrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              } else {
                updateFixedAssetQuery =
                "${TablesColumnFile.mfixedassetrefno} = ${obj[cust]
                    .fixedAssetsList.mfixedassetrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateFixedAssetQuery != null) {
                await AppDatabase.get().updateFixedAsset(updateFixedAssetQuery);
              }
            } catch (_) {}
            //current asset detail
            try {
              if (isSyncingFirstTime) {
                updateCurrentAssetQuery =
                "${TablesColumnFile.mcurrentassetrefno} = ${obj[cust]
                    .currentAssetsList.mcurrentassetrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              } else {
                updateCurrentAssetQuery =
                "${TablesColumnFile.mcurrentassetrefno} = ${obj[cust]
                    .currentAssetsList
                    .mcurrentassetrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateCurrentAssetQuery != null) {
                await AppDatabase.get()
                    .updateCurrentAsset(updateCurrentAssetQuery);
              }
            } catch (_) {}
            //long term liability detail
            try {
              if (isSyncingFirstTime) {
                updateLngTrmLiabQuery =
                "${TablesColumnFile.mlngtrmliabiltyrefno} = ${obj[cust]
                    .longTermLiabilitiesList
                    .mlngtrmliabiltyrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              } else {
                updateLngTrmLiabQuery =
                "${TablesColumnFile.mlngtrmliabiltyrefno} = ${obj[cust]
                    .longTermLiabilitiesList
                    .mlngtrmliabiltyrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateLngTrmLiabQuery != null) {
                await AppDatabase.get()
                    .updateLongTermLiabilities(updateLngTrmLiabQuery);
              }
            } catch (_) {}
//short term liability detail
            try {
              if (isSyncingFirstTime) {
                updateShrtTrmLiabQuery =
                "${TablesColumnFile.mshrttrmliabiltyrefno} = ${obj[cust]
                    .shortTermLiabilitiesList
                    .mshrttrmliabiltyrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              } else {
                updateShrtTrmLiabQuery =
                "${TablesColumnFile.mshrttrmliabiltyrefno} = ${obj[cust]
                    .shortTermLiabilitiesList
                    .mshrttrmliabiltyrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateShrtTrmLiabQuery != null) {
                await AppDatabase.get()
                    .updateShortTermLiabilities(updateShrtTrmLiabQuery);
              }
            } catch (_) {}
//equity detail
            try {
              if (isSyncingFirstTime) {
                updateEquityQuery =
                "${TablesColumnFile.mequityrefno} = ${obj[cust].equityList
                    .mequityrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}";
              } else {
                updateEquityQuery =
                "${TablesColumnFile.mequityrefno} = ${obj[cust].equityList
                    .mequityrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateEquityQuery != null) {
                await AppDatabase.get().updateEquity(updateEquityQuery);
              }
            } catch (_) {}
            //income statement detail
            try {
              if (isSyncingFirstTime) {
                updateIncmStmtQuery =
                "${TablesColumnFile.mincomerefno} = ${obj[cust]
                    .incomeStatementList.mincomerefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              } else {
                updateIncmStmtQuery =
                "${TablesColumnFile.mincomerefno} = ${obj[cust]
                    .incomeStatementList.mincomerefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateIncmStmtQuery != null) {
                await AppDatabase.get()
                    .updateIncomeStatement(updateIncmStmtQuery);
              }
            } catch (_) {}

            //financial statement detail
            try {
              if (isSyncingFirstTime) {
                updateFinStmtQuery =
                "${TablesColumnFile.mfinancialstmntrefno} = ${obj[cust]
                    .financialStmntList.mfinancialstmntrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              } else {
                updateFinStmtQuery =
                "${TablesColumnFile.mfinancialstmntrefno} = ${obj[cust]
                    .financialStmntList
                    .mfinancialstmntrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateFinStmtQuery != null) {
                await AppDatabase.get()
                    .updateFinancialStatement(updateFinStmtQuery);
              }
            } catch (_) {}

            //updateTotlExpQuery statement detail
            try {
              if (isSyncingFirstTime) {
                updateTotlExpQuery =
                "${TablesColumnFile.mtotlexpnmrefno} = ${obj[cust]
                    .totalExpenditureDetailsBean
                    .mtotlexpnmrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}";
              } else {
                updateTotlExpQuery =
                "${TablesColumnFile.mtotlexpnmrefno} = ${obj[cust]
                    .totalExpenditureDetailsBean
                    .mtotlexpnmrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].trefno}";
              }

              if (updateTotlExpQuery != null) {
                await AppDatabase.get().updateTotalExpndtr(updateTotlExpQuery);
              }
            } catch (_) {}
            try {
              if (isSyncingFirstTime) {
                updateESMSQuery =
                "${TablesColumnFile.mesmsrefno} = ${obj[cust].esmsentity
                    .mesmsrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} WHERE ${TablesColumnFile.trefno} =  ${obj[cust]
                    .trefno}";
              } else {
                updateESMSQuery =
                "${TablesColumnFile.mesmsrefno} = ${obj[cust].esmsentity
                    .mesmsrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} =  ${obj[cust]
                    .trefno}";
              }

              if (updateESMSQuery != null) {
                await AppDatabase.get().updateESMS(updateESMSQuery);
              }
            } catch (_) {}

            try {
              if (isSyncingFirstTime) {
                updateRiskRatingsQuery =
                "${TablesColumnFile.mriskratingsrefno} = ${obj[cust]
                    .riskratingsentity.mriskratingsrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile
                    .trefno} =  ${obj[cust].trefno}";
              } else {
                updateRiskRatingsQuery =
                "${TablesColumnFile.mriskratingsrefno} = ${obj[cust]
                    .riskratingsentity
                    .mriskratingsrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} =  ${obj[cust].trefno}";
              }

              if (updateRiskRatingsQuery != null) {
                await AppDatabase.get().updateRiskRatings(
                    updateRiskRatingsQuery);
              }
            } catch (_) {}
          });
          updatedInTabCust.add(obj[cust].mrefno);
          print("updatedInTabCust"+updatedInTabCust.toString());
        }catch(_){}
        }

        //updating lastsynced date time with now
        if (!isForSingleCustomer) {
          AppDatabase.get().updateStaticTablesLastSyncedMaster(1);
        }
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> customerNormalData() async {
    List customerList = new List();
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1, false)
        .then((onValue) async {
      await AppDatabase.get()
          .selectCustomerListIsDataSynced(onValue)
          .then((List<CustomerListBean> customerData) async {
        print("lengtrh cust " + customerData.length.toString());
        for (int i = 0; i < customerData.length; i++) {
          await AppDatabase.get()
              .selectCustomerFamilyDetailsListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((List<FamilyDetailsBean> familyDetailsBean) async {
            customerFamilyDetailsList = familyDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerBankDetailsListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<SocialFinancialDetailsBean> socialFinancialDetailsBean) async {
            customerBankDetailsList = socialFinancialDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerBorrowingDetailsListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((List<BorrowingDetailsBean> borrowingDetailsBean) async {
            customerBorrowingDetailsList = borrowingDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerAddressDetailsListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((List<AddressDetailsBean> addressDetails) async {
            customerAddressDetailsList = addressDetails;
          });

          await AppDatabase.get()
              .selectImagesListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((List<ImageBean> imageBean) async {
            imageList = imageBean;
          });

          await AppDatabase.get()
              .selectCustomerBussinessDetails(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((List<CustomerBusinessDetailsBean> customerBussBean) async {
            customerBusinessDetailsBean = customerBussBean;
          });

          /*     await AppDatabase.get()
              .selectCustomerBusinessExpenseListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<BusinessExpenditureDetailsBean> businessExpenditureDetailsBean) async {
            businessExpendDetailsList = businessExpenditureDetailsBean;
          });*/

          /*     await AppDatabase.get()
              .selectCustomerHouseholdExpenseListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<HouseholdExpenditureDetailsBean> householdExpenditureDetailsBean) async {
            householdExpendDetailsList = householdExpenditureDetailsBean;
          });*/

          await AppDatabase.get()
              .selectCustomerAssetDetailListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((List<AssetDetailsBean> assetDetailsBean) async {
            assetDetailsList = assetDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerFixedAssetListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((FixedAssetsBean fixedAssetsBean) async {
            fixedAssetsList = fixedAssetsBean;
          });

          await AppDatabase.get()
              .selectCustomerCurrentAssetListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((CurrentAssetsBean currentAssetsBean) async {
            currentAssetsList = currentAssetsBean;
          });

          await AppDatabase.get()
              .selectCustomerLongTermLiabilitiesListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((LongTermLiabilitiesBean longTermLiabilitiesBean) async {
            longTermLiabilitiesList = longTermLiabilitiesBean;
          });

          await AppDatabase.get()
              .selectCustomerShortTermLiabilitiesListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((ShortTermLiabilitiesBean shortTermLiabilitiesBean) async {
            shortTermLiabilitiesList = shortTermLiabilitiesBean;
          });

          await AppDatabase.get()
              .selectCustomerEquityListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((EquityBean equityBean) async {
            equityList = equityBean;
          });

          await AppDatabase.get()
              .selectCustomerIncomeStatementListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((IncomeStatementBean incomeStatementBean) async {
            incomeStatemntBean = incomeStatementBean;
          });

          await AppDatabase.get()
              .selectCustomerTotalExpndtrListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then(
                  (TotalExpenditureDetailsBean totalExpenditureDetails) async {
            totalExpenditureDetailsBean = totalExpenditureDetails;
          });

          await AppDatabase.get()
              .selectCustomerFinancialStatementListIsDataSynced(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((FinancialStmntBean financialStmntBean) async {
            financialStatemntBean = financialStmntBean;
          });
          await AppDatabase.get()
              .selectCustomerESMSDetails(
                  customerData[i].trefno, customerData[i].mrefno)
              .then((ESMSBean returnESMSBean) async {
            customerESMSBean = returnESMSBean;
          });

          await AppDatabase.get()
              .selectCustomerRiskRatingsDetails(
              customerData[i].trefno, customerData[i].mrefno)
              .then((RiskRatingsBean returnRiskratingsBean) async {
            customerRiskRatingsBean = returnRiskratingsBean;
          });

          await _toCustomerJson(customerData[i]).then((onValue) {});
        }
      });
      _serviceUrl = "customerData/addCustomerByHolder";
      String json = JSON.encode(listCust);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  Future<Null> _toCustomerJson(CustomerListBean customerListBean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =
        customerListBean.trefno != null ? customerListBean.trefno : 0;
    mapData[TablesColumnFile.mrefno] =
        customerListBean.mrefno != null ? customerListBean.mrefno : 0;
    mapData[TablesColumnFile.mcustno] =
        customerListBean.mcustno != null ? customerListBean.mcustno : 0;
    mapData[TablesColumnFile.mlbrcode] =
        customerListBean.mlbrcode != null ? customerListBean.mlbrcode : 0;
    //mIsMbrGrp
    mapData[TablesColumnFile.mcenterid] =
        customerListBean.mcenterid != null ? customerListBean.mcenterid : 0;
    mapData[TablesColumnFile.mgroupcd] =
        customerListBean.mgroupcd != null ? customerListBean.mgroupcd : 0;
    mapData[TablesColumnFile.mnametitle] =
        ifNullCheck(customerListBean.mnametitle);
    mapData[TablesColumnFile.mlongname] =
        ifNullCheck(customerListBean.mlongname);
    mapData[TablesColumnFile.mfathertitle] =
        ifNullCheck(customerListBean.mfathertitle);
    mapData[TablesColumnFile.mfatherfname] =
        ifNullCheck(customerListBean.mfatherfname);
    mapData[TablesColumnFile.mfathermname] =
        ifNullCheck(customerListBean.mfathermname);
    mapData[TablesColumnFile.mfatherlname] =
        ifNullCheck(customerListBean.mfatherlname);
    mapData[TablesColumnFile.mspousetitle] =
        ifNullCheck(customerListBean.mspousetitle);
    mapData[TablesColumnFile.mhusbandname] =
        ifNullCheck(customerListBean.mhusbandname);
    mapData[TablesColumnFile.mdob] = customerListBean.mdob != null
        ? customerListBean.mdob.toIso8601String()
        : null;
    mapData[TablesColumnFile.mage] =
        customerListBean.mage != null ? customerListBean.mage : 0;
    mapData[TablesColumnFile.mbankacno] = customerListBean.mbankacno.toString();
    /*mapData[TablesColumnFile.mbankacyn] =
    customerListBean.mbankacyn != null ? customerListBean.mbankacyn : 0;*/
    mapData[TablesColumnFile.mbankacyn] =
        ifNullCheck(customerListBean.mbankacyn);
    mapData[TablesColumnFile.mbankifsc] =
        ifNullCheck(customerListBean.mbankifsc);
    mapData[TablesColumnFile.mbanknamelk] =
        ifNullCheck(customerListBean.mbanknamelk);
    mapData[TablesColumnFile.mbankbranch] =
        ifNullCheck(customerListBean.mbankbranch);
    mapData[TablesColumnFile.mcuststatus] =
        customerListBean.mcuststatus != null ? customerListBean.mcuststatus : 0;
    mapData[TablesColumnFile.mdropoutdate] =
        customerListBean.mdropoutdate != null
            ? customerListBean.mdropoutdate.toIso8601String()
            : null;
    mapData[TablesColumnFile.mmobno] = ifNullCheck(customerListBean.mmobno);
    mapData[TablesColumnFile.mpanno] =
        customerListBean.mpanno != null ? customerListBean.mpanno : 0;
    mapData[TablesColumnFile.mpannodesc] =
        ifNullCheck(customerListBean.mpannodesc);
    mapData[TablesColumnFile.mtdsyn] = ifNullCheck(customerListBean.mtdsyn);
    mapData[TablesColumnFile.mtdsreasoncd] =
        customerListBean.mtdsreasoncd != null
            ? customerListBean.mtdsreasoncd
            : 0;
    mapData[TablesColumnFile.mtdsfrm15subdt] =
        customerListBean.mtdsfrm15subdt != null
            ? customerListBean.mtdsfrm15subdt.toIso8601String()
            : null;
    mapData[TablesColumnFile.memailId] = ifNullCheck(customerListBean.memailId);
    mapData[TablesColumnFile.mcustcategory] =
        ifNullCheck(customerListBean.mcustcategory);

    mapData[TablesColumnFile.mtier] =
        customerListBean.mtier != null ? customerListBean.mtier : 0;
    mapData[TablesColumnFile.mAdd1] = ifNullCheck(customerListBean.mAdd1);
    mapData[TablesColumnFile.mAdd2] = ifNullCheck(customerListBean.mAdd2);
    mapData[TablesColumnFile.mAdd3] = ifNullCheck(customerListBean.mAdd3);
    mapData[TablesColumnFile.marea] =
        customerListBean.mArea != null ? customerListBean.mArea : 0;
    mapData[TablesColumnFile.mPinCode] = ifNullCheck(customerListBean.mPinCode);
    mapData[TablesColumnFile.mCounCd] = ifNullCheck(customerListBean.mCounCd);
    mapData[TablesColumnFile.mCityCd] = ifNullCheck(customerListBean.mCityCd);
    mapData[TablesColumnFile.mfname] = ifNullCheck(customerListBean.mfname);
    mapData[TablesColumnFile.mmname] = ifNullCheck(customerListBean.mmname);
    mapData[TablesColumnFile.mlname] = ifNullCheck(customerListBean.mlname);
    print("Gender");
    print(customerListBean.mgender);
    mapData[TablesColumnFile.mgender] = customerListBean.mgender;
    mapData[TablesColumnFile.mrelegion] =
        ifNullCheck(customerListBean.mrelegion);
    /*mapData[TablesColumnFile.mrelegion] =
    customerListBean.mrelegion != null || customerListBean.mrelegion != "null" ? customerListBean.mrelegion : "0";*/
    mapData[TablesColumnFile.mRuralUrban] =
        customerListBean.mRuralUrban != null ? customerListBean.mRuralUrban : 0;
    mapData[TablesColumnFile.mcaste] = ifNullCheck(customerListBean.mcaste);
    mapData[TablesColumnFile.mqualification] =
        ifNullCheck(customerListBean.mqualification);
    mapData[TablesColumnFile.moccupation] =
        customerListBean.moccupation != null ? customerListBean.moccupation : 0;
    mapData[TablesColumnFile.mLandType] =
        ifNullCheck(customerListBean.mLandType);
    mapData[TablesColumnFile.mLandMeasurement] =
        ifNullCheck(customerListBean.mLandMeasurement);
    mapData[TablesColumnFile.mmaritialStatus] =
        customerListBean.mmaritialStatus != null
            ? customerListBean.mmaritialStatus
            : 0;
    mapData[TablesColumnFile.mTypeOfId] =
        customerListBean.mTypeOfId != null ? customerListBean.mTypeOfId : 0;
    mapData[TablesColumnFile.mIdDesc] = ifNullCheck(customerListBean.mIdDesc);
    /* mapData[TablesColumnFile.mInsuranceCovYN] =
    customerListBean.mInsuranceCovYN != null || customerListBean.mInsuranceCovYN != "null" ? customerListBean.mInsuranceCovYN : "0";*/
    mapData[TablesColumnFile.mInsuranceCovYN] =
        ifNullCheck(customerListBean.mInsuranceCovYN);
    mapData[TablesColumnFile.mTypeofCoverage] =
        customerListBean.mTypeofCoverage != null
            ? customerListBean.mTypeofCoverage
            : 0;
    mapData[TablesColumnFile.mcreateddt] = customerListBean.mcreateddt != null
        ? customerListBean.mcreateddt.toIso8601String()
        : null;
    mapData[TablesColumnFile.mcreatedby] =
        ifNullCheck(customerListBean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =
        customerListBean.mlastupdatedt != null
            ? customerListBean.mlastupdatedt.toIso8601String()
            : null;
    mapData[TablesColumnFile.mlastupdateby] =
        ifNullCheck(customerListBean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =
        ifNullCheck(customerListBean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(customerListBean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(customerListBean.mgeologd);
    mapData[TablesColumnFile.misCbCheckDone] =
        customerListBean.misCbCheckDone != null
            ? customerListBean.misCbCheckDone
            : 0;
    mapData[TablesColumnFile.mcbcheckrprtdt] =
        customerListBean.mcbcheckrprtdt != null
            ? customerListBean.mcbcheckrprtdt.toIso8601String()
            : null;

    mapData[TablesColumnFile.merrormessage] =
        ifNullCheck(customerListBean.merrormessage);
    mapData[TablesColumnFile.missynctocoresys] =
        customerListBean.missynctocoresys != null
            ? customerListBean.missynctocoresys
            : 0;
    mapData[TablesColumnFile.mlastsynsdate] =
        customerListBean.mlastsynsdate != null
            ? customerListBean.mlastsynsdate.toIso8601String()
            : null;
    mapData[TablesColumnFile.mloanagreed] =
        customerListBean.mLoanAgreed != null ? customerListBean.mLoanAgreed : 0;
    print("Center Name");
    print(customerListBean.mcentername);
    print(ifNullCheck(customerListBean.mcentername.trim()));
    print(customerListBean.mgroupname);
    print(ifNullCheck(customerListBean.mgroupname.trim()));
    mapData[TablesColumnFile.mcentername] =
        ifNullCheck(customerListBean.mcentername.trim());

    mapData[TablesColumnFile.mgroupname] =
        ifNullCheck(customerListBean.mgroupname.trim());
    mapData[TablesColumnFile.mhusdob] = customerListBean.mhusdob != null
        ? customerListBean.mhusdob.toIso8601String()
        : null;
    mapData[TablesColumnFile.mprofileind] =
        ifNullCheck(customerListBean.mprofileind);

    mapData[TablesColumnFile.mlangofcust] =
        ifNullCheck(customerListBean.mlangofcust);
    mapData[TablesColumnFile.mmainoccupn] =
        ifNullCheck(customerListBean.mmainoccupn);
    mapData[TablesColumnFile.msuboccupn] =
        ifNullCheck(customerListBean.msuboccupn);
    mapData[TablesColumnFile.mmainoccupndesc] =
        ifNullCheck(customerListBean.mmainoccupndesc);
    mapData[TablesColumnFile.msuboccupndesc] =
        ifNullCheck(customerListBean.msuboccupndesc);
    mapData[TablesColumnFile.msecoccupatn] =
        customerListBean.msecoccupatn != null
            ? customerListBean.msecoccupatn
            : 0;

    mapData[TablesColumnFile.mnametitle] =
        ifNullCheck(customerListBean.mnametitle2);
    mapData[TablesColumnFile.mlongname] =
        ifNullCheck(customerListBean.mlongname2);
    mapData[TablesColumnFile.mfname2] = ifNullCheck(customerListBean.mfname2);
    mapData[TablesColumnFile.mmname2] = ifNullCheck(customerListBean.mmname2);
    mapData[TablesColumnFile.mlname2] = ifNullCheck(customerListBean.mlname2);

    mapData[TablesColumnFile.mid1issuedate] =
        customerListBean.mid1issuedate != null
            ? customerListBean.mid1issuedate.toIso8601String()
            : null;
    mapData[TablesColumnFile.mid2issuedate] =
        customerListBean.mid2issuedate != null
            ? customerListBean.mid2issuedate.toIso8601String()
            : null;
    mapData[TablesColumnFile.mid1expdate] = customerListBean.mid1expdate != null
        ? customerListBean.mid1expdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mid2expdate] = customerListBean.mid2expdate != null
        ? customerListBean.mid2expdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mnationality] =
        ifNullCheck(customerListBean.mnationality);

    mapData[TablesColumnFile.mid3expdate] = customerListBean.mid3expdate != null
        ? customerListBean.mid3expdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mid3issuedate] =
        customerListBean.mid3issuedate != null
            ? customerListBean.mid3issuedate.toIso8601String()
            : null;
    mapData[TablesColumnFile.missngautryt1] =
        ifNullCheck(customerListBean.missngautryt1);
    mapData[TablesColumnFile.missngautryt2] =
        ifNullCheck(customerListBean.missngautryt2);
    mapData[TablesColumnFile.missngautryt3] =
        ifNullCheck(customerListBean.missngautryt3);

    mapData[TablesColumnFile.mtypeofid3] =
        customerListBean.mtypeofid3 != null ? customerListBean.mtypeofid3 : 0;
    mapData[TablesColumnFile.macctbal] =
        customerListBean.macctbal != null ? customerListBean.macctbal : 0;

    mapData[TablesColumnFile.middesc3] = ifNullCheck(customerListBean.middesc3);

    mapData[TablesColumnFile.misearngmembr] =
        ifNullCheck(customerListBean.misearngmembr);
    mapData[TablesColumnFile.misstudyingmembr] =
        ifNullCheck(customerListBean.misstudyingmembr);
    mapData[TablesColumnFile.mmemberno] =
        ifNullCheck(customerListBean.mmemberno);
    mapData[TablesColumnFile.mischldrn] =
        ifNullCheck(customerListBean.mischldrn);
    mapData[TablesColumnFile.mbusinessname] =
        ifNullCheck(customerListBean.mbusinessname);
    mapData[TablesColumnFile.mtarget] = ifNullCheck(customerListBean.mtarget);
    mapData[TablesColumnFile.mownership] =
        ifNullCheck(customerListBean.mownership);
    mapData[TablesColumnFile.mresstatus] =
        ifNullCheck(customerListBean.mresstatus);

    mapData[TablesColumnFile.miscpemp] = ifNullCheck(customerListBean.miscpemp);
    mapData[TablesColumnFile.mrankofemp] =
        ifNullCheck(customerListBean.mrankofemp);
    mapData[TablesColumnFile.mempid] = ifNullCheck(customerListBean.mempid);

    var mapDataFamily;
    var famiDetList = List();
    for (int famDetList = 0;
        famDetList < customerFamilyDetailsList.length;
        famDetList++) {
      mapDataFamily = new Map();
      mapDataFamily[TablesColumnFile.tfamilyrefno] =
          customerFamilyDetailsList[famDetList].tfamilyrefno != null
              ? customerFamilyDetailsList[famDetList].tfamilyrefno
              : 0;
      mapDataFamily[TablesColumnFile.trefno] =
          customerFamilyDetailsList[famDetList].trefno != null
              ? customerFamilyDetailsList[famDetList].trefno
              : 0;
      // mapDataFamily[TablesColumnFile.mfamilyrefno] =	        customerFamilyDetailsList[famDetList].mfamilyrefno!=null?customerFamilyDetailsList[famDetList].mfamilyrefno:0;
      mapDataFamily[TablesColumnFile.mrefno] =
          customerFamilyDetailsList[famDetList].mrefno != null
              ? customerFamilyDetailsList[famDetList].mrefno
              : 0;
      mapDataFamily[TablesColumnFile.mcustno] =
          customerFamilyDetailsList[famDetList].mcustno != null
              ? customerFamilyDetailsList[famDetList].mcustno
              : 0;

      mapDataFamily[TablesColumnFile.mnicno] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mnicno);
      mapDataFamily[TablesColumnFile.mdob] =
          customerFamilyDetailsList[famDetList].mdob != null
              ? customerFamilyDetailsList[famDetList].mdob.toIso8601String()
              : null;
      mapDataFamily[TablesColumnFile.mage] =
          customerFamilyDetailsList[famDetList].mage != null
              ? customerFamilyDetailsList[famDetList].mage
              : 0;
      mapDataFamily[TablesColumnFile.meducation] =
          ifNullCheck(customerFamilyDetailsList[famDetList].meducation);
      mapDataFamily[TablesColumnFile.mmemberno] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mmemberno);
      mapDataFamily[TablesColumnFile.moccuptype] =
          customerFamilyDetailsList[famDetList].moccuptype != null
              ? customerFamilyDetailsList[famDetList].moccuptype
              : 0;
      mapDataFamily[TablesColumnFile.mincome] =
          customerFamilyDetailsList[famDetList].mincome != null
              ? customerFamilyDetailsList[famDetList].mincome
              : 0;
      mapDataFamily[TablesColumnFile.mhealthstatus] =
          customerFamilyDetailsList[famDetList].mhealthstatus != null
              ? customerFamilyDetailsList[famDetList].mhealthstatus
              : 0;
      mapDataFamily[TablesColumnFile.mrelationwithcust] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mrelationwithcust);
      mapDataFamily[TablesColumnFile.maritalstatus] =
          ifNullCheck(customerFamilyDetailsList[famDetList].maritalstatus);
      mapDataFamily[TablesColumnFile.mcontrforhouseexp] =
          customerFamilyDetailsList[famDetList].mcontrforhouseexp != null
              ? customerFamilyDetailsList[famDetList].mcontrforhouseexp
              : 0;
      mapDataFamily[TablesColumnFile.macidntlinsurance] =
          ifNullCheck(customerFamilyDetailsList[famDetList].macidntlinsurance);
      mapDataFamily[TablesColumnFile.mnomineeyn] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mnomineeyn);

      mapDataFamily[TablesColumnFile.mnametitle] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mnametitle);
      mapDataFamily[TablesColumnFile.mlongname] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mlongname);
      mapDataFamily[TablesColumnFile.mfname] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mfname);
      mapDataFamily[TablesColumnFile.mmname] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mmname);
      mapDataFamily[TablesColumnFile.mlname] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mlname);
      mapDataFamily[TablesColumnFile.mdesignation] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mdesignation);
      //mapDataFamily[TablesColumnFile.mprofession] = ifNullCheck(customerFamilyDetailsList[famDetList].mprofession);
      mapDataFamily[TablesColumnFile.misstudyingmembr] =
          customerFamilyDetailsList[famDetList].misstudyingmembr != null
              ? customerFamilyDetailsList[famDetList].misstudyingmembr
              : 0;
      mapDataFamily[TablesColumnFile.misearngmembr] =
          customerFamilyDetailsList[famDetList].misearngmembr != null
              ? customerFamilyDetailsList[famDetList].misearngmembr
              : 0;
      mapDataFamily[TablesColumnFile.misleavingwithappcnt] =
          customerFamilyDetailsList[famDetList].misleavingwithappcnt != null
              ? customerFamilyDetailsList[famDetList].misleavingwithappcnt
              : 0;
      mapDataFamily[TablesColumnFile.mreverseRelationship] = ifNullCheck(
          customerFamilyDetailsList[famDetList].mreverseRelationship);

      famiDetList.add(mapDataFamily);
    }




    var mapDataBank;
    var bankDetailList = List();
    for (int bankDetList = 0;
    bankDetList < customerBankDetailsList.length;
    bankDetList++) {
      mapDataBank = new Map();
      mapDataBank[TablesColumnFile.tbanktrefno] =
      customerBankDetailsList[bankDetList].tbanktrefno != null
          ? customerBankDetailsList[bankDetList].tbanktrefno
          : 0;
      mapDataBank[TablesColumnFile.trefno] =
      customerBankDetailsList[bankDetList].trefno != null
          ? customerBankDetailsList[bankDetList].trefno
          : 0;
      mapDataBank[TablesColumnFile.mbanktrefno] =
      customerBankDetailsList[bankDetList].mbanktrefno != null
          ? customerBankDetailsList[bankDetList].mbanktrefno
          : 0;
      mapDataBank[TablesColumnFile.mrefno] =
      customerBankDetailsList[bankDetList].mrefno != null
          ? customerBankDetailsList[bankDetList].mrefno
          : 0;

      mapDataBank[TablesColumnFile.maccno] =
          ifNullCheck(customerBankDetailsList[bankDetList].maccno);

      mapDataBank[TablesColumnFile.mcreatedby] =
          ifNullCheck(customerBankDetailsList[bankDetList].mcreatedby);
      mapDataBank[TablesColumnFile.maccstatus] =
          ifNullCheck(customerBankDetailsList[bankDetList].maccstatus);
      mapDataBank[TablesColumnFile.migyn] =
          ifNullCheck(customerBankDetailsList[bankDetList].migyn);
      mapDataBank[TablesColumnFile.mcurcode] =
          ifNullCheck(customerBankDetailsList[bankDetList].mcurcode);

      mapDataBank[TablesColumnFile.mbankname] =
          ifNullCheck(customerBankDetailsList[bankDetList].mbankname);

      mapDataBank[TablesColumnFile.mbranch] =
          ifNullCheck(customerBankDetailsList[bankDetList].mbranch);

      mapDataBank[TablesColumnFile.maccbal] =
      customerBankDetailsList[bankDetList].maccbal != null
          ? customerBankDetailsList[bankDetList].maccbal
          : 0;

      mapDataBank[TablesColumnFile.misusefordis] =
          ifNullCheck(customerBankDetailsList[bankDetList].misusefordis);


      bankDetailList.add(mapDataBank);
    }








    var mapDataAdd;
    var addDetailsList = new List();
    for (int addDetList = 0;
        addDetList < customerAddressDetailsList.length;
        addDetList++) {
      mapDataAdd = new Map();
      mapDataAdd[TablesColumnFile.taddrefno] =
          customerAddressDetailsList[addDetList].taddrefno != null
              ? customerAddressDetailsList[addDetList].taddrefno
              : 0;
      mapDataAdd[TablesColumnFile.trefno] =
          customerAddressDetailsList[addDetList].trefno != null &&
                  customerAddressDetailsList[addDetList].trefno != 'null'
              ? customerAddressDetailsList[addDetList].trefno
              : 0;
      // mapDataAdd[TablesColumnFile.maddrefno] =	        customerAddressDetailsList[addDetList].maddrefno!=null&& customerAddressDetailsList[addDetList].maddrefno!='null'?customerAddressDetailsList[addDetList].maddrefno:0;
      mapDataAdd[TablesColumnFile.mrefno] =
          customerAddressDetailsList[addDetList].mrefno != null
              ? customerAddressDetailsList[addDetList].mrefno
              : 0;
      mapDataAdd[TablesColumnFile.mcustno] =
          customerAddressDetailsList[addDetList].mcustno != null
              ? customerAddressDetailsList[addDetList].mcustno
              : 0;
      mapDataAdd[TablesColumnFile.maddrType] =
          customerAddressDetailsList[addDetList].maddrType != null
              ? customerAddressDetailsList[addDetList].maddrType
              : 0;
      mapDataAdd[TablesColumnFile.maddr1] =
          ifNullCheck(customerAddressDetailsList[addDetList].maddr1);
      mapDataAdd[TablesColumnFile.maddr2] =
          ifNullCheck(customerAddressDetailsList[addDetList].maddr2);
      mapDataAdd[TablesColumnFile.maddr3] =
          ifNullCheck(customerAddressDetailsList[addDetList].maddr3);
      mapDataAdd[TablesColumnFile.mpinCd] =
          customerAddressDetailsList[addDetList].mpinCd != null
              ? customerAddressDetailsList[addDetList].mpinCd
              : 0;
      mapDataAdd[TablesColumnFile.mtel1] =
          ifNullCheck(customerAddressDetailsList[addDetList].mtel1);
      mapDataAdd[TablesColumnFile.mtel2] =
          ifNullCheck(customerAddressDetailsList[addDetList].mtel2);
      mapDataAdd[TablesColumnFile.mcityCd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mcityCd);
      mapDataAdd[TablesColumnFile.mfax1] =
          ifNullCheck(customerAddressDetailsList[addDetList].mfax1);
      mapDataAdd[TablesColumnFile.mfax2] =
          ifNullCheck(customerAddressDetailsList[addDetList].mfax2);
      mapDataAdd[TablesColumnFile.mcountryCd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mcountryCd);
      mapDataAdd[TablesColumnFile.marea] =
          customerAddressDetailsList[addDetList].marea != null
              ? customerAddressDetailsList[addDetList].marea
              : 0;
      /*mapDataAdd[TablesColumnFile.mHouseType] =
      customerAddressDetailsList[addDetList].mHouseType != null
          ? customerAddressDetailsList[addDetList].mHouseType
          : 0;*/
      print(customerListBean.mHouse);
      mapDataAdd[TablesColumnFile.mHouseType] =
          customerListBean.mHouse != "null" ? customerListBean.mHouse : 0;
      mapDataAdd[TablesColumnFile.mRntLeasAmt] =
          customerAddressDetailsList[addDetList].mRntLeasAmt != null
              ? customerAddressDetailsList[addDetList].mRntLeasAmt
              : 0;
      mapDataAdd[TablesColumnFile.mRntLeasDep] =
          customerAddressDetailsList[addDetList].mRntLeasDep != null
              ? customerAddressDetailsList[addDetList].mRntLeasDep
              : 0;
      mapDataAdd[TablesColumnFile.mContLeasExp] =
          customerAddressDetailsList[addDetList].mContLeasExp != null
              ? customerAddressDetailsList[addDetList]
                  .mContLeasExp
                  .toIso8601String()
              : null;
      /*mapDataAdd[TablesColumnFile.mRoofCond] =
      customerAddressDetailsList[addDetList].mRoofCond != null
          ? customerAddressDetailsList[addDetList].mRoofCond
          : 0;*/
      print("no of room/post");
      print(customerAddressDetailsList[addDetList].mNoOfRooms);
      mapDataAdd[TablesColumnFile.mNoOfRooms] =
          customerAddressDetailsList[addDetList].mNoOfRooms != null
              ? customerAddressDetailsList[addDetList].mNoOfRooms
              : 0;
      print(customerListBean.mConstruct);
      mapDataAdd[TablesColumnFile.mRoofCond] =
          customerListBean.mConstruct != null ? customerListBean.mConstruct : 0;
      mapDataAdd[TablesColumnFile.mUtils] =
          customerAddressDetailsList[addDetList].mUtils != null
              ? customerAddressDetailsList[addDetList].mUtils
              : 0;
      mapDataAdd[TablesColumnFile.mAreaType] =
          customerAddressDetailsList[addDetList].mAreaType != null
              ? customerAddressDetailsList[addDetList].mAreaType
              : 0;
      mapDataAdd[TablesColumnFile.mLandmark] =
          ifNullCheck(customerAddressDetailsList[addDetList].mLandmark);
      mapDataAdd[TablesColumnFile.mstate] =
          ifNullCheck(customerAddressDetailsList[addDetList].mState);
      mapDataAdd[TablesColumnFile.mYearStay] =
          customerAddressDetailsList[addDetList].mYearStay != null &&
                  customerAddressDetailsList[addDetList].mYearStay != 'null'
              ? customerAddressDetailsList[addDetList].mYearStay
              : 0;
      mapDataAdd[TablesColumnFile.mWardNo] =
          ifNullCheck(customerAddressDetailsList[addDetList].mWardNo);
      mapDataAdd[TablesColumnFile.mMobile] =
          ifNullCheck(customerAddressDetailsList[addDetList].mMobile);
      mapDataAdd[TablesColumnFile.mEmail] =
          ifNullCheck(customerAddressDetailsList[addDetList].mEmail);
      mapDataAdd[TablesColumnFile.mPattaName] =
          ifNullCheck(customerAddressDetailsList[addDetList].mPattaName);
      mapDataAdd[TablesColumnFile.mRelationship] =
          ifNullCheck(customerAddressDetailsList[addDetList].mRelationship);
      mapDataAdd[TablesColumnFile.mSourceOfDep] =
          customerAddressDetailsList[addDetList].mSourceOfDep != null
              ? customerAddressDetailsList[addDetList].mSourceOfDep
              : 0;
      mapDataAdd[TablesColumnFile.mInstAmount] =
          customerAddressDetailsList[addDetList].mInstAmount != null
              ? customerAddressDetailsList[addDetList].mInstAmount
              : 0;
      /* print("ToiletYN");//mToilet
      mapDataAdd[TablesColumnFile.mToietYN] =
      customerAddressDetailsList[addDetList].mToietYN != "null"
          ? customerAddressDetailsList[addDetList].mToietYN
          : 0;
      print(customerAddressDetailsList[addDetList].mToietYN);*/

      print("ToiletYN"); //mToilet
      print(customerListBean.mToilet);
      mapDataAdd[TablesColumnFile.mToietYN] =
          customerListBean.mToilet != "null" ? customerListBean.mToilet : 0;
      /* mapDataAdd[TablesColumnFile.mToietYN] =
          ifNullCheck(customerAddressDetailsList[addDetList].mToietYN);*/
      mapDataAdd[TablesColumnFile.mNoOfRooms] =
          customerAddressDetailsList[addDetList].mNoOfRooms != null
              ? customerAddressDetailsList[addDetList].mNoOfRooms
              : 0;
      mapDataAdd[TablesColumnFile.mSpouseYearsStay] =
          customerAddressDetailsList[addDetList].mSpouseYearsStay != null
              ? customerAddressDetailsList[addDetList].mSpouseYearsStay
              : 0;
      mapDataAdd[TablesColumnFile.mDistCd] =
          customerAddressDetailsList[addDetList].mDistCd != null
              ? customerAddressDetailsList[addDetList].mDistCd
              : 0;

      mapDataAdd[TablesColumnFile.mvillage] =
          customerAddressDetailsList[addDetList].mvillage != null
              ? customerAddressDetailsList[addDetList].mvillage
              : 0;
      mapDataAdd[TablesColumnFile.mplacecd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mplacecd);
      mapDataAdd[TablesColumnFile.mCookFuel] =
          customerAddressDetailsList[addDetList].mCookFuel != null
              ? customerAddressDetailsList[addDetList].mCookFuel
              : 0;
      mapDataAdd[TablesColumnFile.mSecMobile] =
          ifNullCheck(customerAddressDetailsList[addDetList].mSecMobile);
      mapDataAdd[TablesColumnFile.mgeolatd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mgeolatd);
      mapDataAdd[TablesColumnFile.mgeologd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mgeologd);
      mapDataAdd[TablesColumnFile.mownership] =
          ifNullCheck(customerAddressDetailsList[addDetList].mownership);

      addDetailsList.add(mapDataAdd);
    }

    var mapDataBorr;
    var borrDetailsList = new List();
    for (int borrDetList = 0;
        borrDetList < customerBorrowingDetailsList.length;
        borrDetList++) {
      mapDataBorr = new Map();
      mapDataBorr[TablesColumnFile.tborrowingrefno] =
          customerBorrowingDetailsList[borrDetList].tborrowingrefno != null
              ? customerBorrowingDetailsList[borrDetList].tborrowingrefno
              : 0;
      mapDataBorr[TablesColumnFile.trefno] =
          customerBorrowingDetailsList[borrDetList].trefno != null
              ? customerBorrowingDetailsList[borrDetList].trefno
              : 0;
      //mapDataBorr[TablesColumnFile.mborrowingrefno] =	        customerBorrowingDetailsList[borrDetList].mborrowingrefno!=null&& customerBorrowingDetailsList[borrDetList].mborrowingrefno!='null'?customerBorrowingDetailsList[borrDetList].mborrowingrefno:0;
      mapDataBorr[TablesColumnFile.mrefno] =
          customerBorrowingDetailsList[borrDetList].mrefno != null
              ? customerBorrowingDetailsList[borrDetList].mrefno
              : 0;
      mapDataBorr[TablesColumnFile.mcustno] =
          customerBorrowingDetailsList[borrDetList].mcustno != null
              ? customerBorrowingDetailsList[borrDetList].mcustno
              : 0;
      mapDataBorr[TablesColumnFile.mnameofborrower] = ifNullCheck(
          customerBorrowingDetailsList[borrDetList].mnameofborrower);
      mapDataBorr[TablesColumnFile.msource] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].msource);
      mapDataBorr[TablesColumnFile.mpurpose] =
          customerBorrowingDetailsList[borrDetList].mpurpose;
      mapDataBorr[TablesColumnFile.mamount] =
          customerBorrowingDetailsList[borrDetList].mamount != null
              ? customerBorrowingDetailsList[borrDetList].mamount
              : 0;
      mapDataBorr[TablesColumnFile.mintrate] =
          customerBorrowingDetailsList[borrDetList].mintrate != null
              ? customerBorrowingDetailsList[borrDetList].mintrate
              : 0;
      mapDataBorr[TablesColumnFile.memiamt] =
          customerBorrowingDetailsList[borrDetList].memiamt != null
              ? customerBorrowingDetailsList[borrDetList].memiamt
              : 0;
      mapDataBorr[TablesColumnFile.moutstandingamt] =
          customerBorrowingDetailsList[borrDetList].moutstandingamt != null
              ? customerBorrowingDetailsList[borrDetList].moutstandingamt
              : 0;
      mapDataBorr[TablesColumnFile.mmemberno] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].mmemberno);
      mapDataBorr[TablesColumnFile.mloancycle] =
          customerBorrowingDetailsList[borrDetList].mloancycle != null
              ? customerBorrowingDetailsList[borrDetList].mloancycle
              : 0;

    /*  mapDataBorr[TablesColumnFile.macctno] =
          customerBorrowingDetailsList[borrDetList].macctno != null
              ? customerBorrowingDetailsList[borrDetList].macctno
              : 0;*/
      mapDataBorr[TablesColumnFile.macctno] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].macctno);

      mapDataBorr[TablesColumnFile.mperiod] =
          customerBorrowingDetailsList[borrDetList].mperiod != null
              ? customerBorrowingDetailsList[borrDetList].mperiod
              : 0;
      mapDataBorr[TablesColumnFile.mfrequency] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].mfrequency);
      mapDataBorr[TablesColumnFile.mcurcd] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].mcurcd);

      mapDataBorr[TablesColumnFile.mrestructrdloan] = ifNullCheck(
          customerBorrowingDetailsList[borrDetList].mrestructrdloan);
      mapDataBorr[TablesColumnFile.msvngamount] =
          customerBorrowingDetailsList[borrDetList].msvngamount != null
              ? customerBorrowingDetailsList[borrDetList].msvngamount
              : 0;
      mapDataBorr[TablesColumnFile.mremark] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].mremark);
      mapDataBorr[TablesColumnFile.mmodeofdisb] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].mmodeofdisb);

      mapDataBorr[TablesColumnFile.mloanDate] =
          customerBorrowingDetailsList[borrDetList].mloanDate != null
              ? customerBorrowingDetailsList[borrDetList]
                  .mloanDate
                  .toIso8601String()
              : null;
      borrDetailsList.add(mapDataBorr);
    }

    //business data error
    //laterOnset this thig

    var mapDataBuss;
    var busDetsList = List();
    for (int busDetList = 0;
        busDetList < customerBusinessDetailsBean.length;
        busDetList++) {
      mapDataBuss = new Map();
      print("customerBusinessDetailsBean.length.toString()" +
          customerBusinessDetailsBean.toString());
      mapDataBuss[TablesColumnFile.tbussdetailsrefno] =
          customerBusinessDetailsBean[busDetList].tbussdetailsrefno != null
              ? customerBusinessDetailsBean[busDetList].tbussdetailsrefno
              : 0;
      /*   mapDataBuss[TablesColumnFile.mbussdetailsrefno] =
      customerBusinessDetailsBean[busDetList].mbussdetailsrefno != null
          ? customerBusinessDetailsBean[busDetList].mbussdetailsrefno
          : 0;*/
      mapDataBuss[TablesColumnFile.trefno] =
          customerBusinessDetailsBean[busDetList].trefno != null
              ? customerBusinessDetailsBean[busDetList].trefno
              : 0;
      mapDataBuss[TablesColumnFile.mrefno] =
          customerBusinessDetailsBean[busDetList].mrefno != null
              ? customerBusinessDetailsBean[busDetList].mrefno
              : 0;
      mapDataBuss[TablesColumnFile.mcusactivitytype] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mcusactivitytype);
      mapDataBuss[TablesColumnFile.mbusstype] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusstype);
      mapDataBuss[TablesColumnFile.mbusinessname] =
          customerBusinessDetailsBean[busDetList].mbusinessname != null
              ? customerBusinessDetailsBean[busDetList].mbusinessname
              : 0;
      mapDataBuss[TablesColumnFile.mbuslocownership] =
          customerBusinessDetailsBean[busDetList].mbuslocownership != null
              ? customerBusinessDetailsBean[busDetList].mbuslocownership
              : 0;
      mapDataBuss[TablesColumnFile.misselfemp] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].misselfemp);
      mapDataBuss[TablesColumnFile.mbusaddress1] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusaddress1);
      mapDataBuss[TablesColumnFile.mbusaddress2] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusaddress2);
      mapDataBuss[TablesColumnFile.mbusaddress3] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusaddress3);
      mapDataBuss[TablesColumnFile.mbusaddress4] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusaddress4);
      mapDataBuss[TablesColumnFile.mbuscity] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbuscity);
      mapDataBuss[TablesColumnFile.mdistcd] =
          customerBusinessDetailsBean[busDetList].mdistcd != null
              ? customerBusinessDetailsBean[busDetList].mdistcd
              : 0;
      mapDataBuss[TablesColumnFile.mbusstate] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusstate);
      mapDataBuss[TablesColumnFile.mbuscountry] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbuscountry);
      mapDataBuss[TablesColumnFile.mbusarea] =
          customerBusinessDetailsBean[busDetList].mbusarea != null
              ? customerBusinessDetailsBean[busDetList].mbusarea
              : 0;
      mapDataBuss[TablesColumnFile.mbusvillage] =
          customerBusinessDetailsBean[busDetList].mbusvillage != null
              ? customerBusinessDetailsBean[busDetList].mbusvillage
              : 0;
      mapDataBuss[TablesColumnFile.mbuslandmark] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbuslandmark);
      mapDataBuss[TablesColumnFile.mbuspin] =
          customerBusinessDetailsBean[busDetList].mbuspin != null
              ? customerBusinessDetailsBean[busDetList].mbuspin
              : 0;
      mapDataBuss[TablesColumnFile.mbusyrsmnths] =
          customerBusinessDetailsBean[busDetList].mbusyrsmnths != null
              ? customerBusinessDetailsBean[busDetList].mbusyrsmnths
              : 0;
      mapDataBuss[TablesColumnFile.mregisteredyn] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mregisteredyn);
      mapDataBuss[TablesColumnFile.mregistrationno] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mregistrationno);
      mapDataBuss[TablesColumnFile.mbusothtomanageabsyn] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusothtomanageabsyn);
      mapDataBuss[TablesColumnFile.mbusothmanagername] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusothmanagername);
      mapDataBuss[TablesColumnFile.mbusothmanagerrel] =
          customerBusinessDetailsBean[busDetList].mbusothmanagerrel != null
              ? customerBusinessDetailsBean[busDetList].mbusothmanagerrel
              : 0;
      mapDataBuss[TablesColumnFile.mbusmonthlyincome] =
          customerBusinessDetailsBean[busDetList].mbusmonthlyincome != null
              ? customerBusinessDetailsBean[busDetList].mbusmonthlyincome
              : 0;
      mapDataBuss[TablesColumnFile.mbusseasonalityjan] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityjan);
      mapDataBuss[TablesColumnFile.mbusseasonalityfeb] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityfeb);
      mapDataBuss[TablesColumnFile.mbusseasonalitymar] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalitymar);
      mapDataBuss[TablesColumnFile.mbusseasonalityapr] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityapr);
      mapDataBuss[TablesColumnFile.mbusseasonalitymay] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalitymay);
      mapDataBuss[TablesColumnFile.mbusseasonalityjun] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityjun);
      mapDataBuss[TablesColumnFile.mbusseasonalityjul] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityjul);
      mapDataBuss[TablesColumnFile.mbusseasonalityaug] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityaug);
      mapDataBuss[TablesColumnFile.mbusseasonalitysep] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalitysep);
      mapDataBuss[TablesColumnFile.mbusseasonalityoct] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalityoct);
      mapDataBuss[TablesColumnFile.mbusseasonalitynov] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalitynov);
      mapDataBuss[TablesColumnFile.mbusseasonalitydec] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusseasonalitydec);
      mapDataBuss[TablesColumnFile.mbushighsales] =
          customerBusinessDetailsBean[busDetList].mbushighsales != null
              ? customerBusinessDetailsBean[busDetList].mbushighsales
              : 0;
      mapDataBuss[TablesColumnFile.mbusmediumsales] =
          customerBusinessDetailsBean[busDetList].mbusmediumsales != null
              ? customerBusinessDetailsBean[busDetList].mbusmediumsales
              : 0;
      mapDataBuss[TablesColumnFile.mbuslowsales] =
          customerBusinessDetailsBean[busDetList].mbuslowsales != null
              ? customerBusinessDetailsBean[busDetList].mbuslowsales
              : 0;
      mapDataBuss[TablesColumnFile.mbushighincome] =
          customerBusinessDetailsBean[busDetList].mbushighincome != null
              ? customerBusinessDetailsBean[busDetList].mbushighincome
              : 0;
      mapDataBuss[TablesColumnFile.mbusmediumincom] =
          customerBusinessDetailsBean[busDetList].mbusmediumincom != null
              ? customerBusinessDetailsBean[busDetList].mbusmediumincom
              : 0;
      mapDataBuss[TablesColumnFile.mbuslowincome] =
          customerBusinessDetailsBean[busDetList].mbuslowincome != null
              ? customerBusinessDetailsBean[busDetList].mbuslowincome
              : 0;
      mapDataBuss[TablesColumnFile.mbusmonthlytotaleval] =
          customerBusinessDetailsBean[busDetList].mbusmonthlytotaleval != null
              ? customerBusinessDetailsBean[busDetList].mbusmonthlytotaleval
              : 0;
      mapDataBuss[TablesColumnFile.mbusmonthlytotalverif] =
          customerBusinessDetailsBean[busDetList].mbusmonthlytotalverif != null
              ? customerBusinessDetailsBean[busDetList].mbusmonthlytotalverif
              : 0;
      mapDataBuss[TablesColumnFile.mbusincludesurcalcyn] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusincludesurcalcyn);
      mapDataBuss[TablesColumnFile.mbusnhousesameplaceyn] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].mbusnhousesameplaceyn);
      mapDataBuss[TablesColumnFile.mbusinesstrend] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbusinesstrend);

      mapDataBuss[TablesColumnFile.mmonthlyincome] =
          customerBusinessDetailsBean[busDetList].mmonthlyincome != null
              ? customerBusinessDetailsBean[busDetList].mmonthlyincome
              : 0;
      mapDataBuss[TablesColumnFile.mtotalmonthlyincome] =
          customerBusinessDetailsBean[busDetList].mtotalmonthlyincome != null
              ? customerBusinessDetailsBean[busDetList].mtotalmonthlyincome
              : 0;
      mapDataBuss[TablesColumnFile.mbusinessexpense] =
          customerBusinessDetailsBean[busDetList].mbusinessexpense != null
              ? customerBusinessDetailsBean[busDetList].mbusinessexpense
              : 0;
      mapDataBuss[TablesColumnFile.mhousehldexpense] =
          customerBusinessDetailsBean[busDetList].mhousehldexpense != null
              ? customerBusinessDetailsBean[busDetList].mhousehldexpense
              : 0;
      mapDataBuss[TablesColumnFile.mmonthlyemi] =
          customerBusinessDetailsBean[busDetList].mmonthlyemi != null
              ? customerBusinessDetailsBean[busDetList].mmonthlyemi
              : 0;
      mapDataBuss[TablesColumnFile.mincomeemiratio] =
          customerBusinessDetailsBean[busDetList].mincomeemiratio != null
              ? customerBusinessDetailsBean[busDetList].mincomeemiratio
              : 0;
      mapDataBuss[TablesColumnFile.mnetamount] =
          customerBusinessDetailsBean[busDetList].mnetamount != null
              ? customerBusinessDetailsBean[busDetList].mnetamount
              : 0;
      mapDataBuss[TablesColumnFile.mpercentage] =
          customerBusinessDetailsBean[busDetList].mpercentage != null
              ? customerBusinessDetailsBean[busDetList].mpercentage
              : 0;

      mapDataBuss[TablesColumnFile.mposition] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mposition);
      mapDataBuss[TablesColumnFile.mdepartment] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mdepartment);
      mapDataBuss[TablesColumnFile.mincomefromothrsrc] =
          customerBusinessDetailsBean[busDetList].mincomefromothrsrc != null
              ? customerBusinessDetailsBean[busDetList].mincomefromothrsrc
              : 0;

      mapDataBuss[TablesColumnFile.mempfrom] =
          customerBusinessDetailsBean[busDetList].mempfrom != null
              ? customerBusinessDetailsBean[busDetList]
                  .mempfrom
                  .toIso8601String()
              : null;
      mapDataBuss[TablesColumnFile.mempto] =
          customerBusinessDetailsBean[busDetList].mempto != null
              ? customerBusinessDetailsBean[busDetList].mempto.toIso8601String()
              : null;

      mapDataBuss[TablesColumnFile.mdateofincorporation] =
          customerBusinessDetailsBean[busDetList].mdateofincorporation != null
              ? customerBusinessDetailsBean[busDetList]
                  .mdateofincorporation
                  .toIso8601String()
              : null;
      mapDataBuss[TablesColumnFile.mtotalmanpower] =
          customerBusinessDetailsBean[busDetList].mtotalmanpower != null
              ? customerBusinessDetailsBean[busDetList].mtotalmanpower
              : 0;
      mapDataBuss[TablesColumnFile.mtotalman] =
          customerBusinessDetailsBean[busDetList].mtotalman != null
              ? customerBusinessDetailsBean[busDetList].mtotalman
              : 0;
      mapDataBuss[TablesColumnFile.mtotalwomen] =
          customerBusinessDetailsBean[busDetList].mtotalwomen != null
              ? customerBusinessDetailsBean[busDetList].mtotalwomen
              : 0;

      mapDataBuss[TablesColumnFile.mcompanycategory] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mcompanycategory);
      mapDataBuss[TablesColumnFile.mmanagerdetails] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mmanagerdetails);

      mapDataBuss[TablesColumnFile.mbusinessownerandshareholdingpercentage] =
          customerBusinessDetailsBean[busDetList]
                      .mbusinessownerandshareholdingpercentage !=
                  null
              ? customerBusinessDetailsBean[busDetList]
                  .mbusinessownerandshareholdingpercentage
              : 0;
      mapDataBuss[TablesColumnFile.mcapital] =
          customerBusinessDetailsBean[busDetList].mcapital != null
              ? customerBusinessDetailsBean[busDetList].mcapital
              : 0;
      mapDataBuss[TablesColumnFile.mcostofgoodssold] =
          customerBusinessDetailsBean[busDetList].mcostofgoodssold != null
              ? customerBusinessDetailsBean[busDetList].mcostofgoodssold
              : 0;
      mapDataBuss[TablesColumnFile.moperationexpenditure] =
          customerBusinessDetailsBean[busDetList].moperationexpenditure != null
              ? customerBusinessDetailsBean[busDetList].moperationexpenditure
              : 0;
      mapDataBuss[TablesColumnFile.mnetprofit] =
          customerBusinessDetailsBean[busDetList].mnetprofit != null
              ? customerBusinessDetailsBean[busDetList].mnetprofit
              : 0;

////////////////  /
      mapDataBuss[TablesColumnFile.msrcname] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].msrcname);
      mapDataBuss[TablesColumnFile.mprofession] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mprofession);
      mapDataBuss[TablesColumnFile.mnoofempincmpny] =
          customerBusinessDetailsBean[busDetList].mnoofempincmpny != null
              ? customerBusinessDetailsBean[busDetList].mnoofempincmpny
              : 0;
      mapDataBuss[TablesColumnFile.myrsofexpinyrs] =
          customerBusinessDetailsBean[busDetList].myrsofexpinyrs != null
              ? customerBusinessDetailsBean[busDetList].myrsofexpinyrs
              : 0;
      mapDataBuss[TablesColumnFile.myrsofexpinmnths] =
          customerBusinessDetailsBean[busDetList].myrsofexpinmnths != null
              ? customerBusinessDetailsBean[busDetList].myrsofexpinmnths
              : 0;
      mapDataBuss[TablesColumnFile.mmobile] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mmobile);
      mapDataBuss[TablesColumnFile.mstatusofemp] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mstatusofemp);
      mapDataBuss[TablesColumnFile.mtagtmrkt] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mtagtmrkt);
      mapDataBuss[TablesColumnFile.mstrtgy] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mstrtgy);
      mapDataBuss[TablesColumnFile.mbussprocss] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbussprocss);
      mapDataBuss[TablesColumnFile.mcomptrmekt] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mcomptrmekt);

      mapDataBuss[TablesColumnFile.miscpemp] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].miscpemp);
      mapDataBuss[TablesColumnFile.mrankofemp] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mrankofemp);
      mapDataBuss[TablesColumnFile.misprimarysrcincome] = ifNullCheck(
          customerBusinessDetailsBean[busDetList].misprimarysrcincome);
      mapDataBuss[TablesColumnFile.mcompanyname] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mcompanyname);
      mapDataBuss[TablesColumnFile.mbussstatus] =
          ifNullCheck(customerBusinessDetailsBean[busDetList].mbussstatus);
      busDetsList.add(mapDataBuss);
    }

/*    var mapDataBussExp;
    var bussExpDetailsList = new List();
    for (int bussExpDetList = 0;
    bussExpDetList < businessExpendDetailsList.length;
    bussExpDetList++) {
      mapDataBussExp = new Map();
      mapDataBussExp[TablesColumnFile.tbusinexpendrefno] =
      businessExpendDetailsList[bussExpDetList].tbusinexpendrefno != null
          ? businessExpendDetailsList[bussExpDetList].tbusinexpendrefno
          : 0;
      mapDataBussExp[TablesColumnFile.trefno] =
      businessExpendDetailsList[bussExpDetList].trefno != null
          ? businessExpendDetailsList[bussExpDetList].trefno
          : 0;
      */ /*  mapDataBussExp[TablesColumnFile.mbusinexpenrefno] =
      businessExpendDetailsList[bussExpDetList].mbusinexpenrefno != null
          ? businessExpendDetailsList[bussExpDetList].mbusinexpenrefno
          : 0;*/ /*
      mapDataBussExp[TablesColumnFile.mrefno] =
      businessExpendDetailsList[bussExpDetList].mrefno != null
          ? businessExpendDetailsList[bussExpDetList].mrefno
          : 0;
      mapDataBussExp[TablesColumnFile.mcustno] =
      businessExpendDetailsList[bussExpDetList].mcustno != null
          ? businessExpendDetailsList[bussExpDetList].mcustno
          : 0;
      mapDataBussExp[TablesColumnFile.mbusinexpntype] = ifNullCheck(
          businessExpendDetailsList[bussExpDetList].mbusinexpntype);

      mapDataBussExp[TablesColumnFile.mbusinevaluationamt] =
      businessExpendDetailsList[bussExpDetList].mbusinevaluationamt != null
          ? businessExpendDetailsList[bussExpDetList].mbusinevaluationamt
          : 0;

      bussExpDetailsList.add(mapDataBussExp);
    }*/

    /* var mapDataHouseExp;
    var houseExpDetailsList = new List();
    for (int bussExpDetList = 0;
    bussExpDetList < householdExpendDetailsList.length;
    bussExpDetList++) {
      mapDataHouseExp = new Map();
      mapDataHouseExp[TablesColumnFile.tbusinexpendrefno] =
      householdExpendDetailsList[bussExpDetList].thoushldexpendrefno != null
          ? householdExpendDetailsList[bussExpDetList].thoushldexpendrefno
          : 0;
      mapDataHouseExp[TablesColumnFile.trefno] =
      householdExpendDetailsList[bussExpDetList].trefno != null
          ? householdExpendDetailsList[bussExpDetList].trefno
          : 0;
      */ /*     mapDataHouseExp[TablesColumnFile.mbusinexpenrefno] =
      householdExpendDetailsList[bussExpDetList].mhoushldexpenrefno != null
          ? householdExpendDetailsList[bussExpDetList].mhoushldexpenrefno
          : 0;*/ /*
      mapDataHouseExp[TablesColumnFile.mrefno] =
      householdExpendDetailsList[bussExpDetList].mrefno != null
          ? householdExpendDetailsList[bussExpDetList].mrefno
          : 0;
      mapDataHouseExp[TablesColumnFile.mcustno] =
      householdExpendDetailsList[bussExpDetList].mcustno != null
          ? householdExpendDetailsList[bussExpDetList].mcustno
          : 0;
      mapDataHouseExp[TablesColumnFile.mhoushldexpntype] = ifNullCheck(
          householdExpendDetailsList[bussExpDetList].mhoushldexpntype);

      mapDataHouseExp[TablesColumnFile.mhoushldevaluationamt] =
      householdExpendDetailsList[bussExpDetList].mhoushldevaluationamt != null
          ? householdExpendDetailsList[bussExpDetList].mhoushldevaluationamt
          : 0;

      houseExpDetailsList.add(mapDataHouseExp);
    }
*/

    var mapDataAsset;
    var assetDetailList = List();
    for (int assetDetList = 0;
        assetDetList < assetDetailsList.length;
        assetDetList++) {
      mapDataAsset = new Map();
      mapDataAsset[TablesColumnFile.tassetdetrefno] =
          assetDetailsList[assetDetList].tassetdetrefno != null
              ? assetDetailsList[assetDetList].tassetdetrefno
              : 0;
      mapDataAsset[TablesColumnFile.trefno] =
          assetDetailsList[assetDetList].trefno != null
              ? assetDetailsList[assetDetList].trefno
              : 0;
      mapDataAsset[TablesColumnFile.massetdetrefno] =
          assetDetailsList[assetDetList].massetdetrefno != null
              ? assetDetailsList[assetDetList].massetdetrefno
              : 0;
      mapDataAsset[TablesColumnFile.mrefno] =
          assetDetailsList[assetDetList].mrefno != null
              ? assetDetailsList[assetDetList].mrefno
              : 0;
      mapDataAsset[TablesColumnFile.mcustno] =
          assetDetailsList[assetDetList].mcustno != null
              ? assetDetailsList[assetDetList].mcustno
              : 0;
      mapDataAsset[TablesColumnFile.mitem] =
          assetDetailsList[assetDetList].mitem != null
              ? assetDetailsList[assetDetList].mitem
              : 0;
      assetDetailList.add(mapDataAsset);
    }

    var mapDataFixedAssets = new Map();
    if (fixedAssetsList != null) {
      mapDataFixedAssets[TablesColumnFile.tfixedassetrefno] =
          fixedAssetsList.tfixedassetrefno != null
              ? fixedAssetsList.tfixedassetrefno
              : 0;
      mapDataFixedAssets[TablesColumnFile.trefno] =
          fixedAssetsList.trefno != null ? fixedAssetsList.trefno : 0;
      mapDataFixedAssets[TablesColumnFile.mrefno] =
          fixedAssetsList.mrefno != null ? fixedAssetsList.mrefno : 0;
      mapDataFixedAssets[TablesColumnFile.mland] =
          fixedAssetsList.mland != null ? fixedAssetsList.mland : 0;
      mapDataFixedAssets[TablesColumnFile.mlandpresentamt] =
          fixedAssetsList.mlandpresentamt != null
              ? fixedAssetsList.mlandpresentamt
              : 0;
      mapDataFixedAssets[TablesColumnFile.mlandnextmonthamount] =
          fixedAssetsList.mlandnextmonthamount != null
              ? fixedAssetsList.mlandnextmonthamount
              : 0;

      mapDataFixedAssets[TablesColumnFile.mbuildng] =
          fixedAssetsList.mbuildng != null ? fixedAssetsList.mbuildng : 0;
      mapDataFixedAssets[TablesColumnFile.mbuildngpresentamt] =
          fixedAssetsList.mbuildngpresentamt != null
              ? fixedAssetsList.mbuildngpresentamt
              : 0;
      mapDataFixedAssets[TablesColumnFile.mbuildngnextmonthamount] =
          fixedAssetsList.mbuildngnextmonthamount != null
              ? fixedAssetsList.mbuildngnextmonthamount
              : 0;

      mapDataFixedAssets[TablesColumnFile.mmachnryorequp] =
          fixedAssetsList.mmachnryorequp != null
              ? fixedAssetsList.mmachnryorequp
              : 0;
      mapDataFixedAssets[TablesColumnFile.mmachnryorequppresentamt] =
          fixedAssetsList.mmachnryorequppresentamt != null
              ? fixedAssetsList.mmachnryorequppresentamt
              : 0;
      mapDataFixedAssets[TablesColumnFile.mmachnryorequpnextmonthamount] =
          fixedAssetsList.mmachnryorequpnextmonthamount != null
              ? fixedAssetsList.mmachnryorequpnextmonthamount
              : 0;

      mapDataFixedAssets[TablesColumnFile.mmeansandtransprt] =
          fixedAssetsList.mmeansandtransprt != null
              ? fixedAssetsList.mmeansandtransprt
              : 0;
      mapDataFixedAssets[TablesColumnFile.mmeansandtransprtpresentamt] =
          fixedAssetsList.mmeansandtransprtpresentamt != null
              ? fixedAssetsList.mmeansandtransprtpresentamt
              : 0;
      mapDataFixedAssets[TablesColumnFile.mmeansandtransprtnextmonthamount] =
          fixedAssetsList.mmeansandtransprtnextmonthamount != null
              ? fixedAssetsList.mmeansandtransprtnextmonthamount
              : 0;

      mapDataFixedAssets[TablesColumnFile.mothrs] =
          fixedAssetsList.mothrs != null ? fixedAssetsList.mothrs : 0;
      mapDataFixedAssets[TablesColumnFile.mothrspresentamt] =
          fixedAssetsList.mothrspresentamt != null
              ? fixedAssetsList.mothrspresentamt
              : 0;
      mapDataFixedAssets[TablesColumnFile.mothrsnextmonthamount] =
          fixedAssetsList.mothrsnextmonthamount != null
              ? fixedAssetsList.mothrsnextmonthamount
              : 0;

      mapDataFixedAssets[TablesColumnFile.msumpresentamt] =
          fixedAssetsList.msumpresentamt != null
              ? fixedAssetsList.msumpresentamt
              : 0;
      mapDataFixedAssets[TablesColumnFile.msumnextmonthamount] =
          fixedAssetsList.msumnextmonthamount != null
              ? fixedAssetsList.msumnextmonthamount
              : 0;

      mapDataFixedAssets[TablesColumnFile.mfromdate] =
          fixedAssetsList.mfromdate != null
              ? fixedAssetsList.mfromdate.toIso8601String()
              : null;
      mapDataFixedAssets[TablesColumnFile.mtodate] =
          fixedAssetsList.mtodate != null
              ? fixedAssetsList.mtodate.toIso8601String()
              : null;
    }

    var mapDataCurrentAssets = new Map();
    if (currentAssetsList != null) {
      mapDataCurrentAssets[TablesColumnFile.tcurrentassetrefno] =
          currentAssetsList.tcurrentassetrefno != null
              ? currentAssetsList.tcurrentassetrefno
              : 0;
      mapDataCurrentAssets[TablesColumnFile.trefno] =
          currentAssetsList.trefno != null ? currentAssetsList.trefno : 0;
      mapDataCurrentAssets[TablesColumnFile.mrefno] =
          currentAssetsList.mrefno != null ? currentAssetsList.mrefno : 0;
      mapDataCurrentAssets[TablesColumnFile.mcash] =
          currentAssetsList.mcash != null ? currentAssetsList.mcash : 0;
      mapDataCurrentAssets[TablesColumnFile.mcashpresentamt] =
          currentAssetsList.mcashpresentamt != null
              ? currentAssetsList.mcashpresentamt
              : 0;
      mapDataCurrentAssets[TablesColumnFile.mcashnextmonthamount] =
          currentAssetsList.mcashnextmonthamount != null
              ? currentAssetsList.mcashnextmonthamount
              : 0;

      mapDataCurrentAssets[TablesColumnFile.maccntrecvbl] =
          currentAssetsList.maccntrecvbl != null
              ? currentAssetsList.maccntrecvbl
              : 0;
      mapDataCurrentAssets[TablesColumnFile.maccntrecvblpresentamt] =
          currentAssetsList.maccntrecvblpresentamt != null
              ? currentAssetsList.maccntrecvblpresentamt
              : 0;
      mapDataCurrentAssets[TablesColumnFile.maccntrecvblnextmonthamount] =
          currentAssetsList.maccntrecvblnextmonthamount != null
              ? currentAssetsList.maccntrecvblnextmonthamount
              : 0;

      mapDataCurrentAssets[TablesColumnFile.minventry] =
          currentAssetsList.minventry != null ? currentAssetsList.minventry : 0;
      mapDataCurrentAssets[TablesColumnFile.minventrypresentamt] =
          currentAssetsList.minventrypresentamt != null
              ? currentAssetsList.minventrypresentamt
              : 0;
      mapDataCurrentAssets[TablesColumnFile.minventrynextmonthamount] =
          currentAssetsList.minventrynextmonthamount != null
              ? currentAssetsList.minventrynextmonthamount
              : 0;

      mapDataCurrentAssets[TablesColumnFile.mprepaid] =
          currentAssetsList.mprepaid != null ? currentAssetsList.mprepaid : 0;
      mapDataCurrentAssets[TablesColumnFile.mprepaidpresentamt] =
          currentAssetsList.mprepaidpresentamt != null
              ? currentAssetsList.mprepaidpresentamt
              : 0;
      mapDataCurrentAssets[TablesColumnFile.mprepaidnextmonthamount] =
          currentAssetsList.mprepaidnextmonthamount != null
              ? currentAssetsList.mprepaidnextmonthamount
              : 0;

      mapDataCurrentAssets[TablesColumnFile.mothrs] =
          currentAssetsList.mothrs != null ? currentAssetsList.mothrs : 0;
      mapDataCurrentAssets[TablesColumnFile.mothrspresentamt] =
          currentAssetsList.mothrspresentamt != null
              ? currentAssetsList.mothrspresentamt
              : 0;
      mapDataCurrentAssets[TablesColumnFile.mothrsnextmonthamount] =
          currentAssetsList.mothrsnextmonthamount != null
              ? currentAssetsList.mothrsnextmonthamount
              : 0;

      mapDataCurrentAssets[TablesColumnFile.msumpresentamt] =
          currentAssetsList.msumpresentamt != null
              ? currentAssetsList.msumpresentamt
              : 0;
      mapDataCurrentAssets[TablesColumnFile.msumnextmonthamount] =
          currentAssetsList.msumnextmonthamount != null
              ? currentAssetsList.msumnextmonthamount
              : 0;
    }

    var mapDatalongTermLiabilities = new Map();
    if (longTermLiabilitiesList != null) {
      mapDatalongTermLiabilities[TablesColumnFile.tlngtrmliabiltyrefno] =
          longTermLiabilitiesList.tlngtrmliabiltyrefno != null
              ? longTermLiabilitiesList.tlngtrmliabiltyrefno
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.trefno] =
          longTermLiabilitiesList.trefno != null
              ? longTermLiabilitiesList.trefno
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.mrefno] =
          longTermLiabilitiesList.mrefno != null
              ? longTermLiabilitiesList.mrefno
              : 0;

      mapDatalongTermLiabilities[TablesColumnFile.mcash] =
          longTermLiabilitiesList.mcash != null
              ? longTermLiabilitiesList.mcash
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.mcashpresentamt] =
          longTermLiabilitiesList.mcashpresentamt != null
              ? longTermLiabilitiesList.mcashpresentamt
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.mcashnextmonthamount] =
          longTermLiabilitiesList.mcashnextmonthamount != null
              ? longTermLiabilitiesList.mcashnextmonthamount
              : 0;

      mapDatalongTermLiabilities[TablesColumnFile.maccntrecvbl] =
          longTermLiabilitiesList.maccntrecvbl != null
              ? longTermLiabilitiesList.maccntrecvbl
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.maccntrecvblpresentamt] =
          longTermLiabilitiesList.maccntrecvblpresentamt != null
              ? longTermLiabilitiesList.maccntrecvblpresentamt
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.maccntrecvblnextmonthamount] =
          longTermLiabilitiesList.maccntrecvblnextmonthamount != null
              ? longTermLiabilitiesList.maccntrecvblnextmonthamount
              : 0;

      mapDatalongTermLiabilities[TablesColumnFile.msumpresentamt] =
          longTermLiabilitiesList.msumpresentamt != null
              ? longTermLiabilitiesList.msumpresentamt
              : 0;
      mapDatalongTermLiabilities[TablesColumnFile.msumnextmonthamount] =
          longTermLiabilitiesList.msumnextmonthamount != null
              ? longTermLiabilitiesList.msumnextmonthamount
              : 0;
    }

    var mapDatashortTermLiabilities = new Map();
    if (shortTermLiabilitiesList != null) {
      mapDatashortTermLiabilities[TablesColumnFile.tshrttrmliabiltyrefno] =
          shortTermLiabilitiesList.tshrttrmliabiltyrefno != null
              ? shortTermLiabilitiesList.tshrttrmliabiltyrefno
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.trefno] =
          shortTermLiabilitiesList.trefno != null
              ? shortTermLiabilitiesList.trefno
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mrefno] =
          shortTermLiabilitiesList.mrefno != null
              ? shortTermLiabilitiesList.mrefno
              : 0;

      mapDatashortTermLiabilities[TablesColumnFile.mcash] =
          shortTermLiabilitiesList.mcash != null
              ? shortTermLiabilitiesList.mcash
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mcashpresentamt] =
          shortTermLiabilitiesList.mcashpresentamt != null
              ? shortTermLiabilitiesList.mcashpresentamt
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mcashnextmonthamount] =
          shortTermLiabilitiesList.mcashnextmonthamount != null
              ? shortTermLiabilitiesList.mcashnextmonthamount
              : 0;

      mapDatashortTermLiabilities[TablesColumnFile.maccntrecvbl] =
          shortTermLiabilitiesList.maccntrecvbl != null
              ? shortTermLiabilitiesList.maccntrecvbl
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.maccntrecvblpresentamt] =
          shortTermLiabilitiesList.maccntrecvblpresentamt != null
              ? shortTermLiabilitiesList.maccntrecvblpresentamt
              : 0;
      mapDatashortTermLiabilities[
              TablesColumnFile.maccntrecvblnextmonthamount] =
          shortTermLiabilitiesList.maccntrecvblnextmonthamount != null
              ? shortTermLiabilitiesList.maccntrecvblnextmonthamount
              : 0;

      mapDatashortTermLiabilities[TablesColumnFile.mfield3] =
          shortTermLiabilitiesList.mfield3 != null
              ? shortTermLiabilitiesList.mfield3
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mfield3presentamt] =
          shortTermLiabilitiesList.mfield3presentamt != null
              ? shortTermLiabilitiesList.mfield3presentamt
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mfield3nextmonthamount] =
          shortTermLiabilitiesList.mfield3nextmonthamount != null
              ? shortTermLiabilitiesList.mfield3nextmonthamount
              : 0;

      mapDatashortTermLiabilities[TablesColumnFile.mfield4] =
          shortTermLiabilitiesList.mfield4 != null
              ? shortTermLiabilitiesList.mfield4
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mfield4presentamt] =
          shortTermLiabilitiesList.mfield4presentamt != null
              ? shortTermLiabilitiesList.mfield4presentamt
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.mfield4nextmonthamount] =
          shortTermLiabilitiesList.mfield4nextmonthamount != null
              ? shortTermLiabilitiesList.mfield4nextmonthamount
              : 0;

      mapDatashortTermLiabilities[TablesColumnFile.msumpresentamt] =
          shortTermLiabilitiesList.msumpresentamt != null
              ? shortTermLiabilitiesList.msumpresentamt
              : 0;
      mapDatashortTermLiabilities[TablesColumnFile.msumnextmonthamount] =
          shortTermLiabilitiesList.msumnextmonthamount != null
              ? shortTermLiabilitiesList.msumnextmonthamount
              : 0;
    }

    var mapDataEquity = new Map();
    if (equityList != null) {
      mapDataEquity[TablesColumnFile.tequityrefno] =
          equityList.tequityrefno != null ? equityList.tequityrefno : 0;
      mapDataEquity[TablesColumnFile.trefno] =
          equityList.trefno != null ? equityList.trefno : 0;
      mapDataEquity[TablesColumnFile.mrefno] =
          equityList.mrefno != null ? equityList.mrefno : 0;

      mapDataEquity[TablesColumnFile.mcash] =
          equityList.mcash != null ? equityList.mcash : 0;
      mapDataEquity[TablesColumnFile.mcashpresentamt] =
          equityList.mcashpresentamt != null ? equityList.mcashpresentamt : 0;
      mapDataEquity[TablesColumnFile.mcashnextmonthamount] =
          equityList.mcashnextmonthamount != null
              ? equityList.mcashnextmonthamount
              : 0;

      mapDataEquity[TablesColumnFile.maccntrecvbl] =
          equityList.maccntrecvbl != null ? equityList.maccntrecvbl : 0;
      mapDataEquity[TablesColumnFile.maccntrecvblpresentamt] =
          equityList.maccntrecvblpresentamt != null
              ? equityList.maccntrecvblpresentamt
              : 0;
      mapDataEquity[TablesColumnFile.maccntrecvblnextmonthamount] =
          equityList.maccntrecvblnextmonthamount != null
              ? equityList.maccntrecvblnextmonthamount
              : 0;

      mapDataEquity[TablesColumnFile.msumpresentamt] =
          equityList.msumpresentamt != null ? equityList.msumpresentamt : 0;
      mapDataEquity[TablesColumnFile.msumnextmonthamount] =
          equityList.msumnextmonthamount != null
              ? equityList.msumnextmonthamount
              : 0;
    }

    //ends here this

    var mapDataIncmSt = new Map();
    if (incomeStatemntBean != null) {
      mapDataIncmSt[TablesColumnFile.tincomerefno] =
          incomeStatemntBean.tincomerefno != null
              ? incomeStatemntBean.tincomerefno
              : 0;
      mapDataIncmSt[TablesColumnFile.mincomerefno] =
          incomeStatemntBean.mincomerefno != null
              ? incomeStatemntBean.mincomerefno
              : 0;
      mapDataIncmSt[TablesColumnFile.trefno] =
          incomeStatemntBean.trefno != null ? incomeStatemntBean.trefno : 0;
      mapDataIncmSt[TablesColumnFile.mrefno] =
          incomeStatemntBean.mrefno != null ? incomeStatemntBean.mrefno : 0;
      mapDataIncmSt[TablesColumnFile.mcustno] =
          incomeStatemntBean.mcustno != null ? incomeStatemntBean.mcustno : 0;
      mapDataIncmSt[TablesColumnFile.mtotalrevenuep] =
          incomeStatemntBean.mtotalrevenuep != null
              ? incomeStatemntBean.mtotalrevenuep
              : 0;
      mapDataIncmSt[TablesColumnFile.mtotalrevenuenm] =
          incomeStatemntBean.mtotalrevenuenm != null
              ? incomeStatemntBean.mtotalrevenuenm
              : 0;
      mapDataIncmSt[TablesColumnFile.mgrossprofitfirstp] =
          incomeStatemntBean.mgrossprofitfirstp != null
              ? incomeStatemntBean.mgrossprofitfirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.mgrossprofitfirstnm] =
          incomeStatemntBean.mgrossprofitfirstnm != null
              ? incomeStatemntBean.mgrossprofitfirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mrevenuefirstp] =
          incomeStatemntBean.mrevenuefirstp != null
              ? incomeStatemntBean.mrevenuefirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.mrevenuefirstnm] =
          incomeStatemntBean.mrevenuefirstnm != null
              ? incomeStatemntBean.mrevenuefirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mgoodcostfirstp] =
          incomeStatemntBean.mgoodcostfirstp != null
              ? incomeStatemntBean.mgoodcostfirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.mgoodcostfirstnm] =
          incomeStatemntBean.mgoodcostfirstnm != null
              ? incomeStatemntBean.mgoodcostfirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mgrossprofitsecondp] =
          incomeStatemntBean.mgrossprofitsecondp != null
              ? incomeStatemntBean.mgrossprofitsecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.mgrossprofitsecondnm] =
          incomeStatemntBean.mgrossprofitsecondnm != null
              ? incomeStatemntBean.mgrossprofitsecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mrevenuesecondp] =
          incomeStatemntBean.mrevenuesecondp != null
              ? incomeStatemntBean.mrevenuesecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.mrevenuesecondnm] =
          incomeStatemntBean.mrevenuesecondnm != null
              ? incomeStatemntBean.mrevenuesecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mgoodcostsecondp] =
          incomeStatemntBean.mgoodcostsecondp != null
              ? incomeStatemntBean.mgoodcostsecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.mgoodcostsecondnm] =
          incomeStatemntBean.mgoodcostsecondnm != null
              ? incomeStatemntBean.mgoodcostsecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.motherrevenuep] =
          incomeStatemntBean.motherrevenuep != null
              ? incomeStatemntBean.motherrevenuep
              : 0;
      mapDataIncmSt[TablesColumnFile.motherrevenuenm] =
          incomeStatemntBean.motherrevenuenm != null
              ? incomeStatemntBean.motherrevenuenm
              : 0;
      mapDataIncmSt[TablesColumnFile.mtotalopexpp] =
          incomeStatemntBean.mtotalopexpp != null
              ? incomeStatemntBean.mtotalopexpp
              : 0;
      mapDataIncmSt[TablesColumnFile.mtotalopexpnm] =
          incomeStatemntBean.mtotalopexpnm != null
              ? incomeStatemntBean.mtotalopexpnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mopexpfirstp] =
          incomeStatemntBean.mopexpfirstp != null
              ? incomeStatemntBean.mopexpfirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.mopexpfirstnm] =
          incomeStatemntBean.mopexpfirstnm != null
              ? incomeStatemntBean.mopexpfirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mpersonalexpfirstp] =
          incomeStatemntBean.mpersonalexpfirstp != null
              ? incomeStatemntBean.mpersonalexpfirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.mpersonalexpfirstnm] =
          incomeStatemntBean.mpersonalexpfirstnm != null
              ? incomeStatemntBean.mpersonalexpfirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mgeneralexpfirstp] =
          incomeStatemntBean.mgeneralexpfirstp != null
              ? incomeStatemntBean.mgeneralexpfirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.mgeneralexpfirstnm] =
          incomeStatemntBean.mgeneralexpfirstnm != null
              ? incomeStatemntBean.mgeneralexpfirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.motherexpfirstp] =
          incomeStatemntBean.motherexpfirstp != null
              ? incomeStatemntBean.motherexpfirstp
              : 0;
      mapDataIncmSt[TablesColumnFile.motherexpfirstnm] =
          incomeStatemntBean.motherexpfirstnm != null
              ? incomeStatemntBean.motherexpfirstnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mopexpsecondp] =
          incomeStatemntBean.mopexpsecondp != null
              ? incomeStatemntBean.mopexpsecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.mopexpsecondnm] =
          incomeStatemntBean.mopexpsecondnm != null
              ? incomeStatemntBean.mopexpsecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mpersonalexpsecondp] =
          incomeStatemntBean.mpersonalexpsecondp != null
              ? incomeStatemntBean.mpersonalexpsecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.mpersonalexpsecondnm] =
          incomeStatemntBean.mpersonalexpsecondnm != null
              ? incomeStatemntBean.mpersonalexpsecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mgeneralexpsecondp] =
          incomeStatemntBean.mgeneralexpsecondp != null
              ? incomeStatemntBean.mgeneralexpsecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.mgeneralexpsecondnm] =
          incomeStatemntBean.mgeneralexpsecondnm != null
              ? incomeStatemntBean.mgeneralexpsecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.motherexpsecondp] =
          incomeStatemntBean.motherexpsecondp != null
              ? incomeStatemntBean.motherexpsecondp
              : 0;
      mapDataIncmSt[TablesColumnFile.motherexpsecondnm] =
          incomeStatemntBean.motherexpsecondnm != null
              ? incomeStatemntBean.motherexpsecondnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mtaxexpp] =
          incomeStatemntBean.mtaxexpp != null ? incomeStatemntBean.mtaxexpp : 0;
      mapDataIncmSt[TablesColumnFile.mtaxexpnm] =
          incomeStatemntBean.mtaxexpnm != null
              ? incomeStatemntBean.mtaxexpnm
              : 0;
      mapDataIncmSt[TablesColumnFile.mnetincomep] =
          incomeStatemntBean.mnetincomep != null
              ? incomeStatemntBean.mnetincomep
              : 0;
      mapDataIncmSt[TablesColumnFile.mnetincomenm] =
          incomeStatemntBean.mnetincomenm != null
              ? incomeStatemntBean.mnetincomenm
              : 0;

      mapDataIncmSt[TablesColumnFile.mfromdate] =
          incomeStatemntBean.mfromdate != null
              ? incomeStatemntBean.mfromdate.toIso8601String()
              : null;
      mapDataIncmSt[TablesColumnFile.mtodate] =
          incomeStatemntBean.mtodate != null
              ? incomeStatemntBean.mtodate.toIso8601String()
              : null;
    }

    var mapDataFinSt = new Map();
    if (financialStatemntBean != null) {
      mapDataFinSt[TablesColumnFile.tfinancialstmntrefno] =
          financialStatemntBean.tfinancialstmntrefno != null
              ? financialStatemntBean.tfinancialstmntrefno
              : 0;
      mapDataFinSt[TablesColumnFile.mfinancialstmntrefno] =
          financialStatemntBean.mfinancialstmntrefno != null
              ? financialStatemntBean.mfinancialstmntrefno
              : 0;
      mapDataFinSt[TablesColumnFile.trefno] =
          financialStatemntBean.trefno != null
              ? financialStatemntBean.trefno
              : 0;
      mapDataFinSt[TablesColumnFile.mrefno] =
          financialStatemntBean.mrefno != null
              ? financialStatemntBean.mrefno
              : 0;
      mapDataFinSt[TablesColumnFile.mcustno] =
          financialStatemntBean.mcustno != null
              ? financialStatemntBean.mcustno
              : 0;
      mapDataFinSt[TablesColumnFile.mgrossprofitmargin] =
          financialStatemntBean.mgrossprofitmargin != null
              ? financialStatemntBean.mgrossprofitmargin
              : 0;
      mapDataFinSt[TablesColumnFile.mcurrentratio] =
          financialStatemntBean.mcurrentratio != null
              ? financialStatemntBean.mcurrentratio
              : 0;
      mapDataFinSt[TablesColumnFile.mdebtratio] =
          financialStatemntBean.mdebtratio != null
              ? financialStatemntBean.mdebtratio
              : 0;
      mapDataFinSt[TablesColumnFile.mtotcurasset] =
          financialStatemntBean.mtotcurasset != null
              ? financialStatemntBean.mtotcurasset
              : 0;
      mapDataFinSt[TablesColumnFile.mtotcurliabilities] =
          financialStatemntBean.mtotcurliabilities != null
              ? financialStatemntBean.mtotcurliabilities
              : 0;
      mapDataFinSt[TablesColumnFile.mworkngcapital] =
          financialStatemntBean.mworkngcapital != null
              ? financialStatemntBean.mworkngcapital
              : 0;
      mapDataFinSt[TablesColumnFile.mavginventory] =
          financialStatemntBean.mavginventory != null
              ? financialStatemntBean.mavginventory
              : 0;
      mapDataFinSt[TablesColumnFile.mavgaccreceivables] =
          financialStatemntBean.mavgaccreceivables != null
              ? financialStatemntBean.mavgaccreceivables
              : 0;
      mapDataFinSt[TablesColumnFile.mavgaccpayables] =
          financialStatemntBean.mavgaccpayables != null
              ? financialStatemntBean.mavgaccpayables
              : 0;
      mapDataFinSt[TablesColumnFile.mcogs] =
          financialStatemntBean.mcogs != null ? financialStatemntBean.mcogs : 0;
      mapDataFinSt[TablesColumnFile.msales] =
          financialStatemntBean.msales != null
              ? financialStatemntBean.msales
              : 0;
      mapDataFinSt[TablesColumnFile.mpurchases] =
          financialStatemntBean.mpurchases != null
              ? financialStatemntBean.mpurchases
              : 0;
      mapDataFinSt[TablesColumnFile.minvconperiod] =
          financialStatemntBean.minvconperiod != null
              ? financialStatemntBean.minvconperiod
              : 0;
      mapDataFinSt[TablesColumnFile.mrecconperiod] =
          financialStatemntBean.mrecconperiod != null
              ? financialStatemntBean.mrecconperiod
              : 0;
      mapDataFinSt[TablesColumnFile.mpayconperiod] =
          financialStatemntBean.mpayconperiod != null
              ? financialStatemntBean.mpayconperiod
              : 0;
      mapDataFinSt[TablesColumnFile.mworkngcapitalcycle] =
          financialStatemntBean.mworkngcapitalcycle != null
              ? financialStatemntBean.mworkngcapitalcycle
              : 0;
    }

    var mapDataTotlExpndtr = new Map();
    if (totalExpenditureDetailsBean != null) {
      print("totalExpenditureDetailsBean"+totalExpenditureDetailsBean.toString());
      mapDataTotlExpndtr[TablesColumnFile.ttotlexpntrefno] =
          totalExpenditureDetailsBean.ttotlexpntrefno != null
              ? totalExpenditureDetailsBean.ttotlexpntrefno
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mtotlexpnmrefno] =
          totalExpenditureDetailsBean.mtotlexpnmrefno != null
              ? totalExpenditureDetailsBean.mtotlexpnmrefno
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.trefno] =
          totalExpenditureDetailsBean.trefno != null
              ? totalExpenditureDetailsBean.trefno
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mrefno] =
          totalExpenditureDetailsBean.mrefno != null
              ? totalExpenditureDetailsBean.mrefno
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mcustno] =
          totalExpenditureDetailsBean.mcustno != null
              ? totalExpenditureDetailsBean.mcustno
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mlivngexpns] =
          totalExpenditureDetailsBean.mlivngexpns != null
              ? totalExpenditureDetailsBean.mlivngexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mtotlcommexpns] =
          totalExpenditureDetailsBean.mtotlcommexpns != null
              ? totalExpenditureDetailsBean.mtotlcommexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.meduexpns] =
          totalExpenditureDetailsBean.meduexpns != null
              ? totalExpenditureDetailsBean.meduexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mmedexpns] =
          totalExpenditureDetailsBean.mmedexpns != null
              ? totalExpenditureDetailsBean.mmedexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mtotlfamexpns] =
          totalExpenditureDetailsBean.mtotlfamexpns != null
              ? totalExpenditureDetailsBean.mtotlfamexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mloanservexpns] =
          totalExpenditureDetailsBean.mloanservexpns != null
              ? totalExpenditureDetailsBean.mloanservexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mcredcrdexpns] =
          totalExpenditureDetailsBean.mcredcrdexpns != null
              ? totalExpenditureDetailsBean.mcredcrdexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mrntlexpns] =
          totalExpenditureDetailsBean.mrntlexpns != null
              ? totalExpenditureDetailsBean.mrntlexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mlghtwtrexpns] =
          totalExpenditureDetailsBean.mlghtwtrexpns != null
              ? totalExpenditureDetailsBean.mlghtwtrexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mvechtrnsprtexpns] =
          totalExpenditureDetailsBean.mvechtrnsprtexpns != null
              ? totalExpenditureDetailsBean.mvechtrnsprtexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mothrexpns] =
          totalExpenditureDetailsBean.mothrexpns != null
              ? totalExpenditureDetailsBean.mothrexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mothrdebtrepymntexpns] =
          totalExpenditureDetailsBean.mothrdebtrepymntexpns != null
              ? totalExpenditureDetailsBean.mothrdebtrepymntexpns
              : 0;
      mapDataTotlExpndtr[TablesColumnFile.mtotldebtexpns] =
          totalExpenditureDetailsBean.mtotldebtexpns != null
              ? totalExpenditureDetailsBean.mtotldebtexpns
              : 0;
    }

    var mapDataImg;
    var imgDetailsList = new List();
    for (int imgDetList = 0; imgDetList < imageList.length; imgDetList++) {
      print("data data ");
      try {
        mapDataImg = new Map();
        mapDataImg[TablesColumnFile.tImgrefno] =
        imageList[imgDetList].tImgrefno != null &&
            imageList[imgDetList].tImgrefno != 'null'
            ? imageList[imgDetList].tImgrefno
            : 0;
        mapDataImg[TablesColumnFile.trefno] =
        imageList[imgDetList].trefno != null
            ? imageList[imgDetList].trefno
            : 0;
        // mapDataImg[TablesColumnFile.mImgrefno] =	        imageList[imgDetList].mImgrefno!=null && imageList[imgDetList].mImgrefno!='null' ?imageList[imgDetList].mImgrefno:0;
        mapDataImg[TablesColumnFile.mrefno] =
        imageList[imgDetList].mrefno != null
            ? imageList[imgDetList].mrefno
            : 0;
        mapDataImg["imgType"] = ifNullCheck(imageList[imgDetList].imgType);
        /* if (imageList[imgDetList].tImgrefno == 11 ||
          imageList[imgDetList].tImgrefno == 12) {*/
        if (imageList[imgDetList].tImgrefno > 10) {
          mapDataImg["imgString"] =
              ifNullCheck(imageList[imgDetList].imgString);
        } else {
          print("Data here is " + imageList[imgDetList].tImgrefno.toString());
          print(imageList[imgDetList].imgString);
          File imageFile = new File(imageList[imgDetList].imgString);
          final Directory extDir = await getApplicationDocumentsDirectory();
          var targetPath = extDir.absolute.path + "/temp.png";
          var imgFile = null;

          if (imageFile != null && targetPath != null) {
            print("imageFile.lengthSync() ${imageFile.lengthSync()}");
            try {
              if (customerListBean.mrefno == null ||
                  customerListBean.mrefno == 'null' ||
                  customerListBean.mrefno == 0) {
                imgFile = await compressAndGetFile(imageFile, targetPath);
              } else {
                imgFile = imageFile;
              }
            }catch(_){
              imgFile = imageFile;
            }
            List<int> imageBytes = imgFile.readAsBytesSync();
            String base64Image = base64.encode(imageBytes);
            mapDataImg["imgString"] = ifNullCheck(base64Image);
          } else {
            mapDataImg["imgString"] = null;
          }
          /*mapDataImg["imgString"] = imageBytes;*/
        }
        mapDataImg["imgSubType"] =
            ifNullCheck(imageList[imgDetList].imgSubType);
        mapDataImg["description"] = ifNullCheck(imageList[imgDetList].desc);
        //mapDataImg["imageByteString"] = imageList[imgDetList].imgString;
      }catch(_){
        mapDataImg["imgString"] = null;
        mapDataImg["imgSubType"] =  ifNullCheck(imageList[imgDetList].imgSubType);
        mapDataImg["description"] = ifNullCheck(imageList[imgDetList].desc);
      }
      if(mapDataImg!=null && mapDataImg!='null'&& mapDataImg!='') {
        imgDetailsList.add(mapDataImg);
      }
    }

//-----------------------ESMS JSON MAPPING---------------------------------------------
    var mapESMS = new Map();
    if (customerESMSBean != null) {
      mapESMS[TablesColumnFile.tesmsrefno] =
          customerESMSBean.tesmsrefno != null ? customerESMSBean.tesmsrefno : 0;
      mapESMS[TablesColumnFile.mesmsrefno] =
          customerESMSBean.mesmsrefno != null ? customerESMSBean.mesmsrefno : 0;

      mapESMS[TablesColumnFile.trefno] =
          customerESMSBean.trefno != null ? customerESMSBean.trefno : 0;
      mapESMS[TablesColumnFile.mrefno] =
          customerESMSBean.mrefno != null ? customerESMSBean.mrefno : 0;
      mapESMS[TablesColumnFile.mexclistchecked] =
          ifNullCheck(customerESMSBean.mexclistchecked);
      mapESMS[TablesColumnFile.misbrwrinlist] =
          ifNullCheck(customerESMSBean.misbrwrinlist);
      mapESMS[TablesColumnFile.mnontrgtcust] =
          ifNullCheck(customerESMSBean.mnontrgtcust);
      mapESMS[TablesColumnFile.misbrwrinnontrgt] =
          ifNullCheck(customerESMSBean.misbrwrinnontrgt);
      mapESMS[TablesColumnFile.mairemssn] =
          ifNullCheck(customerESMSBean.mairemssn);
      mapESMS[TablesColumnFile.maeapplglrequire] =
          ifNullCheck(customerESMSBean.maeapplglrequire);
      mapESMS[TablesColumnFile.maecmplncstatus] =
          ifNullCheck(customerESMSBean.maecmplncstatus);
      mapESMS[TablesColumnFile.maeevediance] =
          ifNullCheck(customerESMSBean.maeevediance);
      mapESMS[TablesColumnFile.mwastewater] =
          ifNullCheck(customerESMSBean.mwastewater);
      mapESMS[TablesColumnFile.mwwapplglrequire] =
          ifNullCheck(customerESMSBean.mwwapplglrequire);
      mapESMS[TablesColumnFile.mwwcmplncstatus] =
          ifNullCheck(customerESMSBean.mwwcmplncstatus);
      mapESMS[TablesColumnFile.mwwevediance] =
          ifNullCheck(customerESMSBean.mwwevediance);
      mapESMS[TablesColumnFile.msolidnhrdauswaste] =
          ifNullCheck(customerESMSBean.msolidnhrdauswaste);
      mapESMS[TablesColumnFile.mshapplglrequire] =
          ifNullCheck(customerESMSBean.mshapplglrequire);
      mapESMS[TablesColumnFile.mshcmplncstatus] =
          ifNullCheck(customerESMSBean.mshcmplncstatus);
      mapESMS[TablesColumnFile.mshevediance] =
          ifNullCheck(customerESMSBean.mshevediance);
      mapESMS[TablesColumnFile.mhrdzchemnfule] =
          ifNullCheck(customerESMSBean.mhrdzchemnfule);
      mapESMS[TablesColumnFile.mhcapplglrequire] =
          ifNullCheck(customerESMSBean.mhcapplglrequire);
      mapESMS[TablesColumnFile.mhccmplncstatus] =
          ifNullCheck(customerESMSBean.mhccmplncstatus);
      mapESMS[TablesColumnFile.mhcevediance] =
          ifNullCheck(customerESMSBean.mhcevediance);
      mapESMS[TablesColumnFile.mrescnsmpt] =
          ifNullCheck(customerESMSBean.mrescnsmpt);
      mapESMS[TablesColumnFile.mnuisance] =
          ifNullCheck(customerESMSBean.mnuisance);

      mapESMS[TablesColumnFile.mdust] = ifBoolNullCheck(customerESMSBean.mdust);
      mapESMS[TablesColumnFile.mtrafficcongandobs] =
          ifBoolNullCheck(customerESMSBean.mtrafficcongandobs);
      mapESMS[TablesColumnFile.mvibration] =
          ifBoolNullCheck(customerESMSBean.mvibration);
      mapESMS[TablesColumnFile.mfumes] =
          ifBoolNullCheck(customerESMSBean.mfumes);
      mapESMS[TablesColumnFile.modours] =
          ifBoolNullCheck(customerESMSBean.modours);
      mapESMS[TablesColumnFile.mnoise] =
          ifBoolNullCheck(customerESMSBean.mnoise);
      mapESMS[TablesColumnFile.mnocomissue] =
          ifBoolNullCheck(customerESMSBean.mnocomissue);
      mapESMS[TablesColumnFile.mnodesigperson] =
          ifBoolNullCheck(customerESMSBean.mnodesigperson);
      mapESMS[TablesColumnFile.mdispandressetle] =
          ifBoolNullCheck(customerESMSBean.mdispandressetle);
      mapESMS[TablesColumnFile.mlandacqreq] =
          ifBoolNullCheck(customerESMSBean.mlandacqreq);
      mapESMS[TablesColumnFile.mnoissue] =
          ifBoolNullCheck(customerESMSBean.mnoissue);
      mapESMS[TablesColumnFile.marchimp] =
          ifBoolNullCheck(customerESMSBean.marchimp);
      mapESMS[TablesColumnFile.msiteofcultural] =
          ifBoolNullCheck(customerESMSBean.msiteofcultural);
      mapESMS[TablesColumnFile.mcomplaintsfromneig] =
          ifBoolNullCheck(customerESMSBean.mcomplaintsfromneig);
      mapESMS[TablesColumnFile.mimpactofindgenous] =
          ifBoolNullCheck(customerESMSBean.mimpactofindgenous);
      mapESMS[TablesColumnFile.mimpactonlocal] =
          ifBoolNullCheck(customerESMSBean.mimpactonlocal);
      mapESMS[TablesColumnFile.mnorecognitionofemp] =
          ifBoolNullCheck(customerESMSBean.mnorecognitionofemp);
      mapESMS[TablesColumnFile.mlabourunion] =
          ifBoolNullCheck(customerESMSBean.mlabourunion);
      mapESMS[TablesColumnFile.mnolabissue] =
          ifBoolNullCheck(customerESMSBean.mnolabissue);
      mapESMS[TablesColumnFile.mnopersonalprotectiveEquip] =
          ifBoolNullCheck(customerESMSBean.mnopersonalprotectiveEquip);
      mapESMS[TablesColumnFile.mnoprocessforemployees] =
          ifBoolNullCheck(customerESMSBean.mnoprocessforemployees);
      mapESMS[TablesColumnFile.mchildoffrcdlabour] =
          ifBoolNullCheck(customerESMSBean.mchildoffrcdlabour);
      mapESMS[TablesColumnFile.mempblwminage] =
          ifBoolNullCheck(customerESMSBean.mempblwminage);
      mapESMS[TablesColumnFile.mpayblwminwage] =
          ifBoolNullCheck(customerESMSBean.mpayblwminwage);
      mapESMS[TablesColumnFile.munequalOpp] =
          ifBoolNullCheck(customerESMSBean.munequalOpp);
      mapESMS[TablesColumnFile.minadequatetermsofemp] =
          ifBoolNullCheck(customerESMSBean.minadequatetermsofemp);
      mapESMS[TablesColumnFile.minediquateworkingcond] =
          ifBoolNullCheck(customerESMSBean.minediquateworkingcond);
      mapESMS[TablesColumnFile.muinadequateemployeehealth] =
          ifBoolNullCheck(customerESMSBean.muinadequateemployeehealth);
      mapESMS[TablesColumnFile.mnontarget] =
          ifBoolNullCheck(customerESMSBean.mnontarget);
      mapESMS[TablesColumnFile.mcategoryc] =
          ifBoolNullCheck(customerESMSBean.mcategoryc);
      mapESMS[TablesColumnFile.mcategoryb] =
          ifBoolNullCheck(customerESMSBean.mcategoryb);
      mapESMS[TablesColumnFile.mcategorya] =
          ifBoolNullCheck(customerESMSBean.mcategorya);
      mapESMS[TablesColumnFile.mcomntfrmoff] =
          ifNullCheck(customerESMSBean.mcomntfrmoff);
      mapESMS[TablesColumnFile.mdecision] =
          ifNullCheck(customerESMSBean.mdecision);
      mapESMS[TablesColumnFile.msign] = ifNullCheck(customerESMSBean.msign);
      mapESMS[TablesColumnFile.mnameofoff] =
          ifNullCheck(customerESMSBean.mnameofoff);
      mapESMS[TablesColumnFile.mdsitrequiretorefroff] =
          ifNullCheck(customerESMSBean.mdsitrequiretorefroff);
      mapESMS[TablesColumnFile.date] = customerESMSBean.date != null
          ? customerESMSBean.date.toIso8601String()
          : null;

      //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxESMS JSON MAPPINGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    }

//-----------------------Risk JSON MAPPING---------------------------------------------
    var mapRiskRatings = new Map();
    if (customerRiskRatingsBean != null) {
      mapRiskRatings[TablesColumnFile.triskratingsrefno] =
      customerRiskRatingsBean.triskratingsrefno != null ? customerRiskRatingsBean.triskratingsrefno : 0;
      mapRiskRatings[TablesColumnFile.mriskratingsrefno] =
      customerRiskRatingsBean.mriskratingsrefno != null ? customerRiskRatingsBean.mriskratingsrefno : 0;
      mapRiskRatings[TablesColumnFile.trefno] =
      customerRiskRatingsBean.trefno != null ? customerRiskRatingsBean.trefno : 0;
      mapRiskRatings[TablesColumnFile.mrefno] =
      customerRiskRatingsBean.mrefno != null ? customerRiskRatingsBean.mrefno : 0;
      mapRiskRatings[TablesColumnFile.mcountryrisk] =
          ifNullCheck(customerRiskRatingsBean.mcountryrisk);
      mapRiskRatings[TablesColumnFile.mtypeofaccount] =
          ifNullCheck(customerRiskRatingsBean.mtypeofaccount);
      mapRiskRatings[TablesColumnFile.macctno] =
          ifNullCheck(customerRiskRatingsBean.macctno);
      mapRiskRatings[TablesColumnFile.mcifno] =
          ifNullCheck(customerRiskRatingsBean.mcifno);
      mapRiskRatings[TablesColumnFile.mvisaperiod] =
          ifNullCheck(customerRiskRatingsBean.mvisaperiod);
      mapRiskRatings[TablesColumnFile.mvisavalid] =
          ifNullCheck(customerRiskRatingsBean.mvisavalid);
      mapRiskRatings[TablesColumnFile.mvisatype] =
          ifNullCheck(customerRiskRatingsBean.mvisatype);
      mapRiskRatings[TablesColumnFile.mnatureofbuss] =
          ifNullCheck(customerRiskRatingsBean.mnatureofbuss);
      mapRiskRatings[TablesColumnFile.mhwwsacctopn] =
          ifNullCheck(customerRiskRatingsBean.mhwwsacctopn);
      mapRiskRatings[TablesColumnFile.mnetwrth] =
          ifNullCheck(customerRiskRatingsBean.mnetwrth);
      mapRiskRatings[TablesColumnFile.mexpectedvalue] =
          ifNullCheck(customerRiskRatingsBean.mexpectedvalue);
      mapRiskRatings[TablesColumnFile.mnooftransmnthly] =
          ifNullCheck(customerRiskRatingsBean.mnooftransmnthly);
      mapRiskRatings[TablesColumnFile.mhighnetwrth] =
          ifNullCheck(customerRiskRatingsBean.mhighnetwrth);
      mapRiskRatings[TablesColumnFile.mprcdservrskque1] =
          ifNullCheck(customerRiskRatingsBean.mprcdservrskque1);
      mapRiskRatings[TablesColumnFile.vmpurposeofacct] =
          ifNullCheck(customerRiskRatingsBean.vmpurposeofacct);
      //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxriSk Ratings JSON MAPPINGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    }


    mapData[TablesColumnFile.familyDetails] = famiDetList;
    mapData[TablesColumnFile.bankDetails] = bankDetailList;
    mapData[TablesColumnFile.addressDetails] = addDetailsList;
    mapData[TablesColumnFile.borrowingDetails] = borrDetailsList;
    // mapData[TablesColumnFile.businessExpendDetails] = bussExpDetailsList;
    // mapData[TablesColumnFile.householdExpendDetails] = houseExpDetailsList;
    mapData[TablesColumnFile.assetDetailsList] = assetDetailList;
    mapData[TablesColumnFile.imageMaster] = imgDetailsList;
    mapData[TablesColumnFile.customerBussDetails] = busDetsList;

    mapData[TablesColumnFile.fixedAssetsList] = mapDataFixedAssets;
    mapData[TablesColumnFile.currentAssetsList] = mapDataCurrentAssets;
    mapData[TablesColumnFile.longTermLiabilitiesList] =
        mapDatalongTermLiabilities;
    mapData[TablesColumnFile.shortTermLiabilitiesList] =
        mapDatashortTermLiabilities;
    mapData[TablesColumnFile.equityList] = mapDataEquity;
    mapData[TablesColumnFile.incomeStatementList] = mapDataIncmSt;
    mapData[TablesColumnFile.financialStmntList] = mapDataFinSt;
    mapData[TablesColumnFile.totalExpenditureDetailsBean] = mapDataTotlExpndtr;
    mapData[TablesColumnFile.esmsentity] = mapESMS;
    mapData[TablesColumnFile.riskratingsentity] = mapRiskRatings;


    //this is still not added in list
    mapData["paymentDetailsDetails"] = List();
    // mapData["customerPPIDetailsEntity"] = List();
    listCust.add(mapData);
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }

  Future<CustomerCheckBean> SyncSingleCustomerToMiddleware(
      CustomerListBean item, DateTime lastBulkSysTime) async {
    try {
      lastSyncedToServerDaeTime = lastBulkSysTime;

      await AppDatabase.get()
          .selectCustomerFamilyDetailsListIsDataSynced(item.trefno, item.mrefno)
          .then((List<FamilyDetailsBean> familyDetailsBean) async {
        customerFamilyDetailsList = familyDetailsBean;
      });

      await AppDatabase.get()
          .selectCustomerBankDetailsListIsDataSynced(item.trefno, item.mrefno)
          .then((List<SocialFinancialDetailsBean> socialFinancialDetailsBean) async {
        customerBankDetailsList = socialFinancialDetailsBean;
      });

      await AppDatabase.get()
          .selectCustomerBorrowingDetailsListIsDataSynced(
              item.trefno, item.mrefno)
          .then((List<BorrowingDetailsBean> borrowingDetailsBean) async {
        customerBorrowingDetailsList = borrowingDetailsBean;
      });

      await AppDatabase.get()
          .selectCustomerAddressDetailsListIsDataSynced(
              item.trefno, item.mrefno)
          .then((List<AddressDetailsBean> addressDetails) async {
        customerAddressDetailsList = addressDetails;
      });

      await AppDatabase.get()
          .selectImagesListIsDataSynced(item.trefno, item.mrefno)
          .then((List<ImageBean> imageBean) async {
        imageList = imageBean;
      });

      await AppDatabase.get()
          .selectCustomerBussinessDetails(item.trefno, item.mrefno)
          .then((List<CustomerBusinessDetailsBean> customerBussBean) async {
        customerBusinessDetailsBean = customerBussBean;
      });

      /*   await AppDatabase.get()
              .selectCustomerBusinessExpenseListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<BusinessExpenditureDetailsBean> businessExpenditureDetailsBean) async {
            businessExpendDetailsList = businessExpenditureDetailsBean;
          });*/

      /*  await AppDatabase.get()
              .selectCustomerHouseholdExpenseListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<HouseholdExpenditureDetailsBean> householdExpenditureDetailsBean) async {
            householdExpendDetailsList = householdExpenditureDetailsBean;
          });*/

      await AppDatabase.get()
          .selectCustomerAssetDetailListIsDataSynced(item.trefno, item.mrefno)
          .then((List<AssetDetailsBean> assetDetailsBean) async {
        assetDetailsList = assetDetailsBean;
      });

      await _toCustomerJson(item).then((onValue) {});

      print("length of adress is ${customerAddressDetailsList.length}");
      print(customerAddressDetailsList);
      //await _toCustomerJson(item).then((onValue) {});
      _serviceUrl = "customerData/addCustomerByHolder";
      String json = JSON.encode(listCust);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      isForSingleCustomer = true;
      await syncedDataToMiddleware(json);
      return custCheckObj;
    } catch (_) {
      return null;
    }
//after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
  }

  String ifDateNullCheck(DateTime value) {
    if (value == null || value == 'null') {
      return null;
    } else {
      return value.toIso8601String();
    }
  }

  bool ifBoolNullCheck(var value) {
    if (value == 'true' || value == true) {
      return true;
    } else {
      return false;
    }
  }
}
