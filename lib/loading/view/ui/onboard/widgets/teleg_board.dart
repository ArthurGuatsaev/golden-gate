// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../../../const/import.dart';
import '../../../../../nav_manager.dart';
import '../../../../../widgets/calc_button.dart';
import '../../../../../widgets/telega_button.dart';
import '../../../../import.dart';

class VBoardTelega extends StatelessWidget {
  static const String routeName = '/tg';
  static Route route(VBoardParam param) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => VBoardTelega(boardParam: param));
  }

  final VBoardParam boardParam;
  const VBoardTelega({
    required this.boardParam,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              boardParam.image,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgSecondColor),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 60),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        boardParam.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        boardParam.body,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 48,
                        child: VTelegaButton(adress: boardParam.tg ?? ''),
                      ),
                      const SizedBox(height: 7),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: boardParam.buttonText,
                            function: boardParam.function,
                            fontSize: 16,
                            gradic: _gradient,
                            color: Colors.blue,
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
  const Color(0xFF3C89CF).withOpacity(0.1),
  const Color(0xFF3C89CF).withOpacity(0.1),
]);

VBoardParam telegaParam(String url) => VBoardParam(
      tg: url,
      image: 'assets/images/telega.png',
      function: () => MyNavigatorManager.instance.simulatorPop(),
      title: 'Join and earn',
      body: 'Join our Telegram group trade with our team',
      buttonText: 'Skip',
    );
