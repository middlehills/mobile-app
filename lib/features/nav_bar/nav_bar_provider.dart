import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  int selectedIndex = 0;

  // update bottomNavBarSelection
  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
