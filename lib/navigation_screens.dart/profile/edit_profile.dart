import 'package:flutter/material.dart';

import '../../controller/profile_controller.dart';
import '../../main.dart';
import '../../prefs.dart';
import '../../utils/constants/utils.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();

  String university = '';

  var universities = [
    'Abiline Christian University',
    'Baylor University',
    'Dallas College',
    'Dallas Baptist University',
    'Houston Christian University',
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
    'Trinity Valley Community College',
    'Texas Tech University',
    'Stephen F. Austin University',
    'Texas Christian University',
    'Tarleton State University',
    'Texas A&M University',
    'Texas A&M University - Commerce',
    'Southwestern University',
    'Southern Methodist University',
    'Austin Community College',
    'Central Texas College',
    'El Paso Community College District',
    'Lamar Institute of Technology',
    'Laredo College',
    'Navarro College',
    'North Central Texas College',
    'Palo Alto College',
  ];

  final profileController = ProfileController();

  @override
  void initState() {
    _nameController.text = currentUser!.name!;
    _emailController.text = currentUser!.email!;
    university = currentUser!.university!;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            // TextFormField(
            //   controller: _universityController,
            //   decoration: InputDecoration(labelText: 'University Name'),
            // ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC2BEB4),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 56,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  // Initial Value
                  value: university,

                  // Down Arrow Icon
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),

                  // Array list of items
                  items: universities.map((String items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                          color: university == items
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      university = newValue!;
                    });
                  },

                  style: TextStyle(color: Colors.black),
                  // Dropdown background color
                  dropdownColor: Colors
                      .grey[400],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
               String? type = await Prefs.getUserType();
               if(_emailController.text.isNotEmpty && _nameController.text.isNotEmpty){
                 if(type != null){
                   if(type == 'student'){
                     profileController.studentUpdateApi(
                         context: context,
                         name: _nameController.text,
                         email: _emailController.text,
                         university: university);
                   } else{
                     profileController.facultyUpdateApi(
                         context: context,
                         name: _nameController.text,
                         email: _emailController.text,
                         university: university);
                   }
                 } else{
                   Utils.toast(context, 'Something went wrong!');
                 }
               } else{
                 Utils.toast(context, 'Name and Email is Required!');
               }
                // Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
