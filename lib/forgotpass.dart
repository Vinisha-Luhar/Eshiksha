import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';


class MyForgotpass extends StatelessWidget {
  const MyForgotpass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.asapTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: const MyForgotpassPage(title: ''),
    );
  }
}

class MyForgotpassPage extends StatefulWidget {
  const MyForgotpassPage({super.key, required this.title});

  final String title;

  @override
  State<MyForgotpassPage> createState() => _MyForgotpassPageState();
}

class _MyForgotpassPageState extends State<MyForgotpassPage> {

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    final bool keyboardopen=MediaQuery.of(context).viewInsets.bottom>0;

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color(0xff9DBFFD),Color(0xffC4ECFB)]
            )
        ),
        child: Stack(
          children: [
            WaveWidget(
              config: CustomConfig(
                  colors: [Colors.white],
                  durations: [50000],
                  heightPercentages: [keyboardopen ? 0.97 : 0.80]
              ),
              size: Size(double.infinity, double.infinity),
            ),
            Column(
              children: [
                FadeInDown(
                    child: Container(
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset("images/icon1removebg.png",
                              width: MediaQuery.of(context).size.width*0.8,
                              height: MediaQuery.of(context).size.height*0.3,
                            )
                        )
                    )
                ),
                FadeInUp(
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
                          padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            height: keyboardopen ? MediaQuery.of(context).size.height*0.3 : MediaQuery.of(context).size.height*0.5,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.topLeft,child: Text("Forgot Password",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),)),
                                  Divider(color: Color(0xff9DBFFD),),
                                  SizedBox(height: 20,),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Mobile Number",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 5,),
                                  Material(
                                    borderRadius: BorderRadius.circular(10),
                                    shadowColor: Colors.blue.shade100,
                                    elevation: 3,
                                    color: Colors.transparent,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
                                      decoration: InputDecoration(
                                          hintText: "Enter Mobile Number",
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                          // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none
                                              )
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("New Password",style: TextStyle(color: Colors.lightBlue.shade800,fontSize: 15,fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 5,),
                                  Material(
                                    elevation: 3,
                                    shadowColor: Colors.blue.shade100,
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(8),
                                      ],
                                      obscureText: true,
                                      obscuringCharacter: "*",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
                                      decoration: InputDecoration(
                                          hintText: "Enter New Password",
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                          // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none
                                              )
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Confirm Password",style: TextStyle(color: Colors.lightBlue.shade800,fontSize: 15,fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 5,),
                                  Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 3,
                                    color: Colors.transparent,
                                    shadowColor: Colors.blue.shade100,
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(8)
                                      ],
                                      obscureText: true,
                                      obscuringCharacter: "*",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
                                      decoration: InputDecoration(
                                          hintText: "Enter Confirm Password",
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                          // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none
                                              )
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  SafeArea(
                                    left: false,
                                    right: false,
                                    top: true,
                                    bottom: false,
                                    minimum: EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height*0.05,
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: TextButton(
                                          onPressed: (){},
                                          child: Text("RESET",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.lightBlue.shade700),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  )
                                              )
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                )
                // FadeInUp(
                //     child: Card(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20)
                //       ),
                //       color: Colors.white,
                //       child: SafeArea(
                //         top: false,
                //         bottom: true,
                //         left: false,
                //         right: false,
                //         minimum: EdgeInsets.only(bottom: 10),
                //         child: Padding(
                //           padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                //           child: Container(
                //             width: MediaQuery.of(context).size.width*0.8,
                //             height: MediaQuery.of(context).size.height*0.5,
                //             child: SingleChildScrollView(
                //               physics: AlwaysScrollableScrollPhysics(),
                //               child: Column(
                //                 children: [
                //                   Align(alignment: Alignment.topLeft,child: Text("Forgot Password",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),)),
                //                   Divider(color: Color(0xff9DBFFD),),
                //                   SizedBox(height: 20,),
                //                   Align(
                //                       alignment: Alignment.topLeft,
                //                       child: Text("Mobile Number",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
                //                   ),
                //                   SizedBox(height: 5,),
                //                   TextFormField(
                //                     keyboardType: TextInputType.phone,
                //                     style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
                //                     decoration: InputDecoration(
                //                         hintText: "Enter Mobile Number",
                //                         isDense: true,
                //                         contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                //                         // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                //                         border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(10),
                //                             borderSide: BorderSide(
                //                                 width: 0,
                //                                 style: BorderStyle.none
                //                             )
                //                         ),
                //                         filled: true,
                //                         fillColor: Colors.grey.shade100
                //                     ),
                //                   ),
                //                   SizedBox(height: 20,),
                //                   Align(
                //                       alignment: Alignment.topLeft,
                //                       child: Text("New Password",style: TextStyle(color: Colors.lightBlue.shade800,fontSize: 15,fontWeight: FontWeight.w500),)
                //                   ),
                //                   SizedBox(height: 5,),
                //                   TextFormField(
                //                     obscureText: true,
                //                     obscuringCharacter: "*",
                //                     style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
                //                     decoration: InputDecoration(
                //                         hintText: "Enter New Password",
                //                         isDense: true,
                //                         contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                //                         // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                //                         border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(10),
                //                             borderSide: BorderSide(
                //                                 width: 0,
                //                                 style: BorderStyle.none
                //                             )
                //                         ),
                //                         filled: true,
                //                         fillColor: Colors.grey.shade100
                //                     ),
                //                   ),
                //                   SizedBox(height: 20,),
                //                   Align(
                //                       alignment: Alignment.topLeft,
                //                       child: Text("Confirm Password",style: TextStyle(color: Colors.lightBlue.shade800,fontSize: 15,fontWeight: FontWeight.w500),)
                //                   ),
                //                   SizedBox(height: 5,),
                //                   TextFormField(
                //                     obscureText: true,
                //                     obscuringCharacter: "*",
                //                     style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
                //                     decoration: InputDecoration(
                //                         hintText: "Enter Confirm Password",
                //                         isDense: true,
                //                         contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                //                         // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                //                         border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(10),
                //                             borderSide: BorderSide(
                //                                 width: 0,
                //                                 style: BorderStyle.none
                //                             )
                //                         ),
                //                         filled: true,
                //                         fillColor: Colors.grey.shade100
                //                     ),
                //                   ),
                //                   SizedBox(height: 15,),
                //                   SafeArea(
                //                     left: false,
                //                     right: false,
                //                     top: true,
                //                     bottom: false,
                //                     minimum: EdgeInsets.only(top: 20),
                //                     child: SizedBox(
                //                       height: MediaQuery.of(context).size.height*0.05,
                //                       width: MediaQuery.of(context).size.width*0.4,
                //                       child: TextButton(
                //                           onPressed: (){},
                //                           child: Text("RESET",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),),
                //                           style: ButtonStyle(
                //                               backgroundColor: MaterialStateProperty.all(Colors.lightBlue.shade700),
                //                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //                                   RoundedRectangleBorder(
                //                                       borderRadius: BorderRadius.circular(15)
                //                                   )
                //                               )
                //                           )
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     )
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
