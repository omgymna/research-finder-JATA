/*
testing api with this- currently can use a placeholder json API but wont load a regular api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:researchfinder_1/selectUniversity.dart';
import 'package:http/http.dart' as http;

void main(){
   runApp(MaterialApp(
    title: 'Flutter DropDownButton',
    debugShowCheckedModeBanner: false,
    home: MyApp()
    
   ));
   }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();


  /*Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const MyHomePage(),
      
    );
  }*/
}


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
*/