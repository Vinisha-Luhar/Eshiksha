import 'dart:math';
import 'package:ndialog/ndialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eshiksha_temp/EmailOtpVerify.dart';
import 'package:eshiksha_temp/Otpverify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class MyEmailVerify extends StatelessWidget {

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

class MyEmailVerifyPage extends StatefulWidget {

  var emailfromsignup;
  MyEmailVerifyPage(this.emailfromsignup);
  String otp="";

  void sendOTP() async {
    var useremail='EShikshaApp@gmail.com';
    otp=(100000+Random().nextInt(900000)).toString();
    print(otp);
    final smtpserver=gmail(useremail,'okvfckhjkebbupoy');
    final message=Message()
      ..from=Address('EShikshaApp@gmail.com')
      ..recipients.add(emailfromsignup)
      ..subject="Verification Code ${otp}"
    // ..text="Your One Time Passcode for Email Verification in E-Shiksha App is $otp"
      ..html="<h1 style='color:#1E90FF;font-family:Verdana;'>E-Shiksha App</h1><br><center><h2 style='font-family:Verdana;color:black'>Hello,</h2><h2 style='font-family:Verdana;color:black'>Please use the verification code below to complete the Email Verification Process for the E-Shiksha App</h2><br><h1>${otp}</h1><br><h2>Thanks!</h2><h2>E-Shiksha Team</h2></center>";
    send(message, smtpserver);
    print("message Sent");
  }


  @override
  State<MyEmailVerifyPage> createState() => _MyEmailVerifyPageState();
}

class _MyEmailVerifyPageState extends State<MyEmailVerifyPage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff152942)
          // gradient: LinearGradient(
          //     begin: Alignment.bottomRight,
          //     end: Alignment.topLeft,
          //     colors: [Color(0xff9DBFFD),Color(0xffC4ECFB)]
          // )
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
                  child: Align(alignment: Alignment.center,child: Text("Email Verification",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text("We need to verify your email id before getting started !!!",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade400,fontSize: 17,fontWeight: FontWeight.w500),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70,bottom: 30,left: 30,right: 30),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Color(0xfff1f4f9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                            child: Text('${widget.emailfromsignup}',style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
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
                            defaultLoadingWidget: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xff152942)),),
                            blur: 10,
                            title: Text("Please Wait..."),
                            message: Text("We are processing your request")
                        );
                        progressdialog.show();
                        await Future.delayed(Duration(seconds: 3));
                        MyEmailVerifyPage myemailverifypage=MyEmailVerifyPage(widget.emailfromsignup);
                        myemailverifypage.sendOTP();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEmailOtpVerifyPage(widget.emailfromsignup,myemailverifypage.otp)));
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
                              Colors.white
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
            )
          ],
        ),
      ),

    );
  }

}