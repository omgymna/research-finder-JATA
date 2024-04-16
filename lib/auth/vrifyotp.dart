import 'package:custom_otp_textfield/custom_otp_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/resetpassword.dart';
import '../main.dart';
import '../widgets/custombutton.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios_rounded),
        title: const Text(
          "Verification",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.02,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "We have sent a pin to your Email \n address to verifcation",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )),
            SizedBox(
              height: h * 0.03,
            ),
            CustomOTPTextField(
              deviceWidth: MediaQuery.of(context).size.width,
              textEditingController: otpController,
              inputBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(width: 1.3),
              ),
              boxSize: w * 0.13,
              cursorHeight: h * 0.03,
              cursorColor: Colors.black12,
            ),
            SizedBox(
              height: h * 0.02,
            ),
            CustomButton(
              title: "Verify OTP",
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const ResetPassword()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t receive code?"),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
