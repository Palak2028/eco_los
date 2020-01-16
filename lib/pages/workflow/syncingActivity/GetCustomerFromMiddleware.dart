import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/Utilities/networt_util.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:path_provider/path_provider.dart';

class GetCustomerFromMiddleware{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCustomerDetails =
      "customerData/getCustomerbyCreatedByAndLastSyncedTiming/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    //isNetworkAvailable = await obj.checkIntCon();
    isNetworkAvailable = await Utility.checkIntCon();
    //  isNetworkAvailable = true;
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetCustomerDetails);
    }
  }

  Future<Null> updateCustomer(CustomerListBean custBean) async {


    await AppDatabase.get()
        .updateCustomerFoundationMasterDetailsTable(custBean,false)
        .then((onValue) {
    });

    print("Customer Mater Update Complete");
    await AppDatabase.get()
        .updateCustomerFoundationAddressDetailsListTable(custBean)
        .then((onValue) {
      //id = onValue;
    });
    print("Customer adress Update Complete");
    await AppDatabase.get()
        .updateCustomerFoundationFamilyDetailsListTable(custBean)
        .then((onValue) {
      //id = onValue;
    });
    print("Customer family Update Complete");
    await AppDatabase.get()
        .updateCustomerFoundationBankDetailsListTable(custBean)
        .then((onValue) {
      //id = onValue;
    });
    print("Customer bank Update Complete");

    await AppDatabase.get()
        .updateCustomerFoundationBorrowingDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });


    print("Customer PPI Update Complete");
 /*   await AppDatabase.get()
        .updateCustomerBusinessExpenseDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });*/
    print("Customer Business Expense Update Complete");
 /*   await AppDatabase.get()
        .updateCustomerHouseholdExpenseDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });*/
    print("Customer Household Expense Update Complete");
    await AppDatabase.get()
        .updateCustomerAssetDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
    print("Customer Asset Update Complete");

    // print("Customer borrowing Update Complete"+obj[cust].customerBusinessDetailsBean.mbussdetailsrefno.toString());
    // obj[cust].customerBusinessDetailsBean.tbussdetailsrefno=1;
    if (custBean.customerBusinessDetailsBean != null) {
      await AppDatabase.get()
          .updateCustomerFoundationBusinessDetailsListTable(
          custBean)
          .then((onValue) {
        // id = onValue;
      });
    }

    print("Customer business details Update Complete");

    await AppDatabase.get()
        .updateCustomerFixedAssetListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
    print("Customer Fixed Asset Update Complete");

    await AppDatabase.get()
        .updateCustomerCurrentAssetListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
    print("Customer Current Asset Update Complete");

    await AppDatabase.get()
        .updateCustomerLongTermLiabilitiesListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
    print("Customer Long Term Liability Update Complete");

    await AppDatabase.get()
        .updateCustomerShortTermLiabilitiesListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
    print("Customer Long Term Liability Update Complete");

    await AppDatabase.get()
        .updateCustomerEquityListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
    print("Customer Equity Update Complete");

    if (custBean.incomeStatementList != null) {
      await AppDatabase.get()
          .updateCustomerIncomeStatementBeanTable(
          custBean)
          .then((onValue) {
        // id = onValue;
      });
    }
    print("Customer Income Statement Update Complete");

    if (custBean.financialStmntList != null) {
      await AppDatabase.get()
          .updateCustomerFinancialStatementBeanTable(
          custBean)
          .then((onValue) {
        // id = onValue;
      });
    }
    print("Customer Financial Statement Update Complete");


    if (custBean.totalExpenditureDetailsBean != null) {
      custBean.totalExpenditureDetailsBean.trefno=custBean.trefno;
      custBean.totalExpenditureDetailsBean.mrefno=custBean.mrefno;
      await AppDatabase.get()
          .updateCustomerTotalExpendtrBeanTable(
          custBean)
          .then((onValue) {
        // id = onValue;
      });
    }
    print("Customer totalExpenditureDetailsBean Statement Update Complete");


    List<ImageBean> imgBean = custBean.imageMaster;
    if (custBean.imageMaster!=null) {
      for(int i =0;i<23;i++){
        custBean.imageMaster.add(new ImageBean());
      }
    }
    if (imgBean!=null) {
      for (int img = 0; img < imgBean.length; img++) {
        if ( imgBean[img].imgString!=null&&imgBean[img].tImgrefno !=null
            &&!(imgBean[img].tImgrefno > 10)
        ) {
          //  if(imgBean[img].imgString!=null) {
          await getData(imgBean[img]);
          //  }
        } else {
          setBean = imgBean[img];
        }
        /*  print("obj.getpath of img " +
                  obj[cust].imageMaster[img].imgString.toString());*/
        setBean.mrefno = custBean.mrefno;
        AppDatabase.get().updateImageMaster(
            setBean, imgBean[img].tImgrefno);
      }
    }

    if (custBean.esmsentity!= null) {
      custBean.esmsentity.trefno=custBean.trefno;
      custBean.esmsentity.mrefno=custBean.mrefno;
      await AppDatabase.get()
          .updateESMSMaster(
          custBean.esmsentity)
          .then((onValue) {
        // id = onValue;
      });
    }

      if (custBean.riskratingsentity!= null) {
        custBean.riskratingsentity.trefno=custBean.trefno;
        custBean.riskratingsentity.mrefno=custBean.mrefno;
        await AppDatabase.get()
            .updateRiskRatingsMaster(
            custBean.riskratingsentity)
            .then((onValue) {
          // id = onValue;
        });
    }
  }


  Future<Null> getMiddleWareData(
      String userName, String url) async {
    //await AppDatabase.get().deletSomeUtil();

    String json;
    DateTime isGreaterToSynced=null;
    List<CustomerListBean> isGreaterToSyncedcustomerData ;

    //After get sync we will make date greater, customer which is updatted before getsync frm server, those cusomer havr to br synced to server
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1, false)
        .then((onValue) async {
      isGreaterToSynced=onValue;
      if(onValue==null) {
        await AppDatabase.get()
            .selectCustomerListIsDataSynced(onValue)
            .then((List<CustomerListBean> customerData) async {
          print("lengtrh cust " + customerData.length.toString());
          isGreaterToSyncedcustomerData = customerData;
        });
      }
        });

    //Ends here

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1,true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName,onValue);
    });
     try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);
      print("url " + Constant.apiURL.toString() + url.toString());
      if (bodyValue == "404" ) {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<CustomerListBean> obj = parsed
            .map<CustomerListBean>(
                (json) => CustomerListBean.fromMapMiddleware(json, true))
            .toList();

        for (int cust = 0; cust < obj.length; cust++) {


         /* await AppDatabase.get()
              .updateCustomerFoundationMasterDetailsTable(obj[cust],false)
              .then((onValue) {
            // customerNumberValue = onValue;
          });

          print("Customer Mater Update Complete");
          await AppDatabase.get()
              .updateCustomerFoundationAddressDetailsListTable(obj[cust])
              .then((onValue) {
            //id = onValue;
          });
          print("Customer adress Update Complete");
          await AppDatabase.get()
              .updateCustomerFoundationFamilyDetailsListTable(obj[cust])
              .then((onValue) {
            //id = onValue;
          });
          print("Customer family Update Complete");

          await AppDatabase.get()
              .updateCustomerFoundationBankDetailsListTable(obj[cust])
              .then((onValue) {
            //id = onValue;
          });
          print("Customer bank Update Complete");
          await AppDatabase.get()
              .updateCustomerFoundationBorrowingDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });

          print("Customer PPI Update Complete");
         *//* await AppDatabase.get()
              .updateCustomerBusinessExpenseDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });*//*
          print("Customer Business Expense Update Complete");
         *//* await AppDatabase.get()
              .updateCustomerHouseholdExpenseDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });*//*
          print("Customer Household Expense Update Complete");
          await AppDatabase.get()
              .updateCustomerAssetDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          print("Customer Asset Update Complete");

          // print("Customer borrowing Update Complete"+obj[cust].customerBusinessDetailsBean.mbussdetailsrefno.toString());
          // obj[cust].customerBusinessDetailsBean.tbussdetailsrefno=1;
          if (obj[cust].customerBusinessDetailsBean != null) {
            await AppDatabase.get()
                .updateCustomerFoundationBusinessDetailsListTable(
                obj[cust])
                .then((onValue) {
              // id = onValue;
            });
          }

          print("Customer business details Update Complete");

          await AppDatabase.get()
              .updateCustomerFixedAssetListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          print("Customer Fixed Asset Update Complete");

          await AppDatabase.get()
              .updateCustomerCurrentAssetListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          print("Customer Current Asset Update Complete");

          await AppDatabase.get()
              .updateCustomerLongTermLiabilitiesListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          print("Customer Long Term Liability Update Complete");

          await AppDatabase.get()
              .updateCustomerShortTermLiabilitiesListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          print("Customer Long Term Liability Update Complete");

          await AppDatabase.get()
              .updateCustomerEquityListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          print("Customer Equity Update Complete");

          if (obj[cust].incomeStatementList != null) {
            await AppDatabase.get()
                .updateCustomerIncomeStatementBeanTable(
                obj[cust])
                .then((onValue) {
              // id = onValue;
            });
          }
          print("Customer Income Statement Update Complete");

          if (obj[cust].financialStmntList != null) {
            await AppDatabase.get()
                .updateCustomerFinancialStatementBeanTable(
                obj[cust])
                .then((onValue) {
              // id = onValue;
            });
          }
          print("Customer Financial Statement Update Complete");

          if (obj[cust].totalExpenditureDetailsBean != null) {
            await AppDatabase.get()
                .updateCustomerTotalExpendtrBeanTable(
                obj[cust])
                .then((onValue) {
              // id = onValue;
            });
          }
          print("Customer totalExpenditureDetailsBean Statement Update Complete");

          List<ImageBean> imgBean = obj[cust].imageMaster;
          if (obj[cust].imageMaster!=null) {
            for(int i =0;i<23;i++){
              obj[cust].imageMaster.add(new ImageBean());
            }
          }
          if (imgBean!=null) {
            for (int img = 0; img < imgBean.length; img++) {
              if (imgBean[img].imgSubType != 'Signature' && imgBean[img].imgString!=null) {
                print("signature or no "+imgBean[img].imgSubType.toString());
                //  if(imgBean[img].imgString!=null) {
                await getData(imgBean[img]);
                //  }
              } else {
                setBean = imgBean[img];
              }
              *//*  print("obj.getpath of img " +
                  obj[cust].imageMaster[img].imgString.toString());*//*
              setBean.mrefno = obj[cust].mrefno;
              AppDatabase.get().updateImageMaster(
                  setBean, imgBean[img].tImgrefno);
            }
          }

          if (obj[cust].esmsentity!= null) {
            await AppDatabase.get()
                .updateESMSMaster(
                obj[cust].esmsentity)
                .then((onValue) {
              // id = onValue;
            });
          }

          if (obj[cust].riskratingsentity!= null) {
            await AppDatabase.get()
                .updateRiskRatingsMaster(
                obj[cust].riskratingsentity)
                .then((onValue) {
              // id = onValue;
            });
          }
*/

          await updateCustomer(obj[cust]);

        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(1,updateDateimeAfterUpdate);


          if(isGreaterToSynced==null){
            AppDatabase.get().updateStaticTablesLastSyncedMaster(1);
          }
          for (int cust = 0; cust < isGreaterToSyncedcustomerData.length; cust++) {
           String  updateCustQuery = "${TablesColumnFile.mlastupdatedt} = '${DateTime
                .now().add(
               Duration(minutes: 1))}' WHERE ${TablesColumnFile
                .mrefno} = ${isGreaterToSyncedcustomerData[cust].mrefno} AND ${TablesColumnFile
                .trefno} = ${isGreaterToSyncedcustomerData[cust].trefno}";
           if (updateCustQuery != null) {
             await AppDatabase.get().updateCustomerMaster(updateCustQuery);
           }
          }
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }

  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(String createdBy, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = createdBy.trim();
    mapData["mlastsynsdate"] = lastsyncedDateTime!=null && lastsyncedDateTime!='null' && lastsyncedDateTime!=''? lastsyncedDateTime.toIso8601String():null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }


  Future<Null> getData(ImageBean bean) async{
    await  getImageStringPath(bean);
  }



  Future<Null> getImageStringPath(ImageBean bean)async{
    setBean = bean;
    Uint8List bytes =  base64.decode(bean.imgString);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/eco_los/getCustomerSyncedData';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    File file = new File(filePath);
    if (file.existsSync()) {
      setBean.imgString = file.path;
      bean.imgString = file.path;
      setBean.imgType=bean.imgType;
      setBean.imgSubType=bean.imgSubType;

    } else {
      print(" file bytes  here is " +bytes.toString());
      setBean.imgType=bean.imgType;
      setBean.imgSubType=bean.imgSubType;
      await file.writeAsBytes(bytes);
      print(setBean.imgType.toString()+" file path here is ");
      print(setBean.imgSubType.toString()+" file path here is ");
      print(file.path.toString()+" file path here is ");
      setBean.imgString = file.path;


    }

  }



}