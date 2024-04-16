import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/auth_controller.dart';
import '../main.dart';
import '../utils/constants/utils.dart';
import '../widgets/customButton.dart';
import '../widgets/customtextfield.dart';

enum SignupType { student, faculty }

class SignUpPage extends StatefulWidget {
  final SignupType signupType;
  SignUpPage({required this.signupType});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController universityController = TextEditingController();

  String university = 'Abiline Christian University';

  String image = '';

  // List of items in  dropdown menu
  var universities = [
    'Abiline Christian University',
    'Baylor University',
    'Dallas College',
    'Dallas Baptist University',
    'Houston Christian University',
    'Texas State University',
    'University of North Texas',
    'University of Texas',
    'University of Texas - Arlington',
    'University of Texas - Tyler',
    'Lamar University',
    'Midwestern State University',
    'Rice University',
    'Sam Houston State University',
    'Wiley College',
    'University of North Texas at Dallas',
    'University of Dallas',
    'Trinity Valley Community College',
    'Texas Tech University',
    'Stephen F. Austin University',
    'Texas Christian University',
    'Tarleton State University',
    'Texas A&M University',
    'Texas A&M University - Commerce',
    'Southwestern University',
    'Southern Methodist University',
    'Austin Community College',
    'Central Texas College',
    'El Paso Community College District',
    'Lamar Institute of Technology',
    'Laredo College',
    'Navarro College',
    'North Central Texas College',
    'Palo Alto College',
  ];

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 27.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFA18C74),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   'Sign Up',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontFamily: 'OpenSans',
                //     fontSize: 30.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: h * 0.02),
                GestureDetector(
                  onTap: () async {
                 await ImagePicker().pickImage(source: ImageSource.gallery).then((file){
                   if(file != null){
                     setState(() {
                       image = file.path;
                     });
                   } else{
                     Utils.toast(context, 'Something went wrong!');
                   }
                 });
                },
                  child: CircleAvatar(
                    backgroundColor: Colors.white60,
                    radius: 50,
                    child: image.isEmpty ? Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey[600],
                      size: 30,
                    ) : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(File(image), fit: BoxFit.cover, height: 100, width: 100,)),

                  ),
                ),
                SizedBox(height: h * 0.02),
                customTextfield("Name", Icons.person, "Enter Your Username",
                    false, nameController),
                SizedBox(height: h * 0.01),
                customTextfield("Email", Icons.email, "Enter Your Email", false,
                    emailController),
                SizedBox(height: h * 0.01),

                customTextfield("Password", Icons.lock, "Enter Your Password",
                    true, passwordController),
                SizedBox(height: h * 0.01),
                customTextfield("Confirm Password", Icons.lock,
                    "Enter Confirm Password", true, confirmPasswordController),

                SizedBox(height: h * 0.01),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select your University',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )),

                SizedBox(height: h * 0.01),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFC2BEB4), 
                    borderRadius: BorderRadius.circular(10.0), 
                  ),
                  height: 56,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      // Initial Value
                      value: university,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),

                      // Array list of items
                      items: universities.map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(
                              color: university == items
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      
                      onChanged: (String? newValue) {
                        setState(() {
                          university = newValue!;
                        });
                      },
                      
                      style: TextStyle(color: Colors.black),
                      // Dropdown background color
                      dropdownColor: Colors
                          .grey[400],      
                    ),
                  ),
                ),

                SizedBox(height: h * 0.01),
                CustomButton(
                  title: 'SIGN UP',
                  onPressed: () {
                    if(image.isEmpty){
                      Utils.toast(context, 'Picture is Required!');
                    } else{
                      if(passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                        if(passwordController.text != confirmPasswordController.text){
                          Utils.toast(context, 'Passwords do not match!');
                        } else{
                          if(nameController.text.isEmpty || emailController.text.isEmpty){
                            Utils.toast(context, 'Please Fill all the details');
                          } else{
                            if(widget.signupType == SignupType.student){
                              debugPrint('student');
                              authController.studentSignupApi(
                                context: context,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                university: university,
                                image: File(image),
                              );
                            } else{
                              authController.facultySignupApi(
                                context: context,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                university: university,
                                image: File(image),
                              );
                            }
                          }
                        }
                      } else{
                        Utils.toast(context, 'Password is Missing!');
                      }
                    }
                    // Navigate to HomeScreen with appropriate student flag
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomeScreen(
                    //       isStudent: widget.signupType == SignupType.student,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
