import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/pages/workflow/Collateral/Bean/CollateralBasicSelectionBean.dart';
import 'package:eco_los/pages/workflow/DocumentCollector/DocumentCollectorBean.dart';
import 'package:eco_los/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_los/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:path_provider/path_provider.dart';

class GetLoanFromMiddleware {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCustomerLoanDetails =
      "customerLoanData/getCustomerLoansbyCreatedByORrouteAndLastSyncedTiming/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;

  Future<Null> trySave(String userName,int lbrCd) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetCustomerLoanDetails,lbrCd);
    }
  }

  Future<Null> getMiddleWareData(String userName, String url,int lbrCd) async {
    //await AppDatabase.get().deletSomeUtil();

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(6, true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName, onValue);
      print(json);
    });
  // try {
    String bodyValue = await NetworkUtil.callPostService(
        json.toString(), Constant.apiURL.toString() + url.toString(), _headers);
    print("url " + Constant.apiURL.toString() + url.toString());
    if (bodyValue == "404") {
      return null;
    } else {
      print(bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      DateTime updateDateimeAfterUpdate = DateTime.now();
      List<CustomerLoanDetailsBean> obj = parsed
          .map<CustomerLoanDetailsBean>(
              (json) => CustomerLoanDetailsBean.fromMapMiddleware(json))
          .toList();

      for (int loan = 0; loan < obj.length; loan++) {

        if(obj[loan].mprdname==null || obj[loan].mprdname=='' ){
         await AppDatabase.get()
              .getProductOnPrdCd(30, lbrCd,obj[loan].mprdcd)
              .then((ProductBean response){
                if(response.mname !=null) {
                  obj[loan].mprdname = response.mname;
                }
         });
        }
        print("obj[loan]"+obj[loan].toString());
        await AppDatabase.get()
            .updateCustomerLoanDetailsMaster(obj[loan])
            .then((onValue) {
          // customerNumberValue = onValue;
        });


     /*   if (obj[loan] != null&& obj.length>0 ) {
          AppDatabase.get().getGaurantorDetailsList(obj[loan].trefno,obj[loan].mrefno).then(
                  (List<GuarantorDetailsBean> gaurantorData){
          for (int gaurantorList = 0;
          gaurantorList < gaurantorData.length;
          gaurantorList++) {
            try {
               AppDatabase.get()
                  .updateGaurantorMaster(gaurantorData[gaurantorList])
                  .then((onValue)  {
              });
            } catch (_) {}
          }});
        }
*/

/*
        if (obj[loan] != null&& obj.length>0 ) {
          AppDatabase.get().getCollatrlDetailsList(obj[loan].trefno,obj[loan].mrefno).then(
                  (List<CollateralBasicSelectionBean> CollateralBasicData){
                for (int CollateralBasicList = 0;
                CollateralBasicList < CollateralBasicData.length;
                CollateralBasicList++) {
                  try {
                    AppDatabase.get()
                        .updateCollateralsMaster(CollateralBasicData[CollateralBasicList])
                        .then((onValue)  {
                      if(onValue.collatrlTyp =='33'){
                        AppDatabase.get().selectCollateralVehicleBeanOnCollateralMTrefAndTrefno(onValue.trefno,
                            onValue.mrefno,onValue.mcreatedby).then((onValue) {
                              try{
                                AppDatabase.get()
                                    .updateCollateralVehicleMaster(onValue)
                                    .then((onValue)  {
                              });}
                              catch(_){

                                }

                        });
                        }
                      if(onValue.collatrlTyp =='34'){
                        AppDatabase.get().selectCollateralREMBeanOnCollateralMTrefAndTrefno(onValue.trefno,
                            onValue.mrefno,onValue.mcreatedby).then((onValue) {
                          try{
                            AppDatabase.get()
                                .updateCollateralREMlandandhouseMaster(onValue)
                                .then((onValue)  {
                            });}
                          catch(_){

                          }

                        });
                      }
                    });
                  } catch (_) {}
                }});
        }*/

   /*     if (obj[loan] != null&& obj.length>0 ) {
          AppDatabase.get().getDocumentList(obj[loan].trefno,obj[loan].mrefno).then(
                  (List<DocumentCollectorBean> DocumentCollectorData){
                for (int DocumentCollectorList = 0;
                DocumentCollectorList < DocumentCollectorData.length;
                DocumentCollectorList++) {
                  try {
                    AppDatabase.get()
                        .updateDocumentsMasters(DocumentCollectorData[DocumentCollectorList])
                        .then((onValue)  {
                    });
                  } catch (_) {}
                }});
        }
*/



        GetCustomerFromMiddleware getCustObj = new GetCustomerFromMiddleware();
        if (obj[loan].custBean != null) {
          print(
              "xxxxxxxxxxxxxxx custname is ${obj[loan].custBean.mlongname}  ");
          await getCustObj.updateCustomer(obj[loan].custBean);
        }
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(
          6, updateDateimeAfterUpdate);

      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(6, false)
          .then((onValue) async {
        if (onValue == null) {
          AppDatabase.get().updateStaticTablesLastSyncedMaster(6);
        }
      });
    }

  /* } catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(
      String loggedInUser, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = loggedInUser;
    //  mapData["routeTo"] = agentUserNo.toString().trim();
    mapData["mlastsynsdate"] = lastsyncedDateTime != null &&
            lastsyncedDateTime != 'null' &&
            lastsyncedDateTime != ''
        ? lastsyncedDateTime.toIso8601String()
        : null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }
}
