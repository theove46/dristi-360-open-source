import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor {
  dev,
  test,
  staging,
  prod;

  @override
  toString() {
    switch (this) {
      case AppFlavor.dev:
        return 'Dev';
      case AppFlavor.test:
        return 'Test';
      case AppFlavor.staging:
        return 'Staging';
      case AppFlavor.prod:
        return 'Prod';
    }
  }
}

class F {
  static AppFlavor? appFlavor;

  static String get name => appFlavor?.toString() ?? '';

  static Future<void> loadEnvironment() async {
    String fileName = 'env/';
    switch (appFlavor) {
      case AppFlavor.dev:
        fileName += '.env.dev';
        break;
      case AppFlavor.test:
        fileName += '.env.test';
        break;
      case AppFlavor.staging:
        fileName += '.env.staging';
        break;
      case AppFlavor.prod:
        fileName += '.env.prod';
        break;
      default:
        fileName += '.env';
    }
    await dotenv.load(fileName: fileName);
  }
}
