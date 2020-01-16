import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_los/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_los/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_los/pages/workflow/customerFormation/bean/CustomerListBean.dart';

class CustomerLoanDetailsBean {


  int trefno;
  int mrefno;
  String mleadsid;
  double mappldloanamt;
  double mapprvdloanamt;
  //cust related changes
  int mcustno;
  int mcusttrefno;
  int mcustmrefno;
  String mcustcategory;
  //
  double mloanamtdisbd;
  DateTime mloandisbdt;
  int mleadstatus;
  String mleadstatusdesc;
  DateTime mexpdt;
  double minstamt;
  DateTime minststrtdt;
  double minterestamount;
  int mrepaymentmode;
  int mmodeofdisb;
  int mperiod;
  String mprdcd;
  String mcurcd;
  int mpurposeofLoan;
  String msubpurposeofloan;
  double mintrate;
  String mroutefrom;
  String mrouteto;
  String mprdacctid;
  int mloancycle;
  String mfrequency;
  String mtypeofloan;
  String missecuredloan;
  String mrepaymentfreq;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  String mprdname; //get value from prdCd
  String mcustname;
  //String mpurposeofloandesc;
  String msubpurposeofloandesc;
  String mrepaymentmodedesc;
  String mfrequencydesc;
  String mmodeofdisbdesc;
  String mapprovaldesc;
  String merrormessage;
  List<CGT1Bean> cgt1Bean;
  List<CGT2Bean> cgt2Bean;
  List<GRTBean> grtBean;
  CustomerListBean custBean;

  int mcenterid;
  int mgroupcd;
  String mappliedasind;
  String mmainoccupn;
  String msuboccupn;
  String msuboccupndesc;
  String mmainoccupndesc;
  String mremarks;
  String maccno;
  String minvestment;
  String mrental;
  String mowneruse;



  @override
  String toString() {
    return 'CustomerLoanDetailsBean{trefno: $trefno, mrefno: $mrefno, mleadsid: $mleadsid, mappldloanamt: $mappldloanamt, mapprvdloanamt: $mapprvdloanamt, mcustno: $mcustno, mcusttrefno: $mcusttrefno, mcustmrefno: $mcustmrefno, mcustcategory: $mcustcategory, mloanamtdisbd: $mloanamtdisbd, mloandisbdt: $mloandisbdt, mleadstatus: $mleadstatus, mleadstatusdesc: $mleadstatusdesc, mexpdt: $mexpdt, minstamt: $minstamt, minststrtdt: $minststrtdt, minterestamount: $minterestamount, mrepaymentmode: $mrepaymentmode, mmodeofdisb: $mmodeofdisb, mperiod: $mperiod, mprdcd: $mprdcd, mcurcd: $mcurcd, mpurposeofLoan: $mpurposeofLoan, msubpurposeofloan: $msubpurposeofloan, mintrate: $mintrate, mroutefrom: $mroutefrom, mrouteto: $mrouteto, mprdacctid: $mprdacctid, mloancycle: $mloancycle, mfrequency: $mfrequency, mtypeofloan: $mtypeofloan, missecuredloan: $missecuredloan, mrepaymentfreq: $mrepaymentfreq, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: $missynctocoresys, mlastsynsdate: $mlastsynsdate, mprdname: $mprdname, mcustname: $mcustname, msubpurposeofloandesc: $msubpurposeofloandesc, mrepaymentmodedesc: $mrepaymentmodedesc, mfrequencydesc: $mfrequencydesc, mmodeofdisbdesc: $mmodeofdisbdesc, mapprovaldesc: $mapprovaldesc, merrormessage: $merrormessage, cgt1Bean: $cgt1Bean, cgt2Bean: $cgt2Bean, grtBean: $grtBean, custBean: $custBean, mcenterid: $mcenterid, mgroupcd: $mgroupcd, mappliedasind: $mappliedasind, mmainoccupn: $mmainoccupn, msuboccupn: $msuboccupn, msuboccupndesc: $msuboccupndesc, mmainoccupndesc: $mmainoccupndesc, mremarks: $mremarks}';
  }

  CustomerLoanDetailsBean(
      { this.trefno,
        this.mrefno,
        this.mleadsid,
        this.mappldloanamt,
        this.mapprvdloanamt,
        this.mcustno,
        this.mcusttrefno,
        this.mcustmrefno,
        this.mcustcategory,
        this.mloanamtdisbd,
        this.mloandisbdt,
        this.mleadstatus,
        this.mleadstatusdesc,
        this.mexpdt,
        this.minstamt,
        this.minststrtdt,
        this.minterestamount,
        this.mrepaymentmode,
        this.mmodeofdisb,
        this.mperiod,
        this.mprdcd,
        this.mpurposeofLoan,
        this.msubpurposeofloan,
        this.mintrate,
        this.mroutefrom,
        this.mrouteto,
        this.mprdacctid,
        this.mloancycle,
        this.mfrequency,
        this.mtypeofloan,
        this.missecuredloan,
        this.mrepaymentfreq,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.missynctocoresys,
        this.mlastsynsdate,
        //this.mpurposeofloandesc,
        this.msubpurposeofloandesc,
        this.mcurcd,
        this.mcustname,
        this.mprdname,
        this.mapprovaldesc,
        this.merrormessage,
        this.cgt1Bean,
        this.cgt2Bean,
        this.grtBean,
        this.custBean,
        this.mcenterid,
        this.mgroupcd,
        this.mappliedasind,
        this.mmainoccupn,
        this.msuboccupndesc,
        this.msuboccupn,
        this.mmainoccupndesc,
        this.mremarks,
        this.maccno,
        this.minvestment,
        this.mrental,
        this.mowneruse

      });

