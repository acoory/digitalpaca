// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:digitalpaca/screen/home_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // @override
  // initState() {
  //   super.initState();

  //   checkAuth();
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // create function HandleSignIn to handle login use api
    void login() async {
      String email = emailController.text;
      String password = passwordController.text;

      var response = await http.post(
          Uri.parse("http://138.68.104.234:8080/auth/login"),
          // body: {"email": email, "password": password});
          body: {
            "email": "test-tech-dp-api_front@gmail.com",
            "password": "#j3apZAYBAm@Q4T2C!dQa"
          });
      if (response.statusCode == 200) {
        late SharedPreferences preferences;
        preferences = await SharedPreferences.getInstance();
        Map<String, dynamic> userMap =
            jsonDecode(response.body!) as Map<String, dynamic>;
        print(userMap['token']);

        // save data user and token and refreshToken in shared preferences
        preferences.setString("user", response.body);
        preferences.setString("token", userMap['token']);
        preferences.setString("refreshToken", userMap['refreshToken']);
        preferences.setBool("isAuth", true);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        print("Login fail");
      }
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 167, 245, 1)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      child: Center(
                        child: Image(
                          image: AssetImage("assets/logo.png"),
                          width: 110,
                          height: 110,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Se connecter :",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: emailController,
                          // onChanged: (value) {
                          //   email = value;
                          // },
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Adresse email",
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Mot de passe",
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomeView()));
                          login();
                        },
                        child: const Text("Se connecter"),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  void checkAuth() async {
    // ignore: use_build_context_synchronously
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    bool isAuth = preferences.getBool("isAuth") ?? false;
    if (isAuth) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      print("Not Auth");
    }
  }
}
