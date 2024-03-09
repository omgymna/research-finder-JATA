import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/pages/chat_page.dart';
import 'package:firebase_chat/pages/inbox_page.dart';
import 'package:firebase_chat/pages/personal_info_page.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_chat/main.dart';

import 'account_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    int _currentIndex = 0;

  //sign user out
  void signOut(){
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  final List<Widget> _pages = [
    PlaceholderWidget('Home Page'),
    PlaceholderWidget('Search Page'),
    InboxPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA18C74),
        elevation: 0,
        title: const Text('Home Page'),
        actions: [
          //sign out button
          IconButton(
            onPressed: signOut, 
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      //body: _buildUserList(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: const Color(0xFFA18C74),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search), // Changed to Icons.explore
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        },
      ),
    );
  }

}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}