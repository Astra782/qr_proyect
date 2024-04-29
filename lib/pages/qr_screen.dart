import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<QrScreen> {
  var getResult = "QR Code Resultado";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            scanQR();
          }, 
          child: const Text("Codigo QR"),
          ),
          SizedBox(height: 20,),
          Text(getResult)
        ],
      ),),
    );
  }
  void scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
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
}