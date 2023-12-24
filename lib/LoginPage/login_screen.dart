import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:mentorx_app/Dashboard/pages/terms_cond.dart';
import 'package:mentorx_app/ForgetPassword/send_otp.dart';
import 'package:mentorx_app/Services/global_methods.dart';
import 'package:mentorx_app/SignupPage/signup_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentorx_app/Widgets/TextFieldWidget.dart';
import 'package:mentorx_app/Widgets/TextSeperator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  MediaQueryData getMediaQueryData() {
    return MediaQuery.of(context);
  }

  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passTextContoller =
      TextEditingController(text: '');

  bool _obscureText = true; //for password field
  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;

  // This function is triggered when the button is clicked

  final FocusNode _passFocusNode = FocusNode(); //handles keyboard events
  final _loginFormKey = GlobalKey<FormState>();
  // ignore: unused_field
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextContoller.dispose();
    _passFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  } //end of initState

  void _submitFormOnLogin() async {
    final isValid =
        _loginFormKey.currentState!.validate(); //checks if Login is succesful
    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      try {
        //Sign in using email and password
        var userCreds = await _auth.signInWithEmailAndPassword(
          email: _emailTextController.text.trim().toLowerCase(),
          password: _passTextContoller.text.trim().toLowerCase(),
        );
        print("Successful");
        print(userCreds.user?.email);
        Navigator.canPop(context)
            ? Navigator.pop(context)
            : null; //Removes dialog box if any using Navigator.canPop(context) Else returns Null
      } catch (error) {
        //Show error dialog in case of error while loging in
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        print('error occured  $error');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          color: Colors.white,
          //width: MediaQuery.of(context).size.width * 0.6,
          // height: MediaQuery.of(context).size.height* 0.5,

          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: ListView(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _loginFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextSeperator(textToDisplay: 'E-mail Address'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFieldWidget(
                              genericFocusNode: _passFocusNode,
                              genericController: _emailTextController,
                              hintTextForm: 'Enter Email Address',
                              textInputType: TextInputType.emailAddress),
                          const SizedBox(
                            height: 10,
                          ),
                          TextSeperator(textToDisplay: 'Password'),
                          TextFormField(
                            //For password
                            textInputAction: TextInputAction.next,
                            focusNode: _passFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passTextContoller,
                            obscureText: !_obscureText, //change it dynamically
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid password ';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.black54),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                //To hide password text based on visibility button
                                onTap: () {
                                  setState(() {
                                    //set password visibility based on Icon click
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText //show visibility icon based on icon clicks
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              hintText: 'Password ',
                              hintStyle: const TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
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
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Material(
                                child: Checkbox(
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              TextButton(
                                child: Text(
                                    'By signing in you are agreeing our terms and conditions',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.blueAccent)),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const T_and_C()));
                                },
                              ),
                            ],
                          ),
                          MaterialButton(
                            onPressed:
                                _submitFormOnLogin, //also authenticates user
                            color: Colors.blueAccent,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            //SignUp
                            child: RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                text: 'Do not have an account ?',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const TextSpan(text: '     '),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp())),
                                  //builder: (context) => JobScreen())),
                                  text: 'SignUp',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ))
                            ])),
                          ),
                        ] //end of children
                        )),
              ])))
    ]) //end of stack
        ); //end of Scaffold
  } //end of build
}
