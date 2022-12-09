import 'package:digitalpaca/navigation/header_drawer.dart';
import 'package:digitalpaca/screen/favoris_view.dart';
import 'package:digitalpaca/screen/home_view.dart';
import 'package:digitalpaca/screen/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewDrawer extends StatefulWidget {
  const NewDrawer({super.key});

  @override
  State<NewDrawer> createState() => _NewDrawerState();
}

int _currentIndex = 0;

class _NewDrawerState extends State<NewDrawer> {
  @override
  Widget build(BuildContext context) {
    var ListDrawer = [
      {'title': "Home", "icon": Icons.home},
      {'title': "Favoris", "icon": Icons.star_outline},
      {'title': "Deconnexion", "icon": Icons.logout}
    ];

    logout() async {
      late SharedPreferences preferences;
      preferences = await SharedPreferences.getInstance();
      preferences.remove("user");
      preferences.remove("isAuth");
      preferences.remove("token");
      preferences.remove("refreshToken");
      _currentIndex = 0;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    }

    void navigateTo(int index) {
      switch (index) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeView()));
          break;
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FavorisView()));
          break;
      }
    }

    return Container(
      color: Colors.blue,
      child: Drawer(
        backgroundColor: Color.fromRGBO(1, 169, 244, 1),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Column(
                      children: ListDrawer.map((e) {
                        var index = ListDrawer.indexOf(e);
                        return ListTile(
                          tileColor: index == _currentIndex
                              ? Color.fromRGBO(19, 61, 82, 1)
                              : Color.fromRGBO(0, 167, 245, 1),
                          leading: Icon(
                            e['icon'] as IconData,
                            size: 30,
                          ),
                          title: Text(
                            e['title'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            setState(() => _currentIndex = index);
                            print(index);
                            print("index");
                            print(_currentIndex);
                            navigateTo(index);
                            if (index == ListDrawer.length - 1) {
                              logout();
                            }
                          },
                        );
                      }).toList(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
