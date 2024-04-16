import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import '../welcome.dart';
import 'models/faculty_model.dart';

double h = 0;
double w = 0;

FacultyModel? currentUser;
String? token, currentUserType;

List<FacultyModel> allFaculties = [];
List<FacultyModel> allStudents = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Auth.setUserRole(Roles.faculty);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFFA18C74),
        appBarTheme: AppBarTheme(
            color: const Color(0xFFA18C74),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
            iconTheme: IconThemeData(color: Colors.white)),
      ),
      home: WelcomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   List<Widget> _widgetOptions = <Widget>[
//     HomePage(), // Index 0: HomePage
//     SignUpPage(), // Index 1: SignUPPage
//     LoginScreen(), // Index 2: LoginScreen
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null, // Set the app bar to null to remove it
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_add),
//             label: 'Sign Up',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.login),
//             label: 'Login',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
