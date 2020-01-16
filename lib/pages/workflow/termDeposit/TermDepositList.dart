import 'package:flutter/material.dart';
import 'package:eco_los/Utilities/ThemeDesign.dart';
import 'package:eco_los/Utilities/globals.dart';
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:eco_los/pages/workflow/termDeposit/NewTermDeposit.dart';
import 'package:eco_los/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermDepositList extends StatefulWidget {

  TermDepositList();

  @override
  _TermDepositList createState() => new _TermDepositList();
}

class _TermDepositList extends State<TermDepositList> {
  NewTermDepositBean loanDetObj = new NewTermDepositBean();
  List<NewTermDepositBean> items = new List<NewTermDepositBean>();
  List<NewTermDepositBean> storedItems = new List<NewTermDepositBean>();
  Widget appBarTitle = new Text("Term Deposit List");
  List<bool> questionCheck;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrCode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";
  NewTermDepositBean customerListBean;
  int count;

  Icon actionIcon = new Icon(Icons.search);

  @override
  void initState() {
    count = 1;
    items.clear();
    super.initState();
    getSessionVariables();
  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.usrCode);
      usrCode = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    });
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    print("snapshaot datya " + snapshot.data.toString());
    if (snapshot.data != null) {
      print("stored item length is ${storedItems.length}");
      print("items item length is ${items.length}");
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    double c_width = MediaQuery.of(context).size.width * 10;
    int mcustNoInt = 0;
    int mprcdAcctIdInt = 0;
    String mprdcd = "";
    String custNo = "";
    String prcdAcctId = "";

    print("inside get item ui");

   /* if (items[index].mprdacctid != null &&
        items[index].mprdacctid != "null" &&
        items[index].mprdacctid != "") {
      mprdcd = items[index].mprdacctid.substring(0, 8).trim();
      custNo = items[index].mprdacctid.substring(8, 16);
      prcdAcctId = items[index].mprdacctid.substring(16, 24);
    }*/
    mprdcd = items[index].mprdcd.toString();
    custNo = items[index].mcustno.toString();
    prcdAcctId = items[index].mprdacctId.toString();

    print("items[index].mprdcd " + mprdcd.toString());
    if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
      print("items[index].mprdcd " + items[index].mprdcd.toString());
      mprdcd = items[index].mprdcd;
    }

    if (custNo == null || custNo == 'null' || custNo.trim() == "") {
      print("items[index].mprdcd " + items[index].mprdcd.toString());
      custNo = items[index].mcustno.toString();
    }
    try {
      if (custNo != null && custNo != 'null') {
        mcustNoInt = int.parse(custNo);
      }
      if (prcdAcctId != null && prcdAcctId != 'null') {
        mprcdAcctIdInt = int.parse(prcdAcctId);
      }
    } catch (_) {
      print("Exception Here in catch future builder");
    }
    return new GestureDetector(
      onTap: () {
      _onTapItem(items[index]);
    },
      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),

                // width: c_width,
                child: Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          ThemeDesign.loginGradientEnd,
                          ThemeDesign.loginGradientStart,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        //firstName+" "+middleName+" "+lastName,
                        "  ${items[index].mlongname}",
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Trefno  :   " +
                                    items[index].trefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    new Text(
                                      mcustNoInt.toString() +
                                          "/" +
                                          mprdcd.toString() +
                                          "/" +
                                          mprcdAcctIdInt.toString(),
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 30.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                /*    Text(
                                      items[index].macctstat == 1
                                          ? "Normal/Operative"
                                          : items[index].macctstat == 2
                                              ? "New"
                                              : items[index].macctstat == 3
                                                  ? "Closed"
                                                  : items[index].macctstat == 14
                                                      ? "WrittenOff"
                                                      : "NPA",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),
                                    ),*/
                                  ],
                                ),
                              ),
                            ],
                          )),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: <Widget>[
                              Text(
                                "Open Date  :  " +
                                    items[index].mcreateddt.toString(),
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                  /*   top: 1.0,
                                  bottom: 1.0,*/
                                  ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new Text(
                                    " Amount: ${items[index].mmainbalfcy}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Mode of Payout: ${items[index].mmodeofdeposit}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var loanDetailsBuilder;

    if (/*storedItems.isEmpty||storedItems==null*/ count == 1 || count == 2) {
      count++;
      print("inside case 1 ");
      loanDetailsBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getTermDepositList()
              .then((List<NewTermDepositBean> utilizationData) {
            items.clear();
            storedItems.clear();
            utilizationData.forEach((f) {
              items.add(f);
              storedItems.add(f);
            });

            print("items length is ${items.length}");
            return items;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Press button to start');
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                        new CircularProgressIndicator()); // new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  print("trying to run homepage");
                  return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (storedItems != null) {
      loanDetailsBuilder = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            double c_width = MediaQuery.of(context).size.width * 10;
            int mcustNoInt = 0;
            int mprcdAcctIdInt = 0;
            String mprdcd = "";
            String custNo = "";
            String prcdAcctId = "";

          /*  if (items[position].mprdacctid != null &&
                items[position].mprdacctid != "null" &&
                items[position].mprdacctid != "") {
              mprdcd = items[position].mprdacctid.substring(0, 8).trim();
              custNo = items[position].mprdacctid.substring(8, 16);
              prcdAcctId = items[position].mprdacctid.substring(16, 24);
            }*/

            mprdcd = items[position].mprdcd.toString();
            custNo = items[position].mcustno.toString();
            prcdAcctId = items[position].mprdacctId.toString();

            print("items[index].mprdcd " + mprdcd.toString());
            if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
              print("items[index].mprdcd " + items[position].mprdcd.toString());
              mprdcd = items[position].mprdcd;
            }

            if (custNo == null || custNo == 'null' || custNo.trim() == "") {
              print("items[index].mprdcd " + items[position].mprdcd.toString());
              custNo = items[position].mcustno.toString();
            }
            try {
              if (custNo != null && custNo != 'null') {
                mcustNoInt = int.parse(custNo);
              }
              if (prcdAcctId != null && prcdAcctId != 'null') {
                mprcdAcctIdInt = int.parse(prcdAcctId);
              }
            } catch (_) {}

            return new GestureDetector(
              onTap: () {
                _onTapItem(items[position]);
              },
              child: new Card(
                //color Color(0xff2f1f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child: new Padding(
                  padding: new EdgeInsets.only(
                    left: 3.0,
                    right: 3.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 3.0),

                        // width: c_width,
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  ThemeDesign.loginGradientEnd,
                                  ThemeDesign.loginGradientStart,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          //color: color,
                          child: Column(
                            children: <Widget>[
                              new Text(
                                //firstName+" "+middleName+" "+lastName,
                                "  ${items[position].mlongname}",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        "Trefno  :   " +
                                            items[position].trefno.toString() +
                                            "   ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            new Text(
                                              mcustNoInt.toString() +
                                                  "/" +
                                                  mprdcd.toString() +
                                                  "/" +
                                                  mprcdAcctIdInt.toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 30.0, right: 10.0),
                                       /* child: Row(
                                          children: <Widget>[
                                            Text(
                                              items[position].macctstat == 1
                                                  ? "Normal/Operative"
                                                  : items[position].macctstat ==
                                                          2
                                                      ? "New"
                                                      : items[position]
                                                                  .macctstat ==
                                                              3
                                                          ? "Closed"
                                                          : items[position]
                                                                      .macctstat ==
                                                                  14
                                                              ? "WrittenOff"
                                                              : "NPA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.yellowAccent),
                                            ),
                                          ],
                                        ),*/
                                      ),
                                    ],
                                  )),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                                    children: <Widget>[
                                      Text(
                                        "Open Date  :  " +
                                            items[position]
                                                .mcreateddt
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        width: c_width,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                          /*   top: 1.0,
                                  bottom: 1.0,*/
                                          ),
                                      child: new Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: <Widget>[
                                      new Text(
                                      " Amount: ${items[position].mmainbalfcy}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[500],
                                          ),
                                        ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            "Mode of Payout: ${items[position].mmodeofdeposit}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    // TODO: implement build
    return new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: (val) {
                      // filterList(val.toLowerCase());
                    },
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Term Deposit List");
                  items = new List<NewTermDepositBean>();
                  items.clear();
                  storedItems.forEach((val) {
                    items.add(val);
                  });
                }
              });
            },
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            _addNewTermDepositAccount();
          }),
      body: loanDetailsBuilder,
    );
  }

  /* Future<void> _CheckBalance(double accbal,double totalien) async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.account_balance,
              color: Colors.green,
              size: 60.0,
              ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          "  Your Current Balance Is :" + accbal.toString()),
                    ],
                    ),
                  new Row(
                    children: <Widget>[
                      new Text("  Your Lien Balance Is      :" +
                                   totalien.toString()),
                    ],
                    )
                  */ /*new Text("  Your Current Balance Is:",style: TextStyle(fontSize: 8.0),),

                  new Text("  ${loanDetObj.macttotbalfcy}",style: TextStyle(fontSize: 8.0),),*/ /*
                ],
                ),
              ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                ),
            ],
            );
        });
  }*/

