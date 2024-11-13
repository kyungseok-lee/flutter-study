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
```shell
flutter pub add logger
```

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
TODO: ENV (Secret) 작성 중