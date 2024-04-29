//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_proyect/pages/qr_screen.dart';
//import 'package:qr_proyect/firebase_options.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final  FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  User? _user;
  
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) { 
      setState(() {
        _user=event;
      });
    });
    _autostart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesion")
      ),
      body: _user != null ? __userInfo(): _googleSignInButtom(),
    );
  }

  Widget _googleSignInButtom(){
    return Center(child: SizedBox(
      height: 50,
      child: SignInButton(Buttons.google, text:"Iniciar Sesion", onPressed: _handleGoogleSignIn
      ),
    ),);
  }
 // widget _signoutButton(){
   // return Center(child:,)
  //}
  Widget __userInfo(){
    return const SizedBox();
  }

  void _handleGoogleSignIn(){
    try{
      GoogleAuthProvider _GoogleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_GoogleAuthProvider);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => const QrScreen()));
    }catch(error){
      print(error);
    }
  }
  void _autostart(){
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QrScreen()));
      }
    });
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
      appBar: AppBar (
        title: const Text('Ubicacion actual'),
      ), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("LAT: ${_currentPosition.latitude}, LNG:${_currentPosition.longitude}"),
            ElevatedButton(child: const Text("Obtener ubicacion"), onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
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