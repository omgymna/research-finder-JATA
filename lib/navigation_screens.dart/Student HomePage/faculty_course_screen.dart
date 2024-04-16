import 'package:flutter/material.dart';
import '../../api.dart';
import '../../controller/course_controller.dart';
import '../../main.dart';
import '../../screens/pdf_screen.dart';
import '../InboxPages/inbox.dart';

class FacultyCourseScreen extends StatefulWidget {
  final String name, id, profile, userId;
  const FacultyCourseScreen({super.key, required this.userId,
    required this.name, required this.id, required this.profile});

  @override
  State<FacultyCourseScreen> createState() => _FacultyCourseScreenState();
}

class _FacultyCourseScreenState extends State<FacultyCourseScreen> {

  final courseController = CourseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: courseController.fetchFacultyCourses(context: context, id: widget.userId),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              } else{
                if(snapshot.hasError){
                  debugPrint('${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if(snapshot.hasData){
                  return snapshot.data!.isNotEmpty ? SizedBox(
                      height: h - 10,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    PDFScreen(
                                        course: snapshot.data![index].name!,
                                        file: '${APIs.filesBaseUrl}/${snapshot.data![index].fileUrl!}'),));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(255, 219, 177, 109)),
                                    color: Colors.amber[50],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/pdfIcon.png',
                                            // scale: 10,
                                            height: 22,
                                          ),
                                          Text(
                                            snapshot.data![index].name!,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          ),
                                          Text(''),
                                          Text(''),
                                          IconButton(
                                            icon: Icon(
                                              Icons.message,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => InboxPage(
                                                        profile: widget.profile,
                                                        name: widget.name,
                                                        id: widget.id,
                                                      )));
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Description:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                               snapshot.data![index].description!,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )) : Center(child: Text('No course was Found!'),);
                }
                return Center(child: Text('No course was found!'),);
              }
            },
        ),
        // child: Container(
        //   height: 270,
        //   decoration: BoxDecoration(
        //       border:
        //           Border.all(color: const Color.fromARGB(255, 219, 177, 109)),
        //       color: Colors.amber[50],
        //       borderRadius: BorderRadius.circular(10)),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Image.asset(
        //               'assets/pdfIcon.png',
        //               // scale: 10,
        //               height: 22,
        //             ),
        //             Text(
        //               'PDF file name',
        //               style: TextStyle(
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.w500,
        //                   color: Colors.black54),
        //             ),
        //             Text(''),
        //             Text(''),
        //             IconButton(
        //               icon: Icon(
        //                 Icons.message,
        //                 color: Colors.black54,
        //               ),
        //               onPressed: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => InboxPage()));
        //               },
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 25,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 15),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 'Description:',
        //                 style: TextStyle(
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black54),
        //               ),
        //               Text(
        //                 'PDF stands for "portable document format". Essentially, the format is used when you need to save files that cannot be modified but still need to be easily shared and printed. Today most devices have a version of Adobe Reader or can open a PDF in an Internet Browser.:',
        //                 style: TextStyle(
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.w500,
        //                     color: Colors.black54),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
