import 'dart:async';
import 'package:flutter/services.dart';

/// Flutter barcode scanner class that bridge the native classes to flutter project
class FlutterBarcodeScanner {
  /// Create a method channel instance
  static const MethodChannel _channel =
  const MethodChannel('flutter_barcode_scanner');

  /// Use this method to start barcode scanning and get the barcode result in string
  /// lineColor is color of a line in scanning
  /// cancelButtonText is text of cancel button
  /// isShowFlashIcon is bool to show or hide flash icon
  static Future<String> scanBarcode(
      String lineColor, String cancelButtonText, bool isShowFlashIcon) async {
    if (null == cancelButtonText || cancelButtonText.isEmpty)
      cancelButtonText = "Cancel";

    /// pass a line color param
    Map params = <String, dynamic>{
      "lineColor": lineColor,
      "cancelButtonText": cancelButtonText,
      "isShowFlashIcon": isShowFlashIcon
    };

    /// Get barcode scan result
    String barcodeResult = await _channel.invokeMethod('scanBarcode', params);
    if (null == barcodeResult) {
      barcodeResult = "";
    }
    return barcodeResult;
  }
}
