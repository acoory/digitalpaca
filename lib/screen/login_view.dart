// ignore_for_file: unnecessary_null_comparison

import 'package:digitalpaca/screen/home_view.dart';
import 'package:digitalpaca/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    AuthCheck() async {
      String email = emailController.text;
      String password = passwordController.text;
      AuthService().Auth(email, password).then((value) {
        if (value == true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeView()));
        }
      });
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
                      radius: 80,
                      child: Center(
                        child: Image(
                          image: AssetImage("assets/logo.png"),
                          width: 110,
                          height: 110,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Se connecter :",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: emailController,
                          style: const TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                              fontFamily: "Roboto"),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(17),
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
                          style: const TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                              fontFamily: "Roboto"),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(17),
                            fillColor: Colors.white,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Mot de passe",
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ElevatedButton(
                        onPressed: () async {
                          AuthCheck();
                        },
                        child: const Text("Se connecter"),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
