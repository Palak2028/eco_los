import 'package:eco_los/db/TablesColumnFile.dart';

class LongTermLiabilitiesBean {
  int tlngtrmliabiltyrefno;
  int trefno;
  int mlngtrmliabiltyrefno;
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


  

  LongTermLiabilitiesBean(
      {
        this.tlngtrmliabiltyrefno,
        this.mrefno,
        this.trefno,
        this.mlngtrmliabiltyrefno,
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


  factory LongTermLiabilitiesBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return LongTermLiabilitiesBean(
      mlngtrmliabiltyrefno : map[TablesColumnFile.mlngtrmliabiltyrefno] as int,
    );
  }


  factory LongTermLiabilitiesBean.fromMap(Map<String, dynamic> map) {
    return LongTermLiabilitiesBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tlngtrmliabiltyrefno : map[TablesColumnFile.tlngtrmliabiltyrefno] as int,
      mlngtrmliabiltyrefno : map[TablesColumnFile.mlngtrmliabiltyrefno] as int,
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
  factory LongTermLiabilitiesBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return LongTermLiabilitiesBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tlngtrmliabiltyrefno : map[TablesColumnFile.tlngtrmliabiltyrefno] as int,
        mlngtrmliabiltyrefno : map[TablesColumnFile.mlngtrmliabiltyrefno] as int,
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
