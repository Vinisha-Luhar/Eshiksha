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

class MyOtpVerify extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.asapTextTheme(
              Theme.of(context).textTheme
          )
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
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border.all(color: Colors.blue.shade100),//Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 45,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,//Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final submittedPinTheme = PinTheme(
    width: 45,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,//Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
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
            color: Colors.white
          // gradient: LinearGradient(
          //     begin: Alignment.bottomRight,
          //     end: Alignment.topLeft,
          //     colors: [Color(0xff9DBFFD),Color(0xffC4ECFB)]
          // )
        ),
        child: Stack(
          children: [
            WaveWidget(
              config: CustomConfig(
                  gradients: [[Color(0xff9DBFFD),Color(0xffC4ECFB)]],
                  durations: [50000],
                  heightPercentages: [0.85]
              ),
              size: Size(double.infinity, double.infinity),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FadeInDown(
                //     child: Container(
                //           width: MediaQuery.of(context).size.width * 2,
                //           height: MediaQuery.of(context).size.height * 0.3,
                //         child: Align(
                //             alignment: Alignment.center,
                //             child: Lottie.asset(
                //               "images/lockgrey.json",
                //               fit: BoxFit.cover
                //             )
                //         )
                //     )
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
                  child: Align(alignment: Alignment.center,child: Text("Verification Code",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600),)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text("Please enter the verification code sent to +91"+widget.number,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade700,fontSize: 17,fontWeight: FontWeight.w500),),
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
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(
                              Colors.lightBlue.shade700
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