import 'package:eco_los/db/TablesColumnFile.dart';

class ESMSBean{



  int tesmsrefno;
  int mesmsrefno;
  int trefno;
  int mrefno;
  String mexclistchecked;
  String misbrwrinlist;
  String mnontrgtcust;
  String misbrwrinnontrgt;
  String mairemssn;
  String maeapplglrequire;
  String maecmplncstatus;
  String maeevediance;
  String mwastewater;
  String mwwapplglrequire;
  String mwwcmplncstatus;
  String mwwevediance;
  String msolidnhrdauswaste;
  String mshapplglrequire;
  String mshcmplncstatus;
  String mshevediance;
  String mhrdzchemnfule;
  String mhcapplglrequire;
  String mhccmplncstatus;
  String mhcevediance;
  String mrescnsmpt;
  String mnuisance;
/*
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String merrormessage;

*/




  bool mdust;
  bool mtrafficcongandobs;
  bool mvibration;
  bool mfumes;
  bool modours;
  bool mnoise;
  bool mnocomissue;
  bool mnodesigperson;
  bool mdispandressetle;
  bool mlandacqreq;
  bool mnoissue;
  bool marchimp;
  bool msiteofcultural;
  bool mcomplaintsfromneig;
  bool mimpactofindgenous;
  bool mimpactonlocal;
  bool mnorecognitionofemp;
  bool mlabourunion;
  bool mnolabissue;
  bool mnopersonalprotectiveEquip;
  bool mnoprocessforemployees;
  bool mchildoffrcdlabour;
  bool mempblwminage;
  bool mpayblwminwage;
  bool munequalOpp;
  bool minadequatetermsofemp;
  bool minediquateworkingcond;
  bool muinadequateemployeehealth;
  bool mnontarget;
  bool mcategoryc;
  bool mcategoryb;
  bool mcategorya;
  String mcomntfrmoff;
  String mdsitrequiretorefroff;
  String mdecision;
  String msign;
  String mnameofoff;
  DateTime date;





  ESMSBean(
      {




        this.trefno,
        this.mrefno,
        this.mexclistchecked,
        this.misbrwrinlist,
        this.mnontrgtcust,
        this.misbrwrinnontrgt,
        this.mairemssn,
        this.maeapplglrequire,
        this.maecmplncstatus,
        this.maeevediance,
        this.mwastewater,
        this.mwwapplglrequire,
        this.mwwcmplncstatus,
        this.mwwevediance,
        this.msolidnhrdauswaste,
        this.mshapplglrequire,
        this.mshcmplncstatus,
        this.mshevediance,
        this.mhrdzchemnfule,
        this.mhcapplglrequire,
        this.mhccmplncstatus,
        this.mhcevediance,
        this.mrescnsmpt,
        this.mnuisance,
        /*  this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.merrormessage,*/
        this.mdust,
        this.mtrafficcongandobs,
        this.mvibration,
        this.mfumes,
        this.modours,
        this.mnoise,
        this.mnocomissue,
        this.mnodesigperson,
        this.mdispandressetle,
        this.mlandacqreq,
        this.mnoissue,
        this.marchimp,
        this.msiteofcultural,
        this.mcomplaintsfromneig,
        this.mimpactofindgenous,
        this.mimpactonlocal,
        this.mnorecognitionofemp,
        this.mlabourunion,
        this.mnolabissue,
        this.mnopersonalprotectiveEquip,
        this.mnoprocessforemployees,
        this.mchildoffrcdlabour,
        this.mempblwminage,
        this.mpayblwminwage,
        this.munequalOpp,
        this.minadequatetermsofemp,
        this.minediquateworkingcond,
        this.muinadequateemployeehealth,
        this.mnontarget,
        this.mcategoryc,
        this.mcategoryb,
        this.mcategorya,
        this.mcomntfrmoff,
        this.mdecision,
        this.msign,
        this.mnameofoff,
        this.date,
        this.tesmsrefno,
        this.mesmsrefno,
        this.mdsitrequiretorefroff


      });


