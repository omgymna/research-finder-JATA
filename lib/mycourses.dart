import 'package:flutter/material.dart';
import 'package:research_finder_jata/screens/pdf_screen.dart';
import '../addcourse.dart';
import 'api.dart';
import 'controller/course_controller.dart';
import 'controller/student_controller.dart';
import 'models/course_model.dart';

class MyCoursesPage extends StatefulWidget {
  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {

  final courseController = CourseController();
  final studentController = StudentController();

  @override
  void initState() {
    studentController.getStudentList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Courses'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
        //     onPressed: () {
        //       setState(() {
        //         _isGridView = !_isGridView; // Toggle between list and grid view
        //       });
        //     },
        //   ),
        // ],
      ),
      body: _buildCourses(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCourse())).then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCourses() {
    
    // List<String> coursestitle = [
    //   'Course Name',
    //   'Course Name',
    //   'Course Name',
    //   'Course Name',
    //   'Course 5',
    //   'Course 6',
    //   'Course 7',
    //   'Course 8',
    //   'Course 9',
    //   'Course 10',
    // ];

    // if (_isGridView) {
    //   // Build grid view
    //   return GridView.builder(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2, // Number of columns
    //       crossAxisSpacing: 16.0,
    //       mainAxisSpacing: 16.0,
    //     ),
    //     itemCount: coursestitle.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return _buildCourseItem(coursestitle[index]);
    //     },
    //   );
    // } else {
    //   // Build list view

    return FutureBuilder(
        future: courseController.fetchMyCourses(context: context),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else{
            if(snapshot.hasError){
              debugPrint('${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if(snapshot.hasData){
              return snapshot.data!.isNotEmpty ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCourseItem(
                    snapshot.data![index],
                    context,
                    () {
                      setState(() {

                      });
                    },
                  );
                },
              ) : Center(child: Text('No courses added yet!'),);
            }
            return Center(child: Text('No courses added yet!'),);
          }
        },
    );

    // return ListView.builder(
    //   itemCount: coursestitle.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return _buildCourseItem(coursestitle[index]);
    //   },
    // );
  }
}

Widget _buildCourseItem(
    CourseModel course,
    BuildContext context,
    VoidCallback afterDelete,
) {
  final courseController = CourseController();
  debugPrint('id: ${course.sId}');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFScreen(course: course.name!, file: '${APIs.filesBaseUrl}/${course.fileUrl!}'),));
        // print('Clicked on course: $courseName');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 155, 156, 157), 
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              course.name!,
              style: TextStyle(
                color: Colors.black, 
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // FaIcon(
            //   Icons.description,
            //   size: 40,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.picture_as_pdf,
                  color: Color.fromARGB(255, 105, 28, 22),
                ),
                SizedBox(width: 10,),
                Expanded(child: Text(
                  textAlign: TextAlign.center,
                  course.description!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    // fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(width: 10,),
                // Icon(
                //   Icons.download,
                //   color: Colors.black,
                // ),
                GestureDetector(
                  onTap: () async{
                    await courseController.courseDeleteApi(context: context, id: course.sId!).then((value){
                      afterDelete();
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
