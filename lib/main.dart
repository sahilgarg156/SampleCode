// Flutter code sample for material.AppBar.1

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:nlsapp/api/referense_repo.dart';
import 'package:nlsapp/api/user_repo.dart';
import 'package:nlsapp/app.dart';
import 'package:nlsapp/app/app_bloc.dart';
import 'package:nlsapp/base/http/custom_http_client.dart';
import 'package:nlsapp/base/utility/play_buzzer_utility.dart';
import 'package:nlsapp/main/app_tab_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return CustomHttpClient(client: super.createHttpClient(context));
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  HttpOverrides.global = CustomHttpOverrides();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print(
        '[${rec.level.name}][${rec.time}][${rec.loggerName}]: ${rec.message}');
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SharedPreferences.getInstance().then((preferences) {
      runApp(NlsApp(
        appBloc: AppBloc(
          preferences: preferences,
          referenceRepository: ReferenceRepository(),
          userRepository: UserRepository(),
        ),
        appTabBloc: AppTabBloc(),
      ));
    });
  });

  //TODO: This is hard code we will changes do to later
  PlayBuzzerCacheManager _playBuzzerCacheManager =  PlayBuzzerCacheManager();
  _playBuzzerCacheManager.loadMusic();
}
