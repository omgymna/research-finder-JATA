import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../api.dart';
import '../models/course_model.dart';
import '../repository/course_repository.dart';
import '../utils/constants/utils.dart';

class CourseController{

  final _api = CourseRepository();

  Future<void> courseUploadApi({
    required BuildContext context,
    required String title,
    required String description,
    required File document,
  }) async{
    Utils.progressDialog(context: context, text: 'Adding Course...');
    Map data = {
      'name' : title,
      'description' : description,
      'file' : document.path,
    };
    await _api.courseUploadApi(APIs.courseAddApi, data).then((value){
      Navigator.pop(context);
      Utils.toast(context, 'Successful!\nCourse has been uploaded.');
    }).onError((error, stackTrace){
      debugPrint('>>>> $error == > $stackTrace');
      String jsonString = extractJsonFromString(error.toString());
      var jsonError = jsonDecode(jsonString);
      Navigator.pop(context);
      Utils.toast(context, jsonError['message']);
      debugPrint('error api hit==$error=>$stackTrace');
    });
  }

  Future<List<CourseModel>> fetchMyCourses({required BuildContext context}) async{
    List<CourseModel> courses = [];
    await _api.fetchMyCoursesApi().then((value){
      courses = parseCourses(jsonEncode(value).toString());
      return courses;
    }).onError((error, stackTrace){
      Utils.toast(context, error.toString());
      return courses;
    });
    return courses;
  }

  Future<List<CourseModel>> fetchFacultyCourses({required BuildContext context, required String id}) async{
    List<CourseModel> courses = [];
    await _api.fetchFacultyCoursesApi(id).then((value){
      courses = parseCourses(jsonEncode(value).toString());
      return courses;
    }).onError((error, stackTrace){
      Utils.toast(context, error.toString());
      return courses;
    });
    return courses;
  }

  Future<void> courseDeleteApi({
    required BuildContext context,
    required String id,
  }) async{
    Utils.progressDialog(context: context, text: 'Requesting Deletion...');
    await _api.courseDeleteApi(id).then((value){
      Navigator.pop(context);
      Utils.toast(context, 'Successful!\nCourse has been deleted.');
    }).onError((error, stackTrace){
      debugPrint('>>>> $error == > $stackTrace');
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

  List<CourseModel> parseCourses(String jsonString) {
    final jsonMap = json.decode(jsonString);
    final code = jsonMap['code'];
    if (code == 200) {
      final coursesJson = jsonMap['courses'];
      return List<CourseModel>.from(coursesJson.map((courseJson) => CourseModel.fromJson(courseJson)));
    } else {
      return [];
    }
  }

}
