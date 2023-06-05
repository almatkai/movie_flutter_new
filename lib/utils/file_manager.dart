import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_flutter_new/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> _write({required String text, required String root}) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/$root');
  try {
    await file.writeAsString(text);
    print(text);
    return true;
  } catch (e, s) {
    print(e);
    print(s);
    return false;
  }
}

Future<String> _read({required String root}) async {
  String text;
  try {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/$root');
    text = await file.readAsString();
  } catch (e) {
    print(e);
    text = "";
  }
  return text;
}

Future<bool> saveTheme({required String color}) async {
  return await _write(text: color, root: "color.txt");
}

Future<bool> saveLanguage({required String language}) async {
  return await _write(text: language, root: "language.txt");
}

Future<bool> addFavorite({required String movieID}) async {
  List<String> listedText = await getFavoritesID();
  bool result = false;
  if (!listedText.contains(movieID)) {
    listedText.insert(0, movieID);
    result = await _write(text: listedText.join(';'), root: "favorites.txt");
  }
  return result;
}

Future<bool> removeFavorite({required String movieID}) async {
  List<String> listedText = await getFavoritesID();
  bool result = false;
  try {
    listedText.remove(movieID);
    result = await _write(text: listedText.join(';'), root: "favorites.txt");
  } catch (e, s) {
    print(s);
    result = false;
  }
  return result;
}

Future<Color> currentTheme() async {
  Color color;
  String text = await _read(root: "color.txt");
  switch (text) {
    case "orange":
      color = kMainOrangeColor;
      break;
    case "blue":
      color = kMainBlueColor;
      break;
    case "pink":
      color = kMainPinkColor;
      break;
    default:
      color = kMainGreenColor;
  }

  return Future.value(color);
}

Future<String> currentLanguage() async {
  String language;
  String text = await _read(root: "language.txt");
  switch (text) {
    case "ENG":
      language = "&language=en-US";
      break;
    case "RUS":
      language = "&language=ru-RU";
      break;
    case "ESP":
      language = "&language=es-SS";
      break;
    default:
      // ignore: avoid_print
      print(text);
      language = "&language=ru-RU";
  }

  return Future.value(language);
}

Future<bool> isMovieInFavorites({required String movieID}) async {
  String result = await _read(root: "favorites.txt");
  return result.split(';').contains(movieID);
}

Future<List<String>> getFavoritesID() async {
  String result = await _read(root: "favorites.txt");
  return result.split(';');
}
