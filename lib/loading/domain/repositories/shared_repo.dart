import 'package:shared_preferences/shared_preferences.dart';

mixin VSharedPref {
  final String fs = 'fscr';
  final String show = 'show';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  Future<void> setFirstShow() async {
    (await prefs).setBool(show, false);
  }

  Future<void> setFirstShowFinance() async {
    (await prefs).setBool(fs, true);
  }
}
