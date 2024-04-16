import 'package:flutter/material.dart';
import '../main.dart';
import '../welcome.dart';
import '../widgets/customButton.dart';
import '../widgets/customtextfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.035),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.02,
            ),
            customTextfield('New Password', Icons.email, 'Enter new password',
                false, resetPasswordController),
            SizedBox(
              height: h * 0.02,
            ),
            customTextfield('Confirm Password', Icons.email,
                'Enter confirm password', false, confirmPasswordController),
            CustomButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
                title: 'Save')
          ],
        ),
      ),
    );
  }
}
