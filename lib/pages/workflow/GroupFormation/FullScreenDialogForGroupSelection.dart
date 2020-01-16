import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'dart:io';
import 'dart:async';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:eco_los/db/AppDatabase.dart';
import 'package:eco_los/pages/workflow/GroupFormation/bean/GetGroupSelectionList.dart';
import 'package:eco_los/pages/workflow/GroupFormation/bean/GroupFoundation.dart';

class FullScreenDialogForGroupSelection extends StatefulWidget {
  String groupName = "";
  String groupNo = "";

  @override
  FullScreenDialogForGroupSelectionState createState() =>
      new FullScreenDialogForGroupSelectionState();
}

class FullScreenDialogForGroupSelectionState
    extends State<FullScreenDialogForGroupSelection> {
  List<GroupFoundationBean> items = new List();
  List<GroupFoundationBean> storedItems = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Group List");

int count  = 0;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () {

        _onTapItem(context, items[index]);
      },
      child: new Card(
        shape: BeveledRectangleBorder(),
        child: new Row(
          children: <Widget>[
            SizedBox(height: 8.0,),
            Expanded(
              child:  new Card(
                  child:new ListTile(
                    leading:Text(
              '${items[index].mgroupid.toString()}',
              style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0,color: Color(0xff07426A),),
              ),

                    title: Text(
                      "Group Name : ${ '${items[index].mgroupname.trim()}'}\n",
              style: TextStyle(

                      ),
                    ),
                    subtitle:new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.local_atm,
                              color: Colors.green,
                              size: 20.0,
              ),
                            new Text('${items[index].mcreatedby}')
                          ],
            ),

                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.present_to_all,
                              color: Colors.yellow,

                              size: 20.0,
                            ),
                           // new Text("Center id: " +items[index].mcenterid.toString())

                          ],
                        )


                      ],
                    ),
                  //  trailing: new Text("Ceated By : " +items[index].mcreatedby,style: TextStyle(color: Colors.red),),

                  )
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future:count==0? AppDatabase.get()
            .getGroupFoundationList()
            .then((List<GroupFoundationBean> response) {
              count++;
              response.forEach((val){

                storedItems.add(val);
              });
              return items = response;
        } ):
        AppDatabase.get()
            .getGroupFoundationList()
            .then((List<GroupFoundationBean> response) {

          return items;
        } )
        ,
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
                return new Text('Error: ${Constant.noGroups}');
              else
                return getHomePageBody(context, snapshot);
          }
        });
    return Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title:  appBarTitle,
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
                            prefixIcon:
                            new Icon(Icons.search, color: Colors.white),
                            hintText: "Search...",
                            hintStyle: new TextStyle(color: Colors.white)),
                        onChanged: (val) {
                          filterList(val.toLowerCase());
                        },
                      );
                    } else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text("Prospect List");
                      items.clear();
                      storedItems.forEach((val) {
                        items.add(val);
                      });
                    }
                  });
                }),]
      ),
      /*  floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new CustomerFormationBasicDetails()),
          );

        },
      ),*/
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(
      BuildContext context, GroupFoundationBean GetGroupFoundationBean) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(GetGroupFoundationBean.mgroupid.toString() +
            ' - ' +
            GetGroupFoundationBean.mgroupname)));

    widget.groupName = GetGroupFoundationBean.mgroupname;
    widget.groupNo = GetGroupFoundationBean.mgroupid.toString();
    globals.grouopName = GetGroupFoundationBean.mgroupname;
    globals.groupNo = GetGroupFoundationBean.mgroupid.toString();
    Navigator.of(context).pop(GetGroupFoundationBean);
  }


  void filterList(String val) {
    print("inside filterList");


    items.clear();
    storedItems.forEach((obj) {
      if (obj.mgroupid.toString().toLowerCase().contains(val) ||
          obj.mgroupname.toLowerCase().contains(val)) {
        print("inside contains");
        print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }
}