/*  void _CheckBalance() {
    print("Inside Check Balance");
    new Text(" ddsf");

  }*/
  void _addNewTermDepositAccount() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
              new NewTermDeposit()), //When Authorized Navigate to the next screen
    );
  }

  void _onTapItem(NewTermDepositBean item) {

    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new NewTermDeposit(
            onTapBean: item,
              )), //When Authorized Navigate to the next screen
    );
  }

/* void filterList(String val) async {
    print("inside filterList");
    items.clear();

    storedItems.forEach((obj) {
      if (obj.mdateopen.toString().contains(val) ||
          obj.trefno.toString().toLowerCase().contains(val) ||
          obj.mcenterid.toString().contains(val) ||
          obj.mgroupcd.toString().contains(val) ||
          obj.mlongname.toString().toUpperCase().contains(val.toUpperCase()) ||
          obj.macctstat.toString().contains(val) ||
          //obj.mmobno.toString().contains(val) |
          obj.mcustno.toString().contains(
              val) */ /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/ /*) {
        print("inside contains");

        items.add(obj);
        print(items);
      }

      if (val.toUpperCase() == "NEW") {
        if (obj.macctstat == 2) {
          items.add(obj);
          print(items);
        }
      }
      else if (val.toUpperCase() == "NORMAL" || val.toUpperCase() == "OPERATIVE") {
        if (obj.macctstat == 1) {
          items.add(obj);
          print(items);
        }
      }
      else  if (val.toUpperCase() == "CLOSED") {
        if (obj.macctstat == 3) {
          items.add(obj);
          print(items);
        }
      }
      else  if (val.toUpperCase() == "WRITTENOFF") {
        if (obj.macctstat == 3) {
          items.add(obj);
          print(items);
        }
      }
      else  {
        if (obj.macctstat == 11) {
          items.add(obj);
          print(items);
        }
      }

    });

    setState(() {
      count = 4;
    });
  }*/

}
