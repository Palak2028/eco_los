import 'package:eco_los/db/TablesColumnFile.dart';

class SocialFinancialDetailsBean {
  int tbanktrefno;
  int trefno;
  int mbanktrefno;
  int mrefno;
  String maccno;
  String mcreatedby;
  String maccstatus;
  String migyn;
  String mcurcode;
  int positionindex;
  String mbankname;
  String mbranch;
  double maccbal;
  String misusefordis;


  @override
  String toString() {
    return 'SocialFinancialDetailsBean{tbanktrefno: $tbanktrefno, trefno: $trefno, mbanktrefno: $mbanktrefno, mrefno: $mrefno, maccno: $maccno, mcreatedby: $mcreatedby, maccstatus: $maccstatus, migyn: $migyn, mcurcode: $mcurcode, positionindex: $positionindex, mbankname: $mbankname, mbranch: $mbranch, maccbal: $maccbal, misusefordis: $misusefordis}';
  }

  SocialFinancialDetailsBean(
      {
        this.tbanktrefno,
        this.mrefno,
        this.mbanktrefno,
        this.trefno,
        this.maccno,
        this.mcreatedby,
        this.maccstatus,
        this.migyn,
        this.mcurcode,
        this.mbankname,
        this.mbranch,
        this.maccbal,
        this.misusefordis,
        this.positionindex
      });

  factory SocialFinancialDetailsBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return SocialFinancialDetailsBean(
      mbanktrefno:map[TablesColumnFile.mbanktrefno] as int,
    );
  }


  factory SocialFinancialDetailsBean.fromMap(Map<String, dynamic> map) {
    return SocialFinancialDetailsBean(
      tbanktrefno : map[TablesColumnFile.tbanktrefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mbanktrefno : map[TablesColumnFile.mbanktrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      maccno : map[TablesColumnFile.maccno] as String,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String,
        maccstatus : map[TablesColumnFile.maccstatus] as String,
        migyn : map[TablesColumnFile.migyn] as String,
        mcurcode : map[TablesColumnFile.mcurcode] as String,
      mbankname : map[TablesColumnFile.mbankname] as String,
      mbranch : map[TablesColumnFile.mbranch] as String,
      maccbal : map[TablesColumnFile.maccbal] as double,
      misusefordis : map[TablesColumnFile.misusefordis] as String


    );
  }
  factory SocialFinancialDetailsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return SocialFinancialDetailsBean(
      tbanktrefno : map[TablesColumnFile.tbanktrefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mbanktrefno : map[TablesColumnFile.mbanktrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      maccno : map[TablesColumnFile.maccno] as String,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String,
        mcurcode : map[TablesColumnFile.mcurcode] as String,
        mbankname : map[TablesColumnFile.mbankname] as String,
      mbranch : map[TablesColumnFile.mbranch] as String,
      maccbal : map[TablesColumnFile.maccbal] as double,
      misusefordis : map[TablesColumnFile.misusefordis] as String
    );}

}
