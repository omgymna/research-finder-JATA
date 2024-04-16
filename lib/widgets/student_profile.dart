import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../navigation_screens.dart/Student%20HomePage/faculty_course_screen.dart';

class ProfileListItem extends StatelessWidget {
  final String profilePhoto;
  final String profileName;
  final String universityName;
  final String id;
  final String userId;
  // final String pdfFileName;
  // final String pdfFileImage;
  final VoidCallback onTap;

  ProfileListItem({
    required this.profilePhoto,
    required this.profileName,
    required this.universityName,
    required this.id,
    required this.userId,
    // required this.pdfFileName,
    // required this.pdfFileImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: Colors.white60,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 5),
              leading: CircleAvatar(
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
              child: CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                imageUrl: profilePhoto,
                placeholder: (context, url) => SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(child: CircularProgressIndicator())),
              ),
            ),
                // backgroundImage: NetworkImage(profilePhoto),
              ),
              title: Text(
                profileName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    universityName,
                    style: TextStyle(
                      // fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   pdfFileName,
                  //   style: TextStyle(
                  //     // fontSize: 16,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              ),
              trailing: TextButton(
                child: Text('See Courses'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FacultyCourseScreen(userId: userId,
                        id: id, name: profileName, profile: profilePhoto,)));
                },
              ),
            ),
          ),
          // SizedBox(height: 5),
          // Container(
          //   padding: EdgeInsets.all(8.0),
          //   color: Colors.white70,
          //   child: Row(
          //     children: [
          //       Icon(Icons.picture_as_pdf),
          //       SizedBox(width: 10),
          //       Text(
          //         pdfFileName,
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
        ],
      ),
      // Image.asset(
      //   pdfFileImage,
      //   width: double.infinity,
      //   // height: 150,
      //   // fit: BoxFit.cover,
      // ),
      // SizedBox(
      //   height: 10,
      // ),
      // Divider(
      //   color: Colors.white70,
      // ),
    );
  }
}
