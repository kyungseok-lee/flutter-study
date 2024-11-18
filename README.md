# Flutter Study

## Firebase

1. Firebase 프로젝트 생성
- Firebase Console에서 프로젝트 생성

2. Firebase SDK 설정

```sheel
export PATH="$PATH":"$HOME/.pub-cache/bin"
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
flutter pub add firebase_core
```

3. 설정 완료 시 Firebase Console에서 생성 된 App 확인 가능

4. ignore 된 생성 파일 목록
```shell
android/app/google-services.json
ios/Podfile
firebase.json
```

## iOS 설정 오류 수정
1. ios/Podfile 수정
```shell
# 최 상단 해당 구문 추가
platform :ios, '13.0'
```

2. pod install
```shell
cd ios
pod install
```

3. rebuild
```shell
flutter clean
flutter run
```

## Logger
- logger 설치
```shell
flutter pub add logger
```

- 사용 예시
```dart
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void main() {
  print('Run with either `dart example/main.dart` or `dart --enable-asserts example/main.dart`.');
  demo();
}

void demo() {
  logger.d('Log message with 2 methods');
  loggerNoStack.i('Info message');
  loggerNoStack.w('Just a warning!');
  logger.e('Error! Something bad happened', error: 'Test Error');
  loggerNoStack.t({'key': 5, 'value': 'something'});
  Logger(printer: SimplePrinter(colors: true)).t('boom');
}
```

## ENV (Secret)
- flutter_dotenv 설치
```shell
flutter pub add flutter_dotenv
```

- 사용 예시
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env", mergeWith: {
    'TEST_VAR': '5',
  }); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_dotenv Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dotenv Demo'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: rootBundle.loadString('assets/.env'),
            initialData: '',
            builder: (context, snapshot) => Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Text(
                    'Env map: ${dotenv.env.toString()}',
                  ),
                  const Divider(thickness: 5),
                  const Text('Original'),
                  const Divider(),
                  Text(snapshot.data ?? ''),
                  Text(dotenv.get('MISSING',
                      fallback: 'Default fallback value')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```