import 'package:flutter/material.dart';
import 'dart:io';

class TextSeperator extends StatelessWidget {
  const TextSeperator({
    super.key,
    required String? textToDisplay,
  }) : textToDisplay = textToDisplay;

  final String? textToDisplay;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: textToDisplay,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          const TextSpan(
              text: '*',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        ],
      ),
    );
  }
}
