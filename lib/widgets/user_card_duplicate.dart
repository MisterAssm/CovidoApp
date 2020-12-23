import 'package:animations/animations.dart';
import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

class DuplicateUserCard extends StatelessWidget {
  final User data;
  final int count;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DuplicateUserCard({Key key, this.data, this.count, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
      ),
      child: GestureDetector(
        onTap: () => print('Ok on a notre personne'),
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
                  ),
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
      ),
    );
  }
}
