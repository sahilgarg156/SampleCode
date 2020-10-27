import 'package:equatable/equatable.dart';
import 'package:nlsapp/api/models/user_response.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class AppStart extends AppEvent {}

class AppAddToWatchlist extends AppEvent {
  final Set<int> players;
  final Set<int> teams;
  final Set<int> clubs;

  AppAddToWatchlist({this.players, this.clubs, this.teams})
      : super([players, clubs, teams]);
}

class AppRemoveFromWatchlist extends AppEvent {
  final Set<int> players;
  final Set<int> teams;
  final Set<int> clubs;

  AppRemoveFromWatchlist({this.players, this.clubs, this.teams})
      : super([players, clubs, teams]);
}

class AppUserChangeEvent extends AppEvent {
  final UserData userData;

  AppUserChangeEvent({this.userData}) : super([userData]);
}
