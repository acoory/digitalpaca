import 'dart:convert';

import 'package:digitalpaca/model/series.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemoteService {
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
      GetRefreshToken();
    }

    return null;
  }

  // ignore: non_constant_identifier_names
  void GetRefreshToken() async {
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String? RefreshToken = preferences.getString('refreshToken');

    var response = await http
        .post(Uri.parse("http://138.68.104.234:8080/auth/refresh"), body: {
      "refreshToken": RefreshToken.toString(),
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> userMap =
          jsonDecode(response.body!) as Map<String, dynamic>;
      preferences.setString('token', userMap['token']);
      preferences.setString('refreshToken', userMap['refreshToken']);
      getSeries(userMap['token']);
    } else if (response.statusCode == 401) {
      print("Refresh token fail");
    }
  }
}
