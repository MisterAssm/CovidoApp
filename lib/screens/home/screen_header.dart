import 'package:covid19_ui/utils/constants.dart';
import 'package:flutter/material.dart';

class ScreenHeader extends StatefulWidget {
  final String title;
  final String subTitle;

  ScreenHeader(this.title, this.subTitle);

  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: kSpacingUnit * 5),
          Text(
            widget.title,
            style: kHeadingTextStyle,
          ),
          SizedBox(height: kSpacingUnit),
          SizedBox(
            width: kSpacingUnit * 30,
            child: Text(
              widget.subTitle,
              textAlign: TextAlign.center,
              style: kBodyTextStyle,
            ),
          ),
          SizedBox(height: kSpacingUnit * 3),
        ],
      ),
    );
  }
}
