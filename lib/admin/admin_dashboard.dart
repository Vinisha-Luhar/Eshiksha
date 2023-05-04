import 'dart:io';
import 'dart:typed_data';
import 'package:base32/base32.dart';
import 'package:eshiksha_temp/admin/user_management.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:eshiksha_temp/forgotpass.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:convert/convert.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:eshiksha_temp/splash.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class MyAdminDashboard extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.beVietnamProTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminDashboard extends StatefulWidget {

  final String imagestring;
  final String gender;
  final String name;
  AdminDashboard(this.imagestring,this.gender,this.name);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  Widget build(BuildContext context){

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
                        widget.imagestring=="image not selected" ?
                        widget.gender=="Male" ?
                        Padding(
                          padding: const EdgeInsets.only(top: 35,left: 10,right: 15),
                          child: CircleAvatar(
                            //backgroundImage: MemoryImage(base32.decode(widget.imagestring)):,
                            child: Image.asset("images/profileformen.png"),
                            radius: 50,
                          ),
                        )
                            :Padding(
                          padding: const EdgeInsets.only(top: 35,left: 10,right: 15),
                          child: CircleAvatar(
                            //backgroundImage: MemoryImage(base32.decode(widget.imagestring)):,
                            child: Image.asset("images/profileforwomen.png"),
                            radius: 50,
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(top: 35,left: 10,right: 15),
                          child: CircleAvatar(
                            backgroundImage: Image.memory(base64Decode(widget.imagestring)).image,
                            //child: Image.asset("images/bear.png"),
                            radius: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 25,right: 15),
                          child: Text("Welcome 👋",style: GoogleFonts.beVietnamPro(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,left: 25,right: 15),
                          child: Text(widget.name,style: GoogleFonts.beVietnamPro(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserManagement()));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xfff1f4f9),
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 50),
                                            child: Align(alignment: Alignment.center,child: Text("User Management",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w400),)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 13,),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xfff1f4f9),
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 50),
                                          child: Align(alignment: Alignment.center,child: Text("Content Allocation",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w400),)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xfff1f4f9),
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 50),
                                          child: Align(alignment: Alignment.center,child: Text("Content Reallocation",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w400),)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 13,),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xfff1f4f9),
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 50),
                                          child: Align(alignment: Alignment.center,child: Text("Content Review",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w400),)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13,),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xfff1f4f9),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 50),
                                      child: Align(alignment: Alignment.center,child: Text("Publish Content",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w400),)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
