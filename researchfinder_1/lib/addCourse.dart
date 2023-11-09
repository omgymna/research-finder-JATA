import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class AddCoursePage extends StatefulWidget { 
const AddCoursePage({Key? key}) : super(key: key); 

@override 
_AddCoursePageState createState() => _AddCoursePageState(); 
} 

class _AddCoursePageState extends State<AddCoursePage>{
  bool selected = false;

  List<String> text = [];
  TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _controller,

            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if(_controller.text.length>0){
                    text.add(_controller.text);
                    _controller.clear();
                  } else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Text is empty"),
                    ));
                  }
                });
              },
              child: Text("add"),
            ),
            Text(text.isNotEmpty?text.toString():""),
          ],
        ),
      ),
    );
  }
}