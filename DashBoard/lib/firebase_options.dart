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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsp47WpCK8jxkj3upV2m1rGGWtC3jqO8E',
    appId: '1:895842378972:android:28d63458452e4eb8e60019',
    messagingSenderId: '895842378972',
    projectId: 'droos-96ed2',
    storageBucket: 'droos-96ed2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbQQgttHRUVB0WbU6tkVPOqPRlbB-r3Z4',
    appId: '1:895842378972:ios:2d7b20d69c97ceb6e60019',
    messagingSenderId: '895842378972',
    projectId: 'droos-96ed2',
    storageBucket: 'droos-96ed2.appspot.com',
    androidClientId: '895842378972-tktis0nrg1greli085njdljttqc62vs2.apps.googleusercontent.com',
    iosClientId: '895842378972-uk851nkr01dci82at2mkk15mq5mkvhfa.apps.googleusercontent.com',
    iosBundleId: 'com.example.admin',
  );
}
