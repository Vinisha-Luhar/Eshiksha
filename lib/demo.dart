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


class MyDemo extends StatelessWidget {
  const MyDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
      home:MyDemoPage(),
    );
  }
}

class MyDemoPage extends StatefulWidget {

  @override
  State<MyDemoPage> createState() => _MyDemoPageState();
}

class _MyDemoPageState extends State<MyDemoPage> {

  Future<List<int>> imageToByte(String imagepath) async
  {
    final file=File(imagepath);
    List<int> imagebytes=await file.readAsBytes();
    return imagebytes;
  }

  Future<String> getImagePath(String imagename) async
  {
    final directory=await getTemporaryDirectory();
    final imagepath="${directory.path}/bear.png";
    return imagepath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(child: TextButton(onPressed: () async {
          String imagepath=await getImagePath('bear.png');
          print(imagepath);
          List<int> bytes=await imageToByte(imagepath);
          print(bytes);
        }, child: Text("Image to bytes"))),
      ),
    );
  }
}
