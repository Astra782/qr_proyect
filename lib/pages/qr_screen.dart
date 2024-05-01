// ignore_for_file: library_private_types_in_public_api

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<QrScreen> {
  var getResult = "Inicie la Lectura de QR para mostrar su hora de entrada y salida";
  late Position _currentPosition;
  String _currentAdress = "Ubicacion";
  
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
      speedAccuracy: 0 
    );
    super.initState();
    _getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bienvenido"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //QR
          ElevatedButton(onPressed: (){
            if(_currentAdress == "San Pedro Sula, 21102, Honduras"){
              scanQR();
            }else{
              _alertDialog();
            }
            //if(_currentAdress!=null) Text(_currentAdress);
          }, 
          child: const Text("Codigo QR"),
          ),
          //Localizacion
          const SizedBox(height: 20,),
          Text(getResult),
          // ignore: unnecessary_null_comparison
          if(_currentAdress!=null) Text(_currentAdress),
            ElevatedButton(child: const Text("Obtener ubicacion"), onPressed: () {
                _getCurrentLocation();
              },
            ),
        ],
      ),),
    );
  }

  //LOGICA DE CODIGO QR
  void scanQR() async {
      try {
        final qrCode = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
        if (!mounted) return;
        setState(() {
          getResult = qrCode;
        });
        print("Su hora de Entrada es: $qrCode");
    } on PlatformException {
      getResult = "Failed to get platform version.";
    }
  }
  //lOGICA DE LOCALIZACION
  _getCurrentLocation() async{
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAdressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }
  _getAdressFromLatLng()async{
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude, 
        _currentPosition.longitude
      );

      Placemark place = placemarks[0];
      setState(() {
        _currentAdress="${place.locality}, ${place.postalCode}, ${place.country}";
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Position>('_currentPosition', _currentPosition));
  }
  //ALERT DIALOG
  void _alertDialog(){
    showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        title: const Text("Error!"),
        content: const Text("Ubicacion no permitida, vaya a la zona designada"),
        actions: <Widget>[
          TextButton(child: const Text("OK"), onPressed: (){Navigator.of(context).pop();}
          ,)
        ],
      );
    });
  }
}