import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:research_finder_jata/main.dart';
import '../api.dart';
import '../prefs.dart';
import '../repository/profile_repository.dart';
import '../utils/constants/utils.dart';

class ProfileController{

  final _api = ProfileRepository();

  Future<void> facultyUpdateApi({
    required BuildContext context,
    required String name,
    required String email,
    required String university,
  }) async{
    Utils.progressDialog(context: context, text: 'Please Wait...');
    Map data = {
      'name' : name,
      'email' : email,
      'university': university,
    };
    await _api.facultyUpdateApi(APIs.facultyUpdateApi, data).then((value){
      Prefs.updateUser(name, email, university);
      Navigator.pop(context);
      Utils.toast(context, 'Profile Updated Successfully!');
    }).onError((error, stackTrace){
      String jsonString = extractJsonFromString(error.toString());
      var jsonError = jsonDecode(jsonString);
      Navigator.pop(context);
      Utils.toast(context, jsonError['message']);
    });
  }

  Future<void> studentUpdateApi({
    required BuildContext context,
    required String name,
    required String email,
    required String university,
  }) async{
    Utils.progressDialog(context: context, text: 'Please Wait...');
    Map data = {
      'name' : name,
      'email' : email,
      'university': university,
    };
    await _api.studentUpdateApi(APIs.studentUpdateApi, data).then((value){
      Prefs.updateUser(name, email, university);
      currentUser!.university = university;
      currentUser!.name = name;
      currentUser!.email = email;
      Navigator.pop(context);
      Utils.toast(context, 'Profile Updated Successfully!');
    }).onError((error, stackTrace){
      debugPrint('eeeeerrrrr ==>>> $error === $stackTrace');
      String jsonString = extractJsonFromString(error.toString());
      var jsonError = jsonDecode(jsonString);
      Navigator.pop(context);
      Utils.toast(context, jsonError['message']);
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
