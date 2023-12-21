import 'package:flutter/cupertino.dart';
import '../pages/import.dart';
import '../loading/import.dart';
import '../widgets/pop/pop_up_ios_delete.dart';
import '../home/view/home.dart';

class MyNavigatorManager {
  MyNavigatorManager._();
  static MyNavigatorManager instance = MyNavigatorManager._();
  final key = GlobalKey<NavigatorState>();
  late NavigatorState bankState;
  NavigatorState? get nav => key.currentState;

  void navigatorInit(NavigatorState state) {
    bankState = state;
  }

  Future<void> carPop() async {
    bankState.pop();
  }

  Future<void> carPush() async {
    bankState.pushNamed('/car');
  }

  Future<void> carPopUntil(String route) async {
    bankState.popUntil(ModalRoute.withName(route));
  }

  Future<void> simulatorPop() async {
    nav!.pop();
  }

  Future<void> untilPop() async {
    nav!.popUntil(ModalRoute.withName('/home'));
  }

  Future<void> errorPop(String message) async {
    showErrorPop(nav!.context, message);
  }

  Future<void> simulatorPush() async {
    nav!.pushNamed('/simulator');
  }

  Future<void> testPush() async {
    nav!.pushNamedAndRemoveUntil('/test', ModalRoute.withName('/home'));
  }

  Future<void> homePush() async {
    nav!.pushReplacementNamed('/home');
  }

  Future<void> finPush(String url) async {
    nav!.pushReplacementNamed('/fin', arguments: url);
  }

  Future<void> unworkBPush() async {
    nav!.pushNamed('/unwork');
  }

  Future<void> bankAccountPush() async {
    bankState.pushNamed('/account');
  }

  Future<void> workBPush(String tg) async {
    nav!.pushNamed('/work', arguments: tg);
  }

  Future<void> telegaPush(VBoardParam param) async {
    nav!.pushNamed('/tg', arguments: param);
  }

  Future<void> valutePush(int index) async {
    nav!.pushNamed('/valute', arguments: index);
  }

  Future<void> winPush() async {
    nav!.pushReplacementNamed('/win');
  }

  Future<void> ansPush() async {
    nav!.pushNamed('/ans');
  }

  Future<void> losePush() async {
    nav!.pushReplacementNamed('/lose');
  }

  Future<void> nextLessonPush() async {
    nav!.pushReplacementNamed('/less');
  }

  Future<void> lessonPush() async {
    nav!.pushNamed('/less');
  }

  Future<void> settingPush() async {
    bankState.pushNamed('/setting');
  }

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SplashPage.route();

      case '/unwork':
        return VUnWorkOnb.route();
      case '/work':
        final tg = settings.arguments as String;
        return VWorkOnb.route(tg);
      case '/tg':
        final tg = settings.arguments as VBoardParam;
        return VBoardTelega.route(tg);
      case '/fin':
        final url = settings.arguments as String;
        return FinicPage.route(url);
      case '/home':
        return HomePage.route();
      default:
        return HomePage.route();
    }
  }
}
