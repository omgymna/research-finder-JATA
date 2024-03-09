import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/pages/chat_page.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_chat/main.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign user out
  void signOut(){
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Color(0xFFA18C74),
        elevation: 0,
        title: const Text('Inbox'),
        actions: [
          //sign out button
          IconButton(
            onPressed: signOut, 
            icon: const Icon(Icons.logout),
          ),
        ],
      ),*/
      body: _buildUserList(),
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
      return Container(
        decoration: BoxDecoration (
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                ListTile(
            title: Text(
              data['email'],
              textAlign: TextAlign.center,),
            onTap: (){
              //pass the clicked user's UID to the chat page
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
              ),
              );
            },
          ),
          /*child: ListTile(
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
          ),*/
              ]
        ),
        ),
      );
    }
    else{
      //return empty container
      return Container();
    }
  }
}