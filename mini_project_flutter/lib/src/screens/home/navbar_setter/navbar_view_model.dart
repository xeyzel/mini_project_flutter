import 'package:flutter/material.dart';

class NavbarViewModel extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void tapIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
