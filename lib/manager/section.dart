import 'package:flutter/services.dart';

class Section{


  int id = 0;
  String image="";

  Section(Map<String, dynamic> jsonObject ){
    this.id = jsonObject["id"];
    this.image = "https://all-go.net/burger/"+jsonObject["image"];

  }

}