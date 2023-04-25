import 'dart:convert';

import 'package:eshiksha_temp/forgotpass.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:eshiksha_temp/splash.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class Admin_Dashboard extends StatelessWidget {
  const Admin_Dashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.asapTextTheme(
            Theme.of(context).textTheme,
          )
      ),
      debugShowCheckedModeBanner: false,
      home:Admin_Dashboard(),
    );
  }
}

class Admin_Dashboard_page extends StatefulWidget {

  @override
  State<Admin_Dashboard_page> createState() => _Admin_Dashboard_PageState();
}

class _Admin_Dashboard_PageState extends State<Admin_Dashboard_page> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(child: Text("Welcome to Admin Dashboard Page",style: TextStyle(fontSize: 20),)),
      ),
    );
  }
}
