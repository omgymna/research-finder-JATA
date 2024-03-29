import 'package:flutter/material.dart';
import 'select_university_page.dart'; // Import the PersonalInfoPage

enum SignUpRole { student, faculty }

class SignUpRolePicker extends StatefulWidget {
  @override
  State<SignUpRolePicker> createState() => _SignUpRolePickerState();
}

class _SignUpRolePickerState extends State<SignUpRolePicker> {
  SignUpRole _role = SignUpRole.student;

  void _handleNextButtonClick() {
    // Navigate to the PersonalInfoPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectUniversityPage(),
        //builder: (context) => PersonalInfoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Color(0xFFA18C74),
        title: Text('Choose Role'),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                'Student or Faculty',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text(
                'I am a Student',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              leading: Radio<SignUpRole>(
                value: SignUpRole.student,
                groupValue: _role,
                onChanged: (value) {
                  setState(() {
                    _role = value!;
                    print('picked sign-up role: ' + value.toString());
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                'I am a Faculty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              leading: Radio<SignUpRole>(
                value: SignUpRole.faculty,
                groupValue: _role,
                onChanged: (value) {
                  setState(() {
                    _role = value!;
                    print('picked sign-up role: ' + value.toString());
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: _handleNextButtonClick,
          backgroundColor: const Color(0xFFA18C74),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

