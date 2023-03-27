import 'package:eshiksha_temp/forgotpass.dart';
import 'package:eshiksha_temp/phoneverify.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:eshiksha_temp/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter/foundation.dart';
import 'package:eshiksha_temp/shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MySplash());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.asapTextTheme(
            Theme.of(context).textTheme,
          )),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController mobilenumbercontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  var mobilenumbervalue;
  var passwordvalue;
  RegExp regexformobile =
  new RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  RegExp regexforpassword = new RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");

  Widget ShowSnackbar(String msg) {
    final snackbar = SnackBar(
      content: Align(
          alignment: Alignment.center,
          child: Text(
            msg,
            style: TextStyle(color: Colors.white, fontSize: 17),
          )),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      padding: EdgeInsets.symmetric(vertical: 17),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return snackbar;
  }

  bool validateFieldValue(var tvValue,var msg,RegExp regExpFormat,var RegMsg) {
    if(tvValue==null || tvValue== "" ) {
      ShowSnackbar(msg);
      print("1");
      return false;
    }else if (regExpFormat.hasMatch(tvValue))
    {
        // ShowSnackbar(RegMsg);
        // print(tvValue);
        // print("2");
        return true;
    }
    else
    {
        ShowSnackbar(RegMsg);
        print("3");
        return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardopen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color(0xff9DBFFD), Color(0xffC4ECFB)])),
        child: Stack(
          children: [
            FadeInUp(
              child: WaveWidget(
                config: CustomConfig(
                    colors: [Colors.white],
                    durations: [50000],
                    heightPercentages: [keyboardopen ? 0.97 : 0.80]),
                size: Size(double.infinity, double.infinity),
              ),
            ),
            Column(
              children: [
                FadeInDown(
                    child: Container(
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "images/icon1removebg.png",
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.3,
                            )))),
                FadeInUp(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.white,
                      child: SafeArea(
                        top: false,
                        bottom: true,
                        left: false,
                        right: false,
                        minimum: EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: keyboardopen
                                ? MediaQuery.of(context).size.height * 0.3
                                : MediaQuery.of(context).size.height * 0.4,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        )),
                                    Divider(
                                      color: Color(0xff9DBFFD),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Mobile Number",
                                          style: TextStyle(
                                              color: Colors.lightBlue.shade700,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 3,
                                      color: Colors.transparent,
                                      shadowColor: Colors.blue.shade100,
                                      child: TextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(20)
                                        ],
                                        controller: mobilenumbercontroller,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            hintText: "Enter Mobile Number",
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none)),
                                            filled: true,
                                            fillColor: Colors.grey.shade200),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Password",
                                          style: TextStyle(
                                              color: Colors.lightBlue.shade800,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shadowColor: Colors.blue.shade100,
                                      child: TextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(8)
                                        ],
                                        controller: passwordcontroller,
                                        obscureText: true,
                                        obscuringCharacter: "*",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            hintText: "Enter Password",
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none)),
                                            filled: true,
                                            fillColor: Colors.grey.shade200),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: MyForgotpass(),
                                                    type: PageTransitionType
                                                        .leftToRightWithFade));
                                          },
                                          child: Text("Forgot Password?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color:
                                                  Colors.lightBlue.shade800))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * 0.05,
                                      width:
                                      MediaQuery.of(context).size.width * 0.4,
                                      child: TextButton(
                                          onPressed: () {
                                            mobilenumbervalue = mobilenumbercontroller.text;
                                            passwordvalue = passwordcontroller.text;

                                            if(validateFieldValue(mobilenumbervalue, "Please Enter Mobile Number",regexformobile,"Please Enter Valid Mobile Number") &&
                                                validateFieldValue(passwordvalue, "Please Enter Password",regexforpassword,"Please Enter Valid Password")){
                                              print("DOne");
                                            }


                                          },
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.lightBlue.shade700),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15))))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            FadeInRight(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not Yet Registered ? ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: MySignup(),
                                    type: PageTransitionType
                                        .leftToRightWithFade));
                          },
                          child: Text("Register Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.lightBlue.shade800)))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
