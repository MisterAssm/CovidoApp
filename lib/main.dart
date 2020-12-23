import 'package:covid19_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home/home_screen.dart';


void main() {
  runApp(CovidoApp());
}

class CovidoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'SF Pro Text'),
          home: HomeScreen(),
        );
      });
    });
  }
}
