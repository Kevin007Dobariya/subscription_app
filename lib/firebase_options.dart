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
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBWJk6xONfyjkhTQqRcpJuNAfM2NnFDrw0',
    appId: '1:888531646889:web:3880c8cbbabf73db4aecb8',
    messagingSenderId: '888531646889',
    projectId: 'juicesubscription-394a3',
    authDomain: 'juicesubscription-394a3.firebaseapp.com',
    databaseURL: 'https://juicesubscription-394a3-default-rtdb.firebaseio.com',
    storageBucket: 'juicesubscription-394a3.appspot.com',
    measurementId: 'G-MWWCXDE0Z4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_DF8EWuzX3EC7FTchtGHSWfDGI2NV1BI',
    appId: '1:888531646889:android:447ce0799a5eb1984aecb8',
    messagingSenderId: '888531646889',
    projectId: 'juicesubscription-394a3',
    databaseURL: 'https://juicesubscription-394a3-default-rtdb.firebaseio.com',
    storageBucket: 'juicesubscription-394a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBw7YWa5rBpeLcpMUaiEetk-fzmRseIg1A',
    appId: '1:888531646889:ios:069c8997d5e673414aecb8',
    messagingSenderId: '888531646889',
    projectId: 'juicesubscription-394a3',
    databaseURL: 'https://juicesubscription-394a3-default-rtdb.firebaseio.com',
    storageBucket: 'juicesubscription-394a3.appspot.com',
    iosBundleId: 'com.example.pVj',
  );
}
