// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loading_model.dart';

class RemoteRepo with SharedSaveUrl {
  final StreamController<String> errorController;
  RemoteRepo({required this.errorController});
  bool isDead = false;
  bool needTg = false;
  bool isAllChangeURL = false;
  String tg = 'https://telegram.me/';
  String url = '';
  final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initialize({
    required StreamController<VLoading> streamController,
    required String userId,
  }) async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration(seconds: 1)),
      );
      streamController.add(VLoading.initRemote);
      await remoteConfig.setDefaults(const {
        "info": "https://google.com",
        "isDead": false,
        "needTg": false,
        "isAllChangeURL": false,
        "tg": 'https://telegram.me/'
      });

      await remoteConfig.fetchAndActivate();
      isAllChangeURL = remoteConfig.getBool('isAllChangeURL');
      final lastUrl = await getLastUrl();
      if (isAllChangeURL) {
        url = remoteConfig.getString('info');
      } else {
        url = lastUrl ?? remoteConfig.getString('info');
      }
      isDead = remoteConfig.getBool('isDead');
      tg = remoteConfig.getString('tg');
      isDead = remoteConfig.getBool('isDead');
      needTg = remoteConfig.getBool('needTg');
      // url = updateUrl(url: initialUrl, userId: userId);
      if (needTg) {
        streamController.add(VLoading.tgTrue);
      } else {
        streamController.add(VLoading.tgFalse);
      }
      streamController.add(VLoading.remoteActivate);
    } catch (e) {
      streamController.add(VLoading.remoteActivate);
      streamController.add(VLoading.tgFalse);
      errorController.add('No internet connection');
    }
  }

  String getUrl() {
    try {
      return remoteConfig.getString('info');
    } catch (e) {
      throw FirebaseRemoteExeption(message: 'firebase remoute exeption');
    }
  }

  String updateUrl({required String url, required String userId}) {
    //генерируем id (Apphud.userId())
    // final id = '=${Random().nextInt(1000000)}-${DateTime.now().millisecond}';
    const click = 'click_id';
    //проверяем есть ли click_id, если есть то вставляем сразу после него рандомный id;
    if (url.contains(click)) {
      final index = url.indexOf(click);
      final before = url.substring(0, index + 8);
      String after = url.substring(index + 8);
      if (after.contains('&')) {
        final aftererIndex = after.indexOf('&');
        after = after.substring(aftererIndex);
      } else {
        after = '';
      }
      return before + '=' + userId + after;
    } else {
      // если нет то вставляем нужный символ и добавляем click_id=id
      final separator = url.contains('?') ? '&' : '?';
      return url + separator + click + '=' + userId;
    }
  }
}

class FirebaseRemoteExeption implements Exception {
  final String message;
  FirebaseRemoteExeption({
    required this.message,
  });
}

mixin SharedSaveUrl {
  final String lu = 'last_url';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  Future<void> setLastUrl({required String lastUrl}) async {
    (await prefs).setString(lu, lastUrl);
  }

  Future<String?> getLastUrl() async {
    final url = (await prefs).getString(lu);
    return url;
  }
}
