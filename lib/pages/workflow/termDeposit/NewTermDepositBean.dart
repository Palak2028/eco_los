import 'package:eco_los/db/TablesColumnFile.dart';

class NewTermDepositBean {
  int trefno;
  int mrefno;
  int mlbrcode;
  String mprdacctId;
  String mnametitle;
  String mlongname;
  String mcurcd;
  DateTime mcertdate;
  int mnoinst;
  int mnoofmonths;
  int mnoofdays;
  double mintrate;
  double mmatval;
  DateTime mmatdate;
  int mreceiptstatus;
  DateTime mlastrepaydate;
  double mmainbalfcy;
  double mintPrvdamtfcy;
  double mintPaidamtfcy;
  double mtdsamtfcy;
  String mtdsyn;
  String mmodeofdeposit;
  int mcustno;
  int mcenterid;
  int mgroupcd;
  String mprdcd;
  int mcrs;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;

  NewTermDepositBean({
    this.trefno,
    this.mrefno,
    this.mlbrcode,
    this.mprdacctId,
    this.mnametitle,
    this.mlongname,
    this.mcurcd,
    this.mcertdate,
    this.mnoinst,
    this.mnoofmonths,
    this.mnoofdays,
    this.mintrate,
    this.mmatval,
    this.mmatdate,
    this.mreceiptstatus,
    this.mlastrepaydate,
    this.mmainbalfcy,
    this.mintPrvdamtfcy,
    this.mintPaidamtfcy,
    this.mtdsamtfcy,
    this.mtdsyn,
    this.mmodeofdeposit,
    this.mcustno,
    this.mcenterid,
    this.mgroupcd,
    this.mprdcd,
    this.mcrs,
    this.mcreateddt,
    this.mcreatedby,
    this.mlastupdatedt,
    this.mlastupdateby,
    this.mgeolocation,
    this.mgeolatd,
    this.mgeologd,
    this.mlastsynsdate,
  });

  @override
  String toString() {
    return 'NewTermDepositBean{trefno: $trefno,'
        ' mrefno: $mrefno,'
        ' mlbrcode: $mlbrcode, '
        'mprdacctId: $mprdacctId,'
        ' mnametitle: $mnametitle,'
        ' mlongname: $mlongname,'
        ' mcurcd: $mcurcd,'
        ' mcertdate: $mcertdate,'
        ' mnoinst: $mnoinst,'
        ' mnoofmonths: $mnoofmonths,'
        ' mnoofdays: $mnoofdays,'
        ' mintrate: $mintrate,'
        ' mmatval: $mmatval,'
        ' mmatdate: $mmatdate,'
        ' mreceiptstatus: $mreceiptstatus,'
        ' mlastrepaydate: $mlastrepaydate,'
        ' mmainbalfcy: $mmainbalfcy,'
        ' mintPrvdamtfcy: $mintPrvdamtfcy,'
        ' mintPaidamtfcy: $mintPaidamtfcy,'
        ' mtdsamtfcy: $mtdsamtfcy,'
        ' mtdsyn: $mtdsyn,'
        ' mmodeofdeposit: $mmodeofdeposit,'
        ' mcustno: $mcustno,'
        ' mcenterid: $mcenterid,'
        ' mgroupcd: $mgroupcd,'
        ' mprdcd: $mprdcd,'
        ' mcrs: $mcrs,'
        ' mcreateddt: $mcreateddt,'
        ' mcreatedby: $mcreatedby,'
        ' mlastupdatedt: $mlastupdatedt,'
        ' mlastupdateby: $mlastupdateby,'
        ' mgeolocation: $mgeolocation,'
        ' mgeolatd: $mgeolatd,'
        ' mgeologd: $mgeologd,'
        ' mlastsynsdate: $mlastsynsdate}';
  }

