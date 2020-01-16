import 'package:eco_los/db/TablesColumnFile.dart';

class GuarantorDetailsBean {
  int trefno;
  int mrefno;
  int loantrefno;
  int loanmrefno;

  int custtrefno;
  int custmrefno;

  String mleadsid;
  String mprdacctid;
  String mfname;
  //nvarchar(50)
  String mmname;
  //nvarchar(50)
  String mlname;
  int	msrno ;
  int	mapplicanttype ;
  String	mexistingcustyn ;
  int	mcustno ;
  String	mnameofguar ;
    String	mgender ;
  String	mrelationwithcust ;
  int	mrelationsince ;
  int	mage ;
  String	mphone ;
  String	mmobile ;
  String	maddress ;
  double	mmonthlyincome ;
  DateTime mdob ;
  int	moccupationtype ;
  int	mmainoccupation ;
  int	mworkexpinyrs ;
  double	mincomeothsources ;
  double	mtotalincome ;
  int	mhousetype ;
  String	mworkingaddress ;
  String	mworkphoneno ;
  String	mmothermaidenname ;
  String	mpromissorynote ;
  int	mnationalidtype ;
  int	mnationalid ;
  String	mnationaliddesc ;
  String	maddress2 ;
  String	maddress3 ;
  String	maddress4 ;
  int	mmaritalstatus ;
  int	mreligioncd ;
  String	meducationalqual ;
  String	memailaddr ;
  String	memployername ;
  String	mbusinessname ;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String merrormessage;


  String	mrevsrc1 ;
  String	mrevsrc2;
  String	mnamesrc1 ;
  String	mnamesrc2;
  double	mrev1 ;
  double	mrev2;
  double	mexp1 ;
  double	mexp2;
  double	minc1 ;
  double	minc2;
  double	mrevtotal ;
  double	mexptotal ;
  double	minctotal ;
  String	mpldggurproprty1 ;
  String	mpldggurproprty2;
  String	mpldggurproprty3;
  double	msize1 ;
  double	msize2;
  double	msize3 ;
  double	mcollvalue1 ;
  double	mcollvalue2;
  double	mcollvalue3 ;
  double	mcollvaluetotal;

  GuarantorDetailsBean(
      {
        this.trefno,
        this.mrefno,
        this.loantrefno,
        this.loanmrefno,
        this.mleadsid,
        this.mprdacctid,
        this.msrno,
        this.mapplicanttype,
        this.mexistingcustyn,
        this.mcustno,
        this.mnameofguar,
        this.mgender,
        this.mrelationwithcust,
        this.mrelationsince,
        this.mage,
        this.mphone,
        this.mmobile,
        this.maddress,
        this.mmonthlyincome,
        this.mdob,
        this.moccupationtype,
        this.mmainoccupation,
        this.mworkexpinyrs,
        this.mincomeothsources,
        this.mtotalincome,
        this.mhousetype,
        this.mworkingaddress,
        this.mworkphoneno,
        this.mmothermaidenname,
        this.mpromissorynote,
        this.mnationalidtype,
        this.mnationalid,
        this.mnationaliddesc,
        this.maddress2,
        this.maddress3,
        this.maddress4,
        this.mmaritalstatus,
        this.mreligioncd,
        this.meducationalqual,
        this.memailaddr,
        this.memployername,
        this.mbusinessname,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.merrormessage,
        this.mfname,
        this.mmname,
        this.mlname,
        this.custmrefno,
        this.custtrefno,
        this.mrevsrc1 ,
        this.mrevsrc2,
        this.mnamesrc1 ,
        this.mnamesrc2,
        this.mrev1 ,
        this.mrev2,
        this.mexp1 ,
        this.mexp2,
        this.minc1 ,
        this.minc2,
        this.mrevtotal ,
        this.mexptotal ,
        this.minctotal ,
        this.mpldggurproprty1 ,
        this.mpldggurproprty2,
        this.mpldggurproprty3,
        this.msize1 ,
        this.msize2,
        this.msize3 ,
        this.mcollvalue1 ,
        this.mcollvalue2,
        this.mcollvalue3 ,
        this.mcollvaluetotal,
        });


