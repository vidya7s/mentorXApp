import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:mentorx_app/ForgetPassword/otp_screen.dart';
import 'package:mentorx_app/ForgetPassword/send_otp.dart';
import 'package:mentorx_app/Services/global_methods.dart';
import 'package:mentorx_app/Widgets/GenderDropDown.dart';
import 'package:mentorx_app/Widgets/TextFieldWidget.dart';
import 'package:mentorx_app/Widgets/TextSeperator.dart';
import 'package:mentorx_app/Widgets/date_picker.dart';
import 'package:mentorx_app/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final _signUpFormKey = GlobalKey<FormState>();
  File? imageFile; //contains image that user selects, currently empty
  final TextEditingController _fullNameContoller =
      TextEditingController(text: '');
  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passTextContoller =
      TextEditingController(text: '');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '');
  final TextEditingController _addressController =
      TextEditingController(text: '');
  final TextEditingController _cityController = TextEditingController(text: '');
  final TextEditingController _stateController =
      TextEditingController(text: '');
  final TextEditingController _pinController = TextEditingController(text: '');
  final TextEditingController _ageController = TextEditingController(text: '');

  FocusNode? genericFocusNode;
  TextEditingController? genericController;
  TextInputType? textInputType;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _pinFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _positionCPFocusNode = FocusNode(); //handles keyboard events

  bool _obscureText = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? imageUrl;
  String? textToDisplay;

  @override
  void dispose() {
    _fullNameContoller.dispose();
    _emailTextController.dispose();
    _passTextContoller.dispose();
    _phoneNumberController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _positionCPFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  } //end of initState

  void _submitFormOnSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      /*  if (imageFile == null) {
        GlobalMethod.showErrorDialog(
          error: 'Please pick an image',
          ctx: context,
        );
        return;
      } */
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.createUserWithEmailAndPassword(
          //authenticate user with email and password
          email: _emailTextController.text.trim().toLowerCase(),
          password: _passTextContoller.text.trim(),
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        FirebaseFirestore.instance.collection('userData').doc(_uid).set({
          'id': _uid,
          'name': _fullNameContoller.text,
          'gender': GenderDropDown.selectedDropdownValue,
          'DOB': DatePickerDOB.selectedDate,
          'email': _emailTextController.text,
          //NOTE: Pasword is NOT STORED in our collection for security purpose. It is stored in Firebase Authentication itself
          "phoneNumber": _phoneNumberController.text,
          'age': _ageController.text,
          'address': _addressController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'pincode': _pinController.text,
          'createdAt': Timestamp.now(),
        });
        Navigator.canPop(context)
            ? Navigator.pop(context)
            : null; //Pops topmost page after signup
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 80),
            child: ListView(children: [
              Form(
                  key: _signUpFormKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text Field for entering Name /company name
                        const TextSeperator(textToDisplay: 'Full Name'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _genderFocusNode,
                            genericController: _fullNameContoller,
                            hintTextForm: 'Enter Full Name',
                            textInputType: TextInputType
                                .name), //end of text field for name
                        const SizedBox(
                          height: 10,
                        ),
                        const TextSeperator(textToDisplay: 'Gender'),
                        const SizedBox(
                          height: 7,
                        ),
                        GenderDropDown(
                            genericFocusNode: _emailFocusNode,
                            genericController: _fullNameContoller),
                        const SizedBox(
                          height: 10,
                        ),
                        const TextSeperator(textToDisplay: 'D.O.B'),
                        const SizedBox(
                          height: 7,
                        ),
                        DatePickerDOB(),
                        const SizedBox(
                          height: 10,
                        ),
                        const TextSeperator(textToDisplay: 'E-Mail Address'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _passFocusNode,
                            genericController: _emailTextController,
                            hintTextForm: 'Enter E-mail Address',
                            textInputType: TextInputType.emailAddress),
                        //Text field for Email
                        const SizedBox(
                          height: 10,
                        ),
                        const TextSeperator(textToDisplay: 'Passsword'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          //Text field for password
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passTextContoller,
                          obscureText:
                              !_obscureText, //change password visibility based on tap
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid Password ';
                            } else {
                              return null;
                            }
                          },
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ), //end of Text field for Password
                        const SizedBox(
                          height: 5,
                        ),
                        const TextSeperator(textToDisplay: 'Mobile Number'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _ageFocusNode,
                            genericController: _phoneNumberController,
                            hintTextForm: 'Enter Mobile Number',
                            textInputType: TextInputType.phone),
                        const SizedBox(
                          height: 5,
                        ),
                        //end of text field for mobile number
                        //Age
                        const TextSeperator(textToDisplay: 'Age'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _addressFocusNode,
                            genericController: _ageController,
                            hintTextForm: 'Enter Age',
                            textInputType: TextInputType.number),
                        const SizedBox(
                          height: 5,
                        ),

                        //Address
                        const TextSeperator(textToDisplay: 'Address'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _cityFocusNode,
                            genericController: _addressController,
                            hintTextForm: 'Enter Address',
                            textInputType: TextInputType.streetAddress),
                        const SizedBox(
                          height: 5,
                        ),
                        //City
                        const TextSeperator(textToDisplay: 'City'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _stateFocusNode,
                            genericController: _cityController,
                            hintTextForm: 'Enter City',
                            textInputType: TextInputType.streetAddress),
                        const SizedBox(
                          height: 5,
                        ),
                        //State
                        const TextSeperator(textToDisplay: 'State'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _pinFocusNode,
                            genericController: _stateController,
                            hintTextForm: 'Enter State',
                            textInputType: TextInputType.streetAddress),
                        const SizedBox(
                          height: 5,
                        ),
                        //Pin code
                        const TextSeperator(textToDisplay: 'Pin Code'),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFieldWidget(
                            genericFocusNode: _positionCPFocusNode,
                            genericController: _pinController,
                            hintTextForm: 'Enter Pin code',
                            textInputType: TextInputType.number),
                        const SizedBox(
                          height: 5,
                        ),

                        Center(
                          child: Column(
                              //mainAxisAlignment :   MainAxisAlignment.center,
                              children: [
                                Align(
                                  //Forget Password Button
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SendOTP()));
                                    },
                                    child: const Text(
                                      'Forget Password ?',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ),
                                ),
                                _isLoading
                                    ? Center(
                                        child: Container(
                                            /* width: size.width * 70,
                                   height: size.width * 70, */
                                            width: size.width * 0.010,
                                            height: size.width * 0.010,
                                            child:
                                                const CircularProgressIndicator()),
                                      )
                                    : MaterialButton(
                                        onPressed: () {
                                          //create submit form on signUp
                                          _submitFormOnSignUp();
                                        },
                                        color: Colors.blueAccent,
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            )),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  thickness: 3,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                      text: 'Already have an account?',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      )),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.canPop(
                                              context) //for loading dialog
                                          ? Navigator.pop(context)
                                          : null,
                                    text: ' Login',
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ])),
                              ]),
                        ),
                      ]))
            ])),
      ]),
    );
  }
}
