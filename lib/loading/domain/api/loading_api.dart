import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../const/import.dart';

class LoadingApiClient {
  static Future<int> validateSesion(
      {required StreamController<String> errorController,
      required String udid,
      required int procentChargh,
      required bool isChargh,
      required bool isVpn}) async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://$zaglushka');
      final response = await client.post(url, body: {
        'vivisWork': isVpn.toString(),
        'poguaKFP': udid,
        'Fpvbduwm': isChargh.toString(),
        'gfpbvjsoM': procentChargh.toString()
      }).timeout(const Duration(seconds: 7));

      if (response.statusCode == 200) {
        final data = response.body;
        return int.tryParse(data) ?? 1;
      }
      return 1;
    } catch (_) {
      return 2;
    }
  }
}
