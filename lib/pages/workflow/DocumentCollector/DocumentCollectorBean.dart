

import 'package:eco_los/db/TablesColumnFile.dart';

class DocumentCollectorBean{

  int trefno;
  int mrefno;
  int loantrefno;
  int loanmrefno;
  String mforeignindicator;
  String  mdoctno;
  String  mcustname;
  int mcustno;
  int custtrefno;
  int custmrefno;
  String  missuingauth;
  DateTime missuedate;
    DateTime mexpdate;
  DateTime mexecutiondate;

  String mimgtype;
  String mcustomertype;
  String mimgtypedesc;
  String mimgsubtype;
  String mcomment;
  String imgstring;
  String mremarks;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String merrormessage;


  @override
  String toString() {
    return 'DocumentCollectorBean{trefno: $trefno, mrefno: $mrefno, loantrefno: $loantrefno, loanmrefno: $loanmrefno, mforeignindicator: $mforeignindicator, mdoctno: $mdoctno, mcustname: $mcustname, missuingauth: $missuingauth, missuedate: $missuedate, mexpdate: $mexpdate, mexecutiondate: $mexecutiondate, mimgtype: $mimgtype, mcustomertype: $mcustomertype, mimgtypedesc: $mimgtypedesc, mimgsubtype: $mimgsubtype, mcomment: $mcomment, imgstring: $imgstring, mremarks: $mremarks, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, merrormessage: $merrormessage}';
  }

  DocumentCollectorBean(
      {this.mforeignindicator,this.trefno,this.mimgtype,this.mcustomertype,this.mrefno, this.mimgtypedesc, this.mimgsubtype,
        this.mcomment, this.imgstring,this.mremarks, this.loantrefno,
        this.loanmrefno,this.mdoctno,this.mcustname,this.mcustno,
        this.custmrefno,
        this.custtrefno,this.missuingauth,this.missuedate,this.mexpdate,this.mexecutiondate, this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.merrormessage,});

  factory DocumentCollectorBean.fromMap(Map<String, dynamic> map) {
    return DocumentCollectorBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      mforeignindicator: 	 map[TablesColumnFile.mforeignindicator] as String,
      mimgtype: 	 map[TablesColumnFile.mimgtype] as String,
      mcustomertype: 	 map[TablesColumnFile.mcustomertype] as String,
      mimgtypedesc: map[TablesColumnFile.mimgtypedesc] as String,
      mimgsubtype: map[TablesColumnFile.mimgsubtype] as String,
      mcomment: map[TablesColumnFile.mcomment] as String,
      imgstring: map[TablesColumnFile.imgstring] as String,
      mremarks: map[TablesColumnFile.mremarks] as String,
      mdoctno: 	 map[TablesColumnFile.mdoctno] as String,
      mcustname: 	 map[TablesColumnFile.mcustname] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,


      custmrefno:	map[TablesColumnFile.mcustmrefno] as int,
      custtrefno:	map[TablesColumnFile.mcusttrefno] as int,
      missuingauth: 	 map[TablesColumnFile.missuingauth] as String,
      missuedate:(map[TablesColumnFile.missuedate]=="null"||map[TablesColumnFile.missuedate]==null)?null:DateTime.parse(map[TablesColumnFile.missuedate]) as DateTime,
      mexpdate:(map[TablesColumnFile.mexpdate]=="null"||map[TablesColumnFile.mexpdate]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdate]) as DateTime,
      mexecutiondate:(map[TablesColumnFile.mexecutiondate]=="null"||map[TablesColumnFile.mexecutiondate]==null)?null:DateTime.parse(map[TablesColumnFile.mexecutiondate]) as DateTime,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

    );
  }

  factory DocumentCollectorBean.fromMapFromMiddleWare(Map<String, dynamic> map) {
    return DocumentCollectorBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      mforeignindicator: 	 map[TablesColumnFile.mforeignindicator] as String,
      mimgtype: 	 map[TablesColumnFile.mimgtype] as String,
      mcustomertype: 	 map[TablesColumnFile.mcustomertype] as String,
      mimgtypedesc: map[TablesColumnFile.mimgtypedesc] as String,
      mimgsubtype: map[TablesColumnFile.mimgsubtype] as String,
      mcomment: map[TablesColumnFile.mcomment] as String,
      imgstring: map[TablesColumnFile.imgstring] as String,
      mremarks: map[TablesColumnFile.mremarks] as String,
      mdoctno: 	 map[TablesColumnFile.mdoctno] as String,
      mcustname: 	 map[TablesColumnFile.mcustname] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,

      custmrefno:	map[TablesColumnFile.mcustmrefno] as int,
      custtrefno:	map[TablesColumnFile.mcusttrefno] as int,
      missuingauth: 	 map[TablesColumnFile.missuingauth] as String,
      missuedate:(map[TablesColumnFile.missuedate]=="null"||map[TablesColumnFile.missuedate]==null)?null:DateTime.parse(map[TablesColumnFile.missuedate]) as DateTime,
      mexpdate:(map[TablesColumnFile.mexpdate]=="null"||map[TablesColumnFile.mexpdate]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdate]) as DateTime,
      mexecutiondate:(map[TablesColumnFile.mexecutiondate]=="null"||map[TablesColumnFile.mexecutiondate]==null)?null:DateTime.parse(map[TablesColumnFile.mexecutiondate]) as DateTime,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

    );
  }


    factory DocumentCollectorBean.fromMapFromMiddleWareOnMrefno(Map<String, dynamic> map) {
    print("map------------- "+map.toString());
    return DocumentCollectorBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      mforeignindicator: 	 map[TablesColumnFile.mforeignindicator] as String,
      mimgtype: 	 map[TablesColumnFile.mimgtype] as String,
      mcustomertype: 	 map[TablesColumnFile.mcustomertype] as String,
      mimgtypedesc: map[TablesColumnFile.mimgtypedesc] as String,
      mimgsubtype: map[TablesColumnFile.mimgsubtype] as String,
      mcomment: map[TablesColumnFile.mcomment] as String,
      imgstring: map[TablesColumnFile.imgstring] as String,
      mremarks: map[TablesColumnFile.mremarks] as String,
      mdoctno: 	 map[TablesColumnFile.mdoctno] as String,
      mcustname: 	 map[TablesColumnFile.mcustname] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,

      custmrefno:	map[TablesColumnFile.mcustmrefno] as int,
      custtrefno:	map[TablesColumnFile.mcusttrefno] as int,
      missuingauth: 	 map[TablesColumnFile.missuingauth] as String,
      missuedate:(map[TablesColumnFile.missuedate]=="null"||map[TablesColumnFile.missuedate]==null)?null:DateTime.parse(map[TablesColumnFile.missuedate]) as DateTime,
      mexpdate:(map[TablesColumnFile.mexpdate]=="null"||map[TablesColumnFile.mexpdate]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdate]) as DateTime,
      mexecutiondate:(map[TablesColumnFile.mexecutiondate]=="null"||map[TablesColumnFile.mexecutiondate]==null)?null:DateTime.parse(map[TablesColumnFile.mexecutiondate]) as DateTime,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

    );
  }

}
