import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shake_burger/main.dart';
import 'package:flutter/material.dart';
import 'package:shake_burger/manager/burger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import "dart:convert" show utf8;
Color primaryColor = Color.fromARGB(255, 115, 171, 66);

class BurgersList extends StatefulWidget {
  MyShakeBurger? app;
  Function? function;

  BurgersList(MyShakeBurger app,Function function) {
    this.app = app;
    this.function = function;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BurgersState(app!,function!);
  }
}

int selected = 0;

class BurgersState extends State<BurgersList> {
  List<Burger> burgers = <Burger>[];
  MyShakeBurger? app;
  Function? function;

  BurgersState(MyShakeBurger app,Function function) {
    this.app=app;
    this.function = function;
  }
  int lastSection = -1;
  @override
  Widget build(BuildContext context) {
    if(lastSection != app!.current_section){
      lastSection = app!.current_section;
      updateListView(lastSection);

    }

    // TODO: implement build
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(right: 15, left: 15),
      child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 25.0,
          itemCount: burgers.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                app!.openActivity(burgers[i]);
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 59),
                    child: Card(
                      color: burgers[i].fav ? primaryColor : Colors.white,
                      elevation: 2.0,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 0.0,
                        margin: EdgeInsets.all(1),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 12, top: 70),
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 15, bottom: 5),
                                        child: Text(
                                          burgers[i].name,
                                          maxLines: 1,
                                          style: TextStyle(color: burgers[i].fav ? primaryColor:Colors.black, fontSize: 18, fontFamily: "futura_bold_font"),
                                        )),
                                    Text(
                                      burgers[i].details,
                                      style: TextStyle(color: Color.fromRGBO(134, 134, 134, 1), fontSize: 14, fontFamily: "futura_medium_bt"),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 18, bottom: 20),
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "AED ",
                                              maxLines: 1,
                                              style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 12, fontFamily: "futura_medium_bt"),
                                            ),
                                            Text(
                                              burgers[i].price.toString(),
                                              maxLines: 1,
                                              style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: "futura_medium_bt"),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )


                  ,
                  ),

                  Column(

                    children: [


                   Container(margin : EdgeInsets.only(bottom: 50),child:

            CachedNetworkImage(
            placeholder: (context,url ) => const CircularProgressIndicator(),
            imageUrl: burgers[i].image,
            width: 120,
            height: 120,

            )



                 ),


                      Container(
                        margin: EdgeInsets.all(10),

                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          child: Image(
                            height: 40,
                            width: 40,
                            image: AssetImage(burgers[i].fav ?   "images/fav_select.png":"images/fav_unselect.png"),
                          ),
                          onTap: (){
                            setState(() {
                              burgers[i].fav = !burgers[i].fav;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  void updateListView(int i) async {

    List<Burger> newList = <Burger>[];
    var url = "https://all-go.net/burger/burgers.php?id="  + i.toString();

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      var string = utf8.decode(response.bodyBytes);

     Map<String , dynamic> object = convert.jsonDecode(string);

     List<dynamic> list = object["list"];

     Burger top = Burger(object["top"]);
     function!(top);
      list.forEach((element) {
        newList.add(Burger(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    setState(() {
      this.burgers = newList;
      if(app != null ){
        app!.hideLoading();
      }
    });


  }

  Future<void> stackHelp() async {}
}
