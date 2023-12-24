import 'package:mentorx_app/Dashboard/Animations/animation_switcher.dart';
import 'package:flutter/material.dart';

class AnimatedSwitcherPage extends StatefulWidget {
  @override
  _AnimatedSwitcherPageState createState() => _AnimatedSwitcherPageState();
}

class _AnimatedSwitcherPageState extends State<AnimatedSwitcherPage> {
  int index = 0;

  final widgets = [
    Image.asset('assets/event1.png', fit: BoxFit.scaleDown, key: Key('1')),
    Image.asset('assets/event2.jpg', fit: BoxFit.scaleDown, key: Key('2')),
    Image.asset('assets/event3.png', fit: BoxFit.scaleDown, key: Key('3')),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Flexible(
          fit: FlexFit.tight,
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 2000),
              reverseDuration: Duration(milliseconds: 5000),
              transitionBuilder: (child, animation) => ScaleTransition(
                child: SizedBox.expand(child: child),
                scale: animation,
              ),
              child: widgets[index],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            final isLastIndex = index == widgets.length - 1;

            setState(() => index = isLastIndex ? 0 : index + 1);
          },
        ),
      );
}
