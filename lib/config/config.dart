import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static late ENV env;
  static late Firebase firebase;

  Config._();

  static Future<void> load() async {
    await dotenv.load(fileName: "assets/env/.env");

    env = ENV.values.firstWhere(
        (e) => e.toString().split('.').last == dotenv.env['ENVIRONMENT']!);

    firebase = Firebase(
      web: FirebaseWeb(
        apiKey: dotenv.env['FIREBASE_WEB_API_KEY']!,
        appId: dotenv.env['FIREBASE_WEB_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_WEB_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_WEB_PROJECT_ID']!,
        authDomain: dotenv.env['FIREBASE_WEB_AUTH_DOMAIN']!,
        storageBucket: dotenv.env['FIREBASE_WEB_STORAGE_BUCKET']!,
        measurementId: dotenv.env['FIREBASE_WEB_MEASUREMENT_ID']!,
      ),
      android: FirebaseAndroid(
        apiKey: dotenv.env['FIREBASE_ANDROID_API_KEY']!,
        appId: dotenv.env['FIREBASE_ANDROID_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_ANDROID_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_ANDROID_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_ANDROID_STORAGE_BUCKET']!,
      ),
      ios: FirebaseIOS(
        apiKey: dotenv.env['FIREBASE_IOS_API_KEY']!,
        appId: dotenv.env['FIREBASE_IOS_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_IOS_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_IOS_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_IOS_STORAGE_BUCKET']!,
        iosBundleId: dotenv.env['FIREBASE_IOS_IOS_BUNDLE_ID']!,
      ),
    );
  }
}

enum ENV {
  development,
  production,
}

class Firebase {
  final FirebaseWeb web;
  final FirebaseAndroid android;
  final FirebaseIOS ios;

  const Firebase({
    required this.web,
    required this.android,
    required this.ios,
  });
}

class FirebaseWeb {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String authDomain;
  final String storageBucket;
  final String measurementId;

  const FirebaseWeb({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.authDomain,
    required this.storageBucket,
    required this.measurementId,
  });
}

class FirebaseAndroid {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String storageBucket;

  const FirebaseAndroid({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.storageBucket,
  });
}

class FirebaseIOS {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String storageBucket;
  final String iosBundleId;

  const FirebaseIOS({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.storageBucket,
    required this.iosBundleId,
  });
}
