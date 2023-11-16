import 'package:flutter/material.dart';
import 'package:research_finder_jata/addCourse.dart'; 
//import 'package:dropdown_search/dropdown_search.dart';
import 'personalinfo.dart';



class SelectUniversityPage extends StatefulWidget { 
const SelectUniversityPage({Key? key}) : super(key: key); 

@override 
_SelectUniversityPageState createState() => _SelectUniversityPageState(); 
} 

class _SelectUniversityPageState extends State<SelectUniversityPage> { 

  void _handleNextButtonClick() {
    // Navigate to the PersonalInfoPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCoursePage(),
      ),
    );
  }
	
// Initial Selected Value 
String university = 'Abiline Christian University'; 

// List of items in our dropdown menu 
var universities = [	 
	'Abiline Christian University', 
	'Baylor University', 'Dallas College', 'Dallas Baptist University', 'Houston Christian University', 
  'Texas State University',
  'University of North Texas', 
	'University of Texas', 
	'University of Texas - Arlington', 
	'University of Texas - Tyler', 
  'Lamar University', 
	'Midwestern State University', 
	'Rice University', 
  'Sam Houston State University',
  'Wiley College', 
	'University of North Texas at Dallas', 
	'University of Dallas', 
	'Trinity Valley Community College', 'Texas Tech University', 
	'Stephen F. Austin University', 
	'Texas Christian University', 
  'Tarleton State University',
  'Texas A&M University', 
	'Texas A&M University - Commerce', 
	'Southwestern University', 
	'Southern Methodist University', 'Austin Community College', 
	'Central Texas College', 
	'El Paso Community College District', 
  'Lamar Institute of Technology',
  'Laredo College', 
	'Navarro College', 
	'North Central Texas College', 
	'Palo Alto College', 

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
  floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: _handleNextButtonClick,
          backgroundColor: Color(0xFFA18C74),
          child: Icon(Icons.arrow_forward),
        )),

	); 
} 
} 

