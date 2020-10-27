import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:nlsapp/api/models/facebook_user.dart';
import 'package:nlsapp/api/user_repo.dart';
import 'package:nlsapp/app/localisations.dart';
import 'package:nlsapp/base/alertdialog/custom_alert_dialog.dart';
import 'package:nlsapp/base/angled_background.dart';
import 'package:nlsapp/base/bloc/load_data_bloc.dart';
import 'package:nlsapp/base/buttons/custom_button.dart';
import 'package:nlsapp/main/account/blocs/account_home_bloc.dart';
import 'package:nlsapp/routes.dart';
import 'package:nlsapp/theme/app_gradient.dart';
import 'package:nlsapp/theme/art.dart';
import 'package:nlsapp/theme/palette.dart';
import 'package:nlsapp/theme/styles.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

enum _AccountHomePageAction { aboutUs, facebook, google, email, logIn, none }

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class AccountHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountHomePageState();
}

class _AccountHomePageState extends State<AccountHomePage> {

  final AccountHomeBloc _accountHomeBloc =
      AccountHomeBloc(userRepository: UserRepository());

  static const double _homeDescriptionBgHeight = 424.0;
  static const double _homeDescriptionGradientHeight = 380.0;

  var facebookLogin = FacebookLogin();
  var facebookLoginResult;

