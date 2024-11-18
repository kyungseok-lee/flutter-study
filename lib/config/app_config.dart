import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late DatabaseConfig databaseConfig;
  static late String apiBaseUrl;
  static late bool isProduction;

  AppConfig._();

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");

    databaseConfig = DatabaseConfig.fromEnv();
    apiBaseUrl = dotenv.env['API_BASE_URL']!;
    isProduction = dotenv.env['ENVIRONMENT'] == 'production';
  }
}

class FirebaseConfig {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String authDomain;
  final String storageBucket;
  final String measurementId;

  const FirebaseConfig({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.authDomain,
    required this.storageBucket,
    required this.measurementId,
  });
}

class DatabaseConfig {
  final String host;
  final int port;
  final String username;
  final String password;

  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
  });

  factory DatabaseConfig.fromEnv() {
    return DatabaseConfig(
      host: dotenv.env['DB_HOST']!,
      port: int.parse(dotenv.env['DB_PORT']!),
      username: dotenv.env['DB_USERNAME']!,
      password: dotenv.env['DB_PASSWORD']!,
    );
  }
}
