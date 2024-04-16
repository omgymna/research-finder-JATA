import 'package:flutter/material.dart';

Widget customTextfield(String text, IconData preIcon, String hinttext,
        bool obscure, TextEditingController controller) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          // alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFFC2BEB4), // Box color
            borderRadius: BorderRadius.circular(10.0), // Box shape
          ),
          height: 55,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: controller,
            obscureText: obscure,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                preIcon,
                color: Colors.white,
              ),
              hintText: hinttext,
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
