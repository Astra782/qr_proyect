// ignore_for_file: library_private_types_in_public_api

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import 'package:geolocator/geolocator.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<QrScreen> {
  var getResult = "QR Code Resultado";
  late Position _currentPosition;

  @override
  void initState() {
    _currentPosition = Position(
      longitude: 0.0,
      latitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0 
    );
    super.initState();
    _getCurrentLocation();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //QR
          ElevatedButton(onPressed: (){
            if(_currentPosition.latitude!= 15.54134 && _currentPosition.longitude!= -88.03602){
              AlertDialog(
                title: const Text("Error!"),
                content: const Text("Ubicacion no permitida, vaya a la zona designada"),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text("OK"))
                ],
              );
            }else{
              scanQR();
            }
          }, 
          child: const Text("Codigo QR"),
          ),
          //Localizacion
          const SizedBox(height: 20,),
          Text(getResult),
          Text("LAT: ${_currentPosition.latitude}, LNG:${_currentPosition.longitude}"),
            ElevatedButton(child: const Text("Obtener ubicacion"), onPressed: () {
                _getCurrentLocation();
              },
            ),
        ],
      ),),
    );
  }
  void scanQR() async {
      try {
        final qrCode = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
        if (!mounted) return;
        setState(() {
          getResult = qrCode;
        });
        print("QRCode_result:--");
        print(qrCode);
    } on PlatformException {
      getResult = "Failed to get platform version.";
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Position>('_currentPosition', _currentPosition));
  }
}