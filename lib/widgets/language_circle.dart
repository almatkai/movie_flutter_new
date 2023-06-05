import 'package:flutter/material.dart';

class LanguageCircle extends StatelessWidget {
  final String language;
  final Function(String) onPressed;
  // final String text;

  LanguageCircle({required this.language, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onPressed(language);
        },
        child: Text(language));
  }
}
