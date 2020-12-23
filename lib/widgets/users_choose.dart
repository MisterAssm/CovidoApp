import 'package:covid19_ui/database/database_manager.dart';
import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/widgets/user_card_duplicate.dart';
import 'package:flutter/material.dart';

class UsersChoose extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  UsersChoose(this.scaffoldKey);

  @override
  _UsersChooseState createState() => _UsersChooseState(scaffoldKey);
}

class _UsersChooseState extends State<UsersChoose> {

  List<User> _userList;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _UsersChooseState(this.scaffoldKey) {
    DatabaseManager().getUserList().then((value) =>
    {
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
      return Column(
          verticalDirection: VerticalDirection.down,
          children: _userList.asMap().entries.map((item) => Container(
            margin: EdgeInsets.symmetric(horizontal: kSpacingUnit * 3).copyWith(
              top: item.key == 0 ? kSpacingUnit * 2 : 0,
              bottom: kSpacingUnit * 2,
            ),
            child: DuplicateUserCard(
              data: item.value,
              count: item.key,
              scaffoldKey: scaffoldKey,
            ),
          )).toList(),
      );
    }
  }

}
