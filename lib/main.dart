// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_burger/manager/burger.dart';
import 'package:shake_burger/manager/sections_list.dart';


void main() {
  runApp(ShakeBurgerApp());
}

class ShakeBurgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShakeBurger();
  }
}


class ShakeBurger extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShakeBurger();
  }
}

Color primaryColor = Color.fromARGB(255, 115, 171, 66);

class _ShakeBurger extends State<ShakeBurger> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shake-Burger",
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        primaryColorDark: Colors.black,
        fontFamily: 'Georgia',
        accentColor: Colors.white,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(bodyColor: primaryColor, displayColor: primaryColor),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark)),
        body: Material(
          child: Column(
            children: [Header(), Container(
              margin: EdgeInsets.only(top: 10),
              child: SizedBox(
                child: StudentsList(),
                height: 110,
              ),
            )],
          ),
        ),
      ),
    );
  }
}


List<Burger> items = [];


class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Image(
                    width: 25,
                    height: 25,
                    image: AssetImage("images/menu.png"),
                    fit: BoxFit.scaleDown,
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "order to".toUpperCase(),
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontFamily: "futura_medium_bt"),
                    ),
                    Text(
                      "Jumeirah Lake Towers".toUpperCase(),
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: -0.02,
                          fontSize: 18,
                          fontFamily: "futura_bold_font"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("images/mic.png"),
                  fit: BoxFit.scaleDown,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Image(
                    width: 18,
                    height: 20,
                    image: AssetImage("images/search.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("images/settings.png"),
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
