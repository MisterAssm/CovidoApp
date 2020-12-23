import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import 'home/screen_header.dart';

class WhatDoScreen extends StatelessWidget {
  final User data;

  WhatDoScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 10.0),
          width: double.infinity,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ScreenHeader("Que voulez-vous faire ?",
                    "Pour ajouter un nouvel utilisateur, il vous suffit de remplir le formulaire ci-dessous et d'appuyer sur le bouton 'enregistrer'"),
                SizedBox(height: kSpacingUnit * 3),
                Container(
                  height: 125,
                  padding: EdgeInsets.all(kSpacingUnit * 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadiusDirectional.circular(kSpacingUnit * 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/man.svg',
                            height: 30.sp,
                            width: 30.sp,
                          ),
                          SizedBox(width: kSpacingUnit),
                          Text(
                            'née le ${data.birthday} à ${data.placeOfBirth}',
                            style: kCardTitleTextStyle,
                          ),
                          const Spacer(),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '${data.firstName} ${data.lastName}',
                        style: kCardSubTitleTextStyle,
                      ),
                      SizedBox(height: kSpacingUnit / 2),
                      Text(
                        '${data.adress}, ${data.zipcode} ${data.town}',
                        style: kCaptionTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
