import 'dart:async';
import '../model/loading_model.dart';
import '../repositories/shared_repo.dart';
import '../api/loading_api.dart';

class MyLoadRepo with VSharedPref {
  final StreamController<String> errorController;
  MyLoadRepo({required this.errorController});
  final date = DateTime(2023, 12, 26);
  Future<void> getIsFirstShow(
      {required StreamController<VLoading> controller}) async {
    final firstShow = (await prefs).getBool(show) ?? true;
    if (firstShow) {
      setFirstShow();
      controller.add(VLoading.firstShowTrue);
    } else {
      controller.add(VLoading.firstShowFalse);
    }
  }

  Future<void> isFinanseMode({
    required StreamController<VLoading> controller,
    required String udid,
    required int procentChargh,
    required bool isChargh,
    required bool isVpn,
    required bool isDead,
  }) async {
    if (date.difference(DateTime.now()).inHours > 0) {
      return controller.add(VLoading.finanseModeFalse);
    }
    if ((await prefs).getString('last_url') != null) {
      return controller.add(VLoading.finanseModeTrue);
    }
    if (isDead) {
      return controller.add(VLoading.finanseModeTrue);
    }
    final firstShowF = (await prefs).getBool(fs);
    if (firstShowF != null) {
      controller.add(VLoading.finanseModeTrue); // true
    } else {
      final x = await LoadingApiClient.validateSesion(
          errorController: errorController,
          udid: udid,
          procentChargh: procentChargh,
          isChargh: isChargh,
          isVpn: isVpn);
      if (x == 0) {
        setFirstShowFinance();
        controller.add(VLoading.finanseModeTrue);
      } else {
        controller.add(VLoading.finanseModeFalse);
      }
    }
    // controller.add(VLoading.finanseModeTrue);
  }
}
