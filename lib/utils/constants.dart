import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final kSpacingUnit = 10.00.w;

const kBackgroundColor = const Color(0xFFF3F3F9);
const kSilverColor = const Color(0xFFF6F7FB);
const kBlackColor = const Color.fromRGBO(17, 17, 17, 1);
const kPrimaryTextColor = const Color(0xFF424242);
const kSecondaryTextColor = const Color(0xFFA1A4A8);

final kBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.05),
  blurRadius: 30.w,
  offset: Offset(0, 10.w),
);

final kHeadingTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontFamily: 'SF Pro Rounded',
  fontSize: 24.sp,
  fontWeight: FontWeight.w800,
);

final kTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 17.sp,
  fontWeight: FontWeight.w600,
);

final kSubTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 10.sp,
);

final kCardSubTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w500,
);

final kBodyTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 13.sp,
);

final kCardTitleTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
);

final tousAntiCovidURL = 'https://bonjour.tousanticovid.gouv.fr/';
