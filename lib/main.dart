import 'package:digitalpaca/provider/favories_provider.dart';
import 'package:digitalpaca/screen/home_view.dart';
import 'package:digitalpaca/screen/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isAuth = prefs.getBool('isAuth') ?? false;

  runApp(MyApp(isAuth: isAuth));
}

class MyApp extends StatelessWidget {
  final bool isAuth;
  const MyApp({Key? key, required this.isAuth}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FavoriteProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isAuth ? HomeView() : LoginView(),
        ));
  }
}
