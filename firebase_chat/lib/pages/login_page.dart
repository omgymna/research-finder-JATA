import 'package:firebase_chat/components/my_button.dart';
import 'package:firebase_chat/components/my_text_field.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  final void Function()? onTap;
  const LoginPage ({super.key, required this.onTap});

  @override
  State <LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  //sign in user
  void signIn () async{
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen:false);

    try{
      await authService.signInWithEmailandPassword(
        emailController.text, 
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),


                //logo
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/welcome1.png"),
                    ),
                  ),
                ),

                  const SizedBox(height: 50),

                //Welcome back message
                const Text(
                  'Welcome Back, You\'ve been missed!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //email textfield
                MyTextField(
                  controller: emailController, 
                  hintText: 'Email ', 
                  obscureText: false
                ),

                const SizedBox(height: 10),

                //password text field
                MyTextField(
                  controller: passwordController, 
                  hintText: 'Password', 
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(onTap: signIn, text: 'Sign In'),

                const SizedBox(height: 25,),

                //registering user

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not Registered?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                          'Register Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}