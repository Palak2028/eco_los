import 'package:eco_los/db/TablesColumnFile.dart';

class FixedAssetsBean {
  int tfixedassetrefno;
  int trefno;
  int mfixedassetrefno;
  int mrefno;
  int mcustno;

  int mland;
  double mlandpresentamt=0.0;
  double mlandnextmonthamount=0.0;

  int mbuildng;
  double mbuildngpresentamt=0.0;
  double mbuildngnextmonthamount=0.0;

  int mmachnryorequp;
  double mmachnryorequppresentamt=0.0;
  double mmachnryorequpnextmonthamount=0.0;

  int mmeansandtransprt;
  double mmeansandtransprtpresentamt=0.0;
  double mmeansandtransprtnextmonthamount=0.0;

  int mothrs;
  double mothrspresentamt=0.0;
  double mothrsnextmonthamount=0.0;

  double msumpresentamt=0.0;
  double msumnextmonthamount=0.0;

  DateTime mfromdate;
  DateTime mtodate;


  FixedAssetsBean(
      {
        this.tfixedassetrefno,
        this.mrefno,
        this.trefno,
        this.mfixedassetrefno,
        this.mcustno,
        this.mland,
        this.mlandpresentamt,
        this.mlandnextmonthamount,
        this.mbuildng,
        this.mbuildngpresentamt,
        this.mbuildngnextmonthamount,
        this.mmachnryorequp,
        this.mmachnryorequppresentamt,
        this.mmachnryorequpnextmonthamount,
        this.mmeansandtransprt,
        this.mmeansandtransprtpresentamt,
        this.mmeansandtransprtnextmonthamount,
        this.mothrs,
        this.mothrspresentamt,
        this.mothrsnextmonthamount,
        this.msumpresentamt,
        this.msumnextmonthamount,
        this.mfromdate,
        this.mtodate
      });

  factory FixedAssetsBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return FixedAssetsBean(
      mfixedassetrefno : map[TablesColumnFile.mfixedassetrefno] as int,
    );
  }



  factory FixedAssetsBean.fromMap(Map<String, dynamic> map) {
    return FixedAssetsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tfixedassetrefno : map[TablesColumnFile.tfixedassetrefno] as int,
      mfixedassetrefno : map[TablesColumnFile.mfixedassetrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,
        mland : map[TablesColumnFile.mland]as int,
        mlandpresentamt : map[TablesColumnFile.mlandpresentamt] as double,
        mlandnextmonthamount : map[TablesColumnFile.mlandnextmonthamount] as double,

        mbuildng : map[TablesColumnFile.mbuildng]as int,
        mbuildngpresentamt : map[TablesColumnFile.mbuildngpresentamt] as double,
        mbuildngnextmonthamount : map[TablesColumnFile.mbuildngnextmonthamount] as double,

        mmachnryorequp : map[TablesColumnFile.mmachnryorequp]as int,
        mmachnryorequppresentamt : map[TablesColumnFile.mmachnryorequppresentamt] as double,
        mmachnryorequpnextmonthamount : map[TablesColumnFile.mmachnryorequpnextmonthamount] as double,

        mmeansandtransprt : map[TablesColumnFile.mmeansandtransprt]as int,
        mmeansandtransprtpresentamt : map[TablesColumnFile.mmeansandtransprtpresentamt] as double,
        mmeansandtransprtnextmonthamount : map[TablesColumnFile.mmeansandtransprtnextmonthamount] as double,

        mothrs : map[TablesColumnFile.mothrs]as int,
        mothrspresentamt : map[TablesColumnFile.mothrspresentamt] as double,
        mothrsnextmonthamount : map[TablesColumnFile.mothrsnextmonthamount] as double,

      msumpresentamt : map[TablesColumnFile.msumpresentamt] as double,
      msumnextmonthamount : map[TablesColumnFile.msumnextmonthamount] as double,

        mfromdate:(map[TablesColumnFile.mfromdate]=="null"||map[TablesColumnFile.mfromdate]==null)?null:DateTime.parse(map[TablesColumnFile.mfromdate]) as DateTime,
    mtodate:(map[TablesColumnFile.mtodate]=="null"||map[TablesColumnFile.mtodate]==null)?null:DateTime.parse(map[TablesColumnFile.mtodate]) as DateTime,
    );
  }
  factory FixedAssetsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return FixedAssetsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tfixedassetrefno : map[TablesColumnFile.tfixedassetrefno] as int,
        mfixedassetrefno : map[TablesColumnFile.mfixedassetrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mland : map[TablesColumnFile.mland]as int,
        mlandpresentamt : map[TablesColumnFile.mlandpresentamt] as double,
        mlandnextmonthamount : map[TablesColumnFile.mlandnextmonthamount] as double,

        mbuildng : map[TablesColumnFile.mbuildng]as int,
        mbuildngpresentamt : map[TablesColumnFile.mbuildngpresentamt] as double,
        mbuildngnextmonthamount : map[TablesColumnFile.mbuildngnextmonthamount] as double,

        mmachnryorequp : map[TablesColumnFile.mmachnryorequp]as int,
        mmachnryorequppresentamt : map[TablesColumnFile.mmachnryorequppresentamt] as double,
        mmachnryorequpnextmonthamount : map[TablesColumnFile.mmachnryorequpnextmonthamount] as double,

        mmeansandtransprt : map[TablesColumnFile.mmeansandtransprt]as int,
        mmeansandtransprtpresentamt : map[TablesColumnFile.mmeansandtransprtpresentamt] as double,
        mmeansandtransprtnextmonthamount : map[TablesColumnFile.mmeansandtransprtnextmonthamount] as double,

        mothrs : map[TablesColumnFile.mothrs]as int,
        mothrspresentamt : map[TablesColumnFile.mothrspresentamt] as double,
        mothrsnextmonthamount : map[TablesColumnFile.mothrsnextmonthamount] as double,
        msumpresentamt : map[TablesColumnFile.msumpresentamt] as double,
        msumnextmonthamount : map[TablesColumnFile.msumnextmonthamount] as double,

        mfromdate:(map[TablesColumnFile.mfromdate]=="null"||map[TablesColumnFile.mfromdate]==null)?null:DateTime.parse(map[TablesColumnFile.mfromdate]) as DateTime,
    mtodate:(map[TablesColumnFile.mtodate]=="null"||map[TablesColumnFile.mtodate]==null)?null:DateTime.parse(map[TablesColumnFile.mtodate]) as DateTime,
    );}

}
