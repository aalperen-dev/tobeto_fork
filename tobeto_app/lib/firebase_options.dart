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
    apiKey: 'AIzaSyCz5gax5mL9r46ILBI29ucliXrljbjb6AI',
    appId: '1:85523505609:web:df3446f5c2e75cd9900818',
    messagingSenderId: '85523505609',
    projectId: 'tobetoapp-ad78a',
    authDomain: 'tobetoapp-ad78a.firebaseapp.com',
    storageBucket: 'tobetoapp-ad78a.appspot.com',
    measurementId: 'G-2VLEWH7DP2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMe9GjtK0dL0ipEDdio5I--uJkpaC-z70',
    appId: '1:85523505609:android:2690d9039a809fb7900818',
    messagingSenderId: '85523505609',
    projectId: 'tobetoapp-ad78a',
    storageBucket: 'tobetoapp-ad78a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaS3xGU3TRNlFXjRoU14SiW58x5HkCAOo',
    appId: '1:85523505609:ios:766dc45320b704a6900818',
    messagingSenderId: '85523505609',
    projectId: 'tobetoapp-ad78a',
    storageBucket: 'tobetoapp-ad78a.appspot.com',
    iosBundleId: 'com.example.tobeto',
  );
}
