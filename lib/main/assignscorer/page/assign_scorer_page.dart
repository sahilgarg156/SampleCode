import 'package:flutter/material.dart';
import 'package:nlsapp/app/localisations.dart';
import 'package:nlsapp/base/gradient_background.dart';
import 'package:nlsapp/main/home/home_bloc.dart';
import 'package:nlsapp/theme/palette.dart';
import 'package:nlsapp/theme/styles.dart';

class AssignScorerPage extends StatefulWidget {
  final ScheduledGameEntity entity;

  const AssignScorerPage({Key key, @required this.entity})
      : assert(entity != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AssignScorerPageState();
}

class _AssignScorerPageState extends State<AssignScorerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.offWhite,
      appBar: _getAppBar(),
      body: Container(),
    );
  }

  /// Returns AppBar with cross button and Game Settings page title
  AppBar _getAppBar() {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).titleAssignScorer,
        style: Styles.button_alertActive,
      ),
      centerTitle: true,
      flexibleSpace: GradientBackground(),
    );
  }
}
