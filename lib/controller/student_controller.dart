import 'dart:convert';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/faculty_model.dart';
import '../repository/student_repository.dart';
import '../utils/constants/utils.dart';

class StudentController{

  final _api = StudentRepository();

  Future<List<FacultyModel>> getStudentList({required BuildContext context}) async{
    List<FacultyModel> students = [];
    await _api.studentListApi().then((value){
      students = parseStudents(jsonEncode(value).toString());
      return students;
    }).onError((error, stackTrace){
      debugPrint('error; $error => $stackTrace');
      Utils.toast(context, error.toString());
      return students;
    });
    debugPrint('before: $students');
    allStudents.clear();
    allStudents.addAll(students.reversed.toList());
    debugPrint('after: $allStudents');
    return students;
  }

  List<FacultyModel> parseStudents(String jsonString) {
    final jsonMap = json.decode(jsonString);
    final code = jsonMap['code'];
    if (code == 200) {
      final studentsJson = jsonMap['students'];
      return List<FacultyModel>.from(studentsJson.map((courseJson) => FacultyModel.fromJson(courseJson)));
    } else {
      return [];
    }
  }

}