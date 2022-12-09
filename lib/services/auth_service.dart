import 'dart:convert';
import 'package:digitalpaca/services/series_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Auth(email, password) async {
    var response = await http.post(
        Uri.parse("http://138.68.104.234:8080/auth/login"),
        body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      late SharedPreferences preferences;
      preferences = await SharedPreferences.getInstance();
      Map<String, dynamic> userMap =
          jsonDecode(response.body) as Map<String, dynamic>;

      preferences.setString("user", response.body);
      preferences.setString("token", userMap['token']);
      preferences.setString("refreshToken", userMap['refreshToken']);
      preferences.setBool("isAuth", true);

      return true;
    } else {
      return false;
    }
  }

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
      SeriesService().getSeries(userMap['token']);
    } else if (response.statusCode == 401) {
      print("Refresh token fail");
    }
  }
}
