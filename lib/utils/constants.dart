import 'package:flutter/material.dart';
import 'package:movie_flutter_new/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

import '../utils/file_manager.dart' as file;

final GlobalKey<HomeScreenState> kHomeScreenKey = GlobalKey();
var language = file.currentLanguage();

const kThemoviedbURL = "https://api.themoviedb.org/3/movie";
const kThemovieDiscoverdbURL = "https://api.themoviedb.org/3/discover/movie";
const kThemoviedbSearchURL = "https://api.themoviedb.org/3/search/movie";
const kThemoviedbImageURL = "https://image.tmdb.org/t/p/w300";

var kHomeScreenButtonFirstText = "Populars";
var kHomeScreenButtonSecondText = "Coming Soon";
var kHomeScreenButtonThirdText = "Top Rated";
var kHomeScreenTitleText = "Watch Now";
var k404Text = "Movies not found";
var kFavoriteRemovedText = "Movie removed from Favorites";
var kFavoriteAddedText = "Movie added to Favorites";
var kDetailsScreenTitleText = "Overview";
var kStoryLineTitleText = "Storyline";
var kSplashScreenTitleText = "loading..";
var kFinderScreenTitleText = "Finder";
var kFavoriteScreenTitleText = "Favorites";
var kDrawerTitleFirstText = "THEME";
var kDrawerTitleSecondText = "ABOUT";
var kDrawerTitleThirdText = "DEPENDENCIES";
var kAppliedTheme = "Theme applied";
var kNotFoundErrorText = "Not found";
var kDrawerAboutDescText =
    "Hi, This is a group project (Almat, Yerdaulet). You see currently my portfoliowork, which is based on the themoviedb API. If you want to see my future developments, follow us on GitHub (almatkai).";

const kMainGreenColor = Color(0xFF37A45E);
const kMainOrangeColor = Color(0xFFE58901);
const kMainBlueColor = Color(0xFF2C78C5);
const kMainPinkColor = Color(0xFFE84CAF);

const kPrimaryColor = Color(0xFF101010);
const kLightGrey = Color(0xFF545454);
const kAppBarColor = Color(0xFF1C1C1C);
const kTextShadowColor = Color(0x4D000000);
const kBackgroundShadowColor = Color(0x4D161616);
const kDrawerLineColor = Color(0xFF707070);
const kInactiveButtonColor = Color(0xFF474747);
const kDrawerTextColor = Color(0xFFBEBEBE);
const kSubTitleCardBoxColor = Color(0xFF8E8E8E);
const kSearchAppBarColor = Color(0xFF161616);

final kTextShadow = [
  Shadow(offset: Offset(0, 0.1.h), blurRadius: 6.0.sp, color: kTextShadowColor),
];

final kBoxShadow = [
  BoxShadow(
    color: kPrimaryColor,
    spreadRadius: 5,
    blurRadius: 30.sp,
    offset: Offset(0, 3),
  ),
];

final kHomeScreenButtonTextStyle = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
  shadows: kTextShadow,
);

final kBoldTitleTextStyle = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
  shadows: kTextShadow,
);

final kTitleTextStyle = TextStyle(
  fontSize: 12.sp,
  shadows: kTextShadow,
);

final kDrawerDescTextStyle = TextStyle(
  fontSize: 12.sp,
  color: kDrawerTextColor,
  height: 0.19.h,
);

final kAppBarTitleTextStyle = TextStyle(
  fontSize: 28.sp,
  fontWeight: FontWeight.bold,
  shadows: kTextShadow,
);

final kSplashScreenTextStyle = TextStyle(
  fontSize: 12.0.sp,
  color: kLightGrey,
);

final kSubTitleCardBoxTextStyle = TextStyle(
  color: kSubTitleCardBoxColor,
  fontSize: 9.sp,
);

final kSmallAppBarTitleTextStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);

final kSmallTitleTextStyle = TextStyle(fontSize: 18.sp);

final kTextFieldDecoration = InputDecoration(
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
);

final kMovieAppBarTitleTextStyle = TextStyle(fontSize: 22.sp);

final kDetailScreenBoldTitle = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);
final kDetailScreenRegularTitle = TextStyle(
  fontSize: 20.sp,
);
