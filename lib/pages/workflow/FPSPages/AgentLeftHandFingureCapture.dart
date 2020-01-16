import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:flutter/material.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentLeftHandFingureCapture extends StatefulWidget {
  @override
  _AgentLeftHandFingureCapture createState() => _AgentLeftHandFingureCapture();
}

class _AgentLeftHandFingureCapture extends State<AgentLeftHandFingureCapture> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          padding:
              EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
          alignment: Alignment.center,
          // color: Colors.white70,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/background_finger_capture.png"),
              fit: BoxFit.fill,
            ),
          ),

//        width: 200.0,
//        height: 100.0,
//      margin: EdgeInsets.only(left: 35.0,top:50.0),
          child: Column(
            children: <Widget>[
              new Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Constant.label_biometric_scan,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.black87
                            //          fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Text(
                  Constant.label_please_select_lt_hand_fngr,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                      color: Colors.black38
                      //          fontStyle: FontStyle.italic
                      ),
                ),
              ),
              new Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: LeftHandThumb(),
                    ),
                    Expanded(
                      child: LeftHandIndexFinger(),
                    ),
                    Expanded(
                      child: LeftHandMiddleFinger(),
                    ),
                  ],
                ),
                flex: 3,
              ),
              new Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Constant.label_thumb_finger,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38
                            //          fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Constant.label_index_finger,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38
                            //          fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Constant.label_middle_finger,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38
                            //          fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                  ],
                ),
                flex: 3,
              ),
              new Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: LeftHandRingFinger(),
                    ),
                    Expanded(
                      child: LeftHandPinkyFinger(),
                    ),
                    /* Expanded(
                      child: LeftHandThumb(),
                    ),*/
                  ],
                ),
                flex: 3,
              ),
              new Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Constant.label_ring_finger,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38
                            //          fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Constant.label_pinky_finger,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38
                            //          fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                  ],
                ),
                flex: 3,
              ),
            ],
          )),
    );
  }
}

/*class LeftHandThumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/fpsImages/lft_hand_thumb.png');
    Image image = Image(
      image: assetImage,
      fit: BoxFit.fitHeight,

      */ /* width: 300.0,
      height: 300.0,*/ /*
    );
    return GestureDetector(
      onTap: () {
        */ /*  print("onTap called.");
        globals.Dialog.alertPopup(context, "Left Hand",
            "you just clicked on Left hand image", "Dashboard");*/ /*
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  new LeftHandThumbSelected()), //When Authorized Navigate to the next screen
        );
      },
      child: image,
    );
  }
}*/

/*class LeftHandThumb extends StatefulWidget {
  @override
  _LeftHandThumb createState() => _LeftHandThumb();
}*/

/*class _LeftHandThumb extends State<LeftHandThumb> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    String _myImage = 'assets/fpsImages/lft_hand_thumb.png';
    AssetImage assetImage = AssetImage(_myImage);
    Image image = Image(
      image: assetImage,
      fit: BoxFit.fitHeight,


    );
    return GestureDetector(
      onTap: () {
        setState(() {
          */ /*   globals.Dialog.alertPopup(context, "Left Hand",
                                        "inside set state", "Dashboard");*/ /*
          if (_myImage == 'assets/fpsImages/lft_hand_thumb.png') {
            globals.Dialog.alertPopup(
                context, "Left Hand", "inside IF", "Dashboard");
            _myImage =
                'assets/fpsImages/lft_hand_thumb_selected.png'; //change myImage to the other one
          } else {
            globals.Dialog.alertPopup(
                context, "Left Hand", "inside ELSE", "Dashboard");
            _myImage =
                'assets/fpsImages/lft_hand_thumb.png'; //change myImage back to the original one
          }
          */ /*  assetImage =
              AssetImage('assets/fpsImages/lft_hand_thumb_selected.png');*/ /*
          //  AgentLeftHandFingureCapture();
        });
      },
      child: image,
    );
  }
}*/

/*class LeftHandThumbSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage =
        AssetImage('assets/fpsImages/lft_hand_thumb_selected.png');
    Image image = Image(
      image: assetImage,
      fit: BoxFit.fitHeight,

      */ /* width: 300.0,
      height: 300.0,*/ /*
    );
    return image;
  }
}*/
//  class for left hand thumb
class LeftHandThumb extends StatefulWidget {
  @override
  _LeftHandThumb createState() => new _LeftHandThumb();
}

class _LeftHandThumb extends State<LeftHandThumb> {
  String _myImage = 'assets/fpsImages/lft_hand_thumb.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/lft_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelLHThumb("LhThumb");
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHThumb(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("leftthumbvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/lft_hand_thumb.png') {
            _myImage =
            'assets/fpsImages/lft_hand_thumb_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/lft_hand_thumb.png'; //change myImage back to the original one
          }

          Navigator.pop(context,fingerType+"#"+geTest );
        });
      }

      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}

// class for Index finger
class LeftHandIndexFinger extends StatefulWidget {
  @override
  _LeftHandIndexFinger createState() => new _LeftHandIndexFinger();
}

class _LeftHandIndexFinger extends State<LeftHandIndexFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_index.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/lft_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelLHIndexFinger("LhIndexFinger");
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHIndexFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("leftindexvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/lft_hand_index.png') {
            _myImage =
            'assets/fpsImages/lft_hand_index_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/lft_hand_index.png'; //change myImage back to the original one
          }

          Navigator.pop(context,fingerType+"#"+geTest );
        });
      }

      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}

// class for middle finger
class LeftHandMiddleFinger extends StatefulWidget {
  @override
  _LeftHandMiddleFinger createState() => new _LeftHandMiddleFinger();
}

class _LeftHandMiddleFinger extends State<LeftHandMiddleFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_middle.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/lft_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelLHMiddleFinger("LhMiddleFinger");
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHMiddleFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("leftmdiddlevalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/lft_hand_middle.png') {
            _myImage =
            'assets/fpsImages/lft_hand_middle_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/lft_hand_middle.png'; //change myImage back to the original one
          }
          Navigator.pop(context,fingerType+"#"+geTest );
        });
      }

      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}

// class for Ring finger
class LeftHandRingFinger extends StatefulWidget {
  @override
  _LeftHandRingFinger createState() => new _LeftHandRingFinger();
}

class _LeftHandRingFinger extends State<LeftHandRingFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_ring.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/lft_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelLHRingFinger("LhRingFinger");
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHRingFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("leftringvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/lft_hand_ring.png') {
            _myImage =
            'assets/fpsImages/lft_hand_ring_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/lft_hand_ring.png'; //change myImage back to the original one
          }
          Navigator.pop(context,fingerType+"#"+geTest );
        });
      }

      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}

// class for pinky finger
class LeftHandPinkyFinger extends StatefulWidget {
  @override
  _LeftHandPinkyFinger createState() => new _LeftHandPinkyFinger();
}

class _LeftHandPinkyFinger extends State<LeftHandPinkyFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_pinky.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/lft_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelLHPinkyFinger("LhPinkyFinger");
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHPinkyFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("leftpinkyvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/lft_hand_pinky.png') {
            _myImage =
            'assets/fpsImages/lft_hand_pinky_slected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/lft_hand_pinky.png'; //change myImage back to the original one
          }
          Navigator.pop(context,fingerType+"#"+geTest );
        });
      }

      print("Flutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("Flutter : " + e.message.toString());
    }
  }
}
