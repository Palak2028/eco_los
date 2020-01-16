


import 'package:eco_los/db/TablesColumnFile.dart';

class TotalExpenditureDetailsBean {
  int ttotlexpntrefno;
  int trefno;
  int mtotlexpnmrefno;
  int mrefno;
  int mcustno;
  double mlivngexpns ;
  double mtotlcommexpns ;
  double meduexpns ;
  double mmedexpns ;
  double mtotlfamexpns ;
  double mloanservexpns ;
  double mcredcrdexpns ;
  double mrntlexpns ;
  double mlghtwtrexpns ;
  double mvechtrnsprtexpns ;
  double mothrexpns ;
  double mothrdebtrepymntexpns ;
  double mtotldebtexpns ;


  TotalExpenditureDetailsBean(
      {
        this.ttotlexpntrefno,
        this.mrefno,
        this.trefno,
        this.mtotlexpnmrefno,
        this.mcustno,
        this.mlivngexpns ,
        this.mtotlcommexpns ,
        this.meduexpns ,
        this.mmedexpns ,
        this.mtotlfamexpns ,
        this.mloanservexpns ,
        this.mcredcrdexpns ,
        this.mrntlexpns ,
        this.mlghtwtrexpns ,
        this.mvechtrnsprtexpns ,
        this.mothrexpns ,
        this.mothrdebtrepymntexpns ,
        this.mtotldebtexpns ,
      });


  @override
  String toString() {
    return 'TotalExpenditureDetailsBean{ttotlexpntrefno: $ttotlexpntrefno, trefno: $trefno, mtotlexpnmrefno: $mtotlexpnmrefno, mrefno: $mrefno, mcustno: $mcustno, mlivngexpns: $mlivngexpns, mtotlcommexpns: $mtotlcommexpns, meduexpns: $meduexpns, mmedexpns: $mmedexpns, mtotlfamexpns: $mtotlfamexpns, mloanservexpns: $mloanservexpns, mcredcrdexpns: $mcredcrdexpns, mrntlexpns: $mrntlexpns, mlghtwtrexpns: $mlghtwtrexpns, mvechtrnsprtexpns: $mvechtrnsprtexpns, mothrexpns: $mothrexpns, mothrdebtrepymntexpns: $mothrdebtrepymntexpns, mtotldebtexpns: $mtotldebtexpns}';
  }

  factory TotalExpenditureDetailsBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return TotalExpenditureDetailsBean(
      mtotlexpnmrefno : map[TablesColumnFile.mtotlexpnmrefno] as int,
    );
  }


  factory TotalExpenditureDetailsBean.fromMap(Map<String, dynamic> map) {
    return TotalExpenditureDetailsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        ttotlexpntrefno : map[TablesColumnFile.ttotlexpntrefno] as int,
        mtotlexpnmrefno : map[TablesColumnFile.mtotlexpnmrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mlivngexpns : map[TablesColumnFile.mlivngexpns] as double,
        mtotlcommexpns : map[TablesColumnFile.mtotlcommexpns] as double,
        meduexpns : map[TablesColumnFile.meduexpns] as double,
        mmedexpns : map[TablesColumnFile.mmedexpns] as double,
        mtotlfamexpns : map[TablesColumnFile.mtotlfamexpns] as double,
        mloanservexpns : map[TablesColumnFile.mloanservexpns] as double,
        mcredcrdexpns : map[TablesColumnFile.mcredcrdexpns] as double,
        mrntlexpns : map[TablesColumnFile.mrntlexpns] as double,
        mlghtwtrexpns : map[TablesColumnFile.mlghtwtrexpns] as double,
        mvechtrnsprtexpns : map[TablesColumnFile.mvechtrnsprtexpns] as double,
        mothrexpns : map[TablesColumnFile.mothrexpns] as double,
        mothrdebtrepymntexpns : map[TablesColumnFile.mothrdebtrepymntexpns] as double,
        mtotldebtexpns : map[TablesColumnFile.mtotldebtexpns] as double,

    );
  }
  factory TotalExpenditureDetailsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return TotalExpenditureDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      ttotlexpntrefno : map[TablesColumnFile.ttotlexpntrefno] as int,
      mtotlexpnmrefno : map[TablesColumnFile.mtotlexpnmrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,
      mlivngexpns : map[TablesColumnFile.mlivngexpns] as double,
      mtotlcommexpns : map[TablesColumnFile.mtotlcommexpns] as double,
      meduexpns : map[TablesColumnFile.meduexpns] as double,
      mmedexpns : map[TablesColumnFile.mmedexpns] as double,
      mtotlfamexpns : map[TablesColumnFile.mtotlfamexpns] as double,
      mloanservexpns : map[TablesColumnFile.mloanservexpns] as double,
      mcredcrdexpns : map[TablesColumnFile.mcredcrdexpns] as double,
      mrntlexpns : map[TablesColumnFile.mrntlexpns] as double,
      mlghtwtrexpns : map[TablesColumnFile.mlghtwtrexpns] as double,
      mvechtrnsprtexpns : map[TablesColumnFile.mvechtrnsprtexpns] as double,
      mothrexpns : map[TablesColumnFile.mothrexpns] as double,
      mothrdebtrepymntexpns : map[TablesColumnFile.mothrdebtrepymntexpns] as double,
      mtotldebtexpns : map[TablesColumnFile.mtotldebtexpns] as double,
    );}

}
