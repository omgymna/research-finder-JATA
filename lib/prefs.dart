import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'models/faculty_model.dart';

class Prefs{

  static Future<void> saveUser(String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(currentUser!.toJson());
    await prefs.setString('loginUser', userJson);
    await prefs.setString('userType', userType);
  }

  static Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('loginUser');
    try{
      Map<String, dynamic> userMap = jsonDecode(userJson!);
      debugPrint('map;; $userMap');
      currentUser = FacultyModel.fromJson(userMap);
    } catch(e){
      debugPrint('e; $e');
    }
  }

  static Future<String?> getUserType() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  static Future<void> updateUser(String name, String email, String university) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser!.name = name;
    currentUser!.email = email;
    currentUser!.university = university;
    String userJson = jsonEncode(currentUser!.toJson());
    await prefs.setString('loginUser', userJson);
  }

  static Future<void> logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    await prefs.setString('loginUser', '');
    await prefs.setString('userType', '');
    await prefs.setString('userToken', '');
  }

  static Future<void> saveCredentials(String email, String password) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginEmail', email);
    await prefs.setString('loginPassword', password);
  }

  static Future<Map<String, String?>?> getCredentials() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String?>? credentials;
    var email = prefs.getString('loginEmail');
    var password = prefs.getString('loginPassword');
    if(email != null && password != null){
      credentials = {
        'email' : email,
        'password' : password
      };
    } else{
      credentials = null;
    }
    return credentials;
  }

  static Future<void> saveToken(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  static Future<String?> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

}
