import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/pages/chat_page.dart';
import 'package:firebase_chat/pages/inbox_page.dart';
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
    SignUpRolePicker(),
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

  //build a list of users except for current logged in user

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(),
     builder: (context, snapshot) {
       if(snapshot.hasError){
        return const Text('error');
       }
       if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('loading...');
       }

       return ListView(
        children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc))
        .toList(),
       );
     },
    );
  }

  //build individual list items
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users but current user
    if(_auth.currentUser!.email != data['email']){
      return ListTile(
        title: Text(data['email'],),
        onTap: (){
          //pass the clicked user's UID to the chat page
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
            receiverUserEmail: data['email'],
            receiverUserID: data['uid'],
          ),
          ),
          );
        },
      );
    }
    else{
      //return empty container
      return Container();
    }
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