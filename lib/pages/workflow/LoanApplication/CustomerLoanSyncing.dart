import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';


class CustomerLoanServices {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  bool isForSingleLoan = false;
  int mrefnoGeneratedForSingleLoan =0;
  DateTime lastSyncedToServerDaeTime=null;
  CustomerLoanCheckBean custLoanChkBean = new CustomerLoanCheckBean();

  Future<Null> syncLoan(List listValue,String userCode) async {
   try {

      String bodyValue  = await NetworkUtil.callPostService(listValue.toString(),Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      } else {

        print("Returned Json is ${bodyValue}");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerLoanDetailsBean> obj = parsed
            .map<CustomerLoanDetailsBean>(
                (json) => CustomerLoanDetailsBean.fromMapMiddleware(json))
            .toList();

        for (int cust = 0; cust < obj.length; cust++) {

          if(isForSingleLoan){
            mrefnoGeneratedForSingleLoan = obj[cust].mrefno;
            custLoanChkBean.trefno = obj[cust].trefno;
            custLoanChkBean.mrefno = obj[cust].mrefno;
            custLoanChkBean.mcustmrefno = obj[cust].mcustmrefno;
            custLoanChkBean.mcustno = obj[cust].mcustno;
            custLoanChkBean.merrormessage = obj[cust].merrormessage;
            custLoanChkBean.mCreatedBy = obj[cust].mcreatedby;
            custLoanChkBean.mlastUpdatedBy = obj[cust].mlastupdateby;
            custLoanChkBean.mleadStatus = obj[cust].mleadstatus;
            custLoanChkBean.mleadsid = obj[cust].mleadsid;
            custLoanChkBean.mprdacctid = obj[cust].mprdacctid.toString();
          }

          await AppDatabase.get()
              .selectLoanOnTrefANDMrefno(obj[cust].trefno, obj[cust].mcreatedby,obj[cust].mrefno)
              .then((CustomerLoanDetailsBean customerLoanDetailsBean) async {

         if ((obj[cust]!=null && obj[cust].mrefno != null )&& (customerLoanDetailsBean.mrefno==null || customerLoanDetailsBean.mrefno == 0)) {
              String updateCustQuery ="";
              if(isForSingleLoan){
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}', ${TablesColumnFile.merrormessage}  = '${obj[cust].merrormessage}'  ,"
                    " ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' , ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                    .mcreatedby.trim()}'":null;
              }else {
                updateCustQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno}  WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                    .mcreatedby.trim()}'";
              }
              if(updateCustQuery !=null) {
                await AppDatabase.get().updateCustomerLoanMaster(
                    updateCustQuery);
              }

              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} "
                  " WHERE ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                  .mcreatedby.trim()}'";
              // if (updateCustQuery != null) {

              await AppDatabase.get().updateCollateralBasicWhileLoanSyncMaster(updateCustQuery);
              await AppDatabase.get().updateCollateralVehicleWhileBasicCollSyncMaster(updateCustQuery);
              await AppDatabase.get().updateCollateralREMMasterAfterSync(updateCustQuery);
              await AppDatabase.get().updateGuranterWhileLoanSyncMaster(updateCustQuery);
              await AppDatabase.get().updateDocumentWhileLoanSyncMaster(updateCustQuery);

            }else{
              String updateCustQuery ="";
              if(isForSingleLoan){
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.merrormessage}  = '${obj[cust].merrormessage}' "
                    ", ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' "
                    " WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}":null;
              }else {
                updateCustQuery =
                    "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}'  WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}";
              }
               if (updateCustQuery != null) {
              await AppDatabase.get().updateCustomerLoanMaster(updateCustQuery);
               }

              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}'  WHERE ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} AND ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${userCode}'";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateCG1WhileLoanSyncMaster(updateCustQuery);

              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' WHERE ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} AND ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${userCode}'";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateCG2WhileLoanSyncMaster(updateCustQuery);
              await AppDatabase.get().updateCollateralBasicWhileLoanSyncMaster(updateCustQuery);


              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}'  WHERE ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} AND ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${userCode}'";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateGRTWhileLoanSyncMaster(updateCustQuery);
            }



        });
        }


        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMaster(6);
      }

   } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }


  Future<Null> getAndSync(String userCode) async {
    List _customerLoanDetailList = new List();
  try {
     await AppDatabase.get()
         .selectStaticTablesLastSyncedMaster(6,false)
         .then((onValue) async {

      await AppDatabase.get().getCustomerLoanDetailsNotSynced(onValue).then((loanList) async{
        for (int i = 0; i < loanList.length; i++) {
          await _toJsonCustomerLoan(loanList[i]).then((onValue) async {
            _customerLoanDetailList.add(onValue.toString());
          });
        }
        _serviceUrl = "customerLoanData/add/";
        await syncLoan(_customerLoanDetailList,userCode);
      });
     });
      }

   catch (e) {
      print('Server Exception!!!');

    }
  }



  Future<String> _toJsonCustomerLoan( CustomerLoanDetailsBean   customerLoan) async {
    var map = new Map();
    map[TablesColumnFile.trefno]  = customerLoan.trefno!=null?customerLoan.trefno:0;
    map[TablesColumnFile.mrefno]  = customerLoan.mrefno!=null? customerLoan.mrefno:0;
    map[TablesColumnFile.mleadsid]  =  ifNullCheck(customerLoan.mleadsid);
    map[TablesColumnFile.mappldloanamt]  =  customerLoan.mappldloanamt!=null?customerLoan.mappldloanamt:0.0;
    map[TablesColumnFile.mapprvdloanamt]  = customerLoan.mappldloanamt!=null?customerLoan.mapprvdloanamt:0.0;
    map[TablesColumnFile.mcustno]  = customerLoan.mcustno!=null?customerLoan.mcustno:0;
    map[TablesColumnFile.mcusttrefno]  = customerLoan.mcusttrefno!=null?customerLoan.mcusttrefno:0;
    map[TablesColumnFile.mcustmrefno]  = customerLoan.mcustmrefno!=null?customerLoan.mcustmrefno:0;
    map[TablesColumnFile.mcustcategory]  =  ifNullCheck(customerLoan.mcustcategory);
    map[TablesColumnFile.mloanamtdisbd]  = customerLoan.mloanamtdisbd!=null?customerLoan.mloanamtdisbd:0;
    map[TablesColumnFile.mloandisbdt]  = customerLoan.mloandisbdt!=null?customerLoan.mloandisbdt.toIso8601String():null;
    map[TablesColumnFile.mleadstatus]  = customerLoan.mloanamtdisbd!=null?customerLoan.mleadstatus:0;
    map[TablesColumnFile.mexpdt]  = customerLoan.mexpdt!=null?customerLoan.mexpdt.toIso8601String():null;

    map[TablesColumnFile.minstamt]  = customerLoan.minstamt!=null?customerLoan.minstamt:0.0;
    map[TablesColumnFile.minststrtdt]  = customerLoan.minststrtdt!=null?customerLoan.minststrtdt.toIso8601String():null;
    map[TablesColumnFile.minterestamount]  = customerLoan.minterestamount!=null?customerLoan.minterestamount:0.0;
    map[TablesColumnFile.mrepaymentmode]  =customerLoan.mrepaymentmode!=null? customerLoan.mrepaymentmode:0;
    map[TablesColumnFile.mmodeofdisb]  = customerLoan.mmodeofdisb!=null?customerLoan.mmodeofdisb:0;
    map[TablesColumnFile.mperiod]  = customerLoan.mperiod!=null?customerLoan.mperiod:0;
    map[TablesColumnFile.mprdcd]  = ifNullCheck(customerLoan.mprdcd);
    map[TablesColumnFile.mcurcd]  = ifNullCheck(customerLoan.mcurcd);
    map[TablesColumnFile.mpurposeofLoan]  =customerLoan.mpurposeofLoan!=null? customerLoan.mpurposeofLoan:0;
    map[TablesColumnFile.msubpurposeofloan]  = ifNullCheck(customerLoan.msubpurposeofloan);
    map[TablesColumnFile.msubpurposeofloandesc]  = ifNullCheck(customerLoan.msubpurposeofloandesc);
    map[TablesColumnFile.mintrate]  = customerLoan.mintrate!=null?customerLoan.mintrate:0;
    map[TablesColumnFile.mroutefrom]  = ifNullCheck(customerLoan.mroutefrom);
    map[TablesColumnFile.mrouteto]  = ifNullCheck(customerLoan.mrouteto);
    map[TablesColumnFile.mprdacctid]  = ifNullCheck(customerLoan.mprdacctid);
    map[TablesColumnFile.mloancycle]  = customerLoan.mloancycle!=null?customerLoan.mloancycle:0;
    map[TablesColumnFile.mfrequency]  = ifNullCheck(customerLoan.mfrequency);
    map[TablesColumnFile.mtypeofloan]  = ifNullCheck(customerLoan.mtypeofloan);
    map[TablesColumnFile.missecuredloan]  = ifNullCheck(customerLoan.missecuredloan);
    map[TablesColumnFile.mrepaymentfreq]  = ifNullCheck(customerLoan.mrepaymentfreq);
    map[TablesColumnFile.mcreateddt]  = customerLoan.mcreateddt!=null?customerLoan.mcreateddt.toIso8601String():null;
    map[TablesColumnFile.mcreatedby]  = ifNullCheck(customerLoan.mcreatedby);
    map[TablesColumnFile.mlastupdatedt]  = DateTime.now().toIso8601String();
    map[TablesColumnFile.mlastupdateby]  = ifNullCheck(customerLoan.mlastupdateby);
    map[TablesColumnFile.mgeolocation]  = ifNullCheck(customerLoan.mgeolocation);
    map[TablesColumnFile.mgeolatd]  =ifNullCheck(customerLoan.mgeolatd);
    map[TablesColumnFile.mgeologd]  = ifNullCheck(customerLoan.mgeologd);
    map[TablesColumnFile.mappliedasind]  = ifNullCheck(customerLoan.mappliedasind);
    map[TablesColumnFile.mappliedasind]  = ifNullCheck(customerLoan.mappliedasind);
    map[TablesColumnFile.missynctocoresys]  = customerLoan.missynctocoresys!=null?customerLoan.missynctocoresys:0;
    map[TablesColumnFile.mlastsynsdate]  = DateTime.now().toIso8601String();
    map[TablesColumnFile.mcustname]=ifNullCheck(customerLoan.mcustname);
    map[TablesColumnFile.mmainoccupn] =   ifNullCheck(customerLoan.mmainoccupn);
    map[TablesColumnFile.msuboccupn] =    ifNullCheck(customerLoan.msuboccupn);
    map[TablesColumnFile.mmainoccupndesc] =   ifNullCheck(customerLoan.mmainoccupndesc);
    map[TablesColumnFile.msuboccupndesc] =    ifNullCheck(customerLoan.msuboccupndesc);
    map[TablesColumnFile.mremarks] =    ifNullCheck(customerLoan.mremarks);
    map[TablesColumnFile.maccno] =    ifNullCheck(customerLoan.maccno);
    map[TablesColumnFile.minvestment] =    ifNullCheck(customerLoan.minvestment);
    map[TablesColumnFile.mrental] =    ifNullCheck(customerLoan.mrental);
    map[TablesColumnFile.mowneruse] =    ifNullCheck(customerLoan.mowneruse);



    String json = JSON.encode(map);
    print("Mapping Data Complete");
    return json;
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value.trim();
  }


  Future<CustomerLoanCheckBean> SyncSingleLoanToMiddleware(CustomerLoanDetailsBean item,DateTime lastBulkSysTime,String userCode) async {
    try {
      List _customerLoanDetailList = new List();

      if(lastBulkSysTime==null||lastBulkSysTime.toString().trim()=='null'){
        lastSyncedToServerDaeTime =DateTime.now();
      }

      lastSyncedToServerDaeTime = lastBulkSysTime;


          await _toJsonCustomerLoan(item).then((onValue) async {

            for(var items in onValue.toString().split(",")){
              print("LoanSending Json is ${items}");
            }
            await _customerLoanDetailList.add(onValue.toString());
          });

        _serviceUrl = "customerLoanData/add/";


      isForSingleLoan = true;
      await syncLoan(_customerLoanDetailList,userCode);
      return custLoanChkBean;
    }catch(_){
      return null;
    }
//after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
  }

