import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    super.key,
    required FocusNode genericFocusNode,
    required TextEditingController genericController,
    required String hintTextForm,
    required textInputType,
  })  : _inputFocusNode = genericFocusNode,
        _inputController = genericController,
        hintTextInput = hintTextForm,
        textInputTyp_set = textInputType;

  final FocusNode _inputFocusNode;
  final TextEditingController _inputController;
  String? hintTextInput;
  final TextInputType textInputTyp_set;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 12),
      decoration: InputDecoration(
        hintText: widget.hintTextInput,
        hintStyle: TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context)
          .requestFocus(widget._inputFocusNode), //Next focus is email
      //keyboardType: TextInputType.name,
      keyboardType: widget.textInputTyp_set,
      controller: widget._inputController,
      validator: (value) {
        if (widget.hintTextInput!.isNotEmpty) {
          if (value!.isEmpty) {
            return 'This field is missing ';
          } else {
            return null;
          }
        } else if (widget.hintTextInput == 'Enter E-mail Address') {
          if (value!.isEmpty || !value.contains('@')) {
            return 'Please enter a valid Email address ';
          } else {
            return null;
          }
        } else if (widget.hintTextInput == 'Enter Mobile Number') {
          if (value!.isEmpty || value.length < 10 || value.length > 10) {
            return 'Please enter a valid Mobile Number, It must be 10 digits ';
          } else {
            return null;
          }
        } else if (widget.hintTextInput == 'Enter Age') {
          int age;
          age = int.parse(value!);
          if (value!.isEmpty || age < 0) {
            return 'Please enter a valid age ';
          } else {
            return null;
          }
        } else if (widget.hintTextInput == 'Enter Pin code') {
          if (value!.isEmpty || value!.length != 6) {
            return 'Please enter a valid Pin Code ';
          } else {
            return null;
          }
        }
      },
    );
  }
}
