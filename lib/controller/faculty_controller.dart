import 'dart:convert';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/faculty_model.dart';
import '../repository/faculty_repsitory.dart';
import '../utils/constants/utils.dart';

class FacultyController{

  final _api = FacultyRepository();

  Future<List<FacultyModel>> getFacultyList({required BuildContext context}) async{
    List<FacultyModel> faculties = [];
    await _api.facultyListApi().then((value){
      faculties = parseFaculties(jsonEncode(value).toString());
      return faculties;
    }).onError((error, stackTrace){
      debugPrint('error; $error => $stackTrace');
      Utils.toast(context, error.toString());
      return faculties;
    });
    debugPrint('before: $faculties');
    allFaculties.addAll(faculties);
    debugPrint('after: $allFaculties');
    return faculties;
  }

  List<FacultyModel> parseFaculties(String jsonString) {
    final jsonMap = json.decode(jsonString);
    final code = jsonMap['code'];
    if (code == 200) {
      final facultiesJson = jsonMap['faculties'];
      return List<FacultyModel>.from(facultiesJson.map((courseJson) => FacultyModel.fromJson(courseJson)));
    } else {
      return [];
    }
  }

}
