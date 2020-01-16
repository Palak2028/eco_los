
import 'dart:convert';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/termDeposit/NewTermDepositBean.dart';


class SyncTDListToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};


  List listTD = List();

  Future<Null> syncedDataToMiddleware(String json) async {
    try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      print("bodyValue" + bodyValue.toString());
      if (bodyValue == "404") {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<NewTermDepositBean> obj = parsed
            .map<NewTermDepositBean>(
                (json) => NewTermDepositBean.fromMap(json))
            .toList();

        for (int save = 0; save < obj.length; save++) {
          print("print que : " +
              obj[save].mrefno.toString() +
              " : " +
              obj[save].trefno.toString());
          await AppDatabase.get()
              .selectTermDepositOnTref(obj[save].trefno, obj[save].mcreatedby)
              .then((NewTermDepositBean tdlist) async {
            String updateTDQuery = "";
            bool isSyncingFirstTime = false;
            print("isSyncingFirstTime111");
            print(isSyncingFirstTime);
            if (obj[save] != null && obj[save].mrefno != null &&
                tdlist != null &&
                (tdlist.mrefno == null || tdlist.mrefno == 0)) {
              isSyncingFirstTime = true;
              updateTDQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mrefno} = ${obj[save]
                  .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save]
                  .trefno}";
            } else {
              updateTDQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save]
                  .mrefno} AND ${TablesColumnFile.trefno} = ${obj[save]
                  .trefno}";
            }
            print("isSyncingFirstTime222");
            print(isSyncingFirstTime);
            print("No record displayed reason");
            print(tdlist.mrefno);
            print(obj[save].mrefno);
            print("upadate query save --" + updateTDQuery);
            print("Checking..");
            if (updateTDQuery != null) {
              await AppDatabase.get().updateTDMaster(updateTDQuery);
            }
          });
        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMaster(13);
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }




  Future<Null> savingsNormalData() async {
    List newTermdepositList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(13,false)
        .then((onValue) async {
      await AppDatabase.get()
          .selectTDListIsDataSynced(onValue)
          .then((List<NewTermDepositBean> savingsList) async {
        for (int i = 0; i < savingsList.length; i++) {
          print("length of TD >>>>> List " + savingsList.length.toString());
          await _toJson(savingsList[i]).then((onValue) {
            newTermdepositList.add(onValue.toString());
          });

        }

      });
    });

      _serviceUrl = "TDReceiptsController/add/";
      String json = JSON.encode(listTD);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }
      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    //});
  }



  Future<String> _toJson(NewTermDepositBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode!=null?bean.mlbrcode:0;
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctId);
    mapData[TablesColumnFile.mnametitle] =	ifNullCheck(bean.mnametitle);
    mapData[TablesColumnFile.mlongname] =	ifNullCheck(bean.mlongname);
    mapData[TablesColumnFile.mcurcd] =	ifNullCheck(bean.mcurcd);
    mapData[TablesColumnFile.mcertdate] =bean.mcertdate != null  ?  bean.mcertdate.toIso8601String() : null;
    mapData[TablesColumnFile.mnoinst] =	bean.mnoinst!=null ? bean.mnoinst:0;
    mapData[TablesColumnFile.mnoofmonths] =bean.mnoofmonths!=null ? bean.mnoofmonths:0;
    mapData[TablesColumnFile.mnoofdays] =	bean.mnoofdays!=null?bean.mnoofdays:0;
    mapData[TablesColumnFile.mintrate] =	bean.mintrate!=null?bean.mintrate:0;
    mapData[TablesColumnFile.mmatval] =	bean.mmatval!=null ? bean.mmatval:0;
    mapData[TablesColumnFile.mmatdate] =	bean.mmatdate != null ?  bean.mmatdate.toIso8601String() : null;
    mapData[TablesColumnFile.mreceiptstatus] =	bean.mreceiptstatus!=null?bean.mreceiptstatus:0;
    mapData[TablesColumnFile.mlastrepaydate] =		bean.mlastrepaydate != null ?  bean.mlastrepaydate.toIso8601String() : null;
    mapData[TablesColumnFile.mmainbalfcy] =	bean.mmainbalfcy!=null?bean.mmainbalfcy:0;
    mapData[TablesColumnFile.mintPrvdamtfcy] =	bean.mintPrvdamtfcy!=null?bean.mintPrvdamtfcy:0;
    mapData[TablesColumnFile.mintPaidamtfcy] =	bean.mintPaidamtfcy!=null ? bean.mintPaidamtfcy:0;
    mapData[TablesColumnFile.mtdsamtfcy] =	bean.mtdsamtfcy!=null ? bean.mtdsamtfcy:0;
    mapData[TablesColumnFile.mtdsyn] =	ifNullCheck(bean.mtdsyn);
    mapData[TablesColumnFile.mmodeofdeposit] =	ifNullCheck(bean.mmodeofdeposit);
    mapData[TablesColumnFile.mcustno] =	bean.mcustno!=null ? bean.mcustno:0;
    mapData[TablesColumnFile.mcenterid] =	bean.mcenterid!=null ? bean.mcenterid:0;
    mapData[TablesColumnFile.mgroupcd] =		bean.mgroupcd!=null ? bean.mgroupcd:0;
    mapData[TablesColumnFile.mprdcd] =		bean.mprdcd!=null ? bean.mprdcd:0;
    mapData[TablesColumnFile.mcrs] =	bean.mcrs!=null ? bean.mcrs:0;
    mapData[TablesColumnFile.mcreateddt] =	bean.mcreateddt != null  ?  bean.mcreateddt.toIso8601String() : null;
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =bean.mlastsynsdate != null ?  bean.mlastsynsdate.toIso8601String() : null;
    mapData[TablesColumnFile.isDataSynced] = 1;
    listTD.add(mapData);

  }

  String ifDateNullCheck(DateTime value){
    if(value==null || value == 'null'){
      return "";
    }
    else {
      return  value.toIso8601String();
    }

  }
  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
  }

}