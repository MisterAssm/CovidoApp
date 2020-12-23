import 'package:covid19_ui/database/database_manager.dart';
import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/screens/forms/edit_form.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/utils/size_config.dart';
import 'package:covid19_ui/widgets/users_all_duplicate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class UserCard extends StatelessWidget {
  final User data;
  final int count;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AllUsersDuplicateState state;

  const UserCard({Key key, this.data, this.count, this.scaffoldKey, this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
      ),
      child: GestureDetector(
        onTap: () => openBottomSheet(context),
        child: Container(
          height: 125.w,
          padding: EdgeInsets.all(kSpacingUnit * 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(kSpacingUnit * 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  LikeButton(
                    size: 20.sp,
                    isLiked: data.isFavorite,
                    onTap: _onLikeButtonTapped,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '${data.firstName} ${data.lastName} #$count',
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
      ),
    );
  }

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    data.switchFavorite();

    return !isLiked;
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: 25 * SizeConfig.heightMultiplier),
              child: Container(
                height: 90 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3 * SizeConfig.heightMultiplier,
                          horizontal: 4 * SizeConfig.widthMultiplier),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 5 * SizeConfig.imageSizeMultiplier,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                    'Voulez-vous supprimer cet utilisateur ?'),
                                actions: [
                                  FlatButton(
                                    child: Text('Annuler'),
                                    textColor: kBlackColor,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  FlatButton(
                                    child: Text('Confirmer'),
                                    textColor: Colors.white,
                                    color: kBlackColor,
                                    onPressed: () => {
                                      Navigator.pop(context),
                                      Navigator.pop(context),
                                      DatabaseManager().deleteUser(data.id),
                                      state.reloadUsers(),
                                      Scaffold.of(context).showSnackBar(
                                        new SnackBar(
                                          content: new Text("L'utilisateur a bien été supprimé."),
                                          duration: new Duration(seconds: 3),
                                          backgroundColor: Color.fromRGBO(123, 237, 159, 1),
                                        ),
                                      ),
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(2.0))
                                    ),
                                  )
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                              ),
                              barrierDismissible: true,
                            ),
                            child: Icon(
                              Icons.delete,
                              color: kBlackColor,
                              size: 5 * SizeConfig.imageSizeMultiplier,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(
                            "assets/icons/avatars/1.png",
                            height: 15 * SizeConfig.imageSizeMultiplier,
                            width: 15 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    Center(
                      child: Text(
                        "${data.firstName} ${data.lastName}",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 4 * SizeConfig.textMultiplier),
                      ),
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    Center(
                      child: Text(
                        "🏠 ${data.adress}, ${data.zipcode} ${data.town}",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                    ),
                    Center(
                      child: Text(
                        "🎂 née le ${data.birthday} à ${data.placeOfBirth}",
                        style: GoogleFonts.nunitoSans(
                            color: kBlackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                    ),
                    SizedBox(height: 4 * SizeConfig.heightMultiplier,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4 * SizeConfig.widthMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attestations téléchargé",
                            style: GoogleFonts.nunitoSans(
                                color: kBlackColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                fontSize: 2 * SizeConfig.textMultiplier),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 3.0,
                                  backgroundColor: kBlackColor  ,
                                ),
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text(
                                "Attestion #154 [DOWNLOAD]",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 1.7 * SizeConfig.textMultiplier),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 3.0,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text(
                                "Attestion #155 [DOWNLOAD]",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 1.7 * SizeConfig.textMultiplier),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 10 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(-3, -3),
                                blurRadius: 10.0)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4 * SizeConfig.widthMultiplier),
                        child: Row(
                          children: [
                            Container(
                              height: 7.5 * SizeConfig.heightMultiplier,
                              width: 15 * SizeConfig.widthMultiplier,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: LikeButton(
                                  size: 30.sp,
                                  isLiked: data.isFavorite,
                                  onTap: _onLikeButtonTapped,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context1) => EditFormScreen(scaffoldKey, data, state))),
                                child: Container(
                                  height: 7.5 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      color: kBlackColor,
                                      borderRadius: BorderRadius.circular(20.0)),
                                  child: Center(
                                    child: Text(
                                      "Editer l'utilisateur",
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                          fontSize:
                                          2 * SizeConfig.textMultiplier),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
