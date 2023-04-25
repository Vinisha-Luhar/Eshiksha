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


class MyQualityCheckerDashboard extends StatelessWidget {
  const MyQualityCheckerDashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         textTheme: GoogleFonts.beVietnamProTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
      home:QualityCheckerDashboard(),
    );
  }
}

class QualityCheckerDashboard extends StatefulWidget {

  @override
  State<QualityCheckerDashboard> createState() => _QualityCheckerDashboardState();
}

class _QualityCheckerDashboardState extends State<QualityCheckerDashboard> {

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
                      height: MediaQuery.of(context).size.height*0.62,
                    ),
                  ),
                )
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
