import 'dart:convert';

import 'package:eshiksha_temp/forgotpass.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:showcaseview/showcaseview.dart';


class Quality_Dashboard extends StatelessWidget {
  const Quality_Dashboard({super.key});

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
      home:Quality_Dashboard(),
    );
  }
}

class Quality_Dashboard_page extends StatefulWidget {

  @override
  State<Quality_Dashboard_page> createState() => _Quality_Dashboard_PageState();
}

class _Quality_Dashboard_PageState extends State<Quality_Dashboard_page> {

  GlobalKey dashcounts=GlobalKey();
  GlobalKey workspacekey=GlobalKey();
  GlobalKey changepasskey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bool keyboardopen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Color(0xff9DBFFD), Color(0xffC4ECFB)]
          )
        ),
        child: Stack(
          children: [
                // child: WaveWidget(
                //     config: CustomConfig(
                //         colors: [Colors.white],
                //         durations: [50000],
                //         heightPercentages: [0.86]//keyboardopen ? 0.97 : 0.80]
                //     ),
                //     size: Size(double.infinity, double.infinity)
                // )
            Column(
              children: [
                // ListTile(
                //   contentPadding: const EdgeInsets.only(
                //     top: 10.0,
                //     left: 20.0,
                //     right: 10.0,
                //   ),
                //   title: Text(
                //     'Dashboard',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //     ),
                //   ),
                //   trailing: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Showcase(
                //         key: changepasskey,
                //         description: 'Click here to Change Your Password',
                //         child: InkWell(
                //           onTap: () {
                //           },
                //           child: Image.asset(
                //             Constants.changePassword,
                //             width: 30,
                //             height: 30,
                //             color: Constants.whiteColor,
                //           ),
                //         ),
                //       ),
                //       Showcase(
                //         key: scLogout,
                //         description: 'Click here to Logout',
                //         child: InkWell(
                //           onTap: () {
                //             Constants.logoutBottomSheet(context);
                //           },
                //           child: Image.asset(
                //             Constants.logout,
                //             width: 50,
                //             height: 50,
                //             color: Constants.whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 50,bottom: 15,left: 20),
                //   child: Align(alignment: Alignment.topLeft,child: Text("Dashboard",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black),)),
                // ),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    color: Colors.white,
                    child: SafeArea(
                        top: false,
                        bottom: true,
                        left: false,
                        right: false,
                        minimum: EdgeInsets.only(bottom: 10),
                        child: Padding(
                            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                              children: [
                                Align(alignment: Alignment.topLeft,child: Text("Welcome,",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500,color: Colors.black),)),
                                SizedBox(height: 40,),
                                Showcase(
                                  description: "Work Reports are shown here",
                                  key: dashcounts,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            height: MediaQuery.of(context).size.height*0.3,
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("No. of \nAllocated \nWork",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)),
                                          ),
                                          SizedBox(width: 12,),
                                          Container(
                                            width: 150,
                                            height: MediaQuery.of(context).size.height*0.3,
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade50,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("No. of \nCompleted \nWork",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade50,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("No. of Published Work",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Showcase(
                                  description: "Click here to go to your Workspace",
                                  key: workspacekey,
                                  child: Container(
                                    width: double.infinity,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        trailing: Icon(
                                          CupertinoIcons.right_chevron,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        leading: Image.asset(
                                          "images/workspace.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        title: Text(
                                          'Workspace',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
