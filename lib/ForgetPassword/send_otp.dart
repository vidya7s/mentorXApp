import 'package:email_otp/email_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:mentorx_app/ForgetPassword/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendOTP extends StatefulWidget {
  //const SendOTP({Key? key}) : super(key: key);
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";

  @override
  State<SendOTP> createState() => _SendOTPState();
}

class _SendOTPState extends State<SendOTP> {
  final _forgetPwdFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
  bool _btnClicked = false;
  bool _formValid = false;

  TextEditingController? otpController;

  void _submitForm() async {
    final isValid = _forgetPwdFormKey.currentState!.validate();
    if (isValid) {
      myauth.setConfig(
          appEmail: "contact@hdevcoder.com",
          appName: "Email OTP",
          userEmail: email.text,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      if (await myauth.sendOTP() == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP has been sent"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Oops, OTP send failed"),
        ));
      }
      setState(() {
        _formValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(), //Container
        leading: IconButton(
          onPressed: () {
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> JobScreen()));
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ), //IconButton
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.15, vertical: size.height * 0.10),
        child: Form(
          key: _forgetPwdFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Image.asset('assets/forgotPwd.png',
                      fit: BoxFit.cover,
                      width: size.width * 0.5,
                      height: size.height * 0.20)),
              const SizedBox(
                height: 30,
              ),
              const Text("E-Mail Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  prefixIcon: const Icon(
                    Icons.mail,
                  ),
                  hintText: "Aman@gmail.com",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid Email address ';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _btnClicked &&
                      _formValid // Display OTP Widget Only when _btnClicked is true
                  ? Center(
                      child: Container(
                          height: size.width * 0.25,
                          child: OtpScreen(
                            myauth: myauth,
                          )),
                    )
                  : Center(
                      child: MaterialButton(
                        onPressed: () {
                          //create submit form on signUp

                          setState(() {
                            _btnClicked = true;
                            _submitForm();
                          });
                        },
                        color: Colors.blueAccent,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              'Get OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )),
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),

//Resend OTP
              _btnClicked
                  ? Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: TextButton(
                        onPressed: () async {
                          myauth.setConfig(
                              appEmail: "contact@hdevcoder.com",
                              appName: "Email OTP",
                              userEmail: email.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(fontSize: 15, color: Colors.black38),
                        ),
                      ))
                  : SizedBox(
                      width: 1,
                    ),
              const Divider(
                thickness: 2,
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
                    ..onTap =
                        () => Navigator.canPop(context) //for loading dialog
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
            ],
          ),
        ),
      ),
    );
  }
}
