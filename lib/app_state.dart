import 'package:flutter/material.dart';
import 'repository.dart';

class AppState extends ChangeNotifier {
  final Repository repo;
  AppState(this.repo) {
    dark = repo.prefs.getBool('dark') ?? false;
    fontScale = repo.prefs.getDouble('font') ?? 1.0;
  }
  bool dark = false;
  double fontScale = 1.0;
  void setDark(bool v) { dark = v; repo.prefs.setBool('dark', v); notifyListeners(); }
  void setFont(double v) { fontScale = v; repo.prefs.setDouble('font', v); notifyListeners(); }
}
