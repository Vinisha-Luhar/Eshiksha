import 'dart:convert';

import 'package:eshiksha_temp/content_developer/content_developer_dashboard.dart';
import 'package:eshiksha_temp/demo.dart';
import 'package:eshiksha_temp/quality_checker/qualitycheckerdashboard.dart';
import 'package:eshiksha_temp/shared/constants.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:eshiksha_temp/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:page_transition/page_transition.dart';

import 'forgotpass.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
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
          textTheme:
              GoogleFonts.beVietnamProTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController mobilenumbercontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  Future<void> loginUser(String phone_numberjson, String passwordjson) async {
    var urljson = "http://192.168.43.61:8089/loginuser";
    var response = await http.post(Uri.parse(urljson),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "phone_number": phone_numberjson,
          "password": passwordjson
        }));
    String responsestring = response.body;
    if (response.statusCode == 200) {
      print(responsestring);
      if (responsestring == "false") {
        ShowSnackbar("The User Haven't Registered Yet!");
      } else {
        ProgressDialog progressdialog =
            ProgressDialog(context, blur: 5, message: Text("Please Wait..."));
        progressdialog.show();
        await Future.delayed(Duration(seconds: 3));
        progressdialog.dismiss();
        if (responsestring == "Quality Checker") {
          print(responsestring);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QualityCheckerDashboard()));
        } else if (responsestring == "E-Content Reviewer") {
          print(responsestring);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyDemoPage()));
        } else if (responsestring == "E-Content Developer") {
          print(responsestring);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Content_Developer_Dashboard_page()));
        } else {
          ShowSnackbar("No Role is provided for this user");
        }
      }
    } else {
      print(response.statusCode);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardopen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xfff1f4f9),
            ),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(color: Color(0xff152942))),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                        ),
                        Center(
                            child: Text(
                          "E-Shiksha",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff152942),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xff152942),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.03,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Mobile Number",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff152942),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  controller: mobilenumbercontroller,
                                  keyboardType: TextInputType.phone,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: "Enter Mobile Number",
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 0, style: BorderStyle.none)),
                                    filled: true,
                                    fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Password",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff152942),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(8)
                                  ],
                                  controller: passwordcontroller,
                                  obscureText: true,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                  ),
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
                                      fillColor: Color(0xfff1f4f9)
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
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Color(0xff152942)
                                          )
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.02,
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                  width:
                                  MediaQuery.of(context).size.width * 0.4,
                                  child: TextButton(
                                      onPressed: () {
                                        if(mobilenumbercontroller.text=="")
                                        {
                                          ShowSnackbar("Please Enter Mobile Number!");
                                        }
                                        else if(passwordcontroller.text=="")
                                        {
                                          ShowSnackbar("Please Enter Password!");
                                        }
                                        else
                                        {
                                          loginUser(mobilenumbercontroller.text,passwordcontroller.text);
                                        }
                                        },
                                      child: Text(
                                        "LOGIN",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                        )
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff152942)),
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.05,
                decoration: BoxDecoration(
                    color: Color(0xff152942)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not Yet Registered ?",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500),),
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
                                color: Colors.white)))
                  ],
                ),
              ),
            )
            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 35,left: 15,right: 15),
            //       child: Container(
            //         child: CircleAvatar(
            //           child: Image.asset("images/bear.png"),
            //           radius: 60,
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 20,top: 15),
            //       child: Text("Welcome 👋",style: GoogleFonts.beVietnamPro(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 20,top: 7),
            //       child: Text("   Vinisha Luhar",style: GoogleFonts.beVietnamPro(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height*0.3,
            // ),
            // Card(
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //   color: Colors.white,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width*0.75,
            //     height: MediaQuery.of(context).size.height*0.5,
            //   ),
            // )
          ],
        )

        // body: Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.bottomRight,
        //           end: Alignment.topLeft,
        //           colors: [Color(0xff9DBFFD), Color(0xffC4ECFB)])),
        //   child: Stack(
        //     children: [
        //       FadeInUp(
        //         child: WaveWidget(
        //           config: CustomConfig(
        //               colors: [Colors.white],
        //               durations: [50000],
        //               heightPercentages: [keyboardopen ? 0.97 : 0.80]),
        //           size: Size(double.infinity, double.infinity),
        //         ),
        //       ),
        //       Column(
        //         children: [
        //           FadeInDown(
        //               child: Container(
        //                   child: Align(
        //                       alignment: Alignment.center,
        //                       child: Image.asset(
        //                         "images/icon1removebg.png",
        //                         width: MediaQuery.of(context).size.width * 0.8,
        //                         height: MediaQuery.of(context).size.height * 0.3,
        //                       )))),
        //           FadeInUp(
        //               child: Card(
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(20)),
        //                 color: Colors.white,
        //                 child: SafeArea(
        //                   top: false,
        //                   bottom: true,
        //                   left: false,
        //                   right: false,
        //                   minimum: EdgeInsets.only(bottom: 10),
        //                   child: Padding(
        //                     padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        //                     child: Container(
        //                       width: MediaQuery.of(context).size.width * 0.8,
        //                       height: keyboardopen
        //                           ? MediaQuery.of(context).size.height * 0.3
        //                           : MediaQuery.of(context).size.height * 0.4,
        //                       child: SingleChildScrollView(
        //                         physics: AlwaysScrollableScrollPhysics(),
        //                         child: Form(
        //                           key: formkey,
        //                           child: Column(
        //                             children: [
        //                               Align(
        //                                   alignment: Alignment.topLeft,
        //                                   child: Text(
        //                                     "Login",
        //                                     style: TextStyle(
        //                                         color: Colors.black,
        //                                         fontSize: 20,
        //                                         fontWeight: FontWeight.w400),
        //                                   )),
        //                               Divider(
        //                                 color: Color(0xff9DBFFD),
        //                               ),
        //                               SizedBox(
        //                                 height: 20,
        //                               ),
        //                               Align(
        //                                   alignment: Alignment.topLeft,
        //                                   child: Text(
        //                                     "Mobile Number",
        //                                     style: TextStyle(
        //                                         color: Colors.lightBlue.shade700,
        //                                         fontSize: 15,
        //                                         fontWeight: FontWeight.w500),
        //                                   )),
        //                               SizedBox(
        //                                 height: 5,
        //                               ),
        //                               Material(
        //                                 borderRadius: BorderRadius.circular(10),
        //                                 elevation: 3,
        //                                 color: Colors.transparent,
        //                                 shadowColor: Colors.blue.shade100,
        //                                 child: TextFormField(
        //                                   inputFormatters: <TextInputFormatter>[
        //                                     LengthLimitingTextInputFormatter(10),
        //                                   ],
        //                                   controller: mobilenumbercontroller,
        //                                   keyboardType: TextInputType.phone,
        //                                   style: TextStyle(
        //                                       fontSize: 15,
        //                                       fontWeight: FontWeight.w400,
        //                                       color: Colors.black),
        //                                   decoration: InputDecoration(
        //                                       hintText: "Enter Mobile Number",
        //                                       isDense: true,
        //                                       contentPadding: EdgeInsets.symmetric(
        //                                           horizontal: 10, vertical: 15),
        //                                       // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                       border: OutlineInputBorder(
        //                                           borderRadius:
        //                                           BorderRadius.circular(10),
        //                                           borderSide: BorderSide(
        //                                               width: 0,
        //                                               style: BorderStyle.none)),
        //                                       filled: true,
        //                                       fillColor: Colors.grey.shade200),
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 height: 20,
        //                               ),
        //                               Align(
        //                                   alignment: Alignment.topLeft,
        //                                   child: Text(
        //                                     "Password",
        //                                     style: TextStyle(
        //                                         color: Colors.lightBlue.shade800,
        //                                         fontSize: 15,
        //                                         fontWeight: FontWeight.w500),
        //                                   )),
        //                               SizedBox(
        //                                 height: 5,
        //                               ),
        //                               Material(
        //                                 borderRadius: BorderRadius.circular(10),
        //                                 color: Colors.transparent,
        //                                 elevation: 3,
        //                                 shadowColor: Colors.blue.shade100,
        //                                 child: TextFormField(
        //                                   inputFormatters: <TextInputFormatter>[
        //                                     LengthLimitingTextInputFormatter(8)
        //                                   ],
        //                                   controller: passwordcontroller,
        //                                   obscureText: true,
        //                                   style: TextStyle(
        //                                       fontSize: 15,
        //                                       fontWeight: FontWeight.w400,
        //                                       color: Colors.black),
        //                                   decoration: InputDecoration(
        //                                       hintText: "Enter Password",
        //                                       isDense: true,
        //                                       contentPadding: EdgeInsets.symmetric(
        //                                           horizontal: 10, vertical: 15),
        //                                       // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                       border: OutlineInputBorder(
        //                                           borderRadius:
        //                                           BorderRadius.circular(10),
        //                                           borderSide: BorderSide(
        //                                               width: 0,
        //                                               style: BorderStyle.none)),
        //                                       filled: true,
        //                                       fillColor: Colors.grey.shade200),
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 height: 3,
        //                               ),
        //                               Align(
        //                                 alignment: Alignment.topRight,
        //                                 child: TextButton(
        //                                     onPressed: () {
        //                                       Navigator.push(
        //                                           context,
        //                                           PageTransition(
        //                                               child: MyForgotpass(),
        //                                               type: PageTransitionType
        //                                                   .leftToRightWithFade));
        //                                     },
        //                                     child: Text("Forgot Password?",
        //                                         style: TextStyle(
        //                                             fontWeight: FontWeight.w600,
        //                                             fontSize: 15,
        //                                             color:
        //                                             Colors.lightBlue.shade800))),
        //                               ),
        //                               SizedBox(
        //                                 height: 15,
        //                               ),
        //                               SizedBox(
        //                                 height:
        //                                 MediaQuery.of(context).size.height * 0.05,
        //                                 width:
        //                                 MediaQuery.of(context).size.width * 0.4,
        //                                 child: TextButton(
        //                                     onPressed: () {
        //                                       if(mobilenumbercontroller.text=="")
        //                                         {
        //                                           ShowSnackbar("Please Enter Mobile Number!");
        //                                         }
        //                                       else if(passwordcontroller.text=="")
        //                                         {
        //                                           ShowSnackbar("Please Enter Password!");
        //                                         }
        //                                       else
        //                                         {
        //                                           loginUser(mobilenumbercontroller.text,passwordcontroller.text);
        //                                         }
        //                                     },
        //                                     child: Text(
        //                                       "LOGIN",
        //                                       style: TextStyle(
        //                                           fontSize: 15,
        //                                           fontWeight: FontWeight.w400,
        //                                           color: Colors.white),
        //                                     ),
        //                                     style: ButtonStyle(
        //                                         backgroundColor:
        //                                         MaterialStateProperty.all(
        //                                             Colors.lightBlue.shade700),
        //                                         shape: MaterialStateProperty.all<
        //                                             RoundedRectangleBorder>(
        //                                             RoundedRectangleBorder(
        //                                                 borderRadius:
        //                                                 BorderRadius.circular(
        //                                                     15))))),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ))
        //         ],
        //       ),
        //       FadeInRight(
        //         child: Padding(
        //           padding: const EdgeInsets.only(top: 30),
        //           child: Container(
        //             margin: EdgeInsets.only(
        //                 top: MediaQuery.of(context).size.height * 0.9),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Not Yet Registered ? ",
        //                   style: TextStyle(
        //                       color: Colors.grey,
        //                       fontSize: 14,
        //                       fontWeight: FontWeight.w500),
        //                 ),
        //                 TextButton(
        //                     onPressed: () {
        //                       Navigator.push(
        //                           context,
        //                           PageTransition(
        //                               child: MySignup(),
        //                               type: PageTransitionType
        //                                   .leftToRightWithFade));
        //                     },
        //                     child: Text("Register Now",
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.w600,
        //                             fontSize: 15,
        //                             color: Colors.lightBlue.shade800)))
        //               ],
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
