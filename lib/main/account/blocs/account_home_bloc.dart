import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:nlsapp/api/models/user_response.dart';
import 'package:nlsapp/api/user_repo.dart';
import 'package:nlsapp/base/bloc/load_data_bloc.dart';

// DATA INPUT
class AccountHomeInput {
  final String accessToken;

  AccountHomeInput({@required this.accessToken}) : assert(accessToken != null);
}

// DATA OUTPUT
class AccountHomeOutput {
  final UserResponse userResponse;
  final int responseCode;

  AccountHomeOutput({@required this.userResponse, @required this.responseCode});
}

// EVENTS
class AccountHomeResetEvent extends LoadDataEvent {}

// Bloc
class AccountHomeBloc extends LoadDataBloc<AccountHomeInput, AccountHomeOutput> {
  final UserRepository userRepository;
  final Logger _log = Logger('AccountHomeBloc');

  AccountHomeBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  Future<AccountHomeOutput> loadData(AccountHomeInput input) async {
    _log.info('Calling home facebook signUp');
    AccountHomeOutput accountHomeOutput = await userRepository.signUpWithFacebook(accessToken: input.accessToken);

    return AccountHomeOutput(userResponse:accountHomeOutput.userResponse,responseCode:accountHomeOutput.responseCode);
  }

  @override
  Stream<LoadedState<AccountHomeInput, AccountHomeOutput>> mapEventToState(
      LoadDataEvent event) async* {
    if (event is AccountHomeResetEvent) {
      yield LoadedState.empty();
    } else {
      yield* super.mapEventToState(event);
    }
  }
}
