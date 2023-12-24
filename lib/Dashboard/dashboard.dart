import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_app/Dashboard/Animations/animated_switcher_advanced_page.dart';
import 'package:mentorx_app/Dashboard/Animations/animation_switcher.dart';

import 'package:mentorx_app/Dashboard/get_user_data.dart';
import 'package:mentorx_app/Dashboard/logout.dart';
import 'package:mentorx_app/Dashboard/menu.dart';
import 'package:mentorx_app/main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    DateTime now = DateTime.now();
    String greeting = "";
    int hours = now.hour;

    if (hours >= 1 && hours <= 12) {
      greeting = "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Good Evening";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night";
    }
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
          'MentorX',
          style: TextStyle(fontSize: 20, color: Colors.blueAccent),
          textAlign: TextAlign.center,
        ),
      ),
      body:
          /* Center(
        child: Text('Side Menu Tutorial'),
      ),
      */
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Center(
              child: Row(children: [
                Text(
                  'Hi,',
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GetUserData(userId: uid)),
              ]),
            ),
            Text(
              greeting,
              style: TextStyle(fontSize: 10, color: Colors.blueAccent),
              textAlign: TextAlign.left,
            ),
            Text(
              'Upcoming Events,',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.left,
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: Animator()),
            Text(
              'Campus Updates,',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.left,
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: Animator())
          ]),
    );
  }
}
