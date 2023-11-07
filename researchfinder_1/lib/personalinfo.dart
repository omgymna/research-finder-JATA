import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xB29FA0FF),
                  radius: 80,
                  child: Text(
                    "Photo",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: John Doe',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Gender: Male',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              'University:',
              style: TextStyle(fontSize: 18.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0x9BAA79FF),
              ),
              child: Center(
                child: Text("North Texas University", textAlign: TextAlign.center),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Major:',
              style: TextStyle(fontSize: 18.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0x9BAA79FF),
              ),
              child: Center(
                child: Text("Computer Science Engineer", textAlign: TextAlign.center),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0x9BAA79FF),
              ),
              child: Center(
                child: Text("xxxxxxx@my.unt.edu", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}