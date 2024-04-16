import 'package:flutter/material.dart';
import 'package:research_finder_jata/controller/faculty_controller.dart';
import '../../api.dart';
import '../../controller/chat_controller.dart';
import '../../main.dart';
import '../../models/faculty_model.dart';
import '../../models/message_model.dart';
import '../../widgets/mychatrooms.dart';
import 'inbox.dart';

class ChatRoomsPage extends StatefulWidget {
  final bool student;
  const ChatRoomsPage({super.key, required this.student});

  @override
  State<ChatRoomsPage> createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {

  MessageModel? _message;
  List<FacultyModel> _facultyList = [];
  List<FacultyModel> _studentList = [];
  final facultyController = FacultyController();

  @override
  void initState() {
    _facultyList = allFaculties;
    _studentList = allStudents;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat Room"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: ChatController.getChatUsers(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.data != null){
                var chattedUsers = snapshot.data!.docs.map((e) => e.id).toList();
                debugPrint('chattd;;;; $chattedUsers');
                List<FacultyModel> filteredFacultyList = [];
                for(String id in chattedUsers){
                  int idx = 0;
                  if(currentUserType == 'faculty'){
                    debugPrint('==============');
                    idx = _studentList.indexWhere((student){
                      debugPrint('ssss id: $id => sId ${student.sId}');
                      return student.sId!.contains(id);
                    });
                    if(idx != -1){
                      debugPrint('found');
                      filteredFacultyList.add(_studentList[idx]);
                    }
                  } else{
                    idx = _facultyList.indexWhere((faculty){
                      debugPrint('id: $id => sId ${faculty.sId}');
                      return faculty.sId!.contains(id);
                    });
                    if(idx != -1){
                      debugPrint('found');
                      filteredFacultyList.add(_facultyList[idx]);
                    }
                  }
                }
                // filteredFacultyList = _facultyList.where((faculty) {
                //   return chattedUsers.contains(faculty.sId);
                // }).toList();
                debugPrint('list=> $filteredFacultyList');
                return ListView.builder(
                                  itemCount: filteredFacultyList.length,
                                  itemBuilder: (context, index) {
                return StreamBuilder(
                    stream: ChatController.getLastMessage(filteredFacultyList[index].sId!),
                    builder: (context, snapshot) {
                      final data = snapshot.data?.docs;
                      final _messagesList = data?.map((e) => MessageModel.fromJson(e.data())).toList() ?? [];
                      if(_messagesList.isNotEmpty) _message = _messagesList[0];
                      return ChatRoom(
                        title: filteredFacultyList[index].name!,
                        id: filteredFacultyList[index].sId!,
                        subtitle: _message!.message,
                        dateTime: DateTime.fromMicrosecondsSinceEpoch(int.parse(_message!.sendingTime)),
                        image: '${APIs.filesBaseUrl}/${filteredFacultyList[index].profilePic!}',
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InboxPage(
                              id: filteredFacultyList[index].sId!, name: filteredFacultyList[index].name!,
                              profile: '${APIs.filesBaseUrl}/${filteredFacultyList[index].profilePic!}'),));
                        },
                      );
                    },
                );
                // return ChatCard(user: filteredFacultyList[index]);
                                  },
                                );
              } else{
                return Center(child: Text('No Conversation Found!'),);
              }
              // debugPrint("snapshot::: ${snapshot.data?.docs.length}");
              // return SizedBox();
              // return StreamBuilder(
              //     stream: ChatController.getAllUsers(
              //         snapshot.data?.docs.map((e) => e.id).toList() ?? []
              //     ),
              //     builder: (context, snapshot){
              //       switch(snapshot.connectionState){
              //         case ConnectionState.waiting:
              //         case ConnectionState.none:
              //           return Center(child: CircularProgressIndicator(),);
              //         case ConnectionState.active:
              //         case ConnectionState.done:
              //           final data = snapshot.data?.docs;
              //           log('data=> $data');
              //           _facultyList = data?.map((e) => FacultyModel.fromJson(e.data())).toList() ?? [];
              //           log('list=> $_facultyList');
              //           if(_facultyList.isNotEmpty){
              //             return ListView.builder(
              //                 padding: EdgeInsets.only(top: h*.02),
              //                 physics: BouncingScrollPhysics(),
              //                 itemCount: _facultyList.length,
              //                 itemBuilder: (context, index){
              //                   return ChatCard(user: _facultyList[index],);
              //                 }
              //             );
              //           }else{
              //             return Center(child: Text('No Connection Found!', style: TextStyle(fontSize: 18),),);
              //           }
              //       }
              //     }
              // );
          }
        },
      ),
      // body: Column(
      //   children: [
      //     ChatRoom(
      //         onPress: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => InboxPage()));
      //         },
      //         title: 'Furqan',
      //         subtitle: 'This is the latest message!',
      //         dateTime: DateTime.now(),
      //         image:
      //             'https://images.unsplash.com/photo-1497316730643-415fac54a2af?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D'),
      //     ChatRoom(
      //         onPress: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => InboxPage()));
      //         },
      //         title: 'Furqan',
      //         subtitle: 'This is the latest message!',
      //         dateTime: DateTime.now(),
      //         image:
      //             'https://images.unsplash.com/photo-1497316730643-415fac54a2af?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D'),
      //     ChatRoom(
      //         onPress: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => InboxPage()));
      //         },
      //         title: 'Furqan',
      //         subtitle: 'This is the latest message!',
      //         dateTime: DateTime.now(),
      //         image:
      //             'https://images.unsplash.com/photo-1497316730643-415fac54a2af?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D'),
      //     ChatRoom(
      //         onPress: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => InboxPage()));
      //         },
      //         title: 'Furqan',
      //         subtitle: 'This is the latest message!',
      //         dateTime: DateTime.now(),
      //         image:
      //             'https://images.unsplash.com/photo-1497316730643-415fac54a2af?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D'),
      //   ],
      // ),
    );
  }
}