  GoogleSignInAccount _currentUser;
  final Logger _log = Logger('AccountHomePage');

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {

      if (account != null) {
        //_handleGetContact();
      }
    });
  _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    _accountHomeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screenWidgets = [];
    screenWidgets.add(_getAccountHomeDescription());
    screenWidgets.add(_getFacebookButton());
    screenWidgets.add(_getGoogleButton());
    screenWidgets.add(_getEmailButton());
    screenWidgets.add(_getAlreadyHaveAccount());

    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screenWidgets,
          ),
        ),
      ),
    );
  }

  /// Returns Widget which contains Stack with background of angular gradient
  /// and details of the screen
  Widget _getAccountHomeDescription() {
    Container accountDescriptionBg = Container(
      width: double.infinity,
      height: _homeDescriptionGradientHeight,
      child: CustomPaint(
        painter: AngledBackground(isFullScreen: true),
      ),
    );

    Column accountDescription = Column(
      children: <Widget>[
        _getLogoImage(),
      ]
        ..addAll(_getScreenTitleDescription())
        ..add(_getAboutUsButton()),
    );

    return Stack(
      children: <Widget>[
        accountDescriptionBg,
        accountDescription,
      ],
    );
  }

  /// Returns Padding widget with only top padding and child containing centered
  /// Logo small image
  Padding _getLogoImage() {
    return Padding(
      // Widget with top spacing mentioned
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Image.asset(Images.ic_logo_small),
      ),
    );
  }

  /// Returns list of padding widgets which has heading and description texts of
  /// create account screen with padding accordingly
  List<Padding> _getScreenTitleDescription() {
    return [
      Padding(
        // Widget with top, left and right spacing mentioned
        padding: const EdgeInsets.only(top: 22.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context).headingCreateAccount,
            style: Styles.largeTextHeroHeading,
          ),
        ),
      ),
      Padding(
        // Widget with top, left and right spacing mentioned
        padding: const EdgeInsets.only(top: 12.0, left: 42.0, right: 42.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context).descriptionCreateAccount,
            textAlign: TextAlign.center,
            style: Styles.bodytextLarge_hero,
          ),
        ),
      ),
    ];
  }

  /// Returns Padding widget which has about us button
  Padding _getAboutUsButton() {
    return Padding(
      // Widget with top spacing mentioned
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: OutlineButton(
          onPressed: () =>
              accountHomePageOptionSelected(_AccountHomePageAction.aboutUs),
          child: Text(
            AppLocalizations.of(context).buttonAboutUs,
            style: Styles.bodytextSmall_buttonActive,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderSide: BorderSide(color: Palette.white),
          highlightedBorderColor: Palette.offWhite,
        ),
      ),
    );
  }

  /// Returns Padding widget which has continue with facebook button
  _getFacebookButton() {
    return BlocBuilder(
      bloc: _accountHomeBloc,
      builder: (BuildContext context, LoadedState state) {
        if (state.error != null) {
          CustomAlertDialog.generalAlert(
            context: context,
            error: state.error,
          ).show();
        } else if (state.data != null) {
          int result = state.data.responseCode;
          if (result == 202) {
            //get user detail and goto home page
            // UserResponse userResponse = state.data.userResponse;
          } else if (result == 203) {
            //get user email goto sign up page
            _getFacebookUserInfo(
              context,
              state.input.accessToken,
            );
          }
        }
        return Padding(
          // Widget with top, left and right spacing mentioned
          // Here top will be 64 and value is calculated like
          // In Zeplin we have gradient background size of 424 and we are giving
          // the container size for the gradient background of 380 and spacing
          // required from gradient bg is 20 so totally 20+(424-380)=64
          padding: const EdgeInsets.only(
              top: 20 +
                  (_homeDescriptionBgHeight - _homeDescriptionGradientHeight),
              left: 40.0,
              right: 40.0),
          child: ButtonTheme(
            minWidth: double.infinity,
            height: 48.0, // Button height set to 48
            child: RaisedButton(
              onPressed: () => accountHomePageOptionSelected(
                  _AccountHomePageAction.facebook),
              // Using stack here inorder to have the image to the left corner
              // and text to be center aligned
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(Images.ic_logo_facebook),
                    heightFactor: 1.6,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).buttonFacebookLogin,
                      style: Styles.button,
                    ),
                  )
                ],
              ),
              shape: _getButtonShape(),
              color: Palette.white,
              highlightColor: Palette.offWhite,
            ),
          ),
        );
      },
    );
  }

  /// Returns Padding widget which has continue with Google button
  Padding _getGoogleButton() {
    return Padding(
      // Widget with top, left and right spacing mentioned
      padding: const EdgeInsets.only(top: 16.0, left: 40.0, right: 40.0),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 48.0, // Button height set to 48
        child: RaisedButton(
          onPressed: () =>
              accountHomePageOptionSelected(_AccountHomePageAction.google),
          // Using stack here inorder to have the image to the left corner
          // and text to be center aligned
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(Images.ic_logo_google),
                heightFactor: 1.6,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).buttonGoogleLogin,
                  style: Styles.button,
                ),
              )
            ],
          ),
          shape: _getButtonShape(),
          color: Palette.white,
          highlightColor: Palette.offWhite,
        ),
      ),
    );
  }

  /// Returns Padding widget which has continue with Email button
  Padding _getEmailButton() {
    return Padding(
      // Widget with top, left and right spacing mentioned
      padding: const EdgeInsets.only(top: 16.0, left: 40.0, right: 40.0),
      child: CustomButton(
        child: Text(
          AppLocalizations.of(context).buttonEmailLogin,
          style: Styles.buttonOrTitle,
        ),
        // Gradient as per the design
        gradient: AppGradient.primary,
        radius: BorderRadius.circular(10.0),
        onPressed: () =>
            accountHomePageOptionSelected(_AccountHomePageAction.email),
      ),
    );
  }

  /// Returns RoundedRectangleBorder widget used for buttons
  RoundedRectangleBorder _getButtonShape() {
    return RoundedRectangleBorder(
      // Widget with circular radius
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  /// Returns Padding widget which has Text span with already have an account
  Padding _getAlreadyHaveAccount() {
    return Padding(
      // Widget with top and bottom spacing mentioned
      padding: const EdgeInsets.only(top: 32.0, bottom: 20.0),
      child: Center(
        child: RichText(
          text: TextSpan(
              text: AppLocalizations.of(context).titleAlreadyHaveAccount,
              style: Styles.bodytext_alertBody,
              children: [
                TextSpan(
                  text: AppLocalizations.of(context).titleLogBackIn,
                  style: Styles.bodytext_link,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => accountHomePageOptionSelected(
                        _AccountHomePageAction.logIn),
                ),
              ]),
        ),
      ),
    );
  }

  /// Based on the action event we will call the necessary steps
  void accountHomePageOptionSelected(_AccountHomePageAction actionEvent) {
    _log.info('Account home page action selection - $actionEvent');
    switch (actionEvent) {
      case _AccountHomePageAction.aboutUs:
        // TODO: Need to implement about us
        break;
      case _AccountHomePageAction.facebook:
        _initiateFacebookLogin();
        break;
      case _AccountHomePageAction.google:
        _initiateGoogleLogin();
        break;
      case _AccountHomePageAction.email:
        Navigator.of(context).pushNamed(
          AppRoutes.SIGN_UP,
          arguments: "",
        );
        break;
      case _AccountHomePageAction.logIn:
        Navigator.of(context).pushNamed(
          AppRoutes.LOG_IN,
        );
        break;
      default:
        break;
    }
  }

  // get token value from facebook
  void _initiateFacebookLogin() async {
    facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        _log.info('Error');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _log.info("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        _log.info("LoggedIn");
        saveAccessToken(facebookLoginResult.accessToken.token);
        break;
    }
  }

  void saveAccessToken(String token) {
    _accountHomeBloc.dispatch(FetchData(AccountHomeInput(accessToken: token)));
  }

  _getFacebookUserInfo(BuildContext context, String token, ) async {
    facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    final token = facebookLoginResult.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=' +
            token);

    FacebookUser user = userFromJson(graphResponse.body);

    Navigator.of(context).pushNamed(
      AppRoutes.SIGN_UP,
      arguments: user.email,
    );

    _accountHomeBloc.dispatch(AccountHomeResetEvent());
  }

  _initiateGoogleLogin() {
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        print('Signed in as ${googleKey.accessToken}');
        var googleIdToken = googleKey.accessToken;
        if (googleIdToken != null && googleIdToken.length > 1) {
          signInWithGoogleForDatabase(googleIdToken);
        }
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<Null> signInWithGoogleForDatabase(String googleIdToken) async {
    print('googleIdToken  before api calling  $googleIdToken');

    final response = await http.get(
        'https://world-sport-action-socket.appspot.com/users/loginWithGoogle?idToken=' + googleIdToken);
    if (response.statusCode == 200) {
      //User got matched ,we can call the required functionality .
      print("User exist");
    } else if (response.statusCode == 203) {
      // make another call to /users/signup
      print("User does not exist");
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

 _initiateGoogleLogin2() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      _log.info(error);
    }
  }

   _handleGetContact() async {

    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {

      _log.info('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);

  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }
}
