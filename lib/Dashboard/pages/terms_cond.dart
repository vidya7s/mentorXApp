import 'package:flutter/material.dart';

class T_and_C extends StatelessWidget {
  const T_and_C({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> JobScreen()));
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black45,
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.15, vertical: size.height * 0.10),
            child: Text(
              'As a user of this Site, you agree not to Engage in unauthorized framing of or linking to the Site Trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords.      Make improper use of our support services, or submit false reports of abuse or misconduct. Engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools. Interfere with, disrupt, or create an undue burden on the Site or the networks and services connected to the Site. Attempt to impersonate or impersonate another user or person, or use the username of another user. Sell or otherwise transfer your profile Use the Site in a manner inconsistent with any applicable laws or regulations',
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 12),
            )));
  }
}
