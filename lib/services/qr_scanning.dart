import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QrScanService {

 Future scanQr() async {
    try {
      return await BarcodeScanner.scan();
     
 
    } on PlatformException catch (e) {
      if(e.code == BarcodeScanner.CameraAccessDenied) {
       return 'no Camera permision';
      } else {
             print(e);
      
      }
 
    } on FormatException catch(e) {
      return'format excepetion $e';
    }
  }
}