  @override
  String toString() {
    return 'GuarantorDetailsBean{trefno: $trefno, mrefno: $mrefno, loantrefno: $loantrefno, loanmrefno: $loanmrefno, custtrefno: $custtrefno, custmrefno: $custmrefno, mleadsid: $mleadsid, mprdacctid: $mprdacctid, mfname: $mfname, mmname: $mmname, mlname: $mlname, msrno: $msrno, mapplicanttype: $mapplicanttype, mexistingcustyn: $mexistingcustyn, mcustno: $mcustno, mnameofguar: $mnameofguar, mgender: $mgender, mrelationwithcust: $mrelationwithcust, mrelationsince: $mrelationsince, mage: $mage, mphone: $mphone, mmobile: $mmobile, maddress: $maddress, mmonthlyincome: $mmonthlyincome, mdob: $mdob, moccupationtype: $moccupationtype, mmainoccupation: $mmainoccupation, mworkexpinyrs: $mworkexpinyrs, mincomeothsources: $mincomeothsources, mtotalincome: $mtotalincome, mhousetype: $mhousetype, mworkingaddress: $mworkingaddress, mworkphoneno: $mworkphoneno, mmothermaidenname: $mmothermaidenname, mpromissorynote: $mpromissorynote, mnationalidtype: $mnationalidtype, mnationalid: $mnationalid, mnationaliddesc: $mnationaliddesc, maddress2: $maddress2, maddress3: $maddress3, maddress4: $maddress4, mmaritalstatus: $mmaritalstatus, mreligioncd: $mreligioncd, meducationalqual: $meducationalqual, memailaddr: $memailaddr, memployername: $memployername, mbusinessname: $mbusinessname, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, merrormessage: $merrormessage, mrevsrc1: $mrevsrc1, mrevsrc2: $mrevsrc2, mnamesrc1: $mnamesrc1, mnamesrc2: $mnamesrc2, mrev1: $mrev1, mrev2: $mrev2, mexp1: $mexp1, mexp2: $mexp2, minc1: $minc1, minc2: $minc2, mrevtotal: $mrevtotal, mexptotal: $mexptotal, minctotal: $minctotal, mpldggurproprty1: $mpldggurproprty1, mpldggurproprty2: $mpldggurproprty2, mpldggurproprty3: $mpldggurproprty3, msize1: $msize1, msize2: $msize2, msize3: $msize3, mcollvalue1: $mcollvalue1, mcollvalue2: $mcollvalue2, mcollvalue3: $mcollvalue3, mcollvaluetotal: $mcollvaluetotal}';
  }

  factory GuarantorDetailsBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return GuarantorDetailsBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      custmrefno:	map[TablesColumnFile.mcustmrefno] as int,
      custtrefno:	map[TablesColumnFile.mcusttrefno] as int,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      msrno:	map[TablesColumnFile.msrno] as int,
      mapplicanttype:	map[TablesColumnFile.mapplicanttype] as int,

      mrevsrc1 :		 map[TablesColumnFile.mrevsrc1] as String,
      mrevsrc2:		  map[TablesColumnFile.mrevsrc2] as String,
      mnamesrc1 :		  map[TablesColumnFile.mnamesrc1] as String,
      mnamesrc2:		  map[TablesColumnFile.mnamesrc2] as String,
      mrev1 :		  map[TablesColumnFile.mrev1] as double,
      mrev2:		  map[TablesColumnFile.mrev2] as double,
      mexp1 :		  map[TablesColumnFile.mexp1] as double,
      mexp2:		  map[TablesColumnFile.mexp2] as double,
      minc1 :		  map[TablesColumnFile.minc1] as double,
      minc2:		  map[TablesColumnFile.minc2] as double,
      mrevtotal :		  map[TablesColumnFile.mrevtotal] as double,
      mexptotal :		  map[TablesColumnFile.mexptotal] as double,
      minctotal :		  map[TablesColumnFile.minctotal] as double,
      mpldggurproprty1 :		  map[TablesColumnFile.mpldggurproprty1] as String,
      mpldggurproprty2:		  map[TablesColumnFile.mpldggurproprty2] as String,
      mpldggurproprty3:		  map[TablesColumnFile.mpldggurproprty3] as String,
      msize1 :		  map[TablesColumnFile.msize1] as double,
      msize2:		  map[TablesColumnFile.msize2] as double,
      msize3 :		  map[TablesColumnFile.msize3] as double,
      mcollvalue1 :		  map[TablesColumnFile.mcollvalue1] as double,
      mcollvalue2:		  map[TablesColumnFile.mcollvalue2] as double,
      mcollvalue3 :		  map[TablesColumnFile.mcollvalue3] as double,
      mcollvaluetotal:		  map[TablesColumnFile.mcollvaluetotal] as double,

