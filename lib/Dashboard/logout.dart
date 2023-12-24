import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_app/user_state.dart';

class LogoutForApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logout ')),
      body: AlertDialog(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: Colors.blueAccent,
                size: 36,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.blueAccent, fontSize: 28),
              ),
            ),
          ],
        ),
        content: const Text(
          //The content of the dialog is displayed in the center of the dialog in a lighter font.
          'do you want to logout ?',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null; //
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => UserState()));
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              _auth.signOut();
              Navigator.canPop(context) ? Navigator.pop(context) : null;
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => UserState()));
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
