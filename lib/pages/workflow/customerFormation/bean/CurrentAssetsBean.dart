import 'package:eco_los/db/TablesColumnFile.dart';

class CurrentAssetsBean {
  int tcurrentassetrefno;
  int trefno;
  int mcurrentassetrefno;
  int mrefno;
  int mcustno;

  @override
  String toString() {
    return 'CurrentAssetsBean{tcurrentassetrefno: $tcurrentassetrefno, trefno: $trefno, mcurrentassetrefno: $mcurrentassetrefno, mrefno: $mrefno, mcustno: $mcustno, mcash: $mcash, mcashpresentamt: $mcashpresentamt, mcashnextmonthamount: $mcashnextmonthamount, maccntrecvbl: $maccntrecvbl, maccntrecvblpresentamt: $maccntrecvblpresentamt, maccntrecvblnextmonthamount: $maccntrecvblnextmonthamount, minventry: $minventry, minventrypresentamt: $minventrypresentamt, minventrynextmonthamount: $minventrynextmonthamount, mprepaid: $mprepaid, mprepaidpresentamt: $mprepaidpresentamt, mprepaidnextmonthamount: $mprepaidnextmonthamount, mothrs: $mothrs, mothrspresentamt: $mothrspresentamt, mothrsnextmonthamount: $mothrsnextmonthamount, msumpresentamt: $msumpresentamt, msumnextmonthamount: $msumnextmonthamount}';
  }

  int mcash;
    double mcashpresentamt=0.0;
    double mcashnextmonthamount=0.0;

    int maccntrecvbl;
    double maccntrecvblpresentamt=0.0;
    double maccntrecvblnextmonthamount=0.0;

  int minventry;
  double minventrypresentamt=0.0;
  double minventrynextmonthamount=0.0;

  int mprepaid;
  double mprepaidpresentamt=0.0;
  double mprepaidnextmonthamount=0.0;

  int mothrs;
  double mothrspresentamt=0.0;
  double mothrsnextmonthamount=0.0;

  double msumpresentamt=0.0;
  double msumnextmonthamount=0.0;



  CurrentAssetsBean(
      {
        this.tcurrentassetrefno,
        this.mrefno,
        this.trefno,
        this.mcurrentassetrefno,
        this.mcustno,
        this.mcash,
        this.mcashpresentamt,
        this.mcashnextmonthamount,
        this.maccntrecvbl,
        this.maccntrecvblpresentamt,
        this.maccntrecvblnextmonthamount,
        this.minventry,
        this.minventrypresentamt,
        this.minventrynextmonthamount,
        this.mprepaid,
        this.mprepaidpresentamt,
        this.mprepaidnextmonthamount,
        this.mothrs,
        this.mothrspresentamt,
        this.mothrsnextmonthamount,
        this.msumpresentamt,
        this.msumnextmonthamount
      });

  factory CurrentAssetsBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return CurrentAssetsBean(
      mcurrentassetrefno : map[TablesColumnFile.mcurrentassetrefno] as int,
    );
  }


  factory CurrentAssetsBean.fromMap(Map<String, dynamic> map) {
    return CurrentAssetsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tcurrentassetrefno : map[TablesColumnFile.tcurrentassetrefno] as int,
      mcurrentassetrefno : map[TablesColumnFile.mcurrentassetrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,


        mcash :	map[TablesColumnFile.mcash]as int,
        mcashpresentamt:	map[TablesColumnFile.mcashpresentamt] as double,
        mcashnextmonthamount:	map[TablesColumnFile.mcashnextmonthamount] as double,

        maccntrecvbl:	map[TablesColumnFile.maccntrecvbl]as int,
        maccntrecvblpresentamt:	map[TablesColumnFile.maccntrecvblpresentamt] as double,
        maccntrecvblnextmonthamount:	map[TablesColumnFile.maccntrecvblnextmonthamount] as double,

        minventry:	map[TablesColumnFile.minventry]as int,
        minventrypresentamt:	map[TablesColumnFile.minventrypresentamt] as double,
        minventrynextmonthamount:	map[TablesColumnFile.minventrynextmonthamount] as double,

        mprepaid:	map[TablesColumnFile.mprepaid]as int,
        mprepaidpresentamt:	map[TablesColumnFile.mprepaidpresentamt] as double,
        mprepaidnextmonthamount:	map[TablesColumnFile.mprepaidnextmonthamount] as double,


        mothrs : map[TablesColumnFile.mothrs]as int,
        mothrspresentamt : map[TablesColumnFile.mothrspresentamt] as double,
        mothrsnextmonthamount : map[TablesColumnFile.mothrsnextmonthamount] as double,



      msumpresentamt : map[TablesColumnFile.msumpresentamt] as double,
      msumnextmonthamount : map[TablesColumnFile.msumnextmonthamount] as double
    );
  }
  factory CurrentAssetsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return CurrentAssetsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tcurrentassetrefno : map[TablesColumnFile.tcurrentassetrefno] as int,
        mcurrentassetrefno : map[TablesColumnFile.mcurrentassetrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mcash :	map[TablesColumnFile.mcash]as int,
        mcashpresentamt:	map[TablesColumnFile.mcashpresentamt] as double,
        mcashnextmonthamount:	map[TablesColumnFile.mcashnextmonthamount] as double,

        maccntrecvbl:	map[TablesColumnFile.maccntrecvbl]as int,
        maccntrecvblpresentamt:	map[TablesColumnFile.maccntrecvblpresentamt] as double,
        maccntrecvblnextmonthamount:	map[TablesColumnFile.maccntrecvblnextmonthamount] as double,

        minventry:	map[TablesColumnFile.minventry]as int,
        minventrypresentamt:	map[TablesColumnFile.minventrypresentamt] as double,
        minventrynextmonthamount:	map[TablesColumnFile.minventrynextmonthamount] as double,

        mprepaid:	map[TablesColumnFile.mprepaid]as int,
        mprepaidpresentamt:	map[TablesColumnFile.mprepaidpresentamt] as double,
        mprepaidnextmonthamount:	map[TablesColumnFile.mprepaidnextmonthamount] as double,

        mothrs : map[TablesColumnFile.mothrs]as int,
        mothrspresentamt : map[TablesColumnFile.mothrspresentamt] as double,
        mothrsnextmonthamount : map[TablesColumnFile.mothrsnextmonthamount] as double,

        msumpresentamt : map[TablesColumnFile.msumpresentamt] as double,
        msumnextmonthamount : map[TablesColumnFile.msumnextmonthamount] as double
    );}

}
