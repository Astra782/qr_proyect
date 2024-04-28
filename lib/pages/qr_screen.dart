import "package:flutter/material.dart";

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text("Bienvenido"),),
      body: Center(
        child: ElevatedButton(child: const Text("Capturar"),
        onPressed: () {
          
        }
      ),)
    );
  }
}