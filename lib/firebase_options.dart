import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
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
    apiKey: 'AIzaSyDCvpTMOCu5oqWVy-kSpuVOSjRStAagszI',
    appId: '1:1053739865999:web:9dfd42fd31fef157fcddfa',
    messagingSenderId: '1053739865999',
    projectId: 'deep-link-bd365',
    authDomain: 'deep-link-bd365.firebaseapp.com',
    storageBucket: 'deep-link-bd365.appspot.com',
    measurementId: 'G-4H16H83NYW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwJHb8FKKXDCey_R6OmCP5wGVv3RR8A-U',
    appId: '1:1053739865999:android:38ce89f33a183fe7fcddfa',
    messagingSenderId: '1053739865999',
    projectId: 'deep-link-bd365',
    storageBucket: 'deep-link-bd365.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-xAyQG6S-PpkEUVumYj9AhoB8G0M2sL8',
    appId: '1:1053739865999:ios:f53603762d554ed0fcddfa',
    messagingSenderId: '1053739865999',
    projectId: 'deep-link-bd365',
    storageBucket: 'deep-link-bd365.appspot.com',
    iosBundleId: 'com.example.dummy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-xAyQG6S-PpkEUVumYj9AhoB8G0M2sL8',
    appId: '1:1053739865999:ios:a90449d4b2f9741efcddfa',
    messagingSenderId: '1053739865999',
    projectId: 'deep-link-bd365',
    storageBucket: 'deep-link-bd365.appspot.com',
    iosBundleId: 'com.example.dummy.RunnerTests',
  );
}
