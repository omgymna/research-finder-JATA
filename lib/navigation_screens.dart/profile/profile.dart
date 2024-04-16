import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../main.dart';
import '../../prefs.dart';
import '../../welcome.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'edit_profile',
                  child: Text('Edit Profile'),
                ),
                PopupMenuItem(
                  onTap: () {
                    Prefs.logout().then((value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage(),));
                    });
                  },
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'edit_profile') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage())).then((value){
                      setState(() {

                      });
                });
              } else if (value == 'logout') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomePage()));
              }
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                // backgroundImage: AssetImage('assets/profile.jpg'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: '${APIs.filesBaseUrl}/${currentUser!.profilePic}',
                    placeholder: (context, url) => SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(child: CircularProgressIndicator())),
                  ),
                ),
                // backgroundImage: CachedNetworkImageProvider(
                //   '${APIs.filesBaseUrl}/${currentUser!.profilePic}'
                // ),
              ),
              SizedBox(height: 20),
              Text(
                'User Email',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                currentUser!.email ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'University Name',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                currentUser!.university!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
