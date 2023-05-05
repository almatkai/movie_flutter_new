import 'package:movie_flutter_new/auth.dart';
import 'package:movie_flutter_new/screens/home_screen.dart';
import 'package:movie_flutter_new/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_new/utils/constants.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authstatechanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(
            key: kHomeScreenKey,
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
