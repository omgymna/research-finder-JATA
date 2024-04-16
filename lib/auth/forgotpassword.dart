import 'package:flutter/material.dart';
import '../auth/vrifyotp.dart';
import '../main.dart';
import '../widgets/customButton.dart';
import '../widgets/customtextfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotController = TextEditingController();
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
              height: h * 0.03,
            ),
            customTextfield('Email', Icons.email, 'Enter your email', false,
                forgotController),
            CustomButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VerifyOTPPage()));
                },
                title: 'Send OTP')
          ],
        ),
      ),
    );
  }
}
