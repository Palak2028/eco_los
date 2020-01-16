import 'dart:convert';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/Guarantor/GuarantorDetailsBean.dart';

import 'package:path_provider/path_provider.dart';

class SyncGuarantorToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};

  Future<Null> syncGuarantor(List listValue,String userCode) async {
    try {

      String bodyValue  = await NetworkUtil.callPostService(listValue.toString(),Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<GuarantorDetailsBean> obj = parsed
            .map<GuarantorDetailsBean>(
                (json) => GuarantorDetailsBean.fromMapMiddleware(json)).toList();
        for (int grntr = 0; grntr < obj.length; grntr++) {
          await AppDatabase.get()
              .selectGuarantorOnTrefANDMrefno(obj[grntr].trefno, obj[grntr].mcreatedby,obj[grntr].mrefno)
              .then((GuarantorDetailsBean guarantorDetailsBean) async {
            if (obj[grntr]!=null && obj[grntr].mrefno != null && guarantorDetailsBean.mrefno==null || guarantorDetailsBean.mrefno == 0) {
              String updateGrntrQuery ="";
              updateGrntrQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.mrefno} = ${obj[grntr].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[grntr].trefno} "
                    "AND ${TablesColumnFile.mcreatedby} = '${obj[grntr].mcreatedby.trim()}'";
              if(updateGrntrQuery !=null) {
                await AppDatabase.get().updateGuarantorMaster(updateGrntrQuery);
              }
            }else{
              String updateGrntrQuery ="";
              updateGrntrQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}'  WHERE ${TablesColumnFile.mrefno} = ${obj[grntr].mrefno} AND ${TablesColumnFile.trefno} = ${obj[grntr].trefno}";
              if (updateGrntrQuery != null) {
                await AppDatabase.get().updateGuarantorMaster(updateGrntrQuery);
              }
            }
          });
        }
        AppDatabase.get().updateStaticTablesLastSyncedMaster(15);
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> getAndSync(String userCode) async {
    List _guarantorList = new List();
    try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(15,false)
          .then((onValue) async {

        await AppDatabase.get().getGuarantorsNotSynced(onValue).then((guarantorList) async{
          for (int i = 0; i < guarantorList.length; i++) {
            await _toJson(guarantorList[i]).then((onValue) async {
              _guarantorList.add(onValue.toString());
            });
          }
          _serviceUrl = "/GuarantorController/add/";
          await syncGuarantor(_guarantorList,userCode);
        });
      });
    }

    catch (e) {
      print('Server Exception!!!');

    }
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

  Future<String> _toJson(GuarantorDetailsBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] =	bean.mrefno!=null ? bean.mrefno:0;
    mapData[TablesColumnFile.loantrefno] =	bean.loantrefno!=null ? bean.loantrefno:0;
    mapData[TablesColumnFile.loanmrefno] =	bean.loanmrefno!=null ? bean.loanmrefno:0;

    mapData[TablesColumnFile.mcustmrefno] =	bean.custmrefno!=null ? bean.custmrefno:0;
    mapData[TablesColumnFile.mcusttrefno] =	bean.custtrefno!=null ? bean.custtrefno:0;

    mapData[TablesColumnFile.mleadsid] =	ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.msrno] =	bean.msrno !=null ? bean.msrno :0;
    mapData[TablesColumnFile.mapplicanttype] =	bean.mapplicanttype !=null ? bean.mapplicanttype:0;
    mapData[TablesColumnFile.mexistingcustyn] =	ifNullCheck(bean.mexistingcustyn);
    mapData[TablesColumnFile.mcustno] =	bean.mcustno !=null ? bean.mcustno:0;
    mapData[TablesColumnFile.mnameofguar] =	ifNullCheck(bean.mnameofguar);
    mapData[TablesColumnFile.mgender] =	ifNullCheck(bean.mgender);
    mapData[TablesColumnFile.mrelationwithcust] =	ifNullCheck(bean.mrelationwithcust);
    mapData[TablesColumnFile.mrelationsince] =	bean.mrelationsince !=null ? bean.mrelationsince:0;
    mapData[TablesColumnFile.mage] =	bean.mage !=null ? bean.mage:0;
    mapData[TablesColumnFile.mphone] =	ifNullCheck(bean.mphone);
    mapData[TablesColumnFile.mmobile] =	ifNullCheck(bean.mmobile);
    mapData[TablesColumnFile.maddress] =	ifNullCheck(bean.maddress);
    mapData[TablesColumnFile.mmonthlyincome] =	bean.mmonthlyincome!=null?bean.mmonthlyincome:0;
    mapData[TablesColumnFile.mdob] =	ifDateNullCheck(bean.mdob) ;
        mapData[TablesColumnFile.moccupationtype] =	bean.moccupationtype!=null ? bean.moccupationtype:0;
        mapData[TablesColumnFile.mmainoccupation] =	bean.mmainoccupation !=null ? bean.mmainoccupation:0;
        mapData[TablesColumnFile.mworkexpinyrs] =	bean.mworkexpinyrs !=null ? bean.mworkexpinyrs:0;
        mapData[TablesColumnFile.mincomeothsources] =	bean.mincomeothsources!=null? bean.mincomeothsources:0;
        mapData[TablesColumnFile.mtotalincome] =	bean.mtotalincome!=null? bean.mtotalincome:0;mapData[TablesColumnFile.mhousetype] =	bean.mhousetype!=null ? bean.mhousetype:0;
        mapData[TablesColumnFile.mworkingaddress] =	ifNullCheck(bean.mworkingaddress);
    mapData[TablesColumnFile.mworkphoneno] =	ifNullCheck(bean.mworkphoneno);
    mapData[TablesColumnFile.mmothermaidenname] =	ifNullCheck(bean.mmothermaidenname);
    mapData[TablesColumnFile.mpromissorynote] =	ifNullCheck(bean.mpromissorynote);
    mapData[TablesColumnFile.mnationalidtype] =	bean.mnationalidtype!=null ? bean.mnationalidtype:0;
    mapData[TablesColumnFile.mnationalid] =	bean.mnationalid !=null ? bean.mnationalid:0;
    mapData[TablesColumnFile.mnationaliddesc] =	ifNullCheck(bean.mnationaliddesc);
    mapData[TablesColumnFile.maddress2] =	ifNullCheck(bean.maddress2);
    mapData[TablesColumnFile.maddress3] =	ifNullCheck(bean.maddress3);
    mapData[TablesColumnFile.maddress4] =	ifNullCheck(bean.maddress4);
    mapData[TablesColumnFile.mmaritalstatus] =	bean.mmaritalstatus!=null ? bean.mmaritalstatus:0;
    mapData[TablesColumnFile.mreligioncd] =	bean.mreligioncd!=null ? bean.mreligioncd:0;
    mapData[TablesColumnFile.meducationalqual] =	ifNullCheck(bean.meducationalqual);
    mapData[TablesColumnFile.memailaddr] =	ifNullCheck(bean.memailaddr);
    mapData[TablesColumnFile.memployername] =	ifNullCheck(bean.memployername);
    mapData[TablesColumnFile.mbusinessname] =	ifNullCheck(bean.mbusinessname);
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.merrormessage] =	ifNullCheck(bean.merrormessage);

    mapData[TablesColumnFile.mrevsrc1 ]=	ifNullCheck(bean.mrevsrc1);
    mapData[TablesColumnFile.mrevsrc2]=	ifNullCheck(bean.mrevsrc2);
    mapData[TablesColumnFile.mnamesrc1 ]=	ifNullCheck(bean.mnamesrc1);
    mapData[TablesColumnFile.mnamesrc2]=	ifNullCheck(bean.mnamesrc2);
    mapData[TablesColumnFile.mrev1 ]=bean.mrev1!=null ? bean.mrev1:0;
    mapData[TablesColumnFile.mrev2]=	bean.mrev2!=null ? bean.mrev2:0;
    mapData[TablesColumnFile.mexp1 ]=	bean.mexp1!=null ? bean.mexp1:0;
    mapData[TablesColumnFile.mexp2]=	bean.mexp2!=null ? bean.mexp2:0;
    mapData[TablesColumnFile.minc1 ]=	bean.minc1!=null ? bean.minc1:0;
    mapData[TablesColumnFile.minc2]=	bean.minc2!=null ? bean.minc2:0;
    mapData[TablesColumnFile.mrevtotal ]=bean.mrevtotal!=null ? bean.mrevtotal:0;
    mapData[TablesColumnFile.mexptotal ]=	bean.mexptotal!=null ? bean.mexptotal:0;
    mapData[TablesColumnFile.minctotal ]=	bean.minctotal!=null ? bean.minctotal:0;
    mapData[TablesColumnFile.mpldggurproprty1 ]=	ifNullCheck(bean.mpldggurproprty1);
    mapData[TablesColumnFile.mpldggurproprty2]=	ifNullCheck(bean.mpldggurproprty2);
    mapData[TablesColumnFile.mpldggurproprty3]=	ifNullCheck(bean.mpldggurproprty3);
    mapData[TablesColumnFile.msize1 ]=	bean.msize1!=null ? bean.msize1:0;
    mapData[TablesColumnFile.msize2]=	bean.msize2!=null ? bean.msize2:0;
    mapData[TablesColumnFile.msize3 ]=bean.msize3!=null ? bean.msize3:0;
    mapData[TablesColumnFile.mcollvalue1 ]=	bean.mcollvalue1!=null ? bean.mcollvalue1:0;
    mapData[TablesColumnFile.mcollvalue2]=	bean.mcollvalue2!=null ? bean.mcollvalue2:0;
    mapData[TablesColumnFile.mcollvalue3 ]=bean.mcollvalue3!=null ? bean.mcollvalue3:0;
    mapData[TablesColumnFile.mcollvaluetotal]=	bean.mcollvaluetotal!=null ? bean.mcollvaluetotal:0;

    mapData[TablesColumnFile.isDataSynced] = 1;
    String json = JSON.encode(mapData);

    return json;

  }
}
