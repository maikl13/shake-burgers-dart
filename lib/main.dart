// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_burger/manager/burger.dart';
import 'package:shake_burger/manager/burgers_list.dart';
import 'package:shake_burger/manager/sections_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'viewer/product_viewer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [],
      supportedLocales: [
        const Locale('en', 'US'),
      ],
      home: ShakeBurgerApp(),
    ),
  );
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
    return MyShakeBurger();
  }
}

Color primaryColor = Color.fromARGB(255, 115, 171, 66);

class MyShakeBurger extends State<ShakeBurger> {
  void openActivity(Burger burger) {
    print(burger.name);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductViewer();
    }));
  }

  Burger topOrdered = Burger.empty();
  int current_section = 1;
  SimpleFontelicoProgressDialog? dialog;
  bool notLoading = true;

  void showLoading() {
    if (dialog != null && notLoading) {
      dialog!.show(message: "Please Wait...", type: SimpleFontelicoProgressDialogType.normal);
      notLoading = false;
    }
  }

  void hideLoading() {
    if (dialog != null) {
      dialog!.hide();
    }

    notLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (dialog == null) {
          dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);

          showLoading();
        }
      });
    });
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
              Header(),
              Expanded(
                  child: Stack(alignment: Alignment.topCenter, overflow: Overflow.visible, children: [
                Container(
                  margin: EdgeInsets.only(top: 90),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: Image(
                            image: AssetImage("images/logo.png"),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 5, left: 5),
                          child:  topOrdered.empty? Container():  Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                                child:GestureDetector(
                                  onTap: () {
                                    openActivity(topOrdered);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2.0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage("images/background.png"),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                margin: EdgeInsets.only(left: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Wrap(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Text(
                                                      "Most ordered".toUpperCase(),
                                                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16, fontFamily: "futura_bold_font"),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          topOrdered.name,
                                                          maxLines: 1,
                                                          style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "futura_bold_font"),
                                                        )),
                                                    Text(
                                                      topOrdered.details,
                                                      style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "futura_medium_bt"),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(top: 15),
                                                        child: Wrap(
                                                          children: [
                                                            Text(
                                                              "AED ",
                                                              maxLines: 1,
                                                              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14, fontFamily: "futura_medium_bt"),
                                                            ),
                                                            Text(
                                                              topOrdered.price.toString(),
                                                              maxLines: 1,
                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "futura_medium_bt"),
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              )),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: CachedNetworkImage(placeholder: (context, url) => const CircularProgressIndicator(), imageUrl: topOrdered.image),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  child: GestureDetector(
                                    child: Image(
                                      height: 40,
                                      width: 40,
                                      image: AssetImage(topOrdered.fav ? "images/fav_select.png" : "images/fav_unselect.png"),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        topOrdered.fav = !topOrdered.fav;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        BurgersList(this, (topOrdered) {
                          setState(() {
                            hideLoading();
                            this.topOrdered = topOrdered;
                          });
                        })
                      ],
                    ),
                  ),
                ),
                SectionsList((i) {
                  setState(() {
                    showLoading();
                    current_section = i;
                  });
                }),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

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
                      style: TextStyle(color: primaryColor, fontSize: 14, fontFamily: "futura_medium_bt"),
                    ),
                    Text(
                      "Jumeirah Lake Towers".toUpperCase(),
                      maxLines: 2,
                      style: TextStyle(color: Colors.black, letterSpacing: -0.02, fontSize: 18, fontFamily: "futura_bold_font"),
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
