import 'package:flutter/material.dart';
import '../mycourses.dart';
import '../navigation_screens.dart/InboxPages/chatroompage.dart';
import '../navigation_screens.dart/Student%20HomePage/student_homepage.dart';
import '../navigation_screens.dart/profile/profile.dart';
import 'main.dart';
import 'prefs.dart';

class HomeScreen extends StatefulWidget {
  final bool isStudent;
  const HomeScreen({super.key, required this.isStudent});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    Prefs.getToken().then((value){
      token = value;
      debugPrint('token===>$value');
    });
    super.initState();
    _updatePages();
  }

  void _updatePages() {
    if (widget.isStudent) {
      _pages = [
        StudentHomePage(),
        // SearchListView(),
        ChatRoomsPage(student: true,),
        ProfilePage(),
      ];
    } else {
      _pages = [
        MyCoursesPage(),
        ChatRoomsPage(student: false,),
        ProfilePage(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
