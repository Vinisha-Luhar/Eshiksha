
import 'package:ndialog/ndialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eshiksha_temp/Otpverify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPhoneVerifyPage extends StatelessWidget {

  var phonefromsignup;
  MyPhoneVerifyPage(this.phonefromsignup);
  String countrycode="+91";
  static String verificationid="";
  static String verify="";

  Widget LoadingIcon(){
    return Container(
      width: 100,
      height: 100,
      child: Lottie.asset("images/loading.json"),
    );
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
    var context;
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackbar);
    return snackbar;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.asapTextTheme(
              Theme.of(context).textTheme
          )
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff152942)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
                          child: Align(alignment: Alignment.center,child: Text("Phone Number Verification",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text("We need to verify your phone number before getting started !!!",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Colors.grey.shade400,fontSize: 17,fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 70,bottom: 30,left: 30,right: 30),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                                    decoration: BoxDecoration(
                                        color: Color(0xfff1f4f9),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("+91",
                                        style: GoogleFonts.poppins(color: Colors.grey.shade700,fontSize: 15,fontWeight: FontWeight.w400,),
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff1f4f9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                    child: Text("$phonefromsignup",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.05,
                          width:
                          MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                              onPressed: () async {

                                ProgressDialog progressdialog=ProgressDialog(
                                    context,
                                    blur: 10,
                                    defaultLoadingWidget: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xff152942)),),
                                    title: Text("Please Wait..."),
                                    message: Text("We are processing your request")
                                );
                                progressdialog.show();

                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: '${countrycode+phonefromsignup}',
                                  timeout: Duration(seconds: 60),
                                  verificationCompleted: (PhoneAuthCredential credential) {},
                                  verificationFailed: (FirebaseAuthException e) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        headerAnimationLoop: false,
                                        title: 'Sorry..! Verification Failed',
                                        btnOkOnPress: () {},
                                        btnOkColor: Color(0xffd33d46)
                                    ).show();
                                  },
                                  codeSent: (String verificationId, int? resendToken) {
                                    MyPhoneVerifyPage.verify=verificationId;
                                    print("_0_0_0"+verify);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOtpVerifyPage(phonefromsignup)));
                                  },
                                  codeAutoRetrievalTimeout: (String verificationId) {
                                    MyPhoneVerifyPage.verify=verificationId;
                                  },
                                );
                              },
                              child: Text(
                                "SEND OTP",
                                style: GoogleFonts.poppins(fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff152942)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Color(0xfff1f4f9)
                                    ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)
                                      )
                                  )
                              )
                          ),
                        ),


            ],
          ),
        ),
        // body: Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: BoxDecoration(
        //       color: Colors.white
        //     // gradient: LinearGradient(
        //     //     begin: Alignment.bottomRight,
        //     //     end: Alignment.topLeft,
        //     //     colors: [Color(0xff9DBFFD),Color(0xffC4ECFB)]
        //     // )
        //   ),
        //   child: Stack(
        //     children: [
        //       WaveWidget(
        //         config: CustomConfig(
        //             gradients: [[Color(0xff9DBFFD),Color(0xffC4ECFB)]],
        //             durations: [50000],
        //             heightPercentages: [0.85]
        //         ),
        //         size: Size(double.infinity, double.infinity),
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           // FadeInDown(
        //           //     child: Container(
        //           //           width: MediaQuery.of(context).size.width * 2,
        //           //           height: MediaQuery.of(context).size.height * 0.3,
        //           //         child: Align(
        //           //             alignment: Alignment.center,
        //           //             child: Lottie.asset(
        //           //               "images/locklight.json",
        //           //               fit: BoxFit.cover
        //           //             )
        //           //         )
        //           //     )
        //           // ),
        //           Padding(
        //             padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
        //             child: Align(alignment: Alignment.center,child: Text("Phone Number Verification",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600),)),
        //           ),
        //           Text("We need to verify your phone number before getting started !!!",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade700,fontSize: 17,fontWeight: FontWeight.w500),),
        //           Container(
        //             margin: EdgeInsets.only(top: 70,bottom: 30,left: 30,right: 30),
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                   flex: 1,
        //                   child: Material(
        //                       elevation: 3,
        //                       shadowColor: Colors.grey.shade300,
        //                       color: Colors.transparent,
        //                       borderRadius: BorderRadius.circular(10),
        //                       child: Container(
        //                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                           decoration: BoxDecoration(
        //                               color: Colors.blue.shade50,
        //                               borderRadius: BorderRadius.circular(10)
        //                           ),
        //                           child: Align(
        //                             alignment: Alignment.center,
        //                             child: Text("+91",
        //                               style: TextStyle(color: Colors.grey.shade700,fontSize: 15,fontWeight: FontWeight.w400,),
        //                             ),
        //                           )
        //                       )
        //                   ),
        //                 ),
        //                 SizedBox(width: 8),
        //                 Expanded(
        //                   flex: 4,
        //                   child: Material(
        //                     elevation: 3,
        //                     shadowColor: Colors.grey.shade300,
        //                     color: Colors.transparent,
        //                     borderRadius: BorderRadius.circular(10),
        //                     child: Container(
        //                       height: 46,
        //                       decoration: BoxDecoration(
        //                         color: Colors.blue.shade50,
        //                         borderRadius: BorderRadius.circular(10),
        //                       ),
        //                       child: Padding(
        //                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                         child: Text("$phonefromsignup"),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           SizedBox(
        //             height:
        //             MediaQuery.of(context).size.height * 0.05,
        //             width:
        //             MediaQuery.of(context).size.width * 0.4,
        //             child: TextButton(
        //                 onPressed: () async {
        //
        //                   ProgressDialog progressdialog=ProgressDialog(
        //                       context,
        //                       blur: 10,
        //                       title: Text("Please Wait..."),
        //                       message: Text("We are processing your request")
        //                   );
        //                   progressdialog.show();
        //
        //                   await FirebaseAuth.instance.verifyPhoneNumber(
        //                     phoneNumber: '${countrycode+phonefromsignup}',
        //                     timeout: Duration(seconds: 60),
        //                     verificationCompleted: (PhoneAuthCredential credential) {},
        //                     verificationFailed: (FirebaseAuthException e) {
        //                       AwesomeDialog(
        //                           context: context,
        //                           dialogType: DialogType.error,
        //                           animType: AnimType.rightSlide,
        //                           headerAnimationLoop: false,
        //                           title: 'Sorry..! Verification Failed',
        //                           btnOkOnPress: () {},
        //                           btnOkColor: Color(0xffd33d46)
        //                       ).show();
        //                     },
        //                     codeSent: (String verificationId, int? resendToken) {
        //                       MyPhoneVerifyPage.verify=verificationId;
        //                       print("_0_0_0"+verify);
        //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOtpVerifyPage(phonefromsignup)));
        //                     },
        //                     codeAutoRetrievalTimeout: (String verificationId) {
        //                       MyPhoneVerifyPage.verify=verificationId;
        //                     },
        //                   );
        //                 },
        //                 child: Text(
        //                   "SEND OTP",
        //                   style: TextStyle(
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.w400,
        //                       color: Colors.white),
        //                 ),
        //                 style: ButtonStyle(
        //                     backgroundColor:
        //                     MaterialStateProperty.all(
        //                         Colors.lightBlue.shade700
        //                       ),
        //                     shape: MaterialStateProperty.all<
        //                         RoundedRectangleBorder>(
        //                         RoundedRectangleBorder(
        //                             borderRadius:
        //                             BorderRadius.circular(
        //                                 10)
        //                         )
        //                     )
        //                 )
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
