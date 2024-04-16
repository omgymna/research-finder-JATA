import 'package:flutter/material.dart';
import '../auth/signup.dart';
import '../prefs.dart';
import '../main.dart';
import '../widgets/customButton.dart';
import '../widgets/customtextfield.dart';
import '../controller/auth_controller.dart';
import '../utils/constants/utils.dart';

enum LoginType { student, faculty }

class LoginScreen extends StatefulWidget {
  final LoginType loginType;

  LoginScreen({required this.loginType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _rememberMe = false;

  final authController = AuthController();

  getCredentials() async{
    await Prefs.getCredentials().then((value){
      emailController.text = value?['email'] ?? '';
      passwordController.text = value?['password'] ?? '';
    });
  }

  @override
  void initState() {
    getCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            customTextfield("Email", Icons.person, "Enter Your Email", false,
                emailController),
            SizedBox(
              height: h * 0.02,
            ),
            customTextfield("Password", Icons.lock, "Enter Your Password", true,
                passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.grey,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey),
                        value: _rememberMe,
                        onChanged: (checked) {
                          setState(() {
                            _rememberMe = checked!;
                          });
                        }),
                    Text(
                      'Remember Me',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => ForgotPassword()));
                //   },
                //   child: Text(
                //     'Forgot Password?',
                //     style: kLabelStyle,
                //   ),
                // ),
              ],
            ),
            CustomButton(
                title: 'LOG IN',
                onPressed: () async{
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                    if(_rememberMe){
                      await Prefs.saveCredentials(emailController.text, passwordController.text);
                    }
                    authController.loginApi(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text,
                      userType: widget.loginType == LoginType.student ? 'student' : 'faculty',
                    );
                    // Depending on the login type, navigate to different pages
                    // if (widget.loginType == LoginType.student) {
                    //   authController.loginApi(
                    //     email: emailController.text,
                    //     password: passwordController.text,
                    //     userType: 'student',
                    //   );
                    //   // Navigate to studentHomeScreen
                    //   // Navigator.push(
                    //   //   context,
                    //   //   MaterialPageRoute(
                    //   //     builder: (context) => HomeScreen(
                    //   //         isStudent: widget.loginType == LoginType.student),
                    //   //   ),
                    //   // );
                    // } else if (widget.loginType == LoginType.faculty) {
                    //   // Navigate to faculty home screen
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HomeScreen(
                    //           isStudent: widget.loginType == LoginType.student),
                    //     ),
                    //   );
                    // }
                  } else{
                    Utils.toast(context, 'Email and Password Required');
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(
                      color: Colors.white60,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage(
                                    signupType:
                                        widget.loginType == LoginType.student
                                            ? SignupType.student
                                            : SignupType.faculty,
                                  )));
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
