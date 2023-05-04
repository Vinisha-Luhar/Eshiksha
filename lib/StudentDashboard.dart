import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:eshiksha_temp/forgotpass.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:eshiksha_temp/splash.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class MyStudentDashboard extends StatelessWidget {
  const MyStudentDashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
      home:StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatefulWidget {

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  @override
  Widget build(BuildContext context) {

    final screenheight=MediaQuery.of(context).size.height;
    final double padding=screenheight*0.25;

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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                      color: Color(0xff152942)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: MySignup(),
                                      type: PageTransitionType
                                          .leftToRightWithFade));
                            },
                            child: Text("Dashboard",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white))),
                      ],
                    ),
                  ),
                ),
              )
              ,
            ),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.38,
                decoration: BoxDecoration(
                    color: Color(0xff152942)
                )
            ),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35,left: 10,right: 15),
                          child: CircleAvatar(
                            child: Image.asset("images/bear.png"),
                            radius: 60,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 25,right: 15),
                          child: Text("Welcome 👋",style: GoogleFonts.beVietnamPro(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,left: 25,right: 15),
                          child: Text("Vinisha Luhar",style: GoogleFonts.beVietnamPro(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.86,
                          height: MediaQuery.of(context).size.height*0.63,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(10)

                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            child: Column(
                                              children: [
                                                Expanded(child: Center(child: Text("00",style: GoogleFonts.poppins(color: Color(0xff152942),fontWeight: FontWeight.w500,fontSize: 39),)),),
                                                Text("Watched Videos",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontWeight: FontWeight.w500,fontSize: 18),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 23,),
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius: BorderRadius.circular(10)

                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            child: Column(
                                              children: [
                                                Expanded(child: Center(child: Text("00",style: GoogleFonts.poppins(color: Color(0xff152942),fontWeight: FontWeight.w500,fontSize: 39),)),),
                                                Text("Total Videos",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontWeight: FontWeight.w500,fontSize: 18),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: 25,),
                                  Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey.shade200
                                        //Color(0xfff1f4f9)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 10,
                                                child: Text("Asssigned Videos",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 20,fontWeight: FontWeight.w500),)
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text("0",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 25,fontWeight: FontWeight.w500),)
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 25,),
                                  Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey.shade200
                                        //Color(0xfff1f4f9)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 10,
                                                child: Text("Checked Videos",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 20,fontWeight: FontWeight.w500),)
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text("0",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 25,fontWeight: FontWeight.w500),)
                                            )
                                          ],
                                        ),
                                      )
                                  )

                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    );
  }
}