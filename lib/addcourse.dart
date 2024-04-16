import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../main.dart';
import '../widgets/custombutton.dart';
import 'controller/course_controller.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _filePath;

  final courseController = CourseController();

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Your Courses'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.04,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Course Title',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  // setState(() {
                  //   _courseTitle = value;
                  // });
                },
              ),
              SizedBox(height: h * 0.01),
              Container(
                height: h * 0.15, 
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText: 'Course Description',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0, 
                    ),
                  ),
                  // decoration: InputDecoration(
                  //   focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide: BorderSide(color: Colors.grey),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide: BorderSide(color: Colors.grey),
                  //   ),
                  //   hintText: 'Course Description',
                  // hintStyle: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 18.0, // Adjust hint text font size
                  // ),
                  // ),
                  // style: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 18.0, // Adjust text font size
                  // ),
                  // onChanged: (value) {
                  //   setState(() {
                  //     _courseTitle = value;
                  //   });
                  // },
                ),
              ),
              // SizedBox(height: h * 0.02),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Add course',
              //       style: TextStyle(fontSize: 28, color: Colors.white),
              //     ),
              //     SizedBox(
              //       height: h * 0.02,
              //     ),
              //     // CustomButton(onPressed: _openFilePicker, title: 'Add file'),
              //     // IconButton(
              //     //   icon: Icon(
              //     //     Icons.add_circle,
              //     //     color: Colors.white,
              //     //     size: 28,
              //     //   ),
              //     //   onPressed:
              //     //       _openFilePicker, // Call method to open file picker
              //     // ),
              //   ],
              // ),
              CustomButton(onPressed: _openFilePicker, title: 'Add file'),
              if (_filePath != null)
                Text('Selected file: $_filePath',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white)), // Show selected file path if any

              // customTextfield('', Icons.title, 'Write a title here', false),

              // SizedBox(
              //   height: h * 0.02,
              // ),
              CustomButton(
                  onPressed: () {
                    if (_filePath != null && titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                      courseController.courseUploadApi(
                          context: context,
                          title: titleController.text,
                          description: descriptionController.text,
                          document: File(_filePath!),
                      ).then((value){
                        titleController.clear();
                        descriptionController.clear();
                        setState(() {
                          _filePath = null;
                        });
                        FocusScope.of(context).unfocus();
                      });
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeScreen(isStudent: false),
                      //   ),
                      // );
                    } else {
                      // Show scaffold message when no file is selected
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red[300],
                        content: Text(
                          'Please fill all the fields before uploading.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  title: 'Upload')
            ],
          ),
        ),
      ),
    );
  }
}
