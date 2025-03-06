import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isdark;

  ThemeProvider(this.isdark);

  Future<void> toogletheme() async {
    isdark = !isdark;
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setBool('isthemechanged', isdark);

    notifyListeners();
  }
}