/* int getMissync(CustomerLoanDetailsBean customerLoan) {

    if(customerLoan.mleadstatusdesc!=null&&customerLoan.mleadstatusdesc!="null"&&(customerLoan.mleadstatusdesc=="Cancelled"||customerLoan.mleadstatusdesc=="PreApproval"
        ||customerLoan.mleadstatusdesc=="Recommendation"||customerLoan.mleadstatusdesc=="Permanent Reject"||customerLoan.mleadstatusdesc=="Analytics"
        ||customerLoan.mleadstatusdesc=="Post Disbursement Cancellation"||customerLoan.mleadstatusdesc=="Verification"||customerLoan.mleadstatusdesc=="Appeal"
   ||customerLoan.mleadstatusdesc=="SendBack"||customerLoan.mleadstatusdesc=="Accepted"||customerLoan.mleadstatusdesc=="Remitted"
   ||customerLoan.mleadstatusdesc=="Rejected"||customerLoan.mleadstatusdesc=="Offer"||customerLoan.mleadstatusdesc=="Lead"
        ||customerLoan.mleadstatusdesc=="Documentation"||customerLoan.mleadstatusdesc=="Disbursement"||customerLoan.mleadstatusdesc=="Disbursement Initiated"
        ||customerLoan.mleadstatusdesc=="Appraisal"||customerLoan.mleadstatusdesc=="Approval"||customerLoan.mleadstatusdesc=="Application Data Entry"
    ||customerLoan.mleadstatusdesc=="Approved")){
      return 0;
    }else{
      return customerLoan.missynctocoresys;
    }*/


