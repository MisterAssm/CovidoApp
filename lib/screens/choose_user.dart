import 'package:covid19_ui/screens/pdf/pdf_generator.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/utils/fade_animation.dart';
import 'package:covid19_ui/utils/size_config.dart';
import 'package:covid19_ui/widgets/users_choose.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home/screen_header.dart';

class ChooseUser extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  ChooseUser(this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: kSpacingUnit * 2),
              FadeAnimation(
                  1,
                  ScreenHeader('Génération de votre attestation',
                      "Veuillez sélectionner la personne à qui vous voulez générer l'attestation.")),
              FadeAnimation(1.2, (UsersChoose(_scaffoldKey))),
              FadeAnimation(
                1.2,
                Container(
                  height: 7.5 * SizeConfig.heightMultiplier,
                  width: 25 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                      color: kBlackColor,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context1) => PdfViewPage())),
                      child: Text(
                        "Continuer sans utilisateur",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 2 * SizeConfig.textMultiplier),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kSpacingUnit * 0.5),
            ],
          ),
        ),
      ),
    );
  }
}
