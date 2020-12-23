import 'package:covid19_ui/screens/home/screen_header.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/utils/fade_animation.dart';
import 'package:covid19_ui/widgets/attestation_card.dart';
import 'package:covid19_ui/widgets/box_panel.dart';
import 'package:covid19_ui/widgets/tousanticovid_banner.dart';
import 'package:covid19_ui/widgets/users_all_duplicate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../choose_user.dart';
import '../forms/add_form.dart';

class HomeScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static AllUsersDuplicateState allUsersDuplicateState;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    allUsersDuplicateState = AllUsersDuplicateState(_scaffoldKey);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(
                  1,
                  ScreenHeader('Covido - Votre utilitaire Covid-19',
                      "Cette application n'est pas affilié au gouvernement français.")),
              SizedBox(height: kSpacingUnit * 3),
              FadeAnimation(1.2, CovidBanner()),
              SizedBox(height: kSpacingUnit * 3),
              FadeAnimation(1.4, _textPart('Attestations', true)),
              FadeAnimation(
                1.4,
                Container(
                  height: kSpacingUnit * 17,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      top: kSpacingUnit * 2,
                      bottom: kSpacingUnit * 4,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: kSpacingUnit * 3),
                      SymptomCard(
                        assetUrl: 'assets/icons/trekking.svg',
                        title: 'Attestation\ndéplacement',
                        description: 'Cliquez pour générer votre attestation',
                        callback: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context1) => ChooseUser(_scaffoldKey))),
                      ),
                      SizedBox(width: kSpacingUnit * 3),
                      SymptomCard(
                        assetUrl: 'assets/icons/moon.svg',
                        title: 'Attestation\ncouvre-feu',
                        description: 'Cliquer pour générer votre attestation',
                        callback: () => {

                        },
                      ),
                      SizedBox(width: kSpacingUnit * 3),
                    ],
                  ),
                ),
              ),
              FadeAnimation(
                1.6,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSpacingUnit * 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Fonctions supplémentaire',
                        style: kTitleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kSpacingUnit * 2),
              FadeAnimation(
                1.6,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kSpacingUnit * 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _customBoxPanel(
                          'assets/icons/follow.svg',
                          () => Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context1) => AddFormScreen(_scaffoldKey, allUsersDuplicateState)))),
                      _customBoxPanel(
                          'assets/icons/stay_home.svg',
                          () => {
                                print('Ouverture des 2'),
                              }),
                      _customBoxPanel(
                          'assets/icons/information.svg',
                          () => {
                                print('Ouverture des 3'),
                              }),
                      _customBoxPanel(
                          'assets/icons/settings.svg',
                          () => {
                                print('Ouverture des paramètres'),
                              }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kSpacingUnit * 4),
              FadeAnimation(1.8, _textPart('Utilisateurs enregistré', true)),
              FadeAnimation(1.8, AllUsersDuplicate(_scaffoldKey, allUsersDuplicateState)),
            ],
          ),
        ),
      ),
    );
  }

  BoxPanel _customBoxPanel(String path, GestureTapCallback callbackAction) {
    return BoxPanel(
      padding: EdgeInsets.all(kSpacingUnit),
      child: InkWell(
        onTap: callbackAction,
        child: SvgPicture.asset(
          path,
          width: kSpacingUnit * 4,
          height: kSpacingUnit * 4,
        ),
      ),
    );
  }

  Padding _textPart(String text, bool seeAll) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpacingUnit * 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: kTitleTextStyle,
          ),
          Text(
            'Rafraîchir',
            style: kBodyTextStyle.copyWith(
              color: kSecondaryTextColor,
            ),
          )
        ],
      ),
    );
  }
}