  @override
  String toString() {
    return 'ESMSBean{tesmsrefno: $tesmsrefno, mesmsrefno: $mesmsrefno, trefno: $trefno, mrefno: $mrefno, mexclistchecked: $mexclistchecked, misbrwrinlist: $misbrwrinlist, mnontrgtcust: $mnontrgtcust, misbrwrinnontrgt: $misbrwrinnontrgt, mairemssn: $mairemssn, maeapplglrequire: $maeapplglrequire, maecmplncstatus: $maecmplncstatus, maeevediance: $maeevediance, mwastewater: $mwastewater, mwwapplglrequire: $mwwapplglrequire, mwwcmplncstatus: $mwwcmplncstatus, mwwevediance: $mwwevediance, msolidnhrdauswaste: $msolidnhrdauswaste, mshapplglrequire: $mshapplglrequire, mshcmplncstatus: $mshcmplncstatus, mshevediance: $mshevediance, mhrdzchemnfule: $mhrdzchemnfule, mhcapplglrequire: $mhcapplglrequire, mhccmplncstatus: $mhccmplncstatus, mhcevediance: $mhcevediance, mrescnsmpt: $mrescnsmpt, mnuisance: $mnuisance, mdust: $mdust, mtrafficcongandobs: $mtrafficcongandobs, mvibration: $mvibration, mfumes: $mfumes, modours: $modours, mnoise: $mnoise, mnocomissue: $mnocomissue, mnodesigperson: $mnodesigperson, mdispandressetle: $mdispandressetle, mlandacqreq: $mlandacqreq, mnoissue: $mnoissue, marchimp: $marchimp, msiteofcultural: $msiteofcultural, mcomplaintsfromneig: $mcomplaintsfromneig, mimpactofindgenous: $mimpactofindgenous, mimpactonlocal: $mimpactonlocal, mnorecognitionofemp: $mnorecognitionofemp, mlabourunion: $mlabourunion, mnolabissue: $mnolabissue, mnopersonalprotectiveEquip: $mnopersonalprotectiveEquip, mnoprocessforemployees: $mnoprocessforemployees, mchildoffrcdlabour: $mchildoffrcdlabour, mempblwminage: $mempblwminage, mpayblwminwage: $mpayblwminwage, munequalOpp: $munequalOpp, minadequatetermsofemp: $minadequatetermsofemp, minediquateworkingcond: $minediquateworkingcond, muinadequateemployeehealth: $muinadequateemployeehealth, mnontarget: $mnontarget, mcategoryc: $mcategoryc, mcategoryb: $mcategoryb, mcategorya: $mcategorya, mcomntfrmoff: $mcomntfrmoff, mdecision: $mdecision, msign: $msign, mnameofoff: $mnameofoff, date: $date}';
  }

