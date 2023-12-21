import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const/import.dart';
import '../domain/model/valute_price.dart';

class ApiClentTrade {
  static Future<ValutePriceModel> getCourse({required String valute}) async {
    try {
      final time = DateTime.now();
      final client = http.Client();
      final url = Uri.parse(
          'https://$apiDomain/api/v2/currencies?pairs=${valute.toSymbol}&startAt=${time.day}.${time.month}.${time.year} 00:00&token=$apiToken');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonT = jsonDecode(response.body) as Map<String, dynamic>;
        final json = jsonT['results'] as List<dynamic>;
        final map = json.map((e) => e as Map<String, dynamic>).first;
        return ValutePriceModel.fromMap(map);
      }
      return ValutePriceModel();
    } catch (_) {
      return ValutePriceModel();
    }
  }
}
