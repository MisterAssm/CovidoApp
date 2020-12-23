import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19_ui/database/database_manager.dart';
import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/screens/home/home_screen.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllUsersDuplicate extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AllUsersDuplicateState allUsersDuplicateState;

  AllUsersDuplicate(this.scaffoldKey, this.allUsersDuplicateState);

  @override
  AllUsersDuplicateState createState() => allUsersDuplicateState;
}

class AllUsersDuplicateState extends State<AllUsersDuplicate> {
  int _cardIndex = 0;
  List<User> _userList;
  final GlobalKey<ScaffoldState> scaffoldKey;

  AllUsersDuplicateState(this.scaffoldKey) {
    reloadUsers();
  }

  void reloadUsers() {
    DatabaseManager().getUserList().then((value) => {
          setState(() {
            _userList = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_userList == null) {
      return Container();
    } else {
      return Container(
        height: 175.w,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 130.w,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: _cardIndex,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _cardIndex = index;
              });
            },
          ),
          itemCount: _userList.length,
          itemBuilder: (BuildContext context, int index) => Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: kSpacingUnit),
            child: UserCard(
              data: _userList[index],
              count: index + 1,
              scaffoldKey: scaffoldKey,
              state: this,
            ),
          ),
        ),
      );
    }
  }
}