  factory NewTermDepositBean.fromMap(Map<String, dynamic> map) {
    print("inside for map"+ map[TablesColumnFile.mrefno].toString());;
    return NewTermDepositBean(
      trefno:map[TablesColumnFile.trefno]!=null?map[TablesColumnFile.trefno] as int:0,
      mrefno: map[TablesColumnFile.mrefno]!=null && map[TablesColumnFile.mrefno].toString().trim()!='null' && map[TablesColumnFile.mrefno].toString().trim()!=''?map[TablesColumnFile.mrefno] as int :0,
      mlbrcode: map[TablesColumnFile.mlbrcode]!=null?map[TablesColumnFile.mlbrcode] as int:0,
      mprdacctId:  map[TablesColumnFile.mprdacctid] as String,
      mnametitle:  map[TablesColumnFile.mnametitle] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mcurcd: map[TablesColumnFile.mcurcd] as String,
      mcertdate: (map[TablesColumnFile.mcertdate]=="null"||map[TablesColumnFile.mcertdate]==null)?null:DateTime.parse(map[TablesColumnFile.mcertdate]) as DateTime,
      mnoinst: map[TablesColumnFile.mnoinst]!=null && map[TablesColumnFile.mnoinst].toString().trim()!='null' && map[TablesColumnFile.mnoinst].toString().trim()!=''?map[TablesColumnFile.mnoinst] as int :0,
      mnoofmonths: map[TablesColumnFile.mnoofmonths]!=null && map[TablesColumnFile.mnoofmonths].toString().trim()!='null' && map[TablesColumnFile.mnoofmonths].toString().trim()!=''?map[TablesColumnFile.mnoofmonths] as int:0,
      mnoofdays:  map[TablesColumnFile.mnoofdays]!=null  && map[TablesColumnFile.mnoofdays].toString().trim()!='null' && map[TablesColumnFile.mnoofdays].toString().trim()!='' ?map[TablesColumnFile.mnoofdays] as int:0,
      mintrate: map[TablesColumnFile.mintrate]!=null  && map[TablesColumnFile.mintrate].toString().trim()!='null' && map[TablesColumnFile.mintrate].toString().trim()!='' ?map[TablesColumnFile.mintrate] as double:0,
      mmatval: map[TablesColumnFile.mmatval] !=null  && map[TablesColumnFile.mmatval].toString().trim()!='null' && map[TablesColumnFile.mmatval].toString().trim()!='' ?map[TablesColumnFile.mmatval] as double:0,
      mmatdate: (map[TablesColumnFile.mmatdate]=="null"||map[TablesColumnFile.mmatdate]==null)?null:DateTime.parse(map[TablesColumnFile.mmatdate]) as DateTime,
      mreceiptstatus: map[TablesColumnFile.mreceiptstatus]!=null  && map[TablesColumnFile.mreceiptstatus].toString().trim()!='null' && map[TablesColumnFile.mreceiptstatus].toString().trim()!=''?map[TablesColumnFile.mreceiptstatus] as int:0,
      mlastrepaydate: (map[TablesColumnFile.mlastrepaydate]=="null"||map[TablesColumnFile.mlastrepaydate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastrepaydate]) as DateTime,
      mmainbalfcy: map[TablesColumnFile.mmainbalfcy] !=null  && map[TablesColumnFile.mmainbalfcy].toString().trim()!='null' && map[TablesColumnFile.mmainbalfcy].toString().trim()!='' ?map[TablesColumnFile.mmainbalfcy] as double:0,
      mintPrvdamtfcy: map[TablesColumnFile.mintPrvdamtfcy]!=null  && map[TablesColumnFile.mintPrvdamtfcy].toString().trim()!='null' && map[TablesColumnFile.mintPrvdamtfcy].toString().trim()!='' ?map[TablesColumnFile.mintPrvdamtfcy] as double:0,
      mintPaidamtfcy: map[TablesColumnFile.mintPaidamtfcy] !=null  && map[TablesColumnFile.mintPaidamtfcy].toString().trim()!='null' && map[TablesColumnFile.mintPaidamtfcy].toString().trim()!='' ?map[TablesColumnFile.mintPaidamtfcy] as double:0,
      mtdsamtfcy: map[TablesColumnFile.mtdsamtfcy] !=null  && map[TablesColumnFile.mtdsamtfcy].toString().trim()!='null' && map[TablesColumnFile.mtdsamtfcy].toString().trim()!='' ?map[TablesColumnFile.mtdsamtfcy] as double:0,
      mtdsyn: map[TablesColumnFile.mtdsyn] as String,
      mmodeofdeposit: map[TablesColumnFile.mmodeofdeposit] as String,
      mcustno:map[TablesColumnFile.mcustno]!=null  && map[TablesColumnFile.mcustno].toString().trim()!='null' && map[TablesColumnFile.mcustno].toString().trim()!=''?map[TablesColumnFile.mcustno] as int:0,
      mcenterid: map[TablesColumnFile.mcenterid]!=null  && map[TablesColumnFile.mcenterid].toString().trim()!='null' && map[TablesColumnFile.mcenterid].toString().trim()!=''?map[TablesColumnFile.mcenterid] as int:0,
      mgroupcd:map[TablesColumnFile.mgroupcd]!=null  && map[TablesColumnFile.mgroupcd].toString().trim()!='null' && map[TablesColumnFile.mgroupcd].toString().trim()!=''?map[TablesColumnFile.mgroupcd] as int:0,
      mprdcd: map[TablesColumnFile.mprdcd] as String,
      mcrs: map[TablesColumnFile.mcrs]!=null  && map[TablesColumnFile.mcrs].toString().trim()!='null' && map[TablesColumnFile.mcrs].toString().trim()!=''?map[TablesColumnFile.mcrs] as int:0,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt: (map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate: (map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

      );

  }
  factory NewTermDepositBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap >>>>>>>>>>>>>>>");
    return NewTermDepositBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mlbrcode:  map[TablesColumnFile.mlbrcode] as int,
      mprdacctId:  map[TablesColumnFile.mprdacctid] as String,
      mnametitle:  map[TablesColumnFile.mnametitle] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mcurcd: map[TablesColumnFile.mcurcd] as String,
      mcertdate: map[TablesColumnFile.mcertdate] as DateTime,
      mnoinst: map[TablesColumnFile.mnoinst] as int,
      mnoofmonths: map[TablesColumnFile.mnoofmonths] as int,
      mnoofdays: map[TablesColumnFile.mnoofdays] as int,
      mintrate: map[TablesColumnFile.mintrate] as double,
      mmatval: map[TablesColumnFile.mmatval] as double,
      mmatdate: map[TablesColumnFile.mmatdate] as DateTime,
      mreceiptstatus: map[TablesColumnFile.mreceiptstatus] as int,
      mlastrepaydate: map[TablesColumnFile.mlastrepaydate] as DateTime,
      mmainbalfcy: map[TablesColumnFile.mmainbalfcy] as double,
      mintPrvdamtfcy: map[TablesColumnFile.mintPrvdamtfcy] as double,
      mintPaidamtfcy: map[TablesColumnFile.mintPaidamtfcy] as double,
      mtdsamtfcy: map[TablesColumnFile.mtdsamtfcy] as double,
      mtdsyn: map[TablesColumnFile.mtdsyn] as String,
      mmodeofdeposit: map[TablesColumnFile.mmodeofdeposit] as String,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mprdcd: map[TablesColumnFile.mprdcd] as String,
      mcrs: map[TablesColumnFile.mcrs] as int,
      mcreateddt: map[TablesColumnFile.mcreateddt] as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt: map[TablesColumnFile.mlastupdatedt] as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate: map[TablesColumnFile.mlastsynsdate] as DateTime,


      );
  }
}
