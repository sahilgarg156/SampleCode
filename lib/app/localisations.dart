import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nlsapp/l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  // Localisations
  String get appTitle => Intl.message('Netball LiveScores',
      name: 'appTitle', desc: 'The application title');

  String get errorMessage =>
      Intl.message('Oops, something went wrong. Please, try again later.',
          name: 'errorMessage', desc: 'Generic error message');

  String get buttonTryAgain => Intl.message('Try again',
      name: 'buttonTryAgain', desc: 'Title of try again button');

  // Home
  String get headingLiveScores => Intl.message('Live Scores',
      name: 'headingLiveScores', desc: 'Heading for Live Scores section');

  String get buttonLive =>
      Intl.message('Live', name: 'buttonLive', desc: 'Title for Live button');

  String get buttonUpcoming => Intl.message('Upcoming',
      name: 'buttonUpcoming', desc: 'Title for Upcoming button');

  String get buttonPlayed => Intl.message('Played',
      name: 'buttonPlayed', desc: 'Title for Played button');

  String get welcomeBack => Intl.message('Welcome back!',
      name: 'welcomeBack', desc: 'Welcome back message');

  String heyUsername(String username) => Intl.message(
        'Hey $username',
        args: [username],
        name: 'heyUsername',
        desc: 'Username greeting',
      );

  String get yourSchedule => Intl.message('Your Schedule',
      name: 'yourSchedule', desc: 'Title for your schedule header');

  String get warningScorerNotSet => Intl.message('Scorer not set',
      name: 'warningScorerNotSet', desc: 'Warning when scorer is not set');

  // ------ Schedule ------
  String get actionManaging => Intl.message('Managing',
      name: 'actionManaging', desc: 'Title for managing action');

  String get actionPlaying => Intl.message('Playing',
      name: 'actionPlaying', desc: 'Title for playing action');

  String get actionUmpiring => Intl.message('Umpiring',
      name: 'actionUmpiring', desc: 'Title for umpiring action');

  String get actionScoring => Intl.message('Scoring',
      name: 'actionScoring', desc: 'Title for scoring action');

  String get statusYes => Intl.message('Yes',
      name: 'statusYes', desc: 'Title for Yes roster status');

  String get statusNo =>
      Intl.message('No', name: 'statusNo', desc: 'Title for No roster status');

  String get statusMaybe => Intl.message('Maybe',
      name: 'statusMaybe', desc: 'Title for Maybe roster status');

  String get statusLate => Intl.message('Late',
      name: 'statusLate', desc: 'Title for Late roster status');

  String get promptConfirmStatus => Intl.message('Confirm your attendance',
      name: 'promptConfirmStatus', desc: 'Prompt under status choice');

  // ------ Watchlist ------
  String get titleWatchlist => Intl.message('Edit watchlist',
      name: 'titleWatchlist', desc: 'Title for Watchlist screen');

  String get buttonAddToWatchlist => Intl.message('Add to your watchlist...',
      name: 'buttonAddToWatchlist',
      desc: 'Title of button to open add to watchlist');

  String get tabPlayers => Intl.message('Players',
      name: 'tabPlayers', desc: 'Title for Players tab');

  String get tabTeamsClubs => Intl.message('Teams & Clubs',
      name: 'tabTeamsClubs', desc: 'Title for Teams and Clubs tab');

  String get labelAdded =>
      Intl.message('Added', name: 'labelAdded', desc: 'Title for Added label');

  String get labelTypeInSearchField => Intl.message('',
      name: 'labelTypeInSearchField',
      desc: 'Text shown at the start of the search');

  String get labelNoResults => Intl.message('No results found',
      name: 'labelNoResults',
      desc: 'Text shown when search give empty results');

  String get hintSearchCompetitions => Intl.message('Find a competition...',
      name: 'hintSearchCompetitions',
      desc: 'Hint for a search field on the first step of watch list search');

  String get hintSearchPlayers => Intl.message('Search for players...',
      name: 'hintSearchPlayers',
      desc: 'Hint for a search field when Players tab is selected');

  String get hintSearchTeamsClubs =>
      Intl.message('Search for teams and clubs...',
          name: 'hintSearchTeamsClubs',
          desc: 'Hint for a search field when Teams & Clubs tab is selected');

  String buttonAddObjectsToWatchlist(int count) =>
      Intl.message('Add $count items to watchlist',
          args: [count],
          name: 'buttonAddObjectsToWatchlist',
          desc: 'Title for add to watchlist button');

  // ------ Account Screen ------
  String get headingCreateAccount => Intl.message('Create an Account',
      name: 'headingCreateAccount', desc: 'Heading for account creation page');

  String get descriptionCreateAccount => Intl.message(
      'Live score a game, '
      'manage your schedule, communicate with your team mates and '
      'administration officials, upload teams photos and so much more.',
      name: 'descriptionCreateAccount',
      desc: 'Description for account creation page');

  String get buttonAboutUs => Intl.message('About Us',
      name: 'buttonAboutUs', desc: 'Title for About Us button');

  String get buttonFacebookLogin => Intl.message('Continue with Facebook',
      name: 'buttonFacebookLogin', desc: 'Title for facebook login button');

  String get buttonGoogleLogin => Intl.message('Continue with Google',
      name: 'buttonGoogleLogin', desc: 'Title for google login button');

  String get buttonEmailLogin => Intl.message('Sign up with your email',
      name: 'buttonEmailLogin', desc: 'Title for signing up with email');

  String get titleAlreadyHaveAccount =>
      Intl.message('Already have an account? ',
          name: 'titleAlreadyHaveAccount',
          desc: 'Title for already have an account');

  String get titleLogBackIn => Intl.message('Log back in',
      name: 'titleLogBackIn', desc: 'Title for log back in');

  // ------ Account Sign Up / Log In ------
  String get titleSignUpPage => Intl.message('Sign Up',
      name: 'titleSignUpPage', desc: 'Title of the page sign up');

  String get titleLogInPage => Intl.message('Log In',
      name: 'titleLogInPage', desc: 'Title of the page log in');

  String get titleEmail =>
      Intl.message('Email', name: 'titleEmail', desc: 'Title for email field');

  String get titlePassword => Intl.message('Password',
      name: 'titlePassword', desc: 'Title for password field');

  String get titleReTypePassword => Intl.message('Re-type Password',
      name: 'titleReTypePassword', desc: 'Title for retype password field');

  String get descriptionPasswordHelper => Intl.message('At least 8 characters',
      name: 'descriptionPasswordHelper',
      desc: 'Description for password helper');

  String get titleForgotPassword => Intl.message('Forgot your password?',
      name: 'titleForgotPassword', desc: 'Title for forgot your password');

  String get titleForgotPasswordValidationError => Intl.message(
      "To reset your password, enter your email address in the supplied field then tap 'Forgot your password'",
      name: 'titleForgotPasswordValidationError',
      desc: 'Title for forgot your password not valid email field');

  String get titleFirstName => Intl.message('First Name',
      name: 'titleFirstName', desc: 'Title for first name field');

  String get titleLastName => Intl.message('Last Name',
      name: 'titleLastName', desc: 'Title for last name field');

  String get titleDOB =>
      Intl.message('DOB', name: 'titleDOB', desc: 'Title for dob field');

  String get titleGender => Intl.message('Gender',
      name: 'titleGender', desc: 'Title for gender field');

  String get titleMobile => Intl.message('Mobile',
      name: 'titleMobile', desc: 'Title for mobile field');

  String get descriptionMobileHelper =>
      Intl.message('This is used to identify you.',
          name: 'descriptionMobileHelper',
          desc: 'Description for mobile helper');

  String get buttonLogIn => Intl.message('Log In',
      name: 'buttonLogIn', desc: 'Title for log in button');

  String get buttonSignUp => Intl.message('Sign Up',
      name: 'buttonSignUp', desc: 'Title for sign up button');

  String get textTermsAndConditions => Intl.message('Terms & Conditions',
      name: 'titleTermsAndConditions', desc: 'Terms & conditions page open');

  String get titleSignUpTermsConditionsCaption =>
      Intl.message('By signing up you agree to our ',
          name: 'titleSignUpTermsConditionsCaption',
          desc: 'Title of text By signing up you agree to our.. of signup');

  String get titleMarketingOptln => Intl.message(
      'Would you like to receive special offers from our sponsors including '
      'FREE & or discounted items, prize giveaways, news etc',
      name: 'titleMarketingOptln',
      desc: 'Title of checkbox item marketing optln');

  String get titleBottomSheetGender => Intl.message('Select Gender',
      name: 'titleBottomSheetGender',
      desc: 'Title of the bottom sheet for selection of gender');

  // ------ Terms and Conditions ------
  String get somethingWentWrong => Intl.message('Something went wrong!',
      name: 'somethingWentWrong', desc: 'Error Message');

  String get titleTermsAndConditions => Intl.message('Terms and conditions',
      name: 'titleTermsAndConditions',
      desc: 'Title of the page Terms and conditions');

  String get tryAgain => Intl.message('Try Again',
      name: 'tryAgain', desc: 'Title for Try Again button');

  // ------ More ------
  String get titleMorePage => Intl.message('More',
      name: 'titleMorePage', desc: 'Title of the page more');

  String get listTileTitleShareApp => Intl.message('Share App',
      name: 'listTileTitleShareApp',
      desc: 'Title for the list tile option Share App');

  String get listTileTitleLogOut => Intl.message('Log Out',
      name: 'listTileTitleLogOut',
      desc: 'Title for the list tile option log out');

  String get messageLogOut => Intl.message('Do you really want to logout?',
      name: 'messageLogOut', desc: 'Message shown in logout prompt');

  String get buttonLogOut => Intl.message('Yes, log out',
      name: 'buttonLogOut', desc: 'Title of logout button');

  // ------ Scoring ------
  String get titleGameEmpiresNotSet => Intl.message('Game umpires not set',
      name: 'titleGameEmpiresNotSet',
      desc: 'Title for the empires not set for game alert');

  String get titleGameAttendanceNotSet =>
      Intl.message('Player attendance not set',
          name: 'titleGameAttendanceNotSet',
          desc: 'Title for the attendance not set for game alert');

  String get titleStartsIn => Intl.message('STARTS IN',
      name: 'titleStartsIn',
      desc: 'Title for the remaining time for the match to start');

  String get infoTimeStillToSetGameRelated => Intl.message(
      'Scoring, Team '
      'Attendance and Umpire screens cannot be accessed until 30mins prior '
      'to the game start time.',
      name: 'infoTimeStillToSetGameRelated',
      desc: 'Information for time still greater than 30 mins to set game '
          'scores, umpires and players');

  String get titleAlertScoreDown => Intl.message('Score Down',
      name: 'titleAlertScoreDown',
      desc: 'Title for the alert dialog while score down');

  String messageAlertScoreDown(String teamName) => Intl.message(
        'Please confirm you want to score $teamName down to ',
        args: [teamName],
        name: 'messageAlertScoreDown',
        desc: 'Message of the alert dialog for score down',
      );

  String titleHalfNumber(int value) => Intl.message(
        'Half: $value',
        args: [value],
        name: 'titleHalfNumber',
        desc: 'Title for the match half number',
      );

  String titleQuarterNumber(int value) => Intl.message(
        'Qtr: $value',
        args: [value],
        name: 'titleQuarterNumber',
        desc: 'Title for the match quarter number',
      );

  String titleBreakNumber(int value) => Intl.message(
        'Break: $value',
        args: [value],
        name: 'titleBreakNumber',
        desc: 'Title for the match break number',
      );

  String get titleMatchEnded => Intl.message('Ended',
      name: 'titleMatchEnded', desc: 'Title for the match complete');

  String get buttonAcceptScores => Intl.message('Accept Scores',
      name: 'buttonAcceptScores', desc: 'Title of accept scores button');

  String get buttonStart =>
      Intl.message('Start', name: 'buttonStart', desc: 'Title of start button');

  String get buttonPause =>
      Intl.message('Pause', name: 'buttonPause', desc: 'Title of pause button');

  String get buttonResume => Intl.message('Resume',
      name: 'buttonResume', desc: 'Title of resume button');

  String messageAlertConfirmScore(String value) => Intl.message(
      'Confirm $value score?',
      args: [value],
      name: 'messageAlertConfirmScore',
      desc: 'Message of the alert dialog for confirming time tracking scores');

  String get messageStaticFirstQuarter => Intl.message('1st quarter',
      name: 'messageStaticFirstQuarter',
      desc: '1st quarter value we show in the messageAlertConfirmScore');

  String get messageStaticHalfTime => Intl.message('half-time',
      name: 'messageStaticHalfTime',
      desc: 'Half-time value we show in the messageAlertConfirmScore');

  String get messageStaticThirdQuarter => Intl.message('3rd quarter',
      name: 'messageStaticThirdQuarter',
      desc: '3rd quarter value we show in the messageAlertConfirmScore');

  String get messageAlertAttendanceChanged =>
      Intl.message('Have your attendances changed?',
          name: 'messageAlertAttendanceChanged',
          desc: 'Message of the alert dialog for checking attendance change');

  // ------ Common ------
  String get hintTextEnter => Intl.message('Enter...',
      name: 'hintTextEnter', desc: 'Hint text enter for a field');

  String get hintTextSelect => Intl.message('Select...',
      name: 'hintTextSelect', desc: 'Hint text select for a field');

  String get buttonDone =>
      Intl.message('Done', name: 'buttonDone', desc: 'Title for Done button');

  String get buttonCancel => Intl.message('Cancel',
      name: 'buttonCancel', desc: 'Title for cancel button');

  String get buttonOk =>
      Intl.message('Ok', name: 'buttonOk', desc: 'Title for ok button');

  String get buttonConfirm => Intl.message('Confirm',
      name: 'buttonConfirm', desc: 'Title for confirm button');

  // ------ Assign Umpires ------
  String get titleAssignUmpires => Intl.message('Assign Umpires',
      name: 'titleAssignUmpires', desc: 'Title of the Assign Umpires');

  String get titleUmpire1 => Intl.message('Umpire 1',
      name: 'titleAssignUmpire2', desc: 'Title of the Assign Umpire1');

  String get titleClub => Intl.message('Club',
      name: 'titleAssignUmpire2', desc: 'Title of the Assign Umpire1');

  String get titleUmpire2 => Intl.message('Umpire 2',
      name: 'titleAssignUmpire2', desc: 'Title of the Assign Umpire2');

  String get titleUmpireName => Intl.message('Name',
      name: 'titleAssignUmpireName', desc: 'Title of the Assign Umpire Name');

  String get buttonConfirmUmpires => Intl.message('Confirm Umpires',
      name: 'buttonConfirmUmpires', desc: 'Title for Confirm Umpires button');

  String get textEnterYourName => Intl.message('Enter your name...',
      name: 'textEnterYourName', desc: 'Title for Enter your name');

  String get messageNoNetwork => Intl.message(
      'Please check your network and try again',
      name: 'messageNoNetwork',
      desc: 'Message which we will show when there is no network connectivity');

  String get buttonYes =>
      Intl.message('Yes', name: 'buttonYes', desc: 'Title for yes button');

  String get buttonNo =>
      Intl.message('No', name: 'buttonNo', desc: 'Title for no button');

  // ------ Team Attendance ------
  String get titleTeamAttendancePage => Intl.message('Attendance',
      name: 'titleTeamAttendancePage',
      desc: 'Title of the Team Attendance Page');

  String get titleConfirmPosition => Intl.message('Confirm position',
      name: 'titleConfirmPosition',
      desc: 'Title of Confirm position in Team Attendance Page');

  String get titleValidatedBy => Intl.message('Validated by',
      name: 'titleValidatedBy',
      desc: 'Title of Validated By in Team Attendance Page');

  String get titleEnterYourName => Intl.message('Enter your name...',
      name: 'titleEnterYourName',
      desc: 'Title of Enter Your Name in Team Attendance Page');

  String get titleAddPlayer => Intl.message('Add a player',
      name: 'titleAddPlayer',
      desc: 'Title of Add Player in Team Attendance Page');

  String get titleConfirmTeam2 => Intl.message('Confirm Team 2',
      name: 'titleConfirmTeam2',
      desc: 'Title of Confirm Team 2 in Team Attendance Page');

  // ------ Game settings ------
  String get titleGameSettings => Intl.message('Game Settings',
      name: 'titleGameSettings', desc: 'Title of the Game Settings');

  String get titleTeamAttendance => Intl.message('Team Attendances',
      name: 'titleTeamAttendance', desc: 'Title of the Team Attendance');

  String get titleGameUmpires => Intl.message('Game Umpires',
      name: 'titleGameUmpires', desc: 'Title of the Game Umpires');

  String get titlePlayers => Intl.message('Players',
      name: 'titlePlayers', desc: 'Title of the Players');

  String get titleCoaches => Intl.message('Coaches',
      name: 'titleCoaches', desc: 'Title of the Coaches');

  String get titleUmpires => Intl.message('Umpires',
      name: 'titleUmpires', desc: 'Title of the Umpires');

  String get titleScorers => Intl.message('Scorers',
      name: 'titleScorers', desc: 'Title of the Scorers');

  String get titleRecordStatistics => Intl.message('Record Statistics',
      name: 'titleRecordStatistics', desc: 'Title of the Record Statistics');

  String get titleScoreBreakdown => Intl.message('Score Breakdown',
      name: 'titleScoreBreakdown', desc: 'Title of the Score Breakdown');

  String get titleGameLocation => Intl.message('Game Location',
      name: 'titleGameLocation', desc: 'Title of the Game Location');

  String get titleReportIncident => Intl.message('Report Incident',
      name: 'titleReportIncident', desc: 'Title of the Report Incident');

  String get titleRestartMatch => Intl.message('Restart Match',
      name: 'titleRestartMatch', desc: 'Title of the restart match');

  String get titleRestartMatchInMinutes => Intl.message('Restart in 5 Min',
      name: 'titleRestartMatchInMinutes',
      desc: 'Title of the restart match in 5 minutes');

  // ----- Assign scorer -----
  String get titleAssignScorer => Intl.message('Assign Scorer',
      name: 'titleAssignScorer',
      desc: 'Title of assign scorer screen');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
