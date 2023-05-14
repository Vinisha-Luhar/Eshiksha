import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:eshiksha_temp/model/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
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
import 'package:image/image.dart' as img;


class MyUserDetails extends StatelessWidget {
  const MyUserDetails({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserDetailsPage extends StatefulWidget {

  final UserModel usermodel;
  UserDetailsPage(this.usermodel);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xfff1f4f9)
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.35,
              color: Color(0xff152942),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 55),
                        child: Center(
                          child: widget.usermodel.imagefile=="" ?
                              widget.usermodel.gender=="Male" ?
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Color(0xfff1f4f9),width: 5)
                                ),
                                child: CircleAvatar(
                                  //backgroundImage: MemoryImage(base32.decode(widget.imagestring)):,
                                  child: Image.asset("images/profileformen.png"),
                                  radius: 55,
                                  backgroundColor: Color(0xfff1f4f9),
                                ),
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Color(0xfff1f4f9),width: 5)
                                ),
                                    child: CircleAvatar(
                                //backgroundImage: MemoryImage(base32.decode(widget.imagestring)):,
                                child: Image.asset("images/profileforwomen.png"),
                                radius: 55,
                                backgroundColor: Color(0xfff1f4f9),
                              ),
                                  )
                              :  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xfff1f4f9),width: 5)
                                ),
                                child: CircleAvatar(
                                        backgroundImage: Image.memory(base64Decode(widget.usermodel.imagefile)).image,
                                        radius: 55,
                                  backgroundColor: Color(0xfff1f4f9),
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(widget.usermodel.name.toUpperCase(),style: GoogleFonts.poppins(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                      SizedBox(height: 3,),
                      Text(widget.usermodel.role,style: GoogleFonts.poppins(color: Colors.grey.shade200,fontSize: 16,fontWeight: FontWeight.w400),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 50),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_circle_sharp,color: Color(0xe6152942),size: 27,),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("NAME",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff152942)),),
                                Text(widget.usermodel.name,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff152942)),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.phone,color: Color(0xe6152942),size: 27,),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CONTACT NUMBER",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff152942)),),
                                Text(widget.usermodel.phone_number,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff152942)),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.email,color: Color(0xe6152942),size: 27,),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("EMAIL ID",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff152942)),),
                                Text(widget.usermodel.emailid,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff152942)),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(widget.usermodel.gender=="Male" ? Icons.man : Icons.woman,color: Color(0xe6152942),size: 27,),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("GENDER",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff152942)),),
                                Text(widget.usermodel.gender,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff152942)),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10,),
                        if(widget.usermodel.role=="Content Developer" || widget.usermodel.role=="Quality Checker")
                        Row(
                          children: [
                            Icon(Icons.menu_book,color: Color(0xe6152942),size: 27,),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("SUBJECTS",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff152942)),),
                                Text(widget.usermodel.subofinterest,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff152942)),),
                              ],
                            )
                          ],
                        ),
                        if(widget.usermodel.role=="Content Developer" || widget.usermodel.role=="Quality Checker")
                        SizedBox(height: 10,),
                        if(widget.usermodel.role=="Content Developer" || widget.usermodel.role=="Quality Checker")
                        Divider(color: Colors.grey),
                        SizedBox(height: 5,),
                        if(widget.usermodel.role=="Content Developer" || widget.usermodel.role=="Quality Checker")
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red.shade800
                          ),
                          child: SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.05,
                            width:
                            MediaQuery.of(context).size.width * 0.41,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.delete,color: Colors.white,size: 20,),
                                  TextButton(
                                      onPressed: (){
                                      },
                                      child: Text(
                                          "REMOVE USER",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          )
                                      ),
                                      // style: ButtonStyle(
                                      //     backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
                                      //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
                                      //         )
                                      //     )
                                      // )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
