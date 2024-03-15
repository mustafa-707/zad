import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gleap_sdk/gleap_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/app/app.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      await _guardedInitalization();
      runApp(const ProviderScope(child: App()));
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

Future<void> _guardedInitalization() async {
  // We ensure Flutter binding is initialized here. Otherwise, calls to
  // SystemChrome will not work, for example. This is a no-op if the binding
  // is already initialized.
  WidgetsFlutterBinding.ensureInitialized();

  log('Going full screen');

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  try {
    await Firebase.initializeApp();
    if (!Platform.isWindows) {
      Gleap.initialize(token: 'CscbW4KQ5zTxqLbX3Qjd50FIA5W3HsPJ');
      if (!kIsWeb) {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
        Isolate.current.addErrorListener(
          RawReceivePort((pair) async {
            final List<dynamic> errorAndStacktrace = pair;
            await FirebaseCrashlytics.instance.recordError(
              errorAndStacktrace.first,
              errorAndStacktrace.last,
            );
          }).sendPort,
        );
      }
    }
  } catch (e) {
    log(" initializing Error: ${e.toString()}");
  }
}