      mexistingcustyn:	map[TablesColumnFile.mexistingcustyn] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,
      mnameofguar:	map[TablesColumnFile.mnameofguar] as String,
      mgender:	map[TablesColumnFile.mgender] as String,
      mrelationwithcust:	map[TablesColumnFile.mrelationwithcust] as String,
      mrelationsince:	map[TablesColumnFile.mrelationsince] as int,
      mage:	map[TablesColumnFile.mage] as int,
      mphone:	map[TablesColumnFile.mphone] as String,
      mmobile:	map[TablesColumnFile.mmobile] as String,
      maddress:	map[TablesColumnFile.maddress] as String,
      mmonthlyincome:	map[TablesColumnFile.mmonthlyincome] as double,
      mdob:	(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      moccupationtype:	map[TablesColumnFile.moccupationtype] as int,
      mmainoccupation:	map[TablesColumnFile.mmainoccupation] as int,
      mworkexpinyrs:	map[TablesColumnFile.mworkexpinyrs] as int,
      mincomeothsources:	map[TablesColumnFile.mincomeothsources] as double,
      mtotalincome:	map[TablesColumnFile.mtotalincome] as double,
      mhousetype:	map[TablesColumnFile.mhousetype] as int,
      mworkingaddress:	map[TablesColumnFile.mworkingaddress] as String,
      mworkphoneno:	map[TablesColumnFile.mworkphoneno] as String,
      mmothermaidenname:	map[TablesColumnFile.mmothermaidenname] as String,
      mpromissorynote:	map[TablesColumnFile.mpromissorynote] as String,
      mnationalidtype:	map[TablesColumnFile.mnationalidtype] as int,
      mnationalid:	map[TablesColumnFile.mnationalid] as int,
      mnationaliddesc:	map[TablesColumnFile.mnationaliddesc] as String,
      maddress2:	map[TablesColumnFile.maddress2] as String,
      maddress3:	map[TablesColumnFile.maddress3] as String,
      maddress4:	map[TablesColumnFile.maddress4] as String,
      mmaritalstatus:	map[TablesColumnFile.mmaritalstatus] as int,
      mreligioncd:	map[TablesColumnFile.mreligioncd] as int,
      meducationalqual:	map[TablesColumnFile.meducationalqual] as String,
      memailaddr:	map[TablesColumnFile.memailaddr] as String,
      memployername:	map[TablesColumnFile.memployername] as String,
      mbusinessname:	map[TablesColumnFile.mbusinessname] as String,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,




    );

  }
  factory GuarantorDetailsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return GuarantorDetailsBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      custmrefno:	map[TablesColumnFile.mcustmrefno] as int,
      custtrefno:	map[TablesColumnFile.mcusttrefno] as int,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      msrno:	map[TablesColumnFile.msrno] as int,
      mapplicanttype:	map[TablesColumnFile.mapplicanttype] as int,
      mexistingcustyn:	map[TablesColumnFile.mexistingcustyn] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,
      mnameofguar:	map[TablesColumnFile.mnameofguar] as String,
      mgender:	map[TablesColumnFile.mgender] as String,
      mrelationwithcust:	map[TablesColumnFile.mrelationwithcust] as String,
      mrelationsince:	map[TablesColumnFile.mrelationsince] as int,
      mage:	map[TablesColumnFile.mage] as int,
      mphone:	map[TablesColumnFile.mphone] as String,
      mmobile:	map[TablesColumnFile.mmobile] as String,
      maddress:	map[TablesColumnFile.maddress] as String,
      mmonthlyincome:	map[TablesColumnFile.mmonthlyincome] as double,
      mdob:	(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      moccupationtype:	map[TablesColumnFile.moccupationtype] as int,
      mmainoccupation:	map[TablesColumnFile.mmainoccupation] as int,
      mworkexpinyrs:	map[TablesColumnFile.mworkexpinyrs] as int,
      mincomeothsources:	map[TablesColumnFile.mincomeothsources] as double,
      mtotalincome:	map[TablesColumnFile.mtotalincome] as double,
      mhousetype:	map[TablesColumnFile.mhousetype] as int,
      mworkingaddress:	map[TablesColumnFile.mworkingaddress] as String,
      mworkphoneno:	map[TablesColumnFile.mworkphoneno] as String,
      mmothermaidenname:	map[TablesColumnFile.mmothermaidenname] as String,
      mpromissorynote:	map[TablesColumnFile.mpromissorynote] as String,
      mnationalidtype:	map[TablesColumnFile.mnationalidtype] as int,
      mnationalid:	map[TablesColumnFile.mnationalid] as int,
      mnationaliddesc:	map[TablesColumnFile.mnationaliddesc] as String,
      maddress2:	map[TablesColumnFile.maddress2] as String,
      maddress3:	map[TablesColumnFile.maddress3] as String,
      maddress4:	map[TablesColumnFile.maddress4] as String,
      mmaritalstatus:	map[TablesColumnFile.mmaritalstatus] as int,
      mreligioncd:	map[TablesColumnFile.mreligioncd] as int,
      meducationalqual:	map[TablesColumnFile.meducationalqual] as String,
      memailaddr:	map[TablesColumnFile.memailaddr] as String,
      memployername:	map[TablesColumnFile.memployername] as String,
      mbusinessname:	map[TablesColumnFile.mbusinessname] as String,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,

      mrevsrc1 :		 map[TablesColumnFile.mrevsrc1] as String,
      mrevsrc2:		  map[TablesColumnFile.mrevsrc2] as String,
      mnamesrc1 :		  map[TablesColumnFile.mnamesrc1] as String,
      mnamesrc2:		  map[TablesColumnFile.mnamesrc2] as String,
      mrev1 :		  map[TablesColumnFile.mrev1] as double,
      mrev2:		  map[TablesColumnFile.mrev2] as double,
      mexp1 :		  map[TablesColumnFile.mexp1] as double,
      mexp2:		  map[TablesColumnFile.mexp2] as double,
      minc1 :		  map[TablesColumnFile.minc1] as double,
      minc2:		  map[TablesColumnFile.minc2] as double,
      mrevtotal :		  map[TablesColumnFile.mrevtotal] as double,
      mexptotal :		  map[TablesColumnFile.mexptotal] as double,
      minctotal :		  map[TablesColumnFile.minctotal] as double,
      mpldggurproprty1 :		  map[TablesColumnFile.mpldggurproprty1] as String,
      mpldggurproprty2:		  map[TablesColumnFile.mpldggurproprty2] as String,
      mpldggurproprty3:		  map[TablesColumnFile.mpldggurproprty3] as String,
      msize1 :		  map[TablesColumnFile.msize1] as double,
      msize2:		  map[TablesColumnFile.msize2] as double,
      msize3 :		  map[TablesColumnFile.msize3] as double,
      mcollvalue1 :		  map[TablesColumnFile.mcollvalue1] as double,
      mcollvalue2:		  map[TablesColumnFile.mcollvalue2] as double,
      mcollvalue3 :		  map[TablesColumnFile.mcollvalue3] as double,
      mcollvaluetotal:		  map[TablesColumnFile.mcollvaluetotal] as double,

    );
  }

}

