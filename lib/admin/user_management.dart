import 'dart:convert';
import 'dart:io';

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


class MyUserManagement extends StatelessWidget {
  const MyUserManagement({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false
    );
  }
}

class UserManagement extends StatefulWidget {

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> with TickerProviderStateMixin{

  List<String> listofroles=["All","Admin","Quality Checker","Content Developer"];
  int currentindex=0;

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff152942)
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("User Management",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 20,),),
              Container(
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Color(0xfff1f4f9),
                    border: Border.all(color: Color(0xff152942),width: 2)
                  ),
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: [
                    Tab(child: Container(width: 75,child: Text("All"),),),
                    Tab(child: Container(width: 75,child: Text("Admin"),),),
                    Tab(child: Container(width: 75,child: Text("Content Developer"),),),
                    Tab(child: Container(width: 75,child: Text("Quality Checker"),),),
                  ],
                ),
              )
            ],
          ),
        )
        ),
    );
      // body: Padding(
      //     padding: EdgeInsets.all(5),
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 50,
      //         decoration: BoxDecoration(
      //           color: Colors.grey.shade300,
      //           borderRadius: BorderRadius.circular(10)
      //         ),
      //         child: TabBar(
      //           dividerColor: Colors.white,
      //           isScrollable: true,
      //           indicator: BoxDecoration(
      //             color: Colors.green,
      //             borderRadius: BorderRadius.circular(10)
      //           ),
      //           labelColor: Colors.white,
      //           unselectedLabelColor: Colors.black,
      //           tabs: [
      //             Tab(text: "All",),
      //             Tab(text: "Content Developer",),
      //             Tab(text: "Admin",),
      //             Tab(text: "Quality Checker",),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // )
      //backgroundColor: Color(0xfff1f4f9),
      // body: Container(
      //   margin: EdgeInsets.all(5),
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 60,
      //         width: double.infinity,
      //         child: ListView.builder(
      //           physics: BouncingScrollPhysics(),
      //           itemCount: listofroles.length,
      //           scrollDirection: Axis.horizontal,
      //           itemBuilder: (context,index){
      //           return Column(
      //             children: [
      //               GestureDetector(
      //                 onTap: (){
      //                   setState(() {
      //                     currentindex=index;
      //                   });
      //                 },
      //                 child: AnimatedContainer(
      //                   duration: Duration(milliseconds: 300),
      //                   margin: const EdgeInsets.all(5),
      //                   width: 150,
      //                   height: 45,
      //                   decoration: BoxDecoration(
      //                     color: currentindex == index ? Colors.white : Colors.white,
      //                     borderRadius: currentindex == index ? BorderRadius.circular(15) : BorderRadius.circular(10),
      //                     border: currentindex == index ? Border.all(color: Color(0xff152942),width: 2) : null,
      //                   ),
      //                   child: Center(
      //                     child: Text(listofroles[index],
      //                       textAlign: TextAlign.center,
      //                       style: GoogleFonts.poppins(
      //                         fontWeight: FontWeight.w500,
      //                         color: currentindex == index ? Colors.black : Colors.grey
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Visibility(
      //                   visible: currentindex == index ,
      //                   child: Container(
      //                     width: 5,
      //                     height: 5,
      //                     decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xff152942)),
      //                   )
      //               ),
      //             ],
      //           );
      //         }),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 30),
      //         width: double.infinity,
      //         height: 500,
      //         color: Colors.white,
      //       )
      //     ],
      //   ),
      // ),
      // body: Stack(
      //   children: [
      //     Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       color: Color(0xfff1f4f9),
      //     ),
      //     Container(
      //         width: double.infinity,
      //         height: MediaQuery.of(context).size.height * 0.38,
      //         decoration: BoxDecoration(color: Color(0xff152942))),
      //     Container(
      //       child: Column(
      //         children: [
      //           Align(
      //             alignment: Alignment.topLeft,
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: MediaQuery.of(context).size.height * 0.07,
      //                 ),
      //                 Center(
      //                     child: Text(
      //                       "User Management",
      //                       style: GoogleFonts.poppins(
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.w500,
      //                           fontSize: 22),
      //                     ))
      //               ],
      //             ),
      //           ),
      //           SizedBox(
      //             height: MediaQuery.of(context).size.height * 0.03,
      //           ),
      //           Center(
      //             child: Card(
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(15)),
      //               color: Colors.white,
      //               child: Container(
      //                 width: MediaQuery.of(context).size.width * 0.89,
      //                 height: MediaQuery.of(context).size.height * 0.8,
      //                 child: Padding(
      //                   padding:
      //                   EdgeInsets.only(top: 20, left: 20, right: 20),
      //                   child: Column(
      //                     children: [
      //                       Row(
      //                         children: [
      //
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // )
    
  }
}
