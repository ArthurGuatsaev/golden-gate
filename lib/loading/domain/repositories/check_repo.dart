import 'dart:async';
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../model/loading_model.dart';

class CheckRepo {
  final StreamController<String> errorController;
  CheckRepo({required this.errorController});
  String? udid;
  int? procentChargh;
  bool? isChargh;
  bool? isVpn;

  Future<void> checkVpn(
      {required StreamController<VLoading> streamController}) async {
    try {
      if (await CheckVpnConnection.isVpnActive()) {
        isVpn = true;
      } else {
        isVpn = false;
      }
      streamController.add(VLoading.checkVpn);
    } catch (_) {
      errorController.add('VPN error');
    }
  }

  Future<void> checkBattery(
      {required StreamController<VLoading> streamController}) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isIOS) {
        var iosInfo = await deviceInfo.iosInfo;
        if (iosInfo.isPhysicalDevice) {
          Battery battery = Battery();
          procentChargh = await battery.batteryLevel;
          isChargh = (await battery.batteryState) == BatteryState.charging;
        }
      }
      streamController.add(VLoading.battary);
    } catch (_) {
      errorController.add('Batary error');
    }
  }

  Future<void> checkDeviceInfo(
      {required StreamController<VLoading> streamController}) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      udid = iosInfo.identifierForVendor;
      streamController.add(VLoading.deviceInfo);
    } catch (_) {
      errorController.add('device info error');
    }
  }
}
