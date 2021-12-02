import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:shake_burger/manager/section.dart';
import 'package:cached_network_image/cached_network_image.dart';

Color primaryColor = Color.fromARGB(255, 115, 171, 66);

class StudentsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentsState();
  }
}
int selected= 0;
class StudentsState extends State<StudentsList> {
  List<Section> sectionsList = <Section>[];

  @override
  Widget build(BuildContext context) {
    updateListView();

    // TODO: implement build
    return getStudentsList();
  }

  ListView getStudentsList() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sectionsList.length,
        itemBuilder: (context, i) {
          return Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selected = i;
                });
              },
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xF55A335).withOpacity(i == selected? 0.1 : 0.0),
                            spreadRadius: 0.05,
                            blurRadius: 2,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image(
                        image: AssetImage(i == selected ? "images/section_selected.png" : "images/section_unselected.png"),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child:
                      CachedNetworkImage(
                        placeholder: (context,url ) => const CircularProgressIndicator(),
                        imageUrl: sectionsList[i].image,
                        width: 35,
                        height: 35,
                        color: i==selected ? primaryColor:Colors.black,

                      )
                      /*
                      Image(
                        image: AssetImage("images/loading.png"),
                        width: 35,
                        height: 35,
                        color: primaryColor,
                      ),

                       */
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 8, right: 8),
              ),
            ),
          );
        });
  }

  Color isPassed(int value) {
    switch (value) {
      case 1:
        return Colors.amber;
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.amber;
    }
  }

  Icon getIcon(int value) {
    switch (value) {
      case 1:
        return Icon(Icons.check);
        break;
      case 2:
        return Icon(Icons.close);
        break;
      default:
        return Icon(Icons.check);
    }
  }

  void updateListView() async {
    List<Section> newList = <Section>[];
    var url = 'https://all-go.net/burger/sections.php';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> list = convert.jsonDecode(response.body);
      list.forEach((element) {
        newList.add(Section(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    setState(() {
      this.sectionsList = newList;
    });
  }

  Future<void> stackHelp() async {}
}
