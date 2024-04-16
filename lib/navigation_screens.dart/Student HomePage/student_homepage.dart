// import 'package:flutter/material.dart';
// import '../Home/person_entity.dart';
// import '../Home/home_card_item.dart';

// class StudentHomePage extends StatefulWidget {
//   StudentHomePage({Key? key}) : super(key: key);

//   @override
//   _StudentHomePageState createState() => _StudentHomePageState();
// }

// class _StudentHomePageState extends State<StudentHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Research Finder'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: ListView.separated(
//           itemBuilder: (context, index) {
//             return getItem(index);
//           },
//           separatorBuilder: (context, index) =>
//               index.isOdd ? Divider(height: 10) : SizedBox(),
//           itemCount: AllUsersData.length,
//         ),
//       ),
//     );
//   }

//   Widget getItem(int index) {
//     var item = AllUsersData[index];
//     var pdfFileName =
//         item.pdfFileName; // Accessing pdfFileName from PersonEntity
//     return HomeCardItem(
//       name: item.name,
//       gender: item.gender,
//       iconUrl: item.iconUrl,
//       university: item.university,
//       major: item.major,
//       email: item.email,
//       pdfFileName: pdfFileName,
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../controller/faculty_controller.dart';
import '../../main.dart';
import '../../models/faculty_model.dart';
import '../../widgets/student_profile.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  // List<Profile> profiles = [
  //   Profile(
  //     profilePhoto:
  //         'https://img.freepik.com/free-photo/pleased-young-businessman-wearing-glasses-holding-book-isolated-white-background_141793-63613.jpg?size=626&ext=jpg&ga=GA1.1.1457419933.1701856505&semt=ais',
  //     profileName: 'John Doe',
  //     universityName: 'xyz University',
  //     pdfFileName: 'Course Name',
  //     pdfFileImage: 'assets/pdf.png',
  //   ),
  //   Profile(
  //     profilePhoto:
  //         'https://img.freepik.com/free-photo/pleased-young-businessman-wearing-glasses-holding-book-isolated-white-background_141793-63613.jpg?size=626&ext=jpg&ga=GA1.1.1457419933.1701856505&semt=ais',
  //     profileName: 'John Doe',
  //     universityName: 'xyz University',
  //     pdfFileName: 'Course Name',
  //     pdfFileImage: 'assets/pdf.png',
  //   ),
  //   Profile(
  //     profilePhoto:
  //         'https://img.freepik.com/free-photo/pleased-young-businessman-wearing-glasses-holding-book-isolated-white-background_141793-63613.jpg?size=626&ext=jpg&ga=GA1.1.1457419933.1701856505&semt=ais',
  //     profileName: 'John Doe',
  //     universityName: 'xyz University',
  //     pdfFileName: 'Course Name',
  //     pdfFileImage: 'assets/pdf.png',
  //   ),
  //
  // ];

  final facultyController = FacultyController();

  List<FacultyModel> facultyList = [];
  List<FacultyModel> searchList = [];

  getFaculties() async{
    await facultyController.getFacultyList(context: context).then((value){
      setState(() {
        facultyList.addAll(value.reversed.toList());
      });
    }).onError((error, stackTrace){

    });
  }

  // List<FacultyModel> searchResults = [];

  // List<Profile> filteredProfiles = [];

  @override
  void initState() {
    // filteredProfiles = profiles;
    getFaculties();
    super.initState();
  }

  // void _runFilter(String query) {
  //   List<Profile> filteredList = profiles.where((profile) {
  //     return profile.profileName.toLowerCase().contains(query.toLowerCase()) ||
  //         profile.universityName.toLowerCase().contains(query.toLowerCase()) ||
  //         profile.pdfFileName.toLowerCase().contains(query.toLowerCase());
  //   }).toList();
  //
  //   setState(() {
  //     filteredProfiles = filteredList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Research Finder'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.02),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(68, 243, 236, 219),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchList.clear();
                      searchList.addAll(facultyList.where((faculty) =>
                      faculty.university!.toLowerCase().contains(value.toLowerCase()) ||
                          faculty.name!.toLowerCase().contains(value.toLowerCase())
                      ));
                    });
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsetsDirectional.only(start: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              facultyList.isEmpty ? Center(child: CircularProgressIndicator(),) : SizedBox(
                height: h-225,
                child: ListView.builder(
                  itemCount: searchList.isEmpty ? facultyList.length : searchList.length,
                  itemBuilder: (context, index) => ProfileListItem(
                    profilePhoto: '${APIs.filesBaseUrl}/${searchList.isEmpty ? facultyList[index].profilePic : searchList[index].profilePic}',
                    profileName: searchList.isEmpty ? facultyList[index].name! : searchList[index].name!,
                    universityName: searchList.isEmpty ? facultyList[index].university! : searchList[index].university!,
                    id: searchList.isEmpty ? facultyList[index].sId! : searchList[index].sId!,
                    userId: searchList.isEmpty ? facultyList[index].userId! : searchList[index].userId!,
                    onTap: () {

                    },
                  ),
                ),
              ),
              // FutureBuilder(
              //   future: facultyController.getFacultyList(context: context),
              //   builder: (context, snapshot) {
              //     if(snapshot.connectionState == ConnectionState.waiting){
              //       return Center(child: CircularProgressIndicator(),);
              //     } else{
              //       if(snapshot.hasError){
              //         debugPrint('${snapshot.error}');
              //         return Center(child: Text('Error: ${snapshot.error}'));
              //       } else if(snapshot.hasData){
              //         if(snapshot.data!.isNotEmpty){
              //           var data = snapshot.data!.reversed.toList();
              //           return SizedBox(
              //               height: h-225,
              //               child: ListView.builder(
              //                 itemCount: data.length,
              //                 physics: const BouncingScrollPhysics(),
              //                 itemBuilder: (BuildContext context, int index) {
              //                   return ProfileListItem(
              //                     profilePhoto: '${APIs.filesBaseUrl}/${data[index].profilePic}',
              //                     profileName: data[index].name!,
              //                     universityName: data[index].university!,
              //                     id: data[index].userId!,
              //                     onTap: () {
              //
              //                     },
              //                   );
              //                 },
              //               ));
              //         } else{
              //           return Center(child: Text('No Faculty Found!'),);
              //         }
              //         // return snapshot.data!.isNotEmpty ? SizedBox(
              //         //     height: h-225,
              //         //     child: ListView.builder(
              //         //       itemCount: snapshot.data!.length,
              //         //       physics: const BouncingScrollPhysics(),
              //         //       itemBuilder: (BuildContext context, int index) {
              //         //         return ProfileListItem(
              //         //           profilePhoto: '${APIs.filesBaseUrl}/${snapshot.data![index].profilePic}',
              //         //           profileName: snapshot.data![index].name!,
              //         //           universityName: snapshot.data![index].university!,
              //         //           id: snapshot.data![index].userId!,
              //         //           onTap: () {
              //         //
              //         //           },
              //         //         );
              //         //       },
              //         //     )) : Center(child: Text('No Faculty Found!'),);
              //       }
              //       return Center(child: Text('No faculty found!'),);
              //     }
              //   },
              // ),

              // Column(
              //   children: filteredProfiles.map((profile) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
              //       child: ProfileListItem(
              //         profilePhoto: profile.profilePhoto,
              //         profileName: profile.profileName,
              //         universityName: profile.universityName,
              //         pdfFileName: profile.pdfFileName,
              //         pdfFileImage: profile.pdfFileImage,
              //         onTap: () {
              //           // Handle item on tap
              //         },
              //       ),
              //     );
              //   }).toList(),
              // ),
              // SizedBox(
              //   height: h * 0.01,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile {
  final String profilePhoto;
  final String profileName;
  final String universityName;
  final String pdfFileName;
  final String pdfFileImage;

  Profile({
    required this.profilePhoto,
    required this.profileName,
    required this.universityName,
    required this.pdfFileName,
    required this.pdfFileImage,
  });
}
