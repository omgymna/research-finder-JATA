import 'package:flutter/material.dart';
import '../homescreen.dart';
import '../main.dart';
import 'auth/login.dart';
import 'prefs.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  checkUser() async{
    await Prefs.getUserType().then((user){
      if(user != null && user != ''){
        debugPrint('type: $user');
        currentUserType = user;
        Prefs.getUser().then((value){
          if(user == 'faculty'){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(isStudent: false),), (route) => false,);
          } else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(isStudent: true),), (route) => false,);
          }
        });
      }
    });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: h * 0.1,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Container(
                height: h / 3,
                width: w * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/welcome1.png"),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.1,
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    color: Color(0xFFA18C74),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    loginType: LoginType.student,
                                  )));
                    },
                    shape: RoundedRectangleBorder(
                      // side: BorderSide(
                      //   color: Colors.black54,
                      // ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minWidth: double.infinity,
                    height: 55,
                    child: Text(
                      "Student Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.025),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 55,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    loginType: LoginType.faculty,
                                  )));
                    },
                    color: Color(0xFFA18C74),
                    shape: RoundedRectangleBorder(
                      // side: BorderSide(
                      //   color: Colors.black54,
                      // ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Faculty Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
