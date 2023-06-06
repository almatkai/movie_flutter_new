import 'package:flutter/material.dart';
import 'package:movie_flutter_new/auth.dart';
import 'package:movie_flutter_new/utils/constants.dart';
import 'package:movie_flutter_new/utils/file_manager.dart' as file;
import 'package:movie_flutter_new/widgets/colored_circle.dart';
import 'package:movie_flutter_new/widgets/drawer_item.dart';
import 'package:movie_flutter_new/widgets/language_circle.dart';
import 'package:sizer/sizer.dart';

class DrawerScreen extends StatelessWidget {
  final Function(Color) colorChanged;
  final Function(String) languageChanged;
  DrawerScreen({required this.colorChanged, required this.languageChanged});

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: signOut, child: const Text("Sign Out/Выйти"));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kPrimaryColor,
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.h, left: 6.w, right: 6.w, bottom: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerItem(
                title: kDrawerTitleFirstText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColoredCircle(
                      color: kMainGreenColor,
                      onPressed: (color) {
                        file.saveTheme(color: "green");
                        colorChanged(color);
                      },
                    ),
                    ColoredCircle(
                      color: kMainBlueColor,
                      onPressed: (color) {
                        file.saveTheme(color: "blue");
                        colorChanged(color);
                      },
                    ),
                    ColoredCircle(
                      color: kMainOrangeColor,
                      onPressed: (color) {
                        file.saveTheme(color: "orange");
                        colorChanged(color);
                      },
                    ),
                    ColoredCircle(
                      color: kMainPinkColor,
                      onPressed: (color) {
                        file.saveTheme(color: "pink");
                        colorChanged(color);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              DrawerItem(
                title: "Language/Язык",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LanguageCircle(
                      onPressed: (language) {
                        file.saveLanguage(language: "ENG");
                        languageChanged(language);
                      },
                      language: "ENG",
                    ),
                    LanguageCircle(
                      onPressed: (language) {
                        file.saveLanguage(language: "RUS");
                        languageChanged(language);
                      },
                      language: "RUS",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              DrawerItem(
                title: kDrawerTitleSecondText,
                desc: kDrawerAboutDescText,
              ),
              SizedBox(
                height: 2.h,
              ),
              DrawerItem(
                  title: "Sign Out/Выйти",
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                          themeColor: kMainBlueColor,
                                        )));
                          },
                          child: Text(
                            "Profile Page",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),*/
                        _signOutButton()
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