  factory CustomerLoanDetailsBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return CustomerLoanDetailsBean(
        trefno: map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mappldloanamt: map[TablesColumnFile.mappldloanamt] as double,
        mapprvdloanamt: map[TablesColumnFile.mapprvdloanamt] as double,
        mcustno: map[TablesColumnFile.mcustno] as int,
        mcusttrefno:map[TablesColumnFile.mcusttrefno] as int,
        mcustmrefno:map[TablesColumnFile.mcustmrefno] as int,
        mcustcategory:map[TablesColumnFile.mcustcategory] as String,

        mloanamtdisbd: map[TablesColumnFile.mloanamtdisbd] as double,
        mloandisbdt: (map[TablesColumnFile.mloandisbdt]=="null"||map[TablesColumnFile.mloandisbdt]==null)?null:DateTime.parse(map[TablesColumnFile.mloandisbdt]) as DateTime,
        mleadstatus: map[TablesColumnFile.mleadstatus] as int,
      mleadstatusdesc: map[TablesColumnFile.mleadstatusdesc] as String,


        mexpdt:(map[TablesColumnFile.mexpdt]=="null"||map[TablesColumnFile.mexpdt]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdt]) as DateTime,
        minstamt: map[TablesColumnFile.minstamt] as double,
        minststrtdt:(map[TablesColumnFile.minststrtdt]=="null"||map[TablesColumnFile.minststrtdt]==null)?null:DateTime.parse(map[TablesColumnFile.minststrtdt]) as DateTime,
        minterestamount: map[TablesColumnFile.minterestamount] as double,
        mrepaymentmode: map[TablesColumnFile.mrepaymentmode] as int,
        mmodeofdisb: map[TablesColumnFile.mmodeofdisb] as int,
        mperiod: map[TablesColumnFile.mperiod] as int,
        mprdcd: map[TablesColumnFile.mprdcd] as String,
      mcurcd: map[TablesColumnFile.mcurcd] as String,
      mprdname: map[TablesColumnFile.mprdname] as String,
        mpurposeofLoan: map[TablesColumnFile.mpurposeofLoan] as int,
        msubpurposeofloan: map[TablesColumnFile.msubpurposeofloan] as String,
        msubpurposeofloandesc: map[TablesColumnFile.msubpurposeofloandesc] as String,
        mintrate: map[TablesColumnFile.mintrate] as double,
        mroutefrom: map[TablesColumnFile.mroutefrom] as String,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mloancycle: map[TablesColumnFile.mloancycle] as int,
        mfrequency: map[TablesColumnFile.mfrequency] as String,
      mtypeofloan: map[TablesColumnFile.mtypeofloan] as String,
      missecuredloan: map[TablesColumnFile.missecuredloan] as String,
      mrepaymentfreq: map[TablesColumnFile.mrepaymentfreq] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby: map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation: map[TablesColumnFile.mgeolocation] as String,
        mgeolatd: map[TablesColumnFile.mgeolatd] as String,
        mgeologd: map[TablesColumnFile.mgeologd] as String,
        missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
        //mpurposeofloandesc: map[TablesColumnFile.mpurposeofloandesc] as String,

