//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:qr_proyect/firebase_options.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final  FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) { 
      setState(() {
        _user=event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesion con Google")
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
  Widget __userInfo(){
    return const SizedBox();
  }

  void _handleGoogleSignIn(){
    try{
      GoogleAuthProvider _GoogleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_GoogleAuthProvider);
    }catch(error){
      print(error);
    }
  }
}

