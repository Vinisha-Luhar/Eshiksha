import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eshiksha_temp/phoneverify.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:eshiksha_temp/signup.dart';
import 'package:ndialog/ndialog.dart';

class MyOtpVerify extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.beVietnamProTextTheme()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyOtpVerifyPage extends StatefulWidget {

  var number;
  MyOtpVerifyPage(this.number);

  @override
  State<MyOtpVerifyPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MyOtpVerifyPage>{

  final FirebaseAuth auth=FirebaseAuth.instance;
  String code="";
  final defaultPinTheme = PinTheme(
    width: 45,
    height: 56,
    textStyle: GoogleFonts.poppins(fontSize: 20,
        color: Color(0xff152942),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xff152942)),//Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 45,
    height: 56,
    textStyle: GoogleFonts.poppins(fontSize: 20,
        color: Color(0xff152942),//Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color(0xfff1f4f9),
      border: Border.all(color: Color(0xff152942)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final submittedPinTheme = PinTheme(
    width: 45,
    height: 56,
    textStyle: GoogleFonts.poppins(fontSize: 20,
        color: Colors.black,//Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color(0xfff1f4f9),
      border: Border.all(color: Color(0xff152942)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

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
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return snackbar;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: null,
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
                  child: Align(alignment: Alignment.center,child: Text("Verification Code",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text("Please enter the verification code sent to +91"+widget.number,textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Colors.grey.shade400,fontSize: 17,fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onChanged: (value){
                      setState(() {
                        code=value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 50,),
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
                            message: Text("We are verifying your OTP")
                        );
                        progressdialog.show();
                        try
                        {
                          print("_0_0_0" + code);
                          print("_0_0_0" +MyPhoneVerifyPage.verify);
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhoneVerifyPage.verify, smsCode: code);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          // isMobileValidate = true
                          setState(() {
                            MySignupPage.isMobileValidate=true;
                          });
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'OTP Verified',
                              btnOkOnPress: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MySignupPage()));
                              },
                              btnOkColor: Colors.green
                          ).show();
                          await Future.delayed(Duration(seconds: 3));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MySignupPage()));
                        }
                        catch(e){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Invalid OTP',
                            btnOkOnPress: () {},
                            btnOkColor: Color(0xffd33d46)
                          ).show();
                        }
                      },
                      child: Text(
                        "VERIFY",
                        style: GoogleFonts.poppins(fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff152942))
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