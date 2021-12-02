import 'package:flutter/services.dart';

class Burger{


  String name="",details="", image="",description="";
  int price=0;
  bool fav = false;
  bool empty = false;
  Burger.empty(){
    empty = true;
  }
  Burger(Map<String, dynamic> jsonObject ){
    this.name = jsonObject["name"];
    this.details = jsonObject["details"];
    this.image = "https://all-go.net/burger/"+ jsonObject["image"];
    this.description = jsonObject["description"];

    this.price = int.parse(jsonObject["price"]);
    this.fav = false;
this.empty = false;

  }

}