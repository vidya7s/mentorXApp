import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_app/Dashboard/get_user_data.dart';
import 'package:mentorx_app/Dashboard/logout.dart';
import 'package:mentorx_app/Dashboard/pages/terms_cond.dart';
import 'package:mentorx_app/Dashboard/profile.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    print('userid logged in is: $uid');

    Size size = MediaQuery.of(context).size;

    // isMorning? Timestamp.now(): ;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              //  width: size.width*0.25,
              //  height: size.height*0.55,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    Text(
                      'Hi,',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GetUserData(userId: uid)),
                    TextButton(
                      child: Text('View/Edit Profile',
                          style: TextStyle(
                              fontSize: 10, color: Colors.blueAccent)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                    ),
                  ],
                ),
              ]),
            ),
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
          ),
          ListTile(
            leading: Icon(Icons.computer_outlined),
            title: Text('My Courses'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.celebration_outlined),
            title: Text('My Certificates'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.bookmark_outline_outlined),
            title: Text('Saved'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.help_outline_sharp),
            title: Text('Help'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.groups_3_rounded),
            title: Text('About Us'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('T & C'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const T_and_C()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LogoutForApp()))
            },
          ),
        ],
      ),
    );
  }
}
