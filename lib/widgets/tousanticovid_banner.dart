import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class CovidBanner extends StatelessWidget {

  const CovidBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSpacingUnit * 3),
      decoration: BoxDecoration(
        color: kBlackColor,
        borderRadius: BorderRadius.circular(kSpacingUnit * 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.all(kSpacingUnit * 2).copyWith(
              right: 0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Télécharger l'application\nTousAntiCovid",
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle.copyWith(
                    fontFamily: 'SF Pro Rounded',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: kSpacingUnit * 2),
                Container(
                  height: kSpacingUnit * 4,
                  width: kSpacingUnit * 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kSpacingUnit * 3),
                  ),
                  child: InkWell(
                    onTap: () async => {
                      if (await canLaunch(tousAntiCovidURL)) {
                        await launch(tousAntiCovidURL)
                      } else {
                        Scaffold.of(context).showSnackBar(
                          new SnackBar(
                            content: new Text("Impossible d'ouvrir la page web."),
                            duration: new Duration(seconds: 3),
                            backgroundColor: Color.fromRGBO(255, 82, 82, 1),
                          ),
                        )
                      }
                    },
                    child: Center(
                      child: Text(
                        'En savoir plus',
                        style: kSubTitleTextStyle,
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/icons/tousAntiCovid.svg',
            height: kSpacingUnit * 9,
            width: kSpacingUnit * 9,
          ),
        ],
      ),
    );
  }
}
