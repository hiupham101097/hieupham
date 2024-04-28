// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';

// class DefaultFirebaseConfig {
//   static FirebaseOptions? get platformOptions {
//     if (kIsWeb) {
//       // Web
//       return const FirebaseOptions(
//         apiKey: 'AIzaSyCnyScQ_LUffh6GA1AP9bumASL3--dwun4',
//         appId: '1:243388008334:web:0b650370bb29e29cac3efc',
//         messagingSenderId: '243388008334',
//         projectId: "edumobiletest",
//         storageBucket: 'edumobiletest.appspot.com',
//       );
//     } else if (Platform.isIOS || Platform.isMacOS) {
//       // iOS and MacOS
//       return const FirebaseOptions(
//         apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
//         appId: '1:243388008334:ios:cc6c1dc7a65cc83c',
//         messagingSenderId: '243388008334',
//         projectId: "edumobiletest",
//         storageBucket: 'edumobiletest.appspot.com',
//       );
//     } else {
//       // Android
//       log("Analytics Dart-only initializer doesn't work on Android, please make sure to add the config file.");

//       return null;
//     }
//   }
// }
