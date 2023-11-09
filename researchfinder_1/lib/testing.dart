
//testing api with this- currently can use a placeholder json API but wont load a regular api

import 'package:flutter/material.dart';
import 'package:researchfinder_1/addCourse.dart';
import 'package:researchfinder_1/selectUniversity.dart';
import 'package:http/http.dart' as http;

void main(){
   runApp(MaterialApp(
    title: 'Add Your Courses',
    debugShowCheckedModeBanner: false,
    home: AddCoursePage()
    
   ));
   }


  /*Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const MyHomePage(),
      
    );
  }*/



/*class _MyAppState extends State<MyApp> {

  //creating method for API
  List data = [];
  int _value = 1;

  getData() async{
    final res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    data = jsonDecode(res.body);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context){
    getData();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: DropdownButton(
          items: data.map((e) {
            return DropdownMenuItem(child: Text(e["username"]), value: e["id"],);
          }).toList(),
          onChanged: (v){
            _value = v as int;
          } ,
        )
      )
    );
  }
}*/
