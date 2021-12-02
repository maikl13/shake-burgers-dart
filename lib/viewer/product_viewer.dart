// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_burger/manager/burger.dart';
import 'package:shake_burger/manager/burgers_list.dart';
import 'package:shake_burger/manager/sections_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [],
      supportedLocales: [
        const Locale('en', 'US'),
      ],
      home: ProductViewerApp(),
    ),
  );
}

class ProductViewerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductViewer();
  }
}

class ProductViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProductViewer();
  }
}

Color primaryColor = Color.fromARGB(255, 115, 171, 66);

class MyProductViewer extends State<ProductViewer> {




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
        appBar: AppBar(toolbarHeight: 0, elevation: 0, systemOverlayStyle: const SystemUiOverlayStyle(systemNavigationBarIconBrightness: Brightness.light, statusBarColor: Colors.white, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark)),
        body: Material(
          child: Column(
            children: [

  ]
          ),
        ),
      ),
    );
  }
}
