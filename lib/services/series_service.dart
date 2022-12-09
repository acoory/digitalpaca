import 'package:digitalpaca/model/series.dart';
import 'package:digitalpaca/services/auth_service.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SeriesService {
  Future<List<Series>?> getSeries(token) async {
    var headers = {
      'Authorization': 'Bearer ${token.toString()}',
    };
    var request =
        http.Request('GET', Uri.parse('http://138.68.104.234:8080/series'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      return seriesFromJson(json);
    } else if (response.statusCode == 401) {
      AuthService().GetRefreshToken();
    }

    return null;
  }
}
