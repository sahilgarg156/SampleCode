import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nlsapp/account/login/page/login_page.dart';
import 'package:nlsapp/account/signup/page/signup_page.dart';
import 'package:nlsapp/account/termsconditions/page/terms_and_conditions_page.dart';
import 'package:nlsapp/api/models/game_match.dart';
import 'package:nlsapp/app/app_bloc.dart';
import 'package:nlsapp/app/app_event.dart';
import 'package:nlsapp/app/localisations.dart';
import 'package:nlsapp/main/app_container.dart';
import 'package:nlsapp/main/app_tab_bloc.dart';
import 'package:nlsapp/main/assignscorer/page/assign_scorer_page.dart';
import 'package:nlsapp/main/assignumpires/page/assign_umpires_page.dart';
import 'package:nlsapp/main/home/home_bloc.dart';
import 'package:nlsapp/main/home/watchlist/watchlist_page.dart';
import 'package:nlsapp/main/home/watchlist/watchlist_search_page.dart';
import 'package:nlsapp/routes.dart';
import 'package:nlsapp/scores/gamesettings/page/game_settings_page.dart';
import 'package:nlsapp/scores/scoring/page/scoring_page.dart';
import 'package:nlsapp/scores/teamattendance/page/team_attendance_page.dart';
import 'package:nlsapp/theme/palette.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/// This Widget is the main application widget.
class NlsApp extends StatelessWidget {
  static double _maxTextScaleFactor = 1.15;

  final AppBloc appBloc;
  final AppTabBloc appTabBloc;

  NlsApp({@required this.appBloc, @required this.appTabBloc});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBloc.dispatch(AppStart());
    });

    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AppBloc>(bloc: appBloc),
        BlocProvider<AppTabBloc>(bloc: appTabBloc),
      ],
      child: MaterialApp(
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            child: child,
            data: data.copyWith(
              textScaleFactor: min(data.textScaleFactor, _maxTextScaleFactor),
            ),
          );
        },
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale("en"),
        ],
        routes: {
          AppRoutes.WATCHLIST: (BuildContext context) => WatchlistPage(),
          AppRoutes.WATCHLIST_SEARCH: (BuildContext context) =>
              WatchlistSearchPage(),
      //    AppRoutes.SIGN_UP: (BuildContext context) => AccountSignUp(),
          AppRoutes.LOG_IN: (BuildContext context) => AccountLogIn(),
          AppRoutes.TERMS_AND_CONDITIONS: (BuildContext context) =>
              TermsAndConditions(),
        },
        onGenerateRoute: (settings) {
          Widget screen;
          var args = settings.arguments;
          Widget loadingScreen;
          if (args is GameMatch) {
            switch (settings.name) {
              case AppRoutes.SCORES:
                screen = Scoring(
                  userId: appBloc.userData.userResponse.user.id,
                  match: args,
                );
                break;
              case AppRoutes.ASSIGN_UMPIRES:
                screen = AssignUmpiresPage(match: args);
                break;
              case AppRoutes.GAME_SETTINGS:
                screen = GameSettingsPage(match: args);
                break;
              case AppRoutes.TEAM_ATTENDANCE:
                screen = TeamAttendancePage(match: args);
                break;
            }

          }else if(args is String){
            if(settings.name == AppRoutes.SIGN_UP)
              loadingScreen = AccountSignUp(emailId: args);
          }
          if (loadingScreen != null) {
            return MaterialPageRoute(
              builder: (context) {
                return loadingScreen;
              },
            );
          } else if (args is ScheduledGameEntity) {
            switch (settings.name) {
              case AppRoutes.ASSIGN_SCORER:
                screen = AssignScorerPage(
                  entity: args,
                );
                break;
            }          }
          if (screen != null) {
            return MaterialPageRoute(
              builder: (context) => screen,
            );
          }
          return null;
        },
        navigatorObservers: [routeObserver],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).appTitle,
        theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0),
          primaryColor: Palette.primaryColor,
          primaryColorDark: Palette.primaryColorDark,
          primaryColorLight: Palette.primaryColorLight,
          primaryColorBrightness: Brightness.dark,
          cursorColor: Palette.primaryColor,
        ),
        home: AppContainerWidget(),
      ),
    );
  }
}
