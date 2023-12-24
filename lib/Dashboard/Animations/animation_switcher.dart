import 'package:mentorx_app/Dashboard/Animations/animated_switcher_advanced_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Animator extends StatefulWidget {
  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator> {
  Future animateRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animateRun();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AnimatedSwitcherPage(),
      );
}
