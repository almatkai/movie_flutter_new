import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'package:movie_flutter_new/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: ThemeData.dark().copyWith(
            platform: TargetPlatform.iOS,
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kPrimaryColor,
          ),
          home: const WidgetTree(),
        );
      },
    );
  }
}
