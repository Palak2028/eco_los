import 'package:eco_los/db/TablesColumnFile.dart';

class EquityBean {
  int tequityrefno;
  int trefno;
  int mequityrefno;
  int mrefno;
  int mcustno;

  int mcash;
  double mcashpresentamt=0.0;
  double mcashnextmonthamount=0.0;

  int maccntrecvbl;
  double maccntrecvblpresentamt=0.0;
  double maccntrecvblnextmonthamount=0.0;

  double msumpresentamt=0.0;
  double msumnextmonthamount=0.0;


  EquityBean(
      {
        this.tequityrefno,
        this.mrefno,
        this.trefno,
        this.mequityrefno,
        this.mcustno,
        this.mcash,
        this.mcashpresentamt,
        this.mcashnextmonthamount,
        this.maccntrecvbl,
        this.maccntrecvblpresentamt,
        this.maccntrecvblnextmonthamount,
        this.msumpresentamt,
        this.msumnextmonthamount
      });


  factory EquityBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return EquityBean(
      mequityrefno : map[TablesColumnFile.mequityrefno] as int,
    );
  }


  factory EquityBean.fromMap(Map<String, dynamic> map) {
    return EquityBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tequityrefno : map[TablesColumnFile.tequityrefno] as int,
      mequityrefno : map[TablesColumnFile.mequityrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,
        mcash :	map[TablesColumnFile.mcash]as int,
        mcashpresentamt:	map[TablesColumnFile.mcashpresentamt] as double,
        mcashnextmonthamount:	map[TablesColumnFile.mcashnextmonthamount] as double,

        maccntrecvbl:	map[TablesColumnFile.maccntrecvbl]as int,
        maccntrecvblpresentamt:	map[TablesColumnFile.maccntrecvblpresentamt] as double,
        maccntrecvblnextmonthamount:	map[TablesColumnFile.maccntrecvblnextmonthamount] as double,
      msumpresentamt : map[TablesColumnFile.msumpresentamt] as double,
      msumnextmonthamount : map[TablesColumnFile.msumnextmonthamount] as double
    );
  }
  factory EquityBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return EquityBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tequityrefno : map[TablesColumnFile.tequityrefno] as int,
        mequityrefno : map[TablesColumnFile.mequityrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mcash :	map[TablesColumnFile.mcash]as int,
        mcashpresentamt:	map[TablesColumnFile.mcashpresentamt] as double,
        mcashnextmonthamount:	map[TablesColumnFile.mcashnextmonthamount] as double,

        maccntrecvbl:	map[TablesColumnFile.maccntrecvbl]as int,
        maccntrecvblpresentamt:	map[TablesColumnFile.maccntrecvblpresentamt] as double,
        maccntrecvblnextmonthamount:	map[TablesColumnFile.maccntrecvblnextmonthamount] as double,
        msumpresentamt : map[TablesColumnFile.msumpresentamt] as double,
        msumnextmonthamount : map[TablesColumnFile.msumnextmonthamount] as double
    );}

}
