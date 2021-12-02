import 'package:flutter/services.dart';

class Burger{


  String? name,details, image,description;
  int? price;
  bool? fav;

  Burger(Map<String, dynamic> jsonObject ){
    this.name = jsonObject["name"];
    this.details = jsonObject["details"];
    this.image = jsonObject["image"];
    this.description = jsonObject["description"];

    this.price =  int.parse(jsonObject["price"]);
    this.fav = false;


  }

}