import 'package:dristi_open_source/core/loggers/riverpod_logger.dart';
import 'package:dristi_open_source/flavors/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'flavors.dart';

Future<void> environment({required AppFlavor appFlavor}) async {
  F.appFlavor = appFlavor;
  await F.loadEnvironment();

  const requiredEnvVars = ['API_BASE_URL'];

  bool hasEnv = dotenv.isEveryDefined(requiredEnvVars);

  if (!hasEnv) {
    throw Exception('Missing required environment variables: $requiredEnvVars');
  }

  // EnvConfig prodConfig = EnvConfig(
  //   appName: TextConstants.appName,
  //   baseUrl: "${dotenv.env['API_BASE_URL']}",
  //   shouldCollectCrashLog: true,
  // );
  //
  // BuildConfig.instantiate(envType: Environment.prod, envConfig: prodConfig);
  //
  // BuildConfig.instantiate(envType: Environment.prod, envConfig: prodConfig);

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();

  runApp(ProviderScope(observers: [RiverpodLogger()], child: const App()));
}
