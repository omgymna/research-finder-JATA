
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:research_finder_jata/model/user.dart';
import 'package:research_finder_jata/provider/firebase_provider.dart';
import 'package:research_finder_jata/view/widgets/user_item.dart';


class ChatsScreen extends StatefulWidget{
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
          .getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final userData = [
    UserModel(
      uid: '1',
      name: 'Hazy',
      email: 'test@test.test',
      image: 'https://i.pravatar.cc/150?img=0',
      isOnline: true,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '1',
      name: 'Charlotte',
      email: 'test@test.test',
      image: 'https://i.pravatar.cc/150?img=0',
      isOnline: false,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '2',
      name: 'Ahmed',
      email: 'test@test.test',
      image: 'https://i.pravatar.cc/150?img=0',
      isOnline: true,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '3',
      name: 'Prateek',
      email: 'test@test.test',
      image: 'https://i.pravatar.cc/150?img=0',
      isOnline: false,
      lastActive: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text('Chats'),
          ),
          body: Consumer<FirebaseProvider>(
            builder: (context, value, child) { 
              return ListView.separated(
            padding: 
                  const EdgeInsets.symmetric(horizontal: 16), 
            itemCount: value.users.length,
            separatorBuilder: (context, index)=>
            const SizedBox(height: 10),
            itemBuilder: (context, index) => 
                UserItem(user: value.users[index]),
          );
       }),
     );
}