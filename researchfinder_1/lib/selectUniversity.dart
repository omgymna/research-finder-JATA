import 'package:flutter/material.dart'; 
//import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MyHomePage extends StatefulWidget { 
const MyHomePage({Key? key}) : super(key: key); 

@override 
_MyHomePageState createState() => _MyHomePageState(); 
} 
/*
class _MyHomePageState extends State<MyHomePage> { 
	
// Initial Selected Value 
String university = 'Abiline Christian University'; 

// List of items in our dropdown menu 
var universities = [	 
	'Abiline Christian University', 
	'Item 2', 'Item 3', 'Item 4', 'Item 5', 
  'Texas State University',
  'Item 6', 
	'Item 7', 
	'Item 8', 
	'Item 9', 
  'Item 10', 
	'Item 11', 
	'Item 12', 
  '13',
  'Item 14', 
	'Item 15', 
	'Item 16', 
	'Item 17', 'Item 19', 
	'Item 18', 
	'Item 20', 
  'Texas',
  'Item 21', 
	'Item 22', 
	'Item 23', 
	'Item 23', 'Item 25', 
	'Item 26', 
	'Item 50', 
  'Texas University',
  'Item 27', 
	'Item 28', 
	'Item 29', 
	'Item 30', 

]; 
@override 
Widget build(BuildContext context) { 
	return Scaffold( 
	appBar: AppBar( 
		title: const Text("Select your university"), 
	), 
	body: Center( 
		child: Column( 
		mainAxisAlignment: MainAxisAlignment.center, 
		children: [ 
			DropdownButton( 
				
			// Initial Value 
			value: university, 
				
			// Down Arrow Icon 
			icon: const Icon(Icons.keyboard_arrow_down),	 
				
			// Array list of items 
			items: universities.map((String items) { 
				return DropdownMenuItem( 
				value: items, 
				child: Text(items), 
				); 
			}).toList(), 
			// After selecting the desired option,it will 
			// change button value to selected value 
			onChanged: (String? newValue) { 
				setState(() { 
				university = newValue!; 
				}); 
			}, 
			), 
		], 
		), 
	), 
	); 
} 
} 
*/
class _MyHomePageState extends State<MyHomePage> {
  String? dropdownvalue;

  Future<List<String>> getAllCategory() async {
    var baseUrl = "http://universities.hipolabs.com";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element["ClassName"]);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<String>>(
              future: getAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  return DropdownButton(
                    // Initial Value
                    value: dropdownvalue ?? data[0],

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: data.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}