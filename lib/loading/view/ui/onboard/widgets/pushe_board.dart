import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../const/import.dart';
import '../../../../../nav_manager.dart';
import '../../../../../widgets/calc_button.dart';

class VBoardPush extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  final String buttonText;
  const VBoardPush({
    Key? key,
    required this.image,
    required this.title,
    required this.body,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              image,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 60),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        body,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const Spacer(),
                      const SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: 'Enable notification',
                            function: _pushActivate,
                            fontSize: 16,
                            gradic: gradientButton,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 7),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: buttonText,
                            function: MyNavigatorManager.instance.simulatorPop,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7),
                            gradic: _gradient,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

final _gradient = LinearGradient(colors: [
  Colors.white.withOpacity(0.06),
  Colors.white.withOpacity(0.06),
]);

void _pushActivate() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    // Notification permissions granted
  } else if (status.isDenied) {
    // Notification permissions denied
  } else if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
}
