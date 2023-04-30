// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyBClVEPaQo51VPA5kJM6I7QJGX3AAEA3YA',
    appId: '1:580855633355:web:afe196c8e2878d9489924e',
    messagingSenderId: '580855633355',
    projectId: 'fir-63719',
    authDomain: 'fir-63719.firebaseapp.com',
    storageBucket: 'fir-63719.appspot.com',
    measurementId: 'G-QD0HE11PFX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCIRAo7cxSTSY5SgqdM3-am7vCPUNZpfw',
    appId: '1:580855633355:android:bf07d91052268b5c89924e',
    messagingSenderId: '580855633355',
    projectId: 'fir-63719',
    storageBucket: 'fir-63719.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4cQ2s9x6pNJjVtuCUMKG9KZ7DXXGeMYs',
    appId: '1:580855633355:ios:aca334e4745f423389924e',
    messagingSenderId: '580855633355',
    projectId: 'fir-63719',
    storageBucket: 'fir-63719.appspot.com',
    iosClientId: '580855633355-dd7mnpujr1fnbqe41g5j40lnre10bgmn.apps.googleusercontent.com',
    iosBundleId: 'com.example.interviewPractice',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4cQ2s9x6pNJjVtuCUMKG9KZ7DXXGeMYs',
    appId: '1:580855633355:ios:aca334e4745f423389924e',
    messagingSenderId: '580855633355',
    projectId: 'fir-63719',
    storageBucket: 'fir-63719.appspot.com',
    iosClientId: '580855633355-dd7mnpujr1fnbqe41g5j40lnre10bgmn.apps.googleusercontent.com',
    iosBundleId: 'com.example.interviewPractice',
  );
}