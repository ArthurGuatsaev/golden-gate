import 'dart:async';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:apphud/apphud.dart';
import '../model/loading_model.dart';

// import 'package:dio/dio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ServRepo {
  final String apphudApiKey = 'app_6EXVZLZ7ztFenR5pHdoYCxnhbnViKt';
  final String amplitudeApiKey = 'fb6d6cb55ecae8ba64d47cbc42adf7fc';
  String userId = '';
  Future<void> initApphud(
      {required StreamController<VLoading> controller}) async {
    await Apphud.start(
        apiKey: apphudApiKey, observerMode: false, userID: userId);
    controller.add(VLoading.apphud);
    userId = await Apphud.userID();
  }

  Future<void> initAmplitude(
      {required StreamController<VLoading> controller}) async {
    try {
      final analytics = Amplitude.getInstance(
          instanceName: '83ddd3e822e941609eb7d3a8d6114cb8');
      await analytics.init(amplitudeApiKey);
      await analytics.trackingSessionEvents(true);
      await analytics.setUserId(userId);
      controller.add(VLoading.amplitude);
    } catch (_) {}
  }

  Future<void> initOneSignal(
      {required StreamController<VLoading> controller}) async {
    await getReadyNotificationSystem();
    OneSignal.initialize("");
    OneSignal.login(userId);
    controller.add(VLoading.onesignal);
  }

  Future<void> getReadyNotificationSystem() async {
    try {
      // const url = '';
      // final dio = Dio();
      // final response = await dio.get(url);
      // if (response.statusCode == 200) {
      //   print('ok');
      //   print(response.data['result']);
      // } else {}
    } catch (_) {}
  }

  Future<void> logAmplitude() async {
    await Amplitude.getInstance().logEvent('did_show_main_screen');
  }
}
