import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:research_finder_jata/homescreen.dart';
import 'package:research_finder_jata/main.dart';
import '../auth/login.dart';
import '../api.dart';
import '../models/faculty_model.dart';
import '../prefs.dart';
import '../repository/auth_repository.dart';
import '../utils/constants/utils.dart';
import 'chat_controller.dart';

class AuthController{

  final _api = AuthRepository();

  void loginApi({
    required BuildContext context,
    required String email,
    required String password,
    required String userType
  }){
    Utils.progressDialog(context: context, text: 'Validating Login...');
    Map data = {
      'email' : email,
      'password' : password,
      'user_type': userType
    };
    _api.loginApi(data).then((value){
      var user = value['user'];
      currentUser = FacultyModel.fromJson(user);
      debugPrint('currentUser: $currentUser');
      ChatController.createUser(currentUser!);
      debugPrint('savingg======>>$userType');
      currentUserType = userType;
      Prefs.saveUser(userType);
      Prefs.saveToken(value['token']);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(isStudent: userType == 'student'),), (route) => false,);
    }).onError((error, stackTrace){
      debugPrint('error: $error: $stackTrace');
      String jsonString = extractJsonFromString(error.toString());
      var jsonError = jsonDecode(jsonString);
      Navigator.pop(context);
      Utils.toast(context, jsonError['message']);
      debugPrint('error api hit==$error=>$stackTrace');
    });
  }

  Future<void> facultySignupApi({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String university,
    required File image,
  }) async {
    Utils.progressDialog(context: context, text: 'Please Wait...');
    Map data = {
      'name' : name,
      'email' : email,
      'password' : password,
      'confirm_password': confirmPassword,
      'university': university,
      'image': image.path,
    };
    await _api.facultySignupApi(
        APIs.facultySignupApi,
        data
    ).then((value){
      // var x = jsonEncode(value);
      // currentUser = UserModel.fromJson(value);
      // debugPrint('currentUser: $currentUser');
      // Prefs.saveUser('faculty');
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(loginType: LoginType.faculty),), (route) => false,);
      Utils.toast(context, 'Signup Successful!\nLogin to Continue');
    }).onError((error, stackTrace){
      String jsonString = extractJsonFromString(error.toString());
      var jsonError = jsonDecode(jsonString);
      Navigator.pop(context);
      Utils.toast(context, jsonError['message']);
      debugPrint('error api hit==$error=>$stackTrace');
    });
  }

  Future<void> studentSignupApi({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String university,
    required File image,
  }) async {
    Utils.progressDialog(context: context, text: 'Please Wait...');
    Map data = {
      'name' : name,
      'email' : email,
      'password' : password,
      'confirm_password': confirmPassword,
      'university': university,
      'image': image.path,
    };
    await _api.studentSignupApi(
        APIs.studentSignupApi,
        data
    ).then((value){
      // var x = jsonEncode(value);
      // currentUser = UserModel.fromJson(value);
      // debugPrint('json x: $x');
      // debugPrint('apiHit Response => $value');
      // Prefs.saveUser('faculty');
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(loginType: LoginType.student),), (route) => false,);
      Utils.toast(context, 'Signup Successful!\nLogin to Continue');
    }).onError((error, stackTrace){
      String jsonString = extractJsonFromString(error.toString());
      var jsonError = jsonDecode(jsonString);
      Navigator.pop(context);
      Utils.toast(context, jsonError['message']);
      debugPrint('error api hit==$error=>$stackTrace');
    });
  }

  String extractJsonFromString(String input) {
    int startIndex = input.indexOf('{');
    int endIndex = input.lastIndexOf('}') + 1;
    if (startIndex != -1 && endIndex != -1) {
      return input.substring(startIndex, endIndex);
    }
    return '';
  }

}
