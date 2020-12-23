import 'package:covid19_ui/mock_data.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'forms/add_form.dart';

class ChooseLogoScreen extends StatelessWidget {
  final int selected;

  ChooseLogoScreen(this.selected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: kSpacingUnit * 8),
          Row(
            children: [
              SizedBox(width: kSpacingUnit.w * 3),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  LineAwesomeIcons.arrow_circle_left,
                  size: ScreenUtil().setSp(kSpacingUnit.w * 3),
                ),
              ),
              SizedBox(width: kSpacingUnit.w * 1.5),
              Text(
                'Choisir une photo',
                textAlign: TextAlign.center,
                style: kHeadingTextStyle,
              ),
              SizedBox(width: kSpacingUnit.w * 3),
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: logos.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(16, 16, 16, 1),
                      ),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/icons/avatars/${logos[index]}.png'),
                        backgroundColor: kSilverColor,
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(1, 1);
                }),
          )),
        ],
      ),
    );
  }
}
