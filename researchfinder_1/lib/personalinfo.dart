import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFC2BEB4), // Changed to full opacity
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
              const SizedBox(height: 30.0),
              const Text(
                'University:',
                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFC2BEB4), // Changed to full opacity
                ),
                child: const Center(
                  child: Text("North Texas University", textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Major:',
                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFC2BEB4), // Changed to full opacity
                ),
                child: const Center(
                  child: Text("Computer Science Engineer", textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Email:',
                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFC2BEB4), // Changed to full opacity
                ),
                child: const Center(
                  child: Text("xxxxxxx@my.unt.edu", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
