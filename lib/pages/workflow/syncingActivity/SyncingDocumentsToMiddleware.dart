

import 'dart:convert';
import 'dart:io';

import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/DocumentCollector/DocumentCollectorBean.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class SyncingDocumentsToMiddleware{

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List documentList = List();

  Future<Null> syncDocumentMaster(String jsonList,String userCode) async {
    try {
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      if (bodyValue == '404') {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<DocumentCollectorBean> obj = parsed
            .map<DocumentCollectorBean>
          ((json) => DocumentCollectorBean.fromMapFromMiddleWareOnMrefno(json))
            .toList();

        for (int docColl = 0; docColl< obj.length; docColl++) {
          await AppDatabase.get()
              .selectDocumentOnTrefANDMrefno(obj[docColl].trefno, obj[docColl].mcreatedby,obj[docColl].mrefno)
              .then((DocumentCollectorBean documentCollectorBean) async {
            if (obj[docColl]!=null && obj[docColl].mrefno != null && documentCollectorBean.mrefno==null || documentCollectorBean.mrefno == 0) {
              String updateDocumentcollQuery ="";
              updateDocumentcollQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.mrefno} = ${obj[docColl].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[docColl].trefno} "
                  "AND ${TablesColumnFile.mcreatedby} = '${obj[docColl].mcreatedby.trim()}'";
              if(updateDocumentcollQuery !=null) {

                await AppDatabase.get().updateDocumentMasterAfterSync(updateDocumentcollQuery);
              }
            }else{
              String updateDocumentcollQuery ="";
              updateDocumentcollQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}'  WHERE ${TablesColumnFile.mrefno} = ${obj[docColl].mrefno} AND ${TablesColumnFile.trefno} = ${obj[docColl].trefno}";
              if (updateDocumentcollQuery != null) {
                await AppDatabase.get().updateDocumentMasterAfterSync(updateDocumentcollQuery);
              }
            }
          });
        }
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }


  Future<Null> getAndSync(String userCode) async {

   // try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(18, false)
          .then((returnedDocumentMasterDateTime) async {
            print("returnedDocumentMasterDateTime"+returnedDocumentMasterDateTime.toString());
        await AppDatabase.get()
            .selectDocumentListNotSynced(returnedDocumentMasterDateTime)
            .then((List<DocumentCollectorBean> documentCollectorBean) async {

          for (int i = 0; i < documentCollectorBean.length; i++) {


            await _toListJson(documentCollectorBean[i]);

          }
          String json = JSON.encode(documentList);

          _serviceUrl = "documentMasterData/add/";
          await syncDocumentMaster(json,userCode);
        });
      });
      AppDatabase.get().updateStaticTablesLastSyncedMaster(18);
   /* } catch (e) {
      print('Server Exception!!!');
    }*/
  }






  Future<String> _toListJson(DocumentCollectorBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno==null?0:bean.trefno;
    mapData[TablesColumnFile.mrefno] =	bean.mrefno==null?0:bean.mrefno;
    mapData[TablesColumnFile.loantrefno] =	bean.loantrefno==null?0:bean.loantrefno;
    mapData[TablesColumnFile.loanmrefno] =	bean.loanmrefno==null?0:bean.loanmrefno;
    mapData[TablesColumnFile.mforeignindicator] =	ifNullCheck(bean.mforeignindicator);
    mapData[TablesColumnFile.mdoctno] =	ifNullCheck(bean.mdoctno);
    mapData[TablesColumnFile.mcustname] =	ifNullCheck(bean.mcustname);
    mapData[TablesColumnFile.mcustno] =	bean.mcustno==null?0:bean.mcustno;
    mapData[TablesColumnFile.mcustmrefno] =	bean.custmrefno==null?0:bean.custmrefno;
    mapData[TablesColumnFile.mcusttrefno] =	bean.custtrefno==null?0:bean.custtrefno;
    mapData[TablesColumnFile.missuingauth] =	ifNullCheck(bean.missuingauth);
    mapData[TablesColumnFile.missuedate] =	ifDateNullCheck(bean.missuedate);
    mapData[TablesColumnFile.mexpdate] =	ifDateNullCheck(bean.mexpdate);
    mapData[TablesColumnFile.mexecutiondate] =	ifDateNullCheck(bean.mexecutiondate);
    mapData[TablesColumnFile.mimgtype] =	ifNullCheck(bean.mimgtype);
    mapData[TablesColumnFile.mcustomertype] =	ifNullCheck(bean.mcustomertype);
    mapData[TablesColumnFile.mimgtypedesc] =	ifNullCheck(bean.mimgtypedesc);
    mapData[TablesColumnFile.mimgsubtype] =	ifNullCheck(bean.mimgsubtype);
    mapData[TablesColumnFile.mcomment] =	ifNullCheck(bean.mcomment);

    mapData[TablesColumnFile.imgstring] =   await	getImageasBlob(bean.imgstring);
    mapData[TablesColumnFile.mremarks] =	ifNullCheck(bean.mremarks);

   // mapData[TablesColumnFile.imgstring] =   bean.imgstring;
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.merrormessage] =	ifNullCheck(bean.merrormessage);

    documentList.add(mapData);
    return mapData.toString();
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
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }


  /*Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }*/

   Future<String>  getImageasBlob(String imgPath) async {
     File imageFile = new File(imgPath);
     final Directory extDir = await getApplicationDocumentsDirectory();
     var targetPath = extDir.absolute.path + "/temp.png";
     var imgFile = null;

     if (imageFile != null && targetPath != null) {
      // imgFile = await compressAndGetFile(imageFile, targetPath);
       List<int> imageBytes = imageFile.readAsBytesSync();
       String base64Image = base64.encode(imageBytes);
       return ifNullCheck(base64Image);
     }
   }



   }
