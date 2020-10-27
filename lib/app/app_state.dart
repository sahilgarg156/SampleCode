import 'package:equatable/equatable.dart';
import 'package:nlsapp/api/models/user_response.dart';
import 'package:nlsapp/api/models/watchlist.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);
}

class AppStartError extends AppState {
  final dynamic error;

  AppStartError(this.error) : super([error]);
}

class AppNotStarted extends AppState {}

class AppStarted extends AppState {}

class AppWatchlistChanged extends AppState {
  final Watchlist watchlist;

  AppWatchlistChanged(this.watchlist)
      : assert(watchlist != null),
        super([watchlist]);
}

class AppUserChanged extends AppState {
  final UserData userData;

  AppUserChanged(this.userData) : super([userData]);
}
