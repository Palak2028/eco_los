import 'package:eco_los/db/TablesColumnFile.dart';
import 'package:flutter/material.dart';
import 'package:eco_los/Utilities/app_constant.dart';
import 'package:eco_los/Utilities/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentRightHandFingureCapture extends StatefulWidget {
  @override
  _AgentRightHandFingureCapture createState() => _AgentRightHandFingureCapture();
}

class _AgentRightHandFingureCapture extends State<AgentRightHandFingureCapture> {
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
                  Constant.label_please_select_rt_hand_fngr,
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
                      child: RightHandThumb(),
                      ),
                    Expanded(
                      child: RightHandIndexFinger(),
                      ),
                    Expanded(
                      child: RightHandMiddleFinger(),
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
                      child: RightHandRingFinger(),
                      ),
                    Expanded(
                      child: RightHandPinkyFinger(),
                      ),
                    /* Expanded(
                      child: RightHandThumb(),
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
//  class for right hand thumb
class RightHandThumb extends StatefulWidget {
  @override
  _RightHandThumb createState() => new _RightHandThumb();
}

class _RightHandThumb extends State<RightHandThumb> {
  String _myImage = 'assets/fpsImages/rt_hand_thumb.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/rt_hand_thumb_selected.png';

  void _onClicked() {
    //I don't know what I should put here to cause the image to redraw
    //only on button press
    _callChannelRHThumb("RhThumb");

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
  _callChannelRHThumb(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("rightthumbvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/rt_hand_thumb.png') {
            _myImage =
            'assets/fpsImages/rt_hand_thumb_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/rt_hand_thumb.png'; //change myImage back to the original one
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
class RightHandIndexFinger extends StatefulWidget {
  @override
  _RightHandIndexFinger createState() => new _RightHandIndexFinger();
}

class _RightHandIndexFinger extends State<RightHandIndexFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_index.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/rt_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelRHIndexFinger("RhIndexFinger");
    //I don't know what I should put here to cause the image to redraw
    //only on button press

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
  _callChannelRHIndexFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("rightindexvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/rt_hand_index.png') {
            _myImage =
            'assets/fpsImages/rt_hand_index_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/rt_hand_index.png'; //change myImage back to the original one
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
class RightHandMiddleFinger extends StatefulWidget {
  @override
  _RightHandMiddleFinger createState() => new _RightHandMiddleFinger();
}

class _RightHandMiddleFinger extends State<RightHandMiddleFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_middle.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/rt_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelRHMiddleFinger("RhMiddleFinger");

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
  _callChannelRHMiddleFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("rihgtmdiddlevalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/rt_hand_middle.png') {
            _myImage =
            'assets/fpsImages/rt_hand_middle_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/rt_hand_middle.png'; //change myImage back to the original one
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
class RightHandRingFinger extends StatefulWidget {
  @override
  _RightHandRingFinger createState() => new _RightHandRingFinger();
}

class _RightHandRingFinger extends State<RightHandRingFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_ring.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/rt_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelRHRingFinger("RhRingFinger");

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
  _callChannelRHRingFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("rightringvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/rt_hand_ring.png') {
            _myImage =
            'assets/fpsImages/rt_hand_ring_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/rt_hand_ring.png'; //change myImage back to the original one
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
class RightHandPinkyFinger extends StatefulWidget {
  @override
  _RightHandPinkyFinger createState() => new _RightHandPinkyFinger();
}

class _RightHandPinkyFinger extends State<RightHandPinkyFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_pinky.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_los');
  SharedPreferences prefs;

  //String _myImage1 ='assets/fpsImages/rt_hand_thumb_selected.png';

  void _onClicked() {
    _callChannelRHPinkyFinger("RhPinkyFinger");

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
  _callChannelRHPinkyFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType
      });
      String geTest = '$result';
      print("righttpinkyvalue!! : " +geTest);
      if (geTest != null) {
        setState(() {
          if (_myImage == 'assets/fpsImages/rt_hand_pinky.png') {
            _myImage =
            'assets/fpsImages/rt_hand_pinky_selected.png'; //change myImage to the other one
          } else {
            _myImage =
            'assets/fpsImages/rt_hand_pinky.png'; //change myImage back to the original one
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