/// }

}
class  CustomerLoanCheckBean{

  int mcustno;
  int mcustmrefno;
  String mprdacctid;
  String merrormessage;
  int mrefno;
  int trefno;
  String mleadsid;
  String mCreatedBy;
  String mlastUpdatedBy;
  int mleadStatus;




  CustomerLoanCheckBean({this.mcustno, this.mcustmrefno, this.mprdacctid,
      this.merrormessage, this.mrefno, this.trefno,this.mleadsid,this.mCreatedBy,this.mlastUpdatedBy,this.mleadStatus
  });

  factory CustomerLoanCheckBean.fromMap(Map<String, dynamic> map,bool isTrue) {
    return CustomerLoanCheckBean(
        mcustmrefno: map[TablesColumnFile.mcustmrefno] as int,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        merrormessage: map[TablesColumnFile.merrormessage] as String,
        mrefno:map[TablesColumnFile.mrefno] as int,
        mcustno:map[TablesColumnFile.mcustno] as int,
        trefno: map[TablesColumnFile.trefno] as int,
      mleadsid: map[TablesColumnFile.mleadsid] as String,
      mCreatedBy:  map[TablesColumnFile.mcreatedby] as String,
      mlastUpdatedBy: map[TablesColumnFile.mlastupdateby] as String,
        mleadStatus: map[TablesColumnFile.mleadstatus] as int,
    );}


}
