import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';
import 'box_panel.dart';

class SymptomCard extends StatelessWidget {
  final String assetUrl;
  final String title;
  final String description;
  final GestureTapCallback callback;

  const SymptomCard({
    Key key,
    this.assetUrl,
    this.title,
    this.description,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoxPanel(
      padding: EdgeInsets.all(kSpacingUnit * 2),
      width: kSpacingUnit * 25,
      child: InkWell(
        onTap: callback,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              this.assetUrl,
              height: kSpacingUnit * 5,
              width: kSpacingUnit * 5,
            ),
            SizedBox(width: kSpacingUnit * 2),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.title,
                    style: kSubTitleTextStyle,
                  ),
                  SizedBox(height: kSpacingUnit),
                  Text(
                    this.description,
                    style: kBodyTextStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
