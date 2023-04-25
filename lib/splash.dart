import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:eshiksha_temp/main.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


class MySplash extends StatelessWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashPage(),
    );
  }
}

class MySplashPage extends StatefulWidget {
  const MySplashPage({Key? key}) : super(key: key);

  @override
  State<MySplashPage> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> with SingleTickerProviderStateMixin{

  late Timer timer;
  bool showwidget=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doSplash();
  }

  Future<Timer> doSplash() async{
    return new Timer(Duration(seconds: 5), afterloading);
  }

  void afterloading() async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff152942)
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: CircleAvatar(radius: 90,backgroundImage: AssetImage('images/eshikshaiconfinal.png'),),
              //child: Text("E-Shiksha",style: GoogleFonts.poppins(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w700))),
              // child: Container(
              //   width: MediaQuery.of(context).size.width*0.8,
              //   height: MediaQuery.of(context).size.height*0.6,
              //   child: Image.asset("images/icon1removebg.png"),
              // ),
            // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            // FadeInUp(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width*0.3,
            //     height: MediaQuery.of(context).size.height*0.3,
            //     child: Lottie.asset("animations/loading.json"),
            //   ),
            )
          ],
        ),
      )
    );
  }
}


