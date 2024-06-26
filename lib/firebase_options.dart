// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD3-krCmhlwuqXc_kieRkWq7GbvmGu9l_o',
    appId: '1:382614716440:web:e68355c78a2b57be28c36d',
    messagingSenderId: '382614716440',
    projectId: 'qrproject-a2b1c',
    authDomain: 'qrproject-a2b1c.firebaseapp.com',
    storageBucket: 'qrproject-a2b1c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMqQkBf2kMOsKruPX6iEGsT1aBy1s-_0k',
    appId: '1:382614716440:android:4ec70647fd2c9e0528c36d',
    messagingSenderId: '382614716440',
    projectId: 'qrproject-a2b1c',
    storageBucket: 'qrproject-a2b1c.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD3-krCmhlwuqXc_kieRkWq7GbvmGu9l_o',
    appId: '1:382614716440:web:38547d1a8477ec6428c36d',
    messagingSenderId: '382614716440',
    projectId: 'qrproject-a2b1c',
    authDomain: 'qrproject-a2b1c.firebaseapp.com',
    storageBucket: 'qrproject-a2b1c.appspot.com',
  );

}