  factory ESMSBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"+map.toString());
    return ESMSBean(
      mesmsrefno : map[TablesColumnFile.mesmsrefno] as int,
    );
  }

  factory ESMSBean.fromMap(Map<String, dynamic> map) {
    return ESMSBean(


      tesmsrefno:  map[TablesColumnFile.tesmsrefno] as int,
      mesmsrefno:  map[TablesColumnFile.mesmsrefno] as int,
      trefno:  map[TablesColumnFile.trefno] as int,
      mrefno:  map[TablesColumnFile.mrefno] as int,
      mexclistchecked: map[TablesColumnFile.mexclistchecked] as String,
      misbrwrinlist: map[TablesColumnFile.misbrwrinlist] as String,
      mnontrgtcust:  map[TablesColumnFile.mnontrgtcust] as String,
      misbrwrinnontrgt:  map[TablesColumnFile.misbrwrinnontrgt] as String,
      mairemssn: map[TablesColumnFile.mairemssn] as String,
      maeapplglrequire:  map[TablesColumnFile.maeapplglrequire] as String,
      maecmplncstatus: map[TablesColumnFile.maecmplncstatus] as String,
      maeevediance:  map[TablesColumnFile.maeevediance] as String,
      mwastewater: map[TablesColumnFile.mwastewater] as String,
      mwwapplglrequire:  map[TablesColumnFile.mwwapplglrequire] as String,
      mwwcmplncstatus: map[TablesColumnFile.mwwcmplncstatus] as String,
      mwwevediance:  map[TablesColumnFile.mwwevediance] as String,
      msolidnhrdauswaste:  map[TablesColumnFile.msolidnhrdauswaste] as String,
      mshapplglrequire:  map[TablesColumnFile.mshapplglrequire] as String,
      mshcmplncstatus: map[TablesColumnFile.mshcmplncstatus] as String,
      mshevediance:  map[TablesColumnFile.mshevediance] as String,
      mhrdzchemnfule:  map[TablesColumnFile.mhrdzchemnfule] as String,
      mhcapplglrequire:  map[TablesColumnFile.mhcapplglrequire] as String,
      mhccmplncstatus: map[TablesColumnFile.mhccmplncstatus] as String,
      mhcevediance:  map[TablesColumnFile.mhcevediance] as String,
      mrescnsmpt:  map[TablesColumnFile.mrescnsmpt] as String,
      mnuisance: map[TablesColumnFile.mnuisance] as String,

      mdust:	map[TablesColumnFile.mdust]!=null&&map[TablesColumnFile.mdust].toString().toLowerCase()=='true'?true:false ,
      mtrafficcongandobs:	 map[TablesColumnFile.mtrafficcongandobs]!=null&&map[TablesColumnFile.mtrafficcongandobs].toString().toLowerCase()=='true'?true:false ,
      mvibration:	 map[TablesColumnFile.mvibration]!=null&&map[TablesColumnFile.mvibration].toString().toLowerCase()=='true'?true:false ,
      mfumes:	 map[TablesColumnFile.mfumes]!=null&&map[TablesColumnFile.mfumes].toString().toLowerCase()=='true'?true:false ,
      modours:	 map[TablesColumnFile.modours]!=null&&map[TablesColumnFile.modours].toString().toLowerCase()=='true'?true:false ,
      mnoise:	 map[TablesColumnFile.mnoise]!=null&&map[TablesColumnFile.mnoise].toString().toLowerCase()=='true'?true:false ,
      mnocomissue:	 map[TablesColumnFile.mnocomissue]!=null&&map[TablesColumnFile.mnocomissue].toString().toLowerCase()=='true'?true:false ,
      mnodesigperson:	 map[TablesColumnFile.mnodesigperson]!=null&&map[TablesColumnFile.mnodesigperson].toString().toLowerCase()=='true'?true:false ,
      mdispandressetle:	 map[TablesColumnFile.mdispandressetle]!=null&&map[TablesColumnFile.mdispandressetle].toString().toLowerCase()=='true'?true:false ,
      mlandacqreq:	 map[TablesColumnFile.mdust]!=null&&map[TablesColumnFile.mdust].toString().toLowerCase()=='true'?true:false ,
      mnoissue:	 map[TablesColumnFile.mnoissue]!=null&&map[TablesColumnFile.mnoissue].toString().toLowerCase()=='true'?true:false ,
      marchimp:	 map[TablesColumnFile.marchimp]!=null&&map[TablesColumnFile.marchimp].toString().toLowerCase()=='true'?true:false ,
      msiteofcultural:	 map[TablesColumnFile.msiteofcultural]!=null&&map[TablesColumnFile.msiteofcultural].toString().toLowerCase()=='true'?true:false ,
      mcomplaintsfromneig:	 map[TablesColumnFile.mcomplaintsfromneig]!=null&&map[TablesColumnFile.mcomplaintsfromneig].toString().toLowerCase()=='true'?true:false ,
      mimpactofindgenous:	 map[TablesColumnFile.mimpactofindgenous]!=null&&map[TablesColumnFile.mimpactofindgenous].toString().toLowerCase()=='true'?true:false ,
      mimpactonlocal:	 map[TablesColumnFile.mimpactonlocal]!=null&&map[TablesColumnFile.mimpactonlocal].toString().toLowerCase()=='true'?true:false ,
      mnorecognitionofemp:	 map[TablesColumnFile.mnorecognitionofemp]!=null&&map[TablesColumnFile.mnorecognitionofemp].toString().toLowerCase()=='true'?true:false ,
      mlabourunion:	 map[TablesColumnFile.mlabourunion]!=null&&map[TablesColumnFile.mlabourunion].toString().toLowerCase()=='true'?true:false ,
      mnolabissue:	 map[TablesColumnFile.mdust]!=null&&map[TablesColumnFile.mdust].toString().toLowerCase()=='true'?true:false ,
      mnopersonalprotectiveEquip:	 map[TablesColumnFile.mnopersonalprotectiveEquip]!=null&&map[TablesColumnFile.mnopersonalprotectiveEquip].toString().toLowerCase()=='true'?true:false ,
      mnoprocessforemployees:	 map[TablesColumnFile.mnoprocessforemployees]!=null&&map[TablesColumnFile.mnoprocessforemployees].toString().toLowerCase()=='true'?true:false ,
      mchildoffrcdlabour:	 map[TablesColumnFile.mchildoffrcdlabour]!=null&&map[TablesColumnFile.mchildoffrcdlabour].toString().toLowerCase()=='true'?true:false ,
      mempblwminage:	 map[TablesColumnFile.mempblwminage]!=null&&map[TablesColumnFile.mempblwminage].toString().toLowerCase()=='true'?true:false ,
      mpayblwminwage:	 map[TablesColumnFile.mpayblwminwage]!=null&&map[TablesColumnFile.mpayblwminwage].toString().toLowerCase()=='true'?true:false ,
      munequalOpp:	 map[TablesColumnFile.munequalOpp]!=null&&map[TablesColumnFile.munequalOpp].toString().toLowerCase()=='true'?true:false ,
      minadequatetermsofemp:	 map[TablesColumnFile.minadequatetermsofemp]!=null&&map[TablesColumnFile.minadequatetermsofemp].toString().toLowerCase()=='true'?true:false ,
      minediquateworkingcond:	 map[TablesColumnFile.minediquateworkingcond]!=null&&map[TablesColumnFile.minediquateworkingcond].toString().toLowerCase()=='true'?true:false ,
      muinadequateemployeehealth:	 map[TablesColumnFile.muinadequateemployeehealth]!=null&&map[TablesColumnFile.muinadequateemployeehealth].toString().toLowerCase()=='true'?true:false ,
      mnontarget:	 map[TablesColumnFile.mnontarget]!=null&&map[TablesColumnFile.mnontarget].toString().toLowerCase()=='true'?true:false ,
      mcategoryc:	 map[TablesColumnFile.mcategoryc]!=null&&map[TablesColumnFile.mcategoryc].toString().toLowerCase()=='true'?true:false ,
      mcategoryb:	 map[TablesColumnFile.mcategoryb]!=null&&map[TablesColumnFile.mcategoryb].toString().toLowerCase()=='true'?true:false ,
      mcategorya:	 map[TablesColumnFile.mcategorya]!=null&&map[TablesColumnFile.mcategorya].toString().toLowerCase()=='true'?true:false ,
      mcomntfrmoff:	 map[TablesColumnFile.mcomntfrmoff] as String,
      mdecision:	 map[TablesColumnFile.mdecision] as String,
      msign:	 map[TablesColumnFile.msign] as String,
      mnameofoff:	 map[TablesColumnFile.mnameofoff] as String,
      date:	 (map[TablesColumnFile.date]=="null"||map[TablesColumnFile.date]==null)?null:
      DateTime.parse(map[TablesColumnFile.date]) as DateTime,
      mdsitrequiretorefroff:	 map[TablesColumnFile.mdsitrequiretorefroff] as String,



    );
  }
  factory ESMSBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return ESMSBean(
      tesmsrefno:  map[TablesColumnFile.tesmsrefno] as int,
      mesmsrefno:  map[TablesColumnFile.mesmsrefno] as int,
      trefno:  map[TablesColumnFile.trefno] as int,
      mrefno:  map[TablesColumnFile.mrefno] as int,
      mexclistchecked: map[TablesColumnFile.mexclistchecked] as String,
      misbrwrinlist: map[TablesColumnFile.misbrwrinlist] as String,
      mnontrgtcust:  map[TablesColumnFile.mnontrgtcust] as String,
      misbrwrinnontrgt:  map[TablesColumnFile.misbrwrinnontrgt] as String,
      mairemssn: map[TablesColumnFile.mairemssn] as String,
      maeapplglrequire:  map[TablesColumnFile.maeapplglrequire] as String,
      maecmplncstatus: map[TablesColumnFile.maecmplncstatus] as String,
      maeevediance:  map[TablesColumnFile.maeevediance] as String,
      mwastewater: map[TablesColumnFile.mwastewater] as String,
      mwwapplglrequire:  map[TablesColumnFile.mwwapplglrequire] as String,
      mwwcmplncstatus: map[TablesColumnFile.mwwcmplncstatus] as String,
      mwwevediance:  map[TablesColumnFile.mwwevediance] as String,
      msolidnhrdauswaste:  map[TablesColumnFile.msolidnhrdauswaste] as String,
      mshapplglrequire:  map[TablesColumnFile.mshapplglrequire] as String,
      mshcmplncstatus: map[TablesColumnFile.mshcmplncstatus] as String,
      mshevediance:  map[TablesColumnFile.mshevediance] as String,
      mhrdzchemnfule:  map[TablesColumnFile.mhrdzchemnfule] as String,
      mhcapplglrequire:  map[TablesColumnFile.mhcapplglrequire] as String,
      mhccmplncstatus: map[TablesColumnFile.mhccmplncstatus] as String,
      mhcevediance:  map[TablesColumnFile.mhcevediance] as String,
      mrescnsmpt:  map[TablesColumnFile.mrescnsmpt] as String,
      mnuisance: map[TablesColumnFile.mnuisance] as String,


      mdust:	map[TablesColumnFile.mdust]!=null&&map[TablesColumnFile.mdust].toString().toLowerCase()=='true'?true:false ,
      mtrafficcongandobs:	 map[TablesColumnFile.mtrafficcongandobs]!=null&&map[TablesColumnFile.mtrafficcongandobs].toString().toLowerCase()=='true'?true:false ,
      mvibration:	 map[TablesColumnFile.mvibration]!=null&&map[TablesColumnFile.mvibration].toString().toLowerCase()=='true'?true:false ,
      mfumes:	 map[TablesColumnFile.mfumes]!=null&&map[TablesColumnFile.mfumes].toString().toLowerCase()=='true'?true:false ,
      modours:	 map[TablesColumnFile.modours]!=null&&map[TablesColumnFile.modours].toString().toLowerCase()=='true'?true:false ,
      mnoise:	 map[TablesColumnFile.mnoise]!=null&&map[TablesColumnFile.mnoise].toString().toLowerCase()=='true'?true:false ,
      mnocomissue:	 map[TablesColumnFile.mnocomissue]!=null&&map[TablesColumnFile.mnocomissue].toString().toLowerCase()=='true'?true:false ,
      mnodesigperson:	 map[TablesColumnFile.mnodesigperson]!=null&&map[TablesColumnFile.mnodesigperson].toString().toLowerCase()=='true'?true:false ,
      mdispandressetle:	 map[TablesColumnFile.mdispandressetle]!=null&&map[TablesColumnFile.mdispandressetle].toString().toLowerCase()=='true'?true:false ,
      mlandacqreq:	 map[TablesColumnFile.mdust]!=null&&map[TablesColumnFile.mdust].toString().toLowerCase()=='true'?true:false ,
      mnoissue:	 map[TablesColumnFile.mnoissue]!=null&&map[TablesColumnFile.mnoissue].toString().toLowerCase()=='true'?true:false ,
      marchimp:	 map[TablesColumnFile.marchimp]!=null&&map[TablesColumnFile.marchimp].toString().toLowerCase()=='true'?true:false ,
      msiteofcultural:	 map[TablesColumnFile.msiteofcultural]!=null&&map[TablesColumnFile.msiteofcultural].toString().toLowerCase()=='true'?true:false ,
      mcomplaintsfromneig:	 map[TablesColumnFile.mcomplaintsfromneig]!=null&&map[TablesColumnFile.mcomplaintsfromneig].toString().toLowerCase()=='true'?true:false ,
      mimpactofindgenous:	 map[TablesColumnFile.mimpactofindgenous]!=null&&map[TablesColumnFile.mimpactofindgenous].toString().toLowerCase()=='true'?true:false ,
      mimpactonlocal:	 map[TablesColumnFile.mimpactonlocal]!=null&&map[TablesColumnFile.mimpactonlocal].toString().toLowerCase()=='true'?true:false ,
      mnorecognitionofemp:	 map[TablesColumnFile.mnorecognitionofemp]!=null&&map[TablesColumnFile.mnorecognitionofemp].toString().toLowerCase()=='true'?true:false ,
      mlabourunion:	 map[TablesColumnFile.mlabourunion]!=null&&map[TablesColumnFile.mlabourunion].toString().toLowerCase()=='true'?true:false ,
      mnolabissue:	 map[TablesColumnFile.mdust]!=null&&map[TablesColumnFile.mdust].toString().toLowerCase()=='true'?true:false ,
      mnopersonalprotectiveEquip:	 map[TablesColumnFile.mnopersonalprotectiveEquip]!=null&&map[TablesColumnFile.mnopersonalprotectiveEquip].toString().toLowerCase()=='true'?true:false ,
      mnoprocessforemployees:	 map[TablesColumnFile.mnoprocessforemployees]!=null&&map[TablesColumnFile.mnoprocessforemployees].toString().toLowerCase()=='true'?true:false ,
      mchildoffrcdlabour:	 map[TablesColumnFile.mchildoffrcdlabour]!=null&&map[TablesColumnFile.mchildoffrcdlabour].toString().toLowerCase()=='true'?true:false ,
      mempblwminage:	 map[TablesColumnFile.mempblwminage]!=null&&map[TablesColumnFile.mempblwminage].toString().toLowerCase()=='true'?true:false ,
      mpayblwminwage:	 map[TablesColumnFile.mpayblwminwage]!=null&&map[TablesColumnFile.mpayblwminwage].toString().toLowerCase()=='true'?true:false ,
      munequalOpp:	 map[TablesColumnFile.munequalOpp]!=null&&map[TablesColumnFile.munequalOpp].toString().toLowerCase()=='true'?true:false ,
      minadequatetermsofemp:	 map[TablesColumnFile.minadequatetermsofemp]!=null&&map[TablesColumnFile.minadequatetermsofemp].toString().toLowerCase()=='true'?true:false ,
      minediquateworkingcond:	 map[TablesColumnFile.minediquateworkingcond]!=null&&map[TablesColumnFile.minediquateworkingcond].toString().toLowerCase()=='true'?true:false ,
      muinadequateemployeehealth:	 map[TablesColumnFile.muinadequateemployeehealth]!=null&&map[TablesColumnFile.muinadequateemployeehealth].toString().toLowerCase()=='true'?true:false ,
      mnontarget:	 map[TablesColumnFile.mnontarget]!=null&&map[TablesColumnFile.mnontarget].toString().toLowerCase()=='true'?true:false ,
      mcategoryc:	 map[TablesColumnFile.mcategoryc]!=null&&map[TablesColumnFile.mcategoryc].toString().toLowerCase()=='true'?true:false ,
      mcategoryb:	 map[TablesColumnFile.mcategoryb]!=null&&map[TablesColumnFile.mcategoryb].toString().toLowerCase()=='true'?true:false ,
      mcategorya:	 map[TablesColumnFile.mcategorya]!=null&&map[TablesColumnFile.mcategorya].toString().toLowerCase()=='true'?true:false ,
      mcomntfrmoff:	 map[TablesColumnFile.mcomntfrmoff] as String,
      mdecision:	 map[TablesColumnFile.mdecision] as String,
      msign:	 map[TablesColumnFile.msign] as String,
      mnameofoff:	 map[TablesColumnFile.mnameofoff] as String,
      date:	 (map[TablesColumnFile.date]=="null"||map[TablesColumnFile.date]==null)?null:
      DateTime.parse(map[TablesColumnFile.date]) as DateTime,
      mdsitrequiretorefroff:	 map[TablesColumnFile.mdsitrequiretorefroff] as String,
    );}

}