        mcustname:map[TablesColumnFile.mcustname] as String,
        mapprovaldesc:map[TablesColumnFile.mApprovalDesc] as String,
        merrormessage:map[TablesColumnFile.merrormessage] as String,
        mcenterid:map[TablesColumnFile.mcenterid] as int,
        mgroupcd:map[TablesColumnFile.mgroupcd] as int,
        mappliedasind:map[TablesColumnFile.mappliedasind] as String,
      mmainoccupn : map[TablesColumnFile.mmainoccupn] as String,
      msuboccupn : map[TablesColumnFile.msuboccupn] as String,
      mmainoccupndesc : map[TablesColumnFile.mmainoccupndesc] as String,
      msuboccupndesc : map[TablesColumnFile.msuboccupndesc] as String,
      mremarks : map[TablesColumnFile.mremarks] as String,
      maccno : map[TablesColumnFile.maccno] as String,
      minvestment : map[TablesColumnFile.minvestment] as String,
      mrental : map[TablesColumnFile.mrental] as String,
      mowneruse : map[TablesColumnFile.mowneruse] as String,

    );
  }

  factory CustomerLoanDetailsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");

    return CustomerLoanDetailsBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mleadsid: map[TablesColumnFile.mleadsid] as String,
      mappldloanamt: map[TablesColumnFile.mappldloanamt] as double,
      mapprvdloanamt: map[TablesColumnFile.mapprvdloanamt] as double,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcusttrefno:map[TablesColumnFile.mcusttrefno] as int,
      mcustmrefno:map[TablesColumnFile.mcustmrefno] as int,
      mcustcategory:map[TablesColumnFile.mcustcategory] as String,
      mloanamtdisbd: map[TablesColumnFile.mloanamtdisbd] as double,
      mloandisbdt: (map[TablesColumnFile.mloandisbdt]=="null"||map[TablesColumnFile.mloandisbdt]==null)?null:DateTime.parse(map[TablesColumnFile.mloandisbdt]) as DateTime,
      mleadstatus: map[TablesColumnFile.mleadstatus] as int,
      mleadstatusdesc: map[TablesColumnFile.mleadstatusdesc] as String,

      mexpdt:(map[TablesColumnFile.mexpdt]=="null"||map[TablesColumnFile.mexpdt]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdt]) as DateTime,
      minstamt: map[TablesColumnFile.minstamt] as double,
      minststrtdt:(map[TablesColumnFile.minststrtdt]=="null"||map[TablesColumnFile.minststrtdt]==null)?null:DateTime.parse(map[TablesColumnFile.minststrtdt]) as DateTime,
      minterestamount: map[TablesColumnFile.minterestamount] as double,
      mrepaymentmode: map[TablesColumnFile.mrepaymentmode] as int,
      mmodeofdisb: map[TablesColumnFile.mmodeofdisb] as int,
      mperiod: map[TablesColumnFile.mperiod] as int,
      mprdcd: map[TablesColumnFile.mprdcd]as String,
      mcurcd: map[TablesColumnFile.mcurcd] as String,
      mpurposeofLoan: map[TablesColumnFile.mpurposeofLoan] as int,
      //mpurposeofLoanDesc: map[TablesColumnFile.mpurposeofLoanDesc] as String,
        msubpurposeofloan: map[TablesColumnFile.msubpurposeofloan] as String,
        msubpurposeofloandesc: map[TablesColumnFile.msubpurposeofloandesc] as String,
      mintrate: map[TablesColumnFile.mintrate] as double,
      mroutefrom: map[TablesColumnFile.mroutefrom] as String,
      mrouteto: map[TablesColumnFile.mrouteto] as String,
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      mloancycle: map[TablesColumnFile.mloancycle] as int,
      mfrequency: map[TablesColumnFile.mfrequency] as String,
      mtypeofloan: map[TablesColumnFile.mtypeofloan] as String,
      missecuredloan: map[TablesColumnFile.missecuredloan] as String,
      mrepaymentfreq: map[TablesColumnFile.mrepaymentfreq] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mcustname:map[TablesColumnFile.mcustname] as String,
      mapprovaldesc:map[TablesColumnFile.mApprovalDesc] as String,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
      cgt1Bean: map[TablesColumnFile.cgt1Bean]==null?null:
      map[TablesColumnFile.cgt1Bean].map<CGT1Bean>((i) => CGT1Bean.fromMiddleware(i))
          .toList(),
      cgt2Bean:map[TablesColumnFile.cgt2Bean]==null?null:map[TablesColumnFile.cgt2Bean].map<CGT2Bean>((i) => CGT2Bean.fromMiddleware(i))
          .toList(),
      grtBean:
      map[TablesColumnFile.grtBean]==null?null:map[TablesColumnFile.grtBean].map<GRTBean>((i) => GRTBean.fromMiddleware(i))
          .toList(),
      mcenterid:map[TablesColumnFile.mcenterid] as int,
      mgroupcd:map[TablesColumnFile.mgroupid] as int,
      custBean:map[TablesColumnFile.custBean]==null?null:

      CustomerListBean.fromMapMiddleware(map[TablesColumnFile.custBean],true),
        mappliedasind:map[TablesColumnFile.mappliedasind] as String,
      mmainoccupn : map[TablesColumnFile.mmainoccupn] as String,
      msuboccupn : map[TablesColumnFile.msuboccupn] as String,
      mmainoccupndesc : map[TablesColumnFile.mmainoccupndesc] as String,
      msuboccupndesc : map[TablesColumnFile.msuboccupndesc] as String,
      mremarks : map[TablesColumnFile.mremarks] as String,
      maccno : map[TablesColumnFile.maccno] as String,
      minvestment : map[TablesColumnFile.minvestment] as String,
      mrental : map[TablesColumnFile.mrental] as String,
      mowneruse : map[TablesColumnFile.mowneruse] as String,



    );

  }
}

