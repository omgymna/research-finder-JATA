import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  //sign up user
  void signUp () async{
      if(passwordController.text != confirmPasswordController.text){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords don't match!"),
          ),
        );
        return;
      }

      final authService = Provider.of<AuthService>(context, listen: false);
      try{
        await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text,);
      }catch(e){
         // ignore: use_build_context_synchronously
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
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
                Icon(
                  Icons.message,
                  size: 100 ,
                  color: Colors.grey[800],
                  ),

                  const SizedBox(height: 50),

                //create account message
                const Text(
                  'Let\'s create an account for you',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //name textfield
                MyTextField(
                  controller: nameController, 
                  hintText: 'Name ', 
                  obscureText: false
                ),

                const SizedBox(height: 10),


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

                const SizedBox(height: 10),

                //confirm password text field
                MyTextField(
                  controller: confirmPasswordController, 
                  hintText: 'Confirm Password', 
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //sign up button
                MyButton(onTap: signUp, text: 'Sign Up'),

                const SizedBox(height: 25),

                //registering user

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have An Account?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
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