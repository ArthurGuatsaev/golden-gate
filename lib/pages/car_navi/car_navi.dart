import 'package:flutter/material.dart';
import '../../pages/import.dart';

class CarNavi extends StatelessWidget {
  const CarNavi({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/collect':
            return MainPage.route();
          case '/car':
            return CapOpenPage.route();

          default:
            return MainPage.route();
        }
      },
    );
  }
}
