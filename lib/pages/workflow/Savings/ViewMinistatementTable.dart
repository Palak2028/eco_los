import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eco_los/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_los/Utilities/app_constant.dart';


class ViewMinistatementTable extends StatefulWidget {
  final List<MiniStatementBean> ministatemntbean;
  ViewMinistatementTable(this.ministatemntbean);


  @override
  _ViewMinistatementTable createState() =>
      _ViewMinistatementTable();
}

class _ViewMinistatementTable
    extends State<ViewMinistatementTable> {
   List<MiniStatementBean> ministatemntlist=new List<MiniStatementBean>();
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
   final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");

  // double shadowbalance=double.parse(widget.ministatemntbean[0].mtotallienfcy)+double.parse(widget.ministatemntbean[0].macttotballcy);
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Date",
      "Amount",
      "DrCr",
      "Remarks"
    ];
  //  print("ministatemntbean"+widget.ministatemntbean.toString());



    if(widget.ministatemntbean!=null){
      ministatemntlist =widget.ministatemntbean;
    }
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Date'),

      ),
      new DataColumn(
        label: const Text('Amount'),
      ),
      new DataColumn(
        label: const Text('DrCr'),
      ),
      new DataColumn(
        label: const Text('Remarks'),
      )
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        ministatemntlist.length,
            (int a) => new DataRow(

            cells: [
              new DataCell(
                  new Text(ministatemntlist[a].mentrydate==null||ministatemntlist[a].mentrydate.toString()=="null"?""
                      :ministatemntlist[a].mentrydate.toString())),
              new DataCell(
                  new Text(ministatemntlist[a].mlcytrnamt==null||ministatemntlist[a].mlcytrnamt.toString()=="null"?"":
                  ministatemntlist[a].mlcytrnamt.toString()
                  )),
              new DataCell(
                  new Text(ministatemntlist[a].mdrcr==null||ministatemntlist[a].mdrcr=="null"?"":
                  ministatemntlist[a].mdrcr.toString()
                  )),
              new DataCell(
                  new Text(ministatemntlist[a].mparticulars==null||ministatemntlist[a].mparticulars=="null"?"":
                  ministatemntlist[a].mparticulars.toString()
                  )),

            ]));

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            'Mini Statements',
           // textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

            actions: <Widget>[

              new IconButton(
                icon: const Icon(
                  Icons.print,
                  color: Colors.white,
                ),
              ),
            ]
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[

                    new Card(color: Constant.semiMandatoryColor,
                        child: new Text(widget.ministatemntbean[0].mlbrcode.toString()=="null"||widget.ministatemntbean[0].mlbrcode.toString()==""?"":widget.ministatemntbean[0].mlbrcode.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(color: Constant.semiMandatoryColor,
                        child: new Text(widget.ministatemntbean[0].mbramchname.toString()=="null"||widget.ministatemntbean[0].mbramchname.toString()==""?"":widget.ministatemntbean[0].mbramchname.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                      child: new Text('Date :'+dateFormat.format(DateTime.now()), style: new TextStyle(
                        color: Color(0xff07426A),
                        fontSize: 18.0,
                      ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                        child: new Text(int.parse(widget.ministatemntbean[0].mprdacctid.substring(0, 8)).toString()+"/"+
                            int.parse(widget.ministatemntbean[0].mprdacctid.substring(8, 16)).toString()+"/"+
                            int.parse(widget.ministatemntbean[0].mprdacctid.substring(16, 24)).toString()
                          , style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                        child: new Text(widget.ministatemntbean[0].mlongname.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 18.0,
                        ), )
                    )
                  ],
                ), Row(
                  children: <Widget>[

                    new Card(
     // double.parse(widget.ministatemntbean[0].mtotallienfcy)+double.parse(widget.ministatemntbean[0].macttotballcy)
                        child: new Text(widget.ministatemntbean[0].macttotballcy.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 18.0,
                        ), )
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                  Container(
                  height: 600.0,
                  child: DataTable(
                    rows: rows2,
                    columns: cols2,
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}








