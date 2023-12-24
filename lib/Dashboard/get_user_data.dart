import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserData extends StatefulWidget {
  final String userId;

  const GetUserData({required this.userId});

  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  void initState() {
    super.initState();
    getUserData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? name;
  String email = '';
  String phoneNumber = '';

  void getUserData() async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.userId)
          .get(); //get data for specific userId
      print('userdoc is: $userDoc');
      if (userDoc == null) {
        print('inside userdoc NUll');
        return;
      } else {
        print('snapshot data is: $userDoc');
        //contains user data
        setState(() {
          name = userDoc.get('name');
          email = userDoc.get('email');
          phoneNumber = userDoc.get('phoneNumber');
          print('phonenum is $phoneNumber');
        });
      }
    } catch (error) {}
  }

  Widget _contactBy(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(icon, color: color),
          onPressed: () {
            fct();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Text(
      name!,
      style: TextStyle(fontSize: 15, color: Colors.blueAccent),
    );
  }
}
