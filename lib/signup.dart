import 'dart:convert';
import 'dart:io';

import 'package:emoji_alert/arrays.dart';
import 'package:eshiksha_temp/EmailVerify.dart';
import 'package:eshiksha_temp/demo.dart';
import 'package:eshiksha_temp/main.dart';
import 'package:eshiksha_temp/model/UserModel.dart';
import 'package:eshiksha_temp/phoneverify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class MySignup extends StatelessWidget {
  const MySignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.beVietnamProTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      home: MySignupPage(),
    );
  }
}

class MySignupPage extends StatefulWidget {
  static bool isMobileValidate = false;
  static bool isEmailValidate = false;

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  bool value = false;
  final ImagePicker imagepicker = ImagePicker();
  final ImageCropper imagecropper = ImageCropper();
  PickedFile? imagefile;
  String roles = "Select Role";
  Color selectedbgcolor = Color(0xff152942);
  Color bgcolor = Color(0xfff1f4f9);
  TextEditingController countrycode = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  TextEditingController emailidcontroller = new TextEditingController();
  TextEditingController subjectofinterestcontroller =
      new TextEditingController();
  TextEditingController academicquacontroller = new TextEditingController();
  TextEditingController professionalquacontroller = new TextEditingController();
  TextEditingController designationcontroller = new TextEditingController();
  TextEditingController aboutcontroller = new TextEditingController();
  TextEditingController teaching_excontroller = new TextEditingController();
  TextEditingController classtaughtcontroller = new TextEditingController();
  TextEditingController technicalquacontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController confirmpasswordcontroller = new TextEditingController();
  List<String> selectedlanguages = [];
  List<String> langwithoutspaces = [];
  String text = "Select Subjects";
  var listofsubjects = [
    "Hindi",
    "English",
    "Tamil",
    "Kannada",
    "Telugu",
    "Urdu",
    "Mathematics",
    "PhysicalScience",
    "BiologicalScience",
    "GeneralScience",
    "SocialStudies",
    "Gujarati"
  ];
  String? phonevalue;
  var subofinterestvalue;
  RegExp passwordregex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  Future<void> registerUser(
      String rolejson,
      String namejson,
      String designationjson,
      String phone_numberjson,
      String emailidjson,
      String passwordjson,
      String confirm_passwordjson,
      int teaching_exjson,
      String subofinterestjson,
      int classtaughtjson,
      String academicquajson,
      String professionalquajson,
      String technicalquajson,
      String aboutjson,
      BuildContext context) async {
    var urljson = "http://192.168.43.61:8089/adduser";
    var response = await http.post(Uri.parse(urljson),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "role": rolejson,
          "name": namejson,
          "designation": designationjson,
          "phone_number": phone_numberjson,
          "emailid": emailidjson,
          "password": passwordjson,
          "confirm_password": confirm_passwordjson,
          "teaching_ex": teaching_exjson,
          "subofinterest": subofinterestjson,
          "classtaught": classtaughtjson,
          "academicqua": academicquajson,
          "professionalqua": professionalquajson,
          "technicalqua": technicalquajson,
          "about": aboutjson
        }));
    String responsestring = response.body;
    if (response.statusCode == 200) {
      print(responsestring);
      if (responsestring == "false") {
        ShowSnackbar(
            "The User With This Mobile Number And Emailid Already Exist");
      } else {
        ProgressDialog progressdialog = ProgressDialog(context,
            blur: 5,
            title: Text("Please Wait..."),
            message: Text("We are storing your data"));
        progressdialog.show();
        await Future.delayed(Duration(seconds: 3));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    } else {
      print(response.statusCode);
    }
  }

  bool validateFieldValue(var tfvalue, var msg) {
    if (tfvalue == null || tfvalue == "") {
      ShowSnackbar(msg);
      return false;
    } else {
      return true;
    }
  }

  Widget ShowSnackbar(String msg) {
    final snackbar = SnackBar(
      content: Align(
          alignment: Alignment.center,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
            child: Center(
              child: Text(
                msg,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
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

  Future<void> permissionPermitter() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera].request();
    if (statuses[Permission.storage]!.isGranted &&
        statuses[Permission.camera]!.isGranted) {
      setState(() {
        value = true;
      });
    }
  }
  // 1 min ave

  Widget subjects(String lang) {
    bool isSubSelected = selectedlanguages.contains(lang);

    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: AnimatedButton(
            text: lang,
            textAlignment: Alignment.center,
            textOverflow: TextOverflow.ellipsis,
            height: 35,
            textMaxLine: 1,
            isReverse: true,
            backgroundColor: bgcolor,
            textStyle: GoogleFonts.asap(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            isSelected: isSubSelected,
            // if TheButton is selected Use this Color
            selectedBackgroundColor: selectedbgcolor,
            selectedTextColor: Colors.white,
            transitionType: TransitionType.TOP_CENTER_ROUNDER,
            borderRadius: 10,
            onPress: () {
              if (isSubSelected) {
                selectedlanguages.remove(lang);
              } else {
                selectedlanguages.add(lang);
              }
              selectedlanguages = selectedlanguages.toSet().toList();
            }),
      ),
    );
  }

  void takePhoto(ImageSource imagesource) async {
    final pickedfile = await imagepicker.getImage(source: imagesource);
    if (pickedfile != null) {
      final cropimage = await imagecropper.cropImage(
          sourcePath: pickedfile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square],
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              backgroundColor: Colors.white,
              toolbarTitle: "Edit Photo",
              toolbarColor: Colors.blue.shade500,
              statusBarColor: Colors.black,
              cropFrameColor: Colors.blue.shade500,
              cropFrameStrokeWidth: 7,
              activeControlsWidgetColor: Colors.blue,
              cropGridStrokeWidth: 3,
              dimmedLayerColor: Colors.grey.shade200,
              toolbarWidgetColor: Colors.white,
            )
          ]);
      setState(() {
        imagefile = PickedFile(cropimage!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardopen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xfff1f4f9),
            ),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(color: Color(0xff152942))),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                        ),
                        Center(
                            child: Text(
                          "E-Shiksha",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Register",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff152942),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Divider(
                                  color: Color(0xff152942),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Stack(
                                  children: [
                                    imagefile != null
                                        ? CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: FileImage(
                                                File(imagefile!.path)))
                                        : CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                                "images/profile6.png"),
                                            backgroundColor: Colors.transparent,
                                          ),
                                    Positioned(
                                        bottom: 6,
                                        right: 0,
                                        child: InkWell(
                                            onTap: () {
                                              //if(value==true)
                                              //{
                                              EmojiAlert(
                                                      alertTitle: Text(
                                                        "Choose Profile Photo",
                                                        style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18)
                                                      ),
                                                      cornerRadiusType:
                                                          CORNER_RADIUS_TYPES
                                                              .TOP_ONLY,
                                                      cancelable: true,
                                                      width: double.infinity,
                                                      height: 180,
                                                      emojiSize: 0,
                                                      description: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                child: Column(
                                                                  children: [
                                                                    InkWell(
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            20,
                                                                        backgroundColor: Colors
                                                                            .blue
                                                                            .shade50,
                                                                        backgroundImage:
                                                                            AssetImage("images/shutter.png"),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        takePhoto(
                                                                            ImageSource.camera);
                                                                      },
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Camera",
                                                                        style: GoogleFonts.poppins(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                child: Column(
                                                                  children: [
                                                                    InkWell(
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            20,
                                                                        backgroundColor: Colors
                                                                            .blue
                                                                            .shade50,
                                                                        backgroundImage:
                                                                            AssetImage("images/galleryicon.png"),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        takePhoto(
                                                                            ImageSource.gallery);
                                                                      },
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Gallery",
                                                                        style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                  .displayBottomSheet(context);
                                              //}
                                              //else
                                              //{
                                              //permissionPermitter();
                                              //}
                                            },
                                            child: CircleAvatar(
                                              radius: 13,
                                              backgroundImage: AssetImage(
                                                  "images/cameraicon5.png"),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Role For Registering",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                roles=="Select Role"
                                    ? Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f4f9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ExpansionTile(
                                        title: Text("Select Role",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey.shade700)),
                                        shape: InputBorder.none,
                                        children: [
                                          ListTile(
                                            title: Text("E-Content Developer"),
                                            onTap: (){
                                              setState(() {
                                                roles="E-Content Developer";
                                              });
                                            },
                                          ),
                                          ListTile(
                                            title: Text("E-Content Reviewer"),
                                            onTap: (){
                                              setState(() {
                                                roles="E-Content Reviewer";
                                              });
                                            },
                                          ),
                                          ListTile(
                                            title: Text("Quality Checker"),
                                            onTap: (){
                                              setState(() {
                                                roles="Quality Checker";
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ):
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff1f4f9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ExpansionTile(
                                    title: Text(roles,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black)),
                                    shape: InputBorder.none,
                                    children: [
                                      ListTile(
                                        title: Text("E-Content Developer"),
                                        onTap: (){
                                          setState(() {
                                            roles="E-Content Developer";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        title: Text("E-Content Reviewer"),
                                        onTap: (){
                                          setState(() {
                                            roles="E-Content Reviewer";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        title: Text("Quality Checker"),
                                        onTap: (){
                                          setState(() {
                                            roles="Quality Checker";
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Name",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: namecontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Name",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Designation",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: designationcontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(30),
                                  ],
                                  keyboardType: TextInputType.text,
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Designation",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Contact Number",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                          decoration: BoxDecoration(
                                              color: Color(0xfff1f4f9),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("+91",
                                              style: GoogleFonts.poppins(color: Colors.grey.shade700,fontSize: 14.5,fontWeight: FontWeight.w400),
                                            ),
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xfff1f4f9),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: TextFormField(
                                                controller: phonecontroller,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(10)
                                                ],
                                                style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                                decoration: InputDecoration(
                                                    hintText: "Phone Number",
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                                    // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                            width: 0,
                                                            style: BorderStyle.none
                                                        )
                                                    ),
                                                    filled: true,
                                                    fillColor: Color(0xfff1f4f9)
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    phonevalue=value;
                                                    //phonecontroller.text=phonevalue!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              height: 37,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: TextButton(
                                                    onPressed: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhoneVerifyPage(phonecontroller.text.toString())));
                                                    },
                                                    child: Text(MySignupPage.isMobileValidate? "Verified":"Verify",
                                                      style: GoogleFonts.poppins(fontSize: 15,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.white)
                                                    )
                                                    ,style: ButtonStyle(
                                                    backgroundColor:MySignupPage.isMobileValidate? MaterialStateProperty.all(Colors.green.shade700):MaterialStateProperty.all(Colors.red.shade700),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                                                    )
                                                )
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Email ID",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xfff1f4f9),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: emailidcontroller,
                                          keyboardType: TextInputType.emailAddress,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(30)
                                          ],
                                          style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                          decoration: InputDecoration(
                                              hintText: "Enter Email ID",
                                              isDense: true,
                                              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                              // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none
                                                  )
                                              ),
                                              filled: true,
                                              fillColor: Color(0xfff1f4f9)
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 37,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: TextButton(
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyEmailVerifyPage(emailidcontroller.text.toString())));
                                              },
                                              child: Text(MySignupPage.isEmailValidate? "Verified" : "Verify",
                                                style: GoogleFonts.poppins(fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white))
                                              ,style: ButtonStyle(
                                              backgroundColor:MySignupPage.isEmailValidate? MaterialStateProperty.all(Colors.green.shade700) : MaterialStateProperty.all(Colors.red.shade700),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                                              )
                                          )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Password",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: passwordcontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(8)
                                  ],
                                  obscureText: true,
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Confirm Password",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: confirmpasswordcontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(8)
                                  ],
                                  obscureText: true,
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Password Again",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Teaching Experience (In Years)",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: teaching_excontroller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(2)
                                  ],
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Experience",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Subject Of Interest",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                InkWell(
                                  child: TextField(
                                    controller: subjectofinterestcontroller,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                    enabled: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9),
                                      hintText: "Select Subjects",
                                      hintStyle: GoogleFonts.poppins(color: Colors.grey.shade700,fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                    EmojiAlert(
                                      alertTitle:
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text("Select Subjects",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.transparent,
                                                  backgroundImage: AssetImage("images/checked.png"),
                                                ),
                                                onTap: (){
                                                  Navigator.pop(context);
                                                  langwithoutspaces=selectedlanguages.map((str) => str.trim()).toList();
                                                  subjectofinterestcontroller.text=langwithoutspaces.toString().replaceAll("[", "").replaceAll("]", "");
                                                  subofinterestvalue=subjectofinterestcontroller.text;
                                                  print(subofinterestvalue);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      cornerRadiusType: CORNER_RADIUS_TYPES.TOP_ONLY,
                                      cancelable: true,
                                      width: double.infinity,
                                      height: 280,
                                      emojiSize: 0,
                                      description: Column(
                                        children: [
                                          Row(
                                            children: [
                                              subjects("Hindi"),
                                              subjects("English"),
                                              subjects("Tamil"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              subjects("Kannada"),
                                              subjects("Telugu"),
                                              subjects("Urdu"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              subjects("Mathematics"),
                                              subjects("     Physical Science"),
                                              subjects("    Biological Science "),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              subjects("     General Science "),
                                              subjects("      Social Studies"),
                                              subjects("Gujarati"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ).displayBottomSheet(context);
                                  },
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Classes Taught",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: classtaughtcontroller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(2)
                                  ],
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Classes Taught",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Academic Qualifications",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: academicquacontroller,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Academic Qualifications",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Professional Qualifications",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: professionalquacontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Professional Qualifications",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text("*",style: GoogleFonts.poppins(fontWeight: FontWeight.w800,color: Colors.red.shade800,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text("This Field is Required",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.red.shade800,fontSize: 13)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Technical Qualifications",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: technicalquacontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter Technical Qualifications",
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      filled: true,
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("About You",style: GoogleFonts.poppins(color: Color(0xff152942),fontSize: 15,fontWeight: FontWeight.w500))
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  controller: aboutcontroller,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(100)
                                  ],
                                  maxLines: 6,
                                  style: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.w400,color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Enter About Yourself",
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
                                      fillColor: Color(0xfff1f4f9)
                                  ),
                                ),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width*0.4,
                      child: TextButton(
                          onPressed: (){
                            if(namecontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Your Name!");
                            }
                            else if(phonecontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Your Phone Number!");
                            }
                            else if(emailidcontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Your Email id!");
                            }
                            else if(passwordcontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Your Password!");
                            }
                            else if(confirmpasswordcontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Confirm Password");
                            }
                            else if(passwordcontroller.text != confirmpasswordcontroller.text)
                            {
                              ShowSnackbar("Passwords Don't Match");
                            }
                            else if(!passwordregex.hasMatch(passwordcontroller.text))
                            {
                              ShowSnackbar("Password must be 8 characters long and contain atleast one uppercase letter, one lowercase letter, one digit and one special character (!@#\$&*~)");
                            }
                            else if(subofinterestvalue=="")
                            {
                              ShowSnackbar("Please Select the Subjects of Your Interest!");
                            }
                            else if(academicquacontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Your Academic Qualification!");
                            }
                            else if(professionalquacontroller.text=="")
                            {
                              ShowSnackbar("Please Enter Your Professional Qualification!");
                            }
                            // else if(MySignupPage.isMobileValidate==false)
                            //   {
                            //     ShowSnackbar("Please Verify Your Mobile Number!");
                            //   }
                            // else if(MySignupPage.isEmailValidate==false)
                            //   {
                            //     ShowSnackbar("Please Verify Your Email Id");
                            //   }
                            else {
                              int teaching_exvalue;
                              int classtaughtvalue;
                              teaching_excontroller.text == "" ? teaching_exvalue=0 : teaching_exvalue=int.parse(teaching_excontroller.text);
                              classtaughtcontroller.text == "" ? classtaughtvalue=0 : classtaughtvalue=int.parse(classtaughtcontroller.text);
                              if(roles=="Select Role")
                              {
                                roles="";
                              }
                              print(roles);
                              registerUser(roles,
                                  namecontroller.text,
                                  designationcontroller.text,
                                  phonecontroller.text,
                                  emailidcontroller.text,
                                  passwordcontroller.text,
                                  confirmpasswordcontroller.text,
                                  teaching_exvalue,
                                  subofinterestvalue,
                                  classtaughtvalue,
                                  academicquacontroller.text,
                                  professionalquacontroller.text,
                                  technicalquacontroller.text,
                                  aboutcontroller.text,
                                  context);
                            }
                          },
                          child: Text("REGISTER",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xff152942)),
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
          ],
        )

        // body: Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.bottomRight,
        //           end: Alignment.topLeft,
        //           colors: [Color(0xff9DBFFD),Color(0xffC4ECFB)]
        //       )
        //   ),
        //   child: Stack(
        //     children: [
        //       WaveWidget(
        //         config: CustomConfig(
        //             colors: [Colors.white],
        //             durations: [50000],
        //             heightPercentages: [0.85]
        //         ),
        //         size: Size(double.infinity, double.infinity),
        //       ),
        //
        //       Column(
        //         children: [
        //           FadeInDown(
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 27,bottom: 10),
        //                 child: Container(
        //                     child: Align(
        //                         alignment: Alignment.center,
        //                         child: Image.asset("images/smallicon1removebg.png",
        //                           width: MediaQuery.of(context).size.width*0.8,
        //                           height: MediaQuery.of(context).size.height*0.1,
        //                         )
        //                     )
        //                 ),
        //               )
        //           ),
        //           FadeInUp(
        //               child: Card(
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(20)
        //                 ),
        //                 color: Colors.white,
        //                 child: Padding(
        //                   padding: EdgeInsets.only(top: 20,left: 20,right: 20),
        //                   child: Container(
        //                     width: MediaQuery.of(context).size.width*0.8,
        //                     height: MediaQuery.of(context).size.height*0.7,
        //                     child: SingleChildScrollView(
        //                       physics: AlwaysScrollableScrollPhysics(),
        //                       child: Column(
        //                         children: [
        //                           Align(alignment: Alignment.topLeft,child: Text("Register",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),)),
        //                           Divider(color: Color(0xff9DBFFD),),
        //                           SizedBox(height: 15,),
        //                           Stack(
        //                             children: [
        //                               imagefile!=null
        //                                   ? CircleAvatar(
        //                                   radius: 50,
        //                                   backgroundColor: Colors.transparent,
        //                                   backgroundImage: FileImage(File(imagefile!.path))
        //                               )
        //                                   : CircleAvatar(
        //                                 radius: 50,
        //                                 backgroundImage: AssetImage("images/profile6.png"),
        //                                 backgroundColor: Colors.transparent,
        //                               ),
        //                               Positioned(
        //                                   bottom: 6,
        //                                   right: 0,
        //                                   child: InkWell(
        //                                       onTap: (){
        //                                         //if(value==true)
        //                                         //{
        //                                         EmojiAlert(
        //                                             alertTitle: Text("Choose Profile Photo",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),),
        //                                             cornerRadiusType: CORNER_RADIUS_TYPES.TOP_ONLY,
        //                                             cancelable: true,
        //                                             width: double.infinity,
        //                                             height: 180,
        //                                             emojiSize: 0,
        //                                             description: Padding(
        //                                               padding: const EdgeInsets.only(top: 5),
        //                                               child: Row(
        //                                                 mainAxisAlignment: MainAxisAlignment.center,
        //                                                 children: [
        //                                                   Expanded(
        //                                                     flex: 1,
        //                                                     child: Container(
        //                                                       child: Column(
        //                                                         children: [
        //                                                           InkWell(
        //                                                             child: CircleAvatar(
        //                                                               radius: 20,
        //                                                               backgroundColor: Colors.blue.shade50,
        //                                                               backgroundImage: AssetImage("images/cameraicon3.png"),
        //                                                             ),
        //                                                             onTap: (){
        //                                                               takePhoto(ImageSource.camera);
        //                                                             },
        //                                                           ),
        //                                                           Padding(
        //                                                             padding: const EdgeInsets.only(top: 10),
        //                                                             child: Text("Camera",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
        //                                                           )
        //                                                         ],
        //                                                       ),
        //                                                     ),
        //                                                   ),
        //                                                   Expanded(
        //                                                     flex: 1,
        //                                                     child: Container(
        //                                                       child: Column(
        //                                                         children: [
        //                                                           InkWell(
        //                                                             child: CircleAvatar(
        //                                                               radius: 20,
        //                                                               backgroundColor: Colors.blue.shade50,
        //                                                               backgroundImage: AssetImage("images/gallery.png"),
        //                                                             ),
        //                                                             onTap: (){
        //                                                               takePhoto(ImageSource.gallery);
        //                                                             },
        //                                                           ),
        //                                                           Padding(
        //                                                             padding: const EdgeInsets.only(top: 10),
        //                                                             child: Text("Gallery",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
        //                                                           )
        //                                                         ],
        //                                                       ),
        //                                                     ),
        //                                                   )
        //                                                 ],
        //                                               ),
        //                                             )
        //                                         ).displayBottomSheet(context);
        //                                         //}
        //                                         //else
        //                                         //{
        //                                         //permissionPermitter();
        //                                         //}
        //                                       },
        //                                       child: CircleAvatar(
        //                                         radius: 13,
        //                                         backgroundImage: AssetImage("images/cameraicon6.png"),
        //                                         backgroundColor: Colors.transparent,
        //                                       )
        //                                   )
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Role For Registering",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           roles=="Select Role"
        //                               ? Material(
        //                             elevation: 3,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             shadowColor: Colors.blue.shade100,
        //                             child: Container(
        //                               decoration: BoxDecoration(
        //                                 color: Colors.grey.shade200,
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               child: ExpansionTile(
        //                                 title: Text("Select Role",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey.shade700),),
        //                                 shape: InputBorder.none,
        //                                 children: [
        //                                   ListTile(
        //                                     title: Text("E-Content Developer"),
        //                                     onTap: (){
        //                                       setState(() {
        //                                         roles="E-Content Developer";
        //                                       });
        //                                     },
        //                                   ),
        //                                   ListTile(
        //                                     title: Text("E-Content Reviewer"),
        //                                     onTap: (){
        //                                       setState(() {
        //                                         roles="E-Content Reviewer";
        //                                       });
        //                                     },
        //                                   ),
        //                                   ListTile(
        //                                     title: Text("Quality Checker"),
        //                                     onTap: (){
        //                                       setState(() {
        //                                         roles="Quality Checker";
        //                                       });
        //                                     },
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ):
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: Container(
        //                               decoration: BoxDecoration(
        //                                 color: Colors.grey.shade200,
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               child: ExpansionTile(
        //                                 title: Text(roles,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),),
        //                                 shape: InputBorder.none,
        //                                 children: [
        //                                   ListTile(
        //                                     title: Text("E-Content Developer"),
        //                                     onTap: (){
        //                                       setState(() {
        //                                         roles="E-Content Developer";
        //                                       });
        //                                     },
        //                                   ),
        //                                   ListTile(
        //                                     title: Text("E-Content Reviewer"),
        //                                     onTap: (){
        //                                       setState(() {
        //                                         roles="E-Content Reviewer";
        //                                       });
        //                                     },
        //                                   ),
        //                                   ListTile(
        //                                     title: Text("Quality Checker"),
        //                                     onTap: (){
        //                                       setState(() {
        //                                         roles="Quality Checker";
        //                                       });
        //                                     },
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Name",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: namecontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(30)
        //                               ],
        //                               keyboardType: TextInputType.name,
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Name",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Designation",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: designationcontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(30),
        //                               ],
        //                               keyboardType: TextInputType.text,
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Designation",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Contact Number",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Row(
        //                             children: [
        //                               Expanded(
        //                                 flex: 1,
        //                                 child: Material(
        //                                     elevation: 3,
        //                                     shadowColor: Colors.blue.shade100,
        //                                     color: Colors.transparent,
        //                                     borderRadius: BorderRadius.circular(10),
        //                                     child: Container(
        //                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                         decoration: BoxDecoration(
        //                                             color: Colors.grey.shade200,
        //                                             borderRadius: BorderRadius.circular(10)
        //                                         ),
        //                                         child: Align(
        //                                           alignment: Alignment.center,
        //                                           child: Text("+91",
        //                                             style: TextStyle(color: Colors.grey.shade700,fontSize: 15,fontWeight: FontWeight.w400,),
        //                                           ),
        //                                         )
        //                                     )
        //                                 ),
        //                               ),
        //                               SizedBox(width: 8,),
        //                               Expanded(
        //                                 flex: 4,
        //                                 child: Material(
        //                                   elevation: 3,
        //                                   shadowColor: Colors.blue.shade100,
        //                                   color: Colors.transparent,
        //                                   borderRadius: BorderRadius.circular(10),
        //                                   child: Container(
        //                                     decoration: BoxDecoration(
        //                                       color: Colors.grey.shade200,
        //                                       borderRadius: BorderRadius.circular(10),
        //                                     ),
        //                                     child: Row(
        //                                       children: [
        //                                         Expanded(
        //                                           flex: 3,
        //                                           child: TextFormField(
        //                                             controller: phonecontroller,
        //                                             keyboardType: TextInputType.number,
        //                                             inputFormatters: <TextInputFormatter>[
        //                                               LengthLimitingTextInputFormatter(10)
        //                                             ],
        //                                             style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                                             decoration: InputDecoration(
        //                                                 hintText: "Phone Number",
        //                                                 isDense: true,
        //                                                 contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                                 // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                                 border: OutlineInputBorder(
        //                                                     borderRadius: BorderRadius.circular(10),
        //                                                     borderSide: BorderSide(
        //                                                         width: 0,
        //                                                         style: BorderStyle.none
        //                                                     )
        //                                                 ),
        //                                                 filled: true,
        //                                                 fillColor: Colors.grey.shade200
        //                                             ),
        //                                             onChanged: (value) {
        //                                               setState(() {
        //                                                 phonevalue=value;
        //                                                 //phonecontroller.text=phonevalue!;
        //                                               });
        //                                             },
        //                                           ),
        //                                         ),
        //                                         Container(
        //                                           height: 33,
        //                                           child: Padding(
        //                                             padding: const EdgeInsets.symmetric(horizontal: 10),
        //                                             child: TextButton(
        //                                                 onPressed: (){
        //                                                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhoneVerifyPage(phonecontroller.text.toString())));
        //                                                 },
        //                                                 child: Text(MySignupPage.isMobileValidate? "Verified":"Verify",
        //                                                   style: TextStyle(
        //                                                       fontSize: 15,
        //                                                       fontWeight: FontWeight.w400,
        //                                                       color: Colors.white
        //                                                   ),)
        //                                                 ,style: ButtonStyle(
        //                                                 backgroundColor:MySignupPage.isMobileValidate? MaterialStateProperty.all(Colors.green.shade700):MaterialStateProperty.all(Colors.red.shade700),
        //                                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                                                     RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
        //                                                 )
        //                                             )
        //                                             ),
        //                                           ),
        //                                         )
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Email ID",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: Container(
        //                               decoration: BoxDecoration(
        //                                   color: Colors.grey.shade200,
        //                                   borderRadius: BorderRadius.circular(10)
        //                               ),
        //                               child: Row(
        //                                 children: [
        //                                   Expanded(
        //                                     child: TextFormField(
        //                                       controller: emailidcontroller,
        //                                       keyboardType: TextInputType.emailAddress,
        //                                       inputFormatters: <TextInputFormatter>[
        //                                         LengthLimitingTextInputFormatter(30)
        //                                       ],
        //                                       style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                                       decoration: InputDecoration(
        //                                           hintText: "Enter Email ID",
        //                                           isDense: true,
        //                                           contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                           // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                           border: OutlineInputBorder(
        //                                               borderRadius: BorderRadius.circular(10),
        //                                               borderSide: BorderSide(
        //                                                   width: 0,
        //                                                   style: BorderStyle.none
        //                                               )
        //                                           ),
        //                                           filled: true,
        //                                           fillColor: Colors.grey.shade200
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Container(
        //                                     height: 33,
        //                                     child: Padding(
        //                                       padding: const EdgeInsets.symmetric(horizontal: 10),
        //                                       child: TextButton(
        //                                           onPressed: (){
        //                                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyEmailVerifyPage(emailidcontroller.text.toString())));
        //                                           },
        //                                           child: Text(MySignupPage.isEmailValidate? "Verified" : "Verify",
        //                                             style: TextStyle(
        //                                                 fontSize: 15,
        //                                                 fontWeight: FontWeight.w400,
        //                                                 color: Colors.white
        //                                             ),)
        //                                           ,style: ButtonStyle(
        //                                           backgroundColor:MySignupPage.isEmailValidate? MaterialStateProperty.all(Colors.green.shade700) : MaterialStateProperty.all(Colors.red.shade700),
        //                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                                               RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
        //                                           )
        //                                       )
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Password",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: passwordcontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(8)
        //                               ],
        //                               obscureText: true,
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Password",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Confirm Password",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: confirmpasswordcontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(8)
        //                               ],
        //                               obscureText: true,
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Password Again",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Teaching Experience (In Years)",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: teaching_excontroller,
        //                               keyboardType: TextInputType.number,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 FilteringTextInputFormatter.digitsOnly,
        //                                 LengthLimitingTextInputFormatter(2)
        //                               ],
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Experience",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Subject Of Interest",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           InkWell(
        //                             child: Material(
        //                               elevation: 3,
        //                               shadowColor: Colors.blue.shade100,
        //                               color: Colors.transparent,
        //                               borderRadius: BorderRadius.circular(10),
        //                               child: TextField(
        //                                 controller: subjectofinterestcontroller,
        //                                 textAlign: TextAlign.left,
        //                                 style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                                 enabled: false,
        //                                 maxLines: null,
        //                                 decoration: InputDecoration(
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200,
        //                                   hintText: "Select Subjects",
        //                                   hintStyle: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w400),
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                             onTap: (){
        //                               EmojiAlert(
        //                                 alertTitle:
        //                                 Row(
        //                                   children: [
        //                                     Expanded(
        //                                       flex: 1,
        //                                       child: Align(
        //                                         alignment: Alignment.topLeft,
        //                                         child: Text("Select Subjects",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),),
        //                                       ),
        //                                     ),
        //                                     Expanded(
        //                                       flex: 1,
        //                                       child: Align(
        //                                         alignment: Alignment.topRight,
        //                                         child: InkWell(
        //                                           child: CircleAvatar(
        //                                             radius: 15,
        //                                             backgroundColor: Colors.transparent,
        //                                             backgroundImage: AssetImage("images/checked.png"),
        //                                           ),
        //                                           onTap: (){
        //                                             Navigator.pop(context);
        //                                             langwithoutspaces=selectedlanguages.map((str) => str.trim()).toList();
        //                                             subjectofinterestcontroller.text=langwithoutspaces.toString().replaceAll("[", "").replaceAll("]", "");
        //                                             subofinterestvalue=subjectofinterestcontroller.text;
        //                                             print(subofinterestvalue);
        //                                           },
        //                                         ),
        //                                       ),
        //                                     )
        //                                   ],
        //                                 ),
        //                                 cornerRadiusType: CORNER_RADIUS_TYPES.TOP_ONLY,
        //                                 cancelable: true,
        //                                 width: double.infinity,
        //                                 height: 280,
        //                                 emojiSize: 0,
        //                                 description: Column(
        //                                   children: [
        //                                     Row(
        //                                       children: [
        //                                         subjects("Hindi"),
        //                                         subjects("English"),
        //                                         subjects("Tamil"),
        //                                       ],
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         subjects("Kannada"),
        //                                         subjects("Telugu"),
        //                                         subjects("Urdu"),
        //                                       ],
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         subjects("Mathematics"),
        //                                         subjects("     Physical Science"),
        //                                         subjects("    Biological Science "),
        //                                       ],
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         subjects("     General Science "),
        //                                         subjects("      Social Studies"),
        //                                         subjects("Gujarati"),
        //                                       ],
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ).displayBottomSheet(context);
        //                             },
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Classes Taught",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: classtaughtcontroller,
        //                               keyboardType: TextInputType.number,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 FilteringTextInputFormatter.digitsOnly,
        //                                 LengthLimitingTextInputFormatter(2)
        //                               ],
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Classes Taught",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Academic Qualifications",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: academicquacontroller,
        //                               inputFormatters: [
        //                                 LengthLimitingTextInputFormatter(30)
        //                               ],
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Academic Qualifications",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Professional Qualifications",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: professionalquacontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(30)
        //                               ],
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Professional Qualifications",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 8,),
        //                           Row(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 12),
        //                                 child: Text("*",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red.shade800,fontSize: 15),),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(left: 4),
        //                                 child: Text("This Field is Required",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red.shade800,fontSize: 13),),
        //                               )
        //                             ],
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("Technical Qualifications",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: technicalquacontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(30)
        //                               ],
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter Technical Qualifications",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Text("About You",style: TextStyle(color: Colors.lightBlue.shade700,fontSize: 15,fontWeight: FontWeight.w500),)
        //                           ),
        //                           SizedBox(height: 5,),
        //                           Material(
        //                             elevation: 3,
        //                             shadowColor: Colors.blue.shade100,
        //                             color: Colors.transparent,
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: TextFormField(
        //                               controller: aboutcontroller,
        //                               inputFormatters: <TextInputFormatter>[
        //                                 LengthLimitingTextInputFormatter(100)
        //                               ],
        //                               maxLines: 6,
        //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
        //                               decoration: InputDecoration(
        //                                   hintText: "Enter About Yourself",
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        //                                   // hintStyle: TextStyle(color: Colors.lightBlue.shade800),
        //                                   border: OutlineInputBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                       borderSide: BorderSide(
        //                                           width: 0,
        //                                           style: BorderStyle.none
        //                                       )
        //                                   ),
        //                                   filled: true,
        //                                   fillColor: Colors.grey.shade200
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: 20,),
        //                           Padding(
        //                             padding: const EdgeInsets.only(bottom: 15),
        //                             child: SizedBox(
        //                               height: MediaQuery.of(context).size.height*0.05,
        //                               width: MediaQuery.of(context).size.width*0.4,
        //                               child: TextButton(
        //                                   onPressed: (){
        //                                     if(namecontroller.text=="")
        //                                       {
        //                                         ShowSnackbar("Please Enter Your Name!");
        //                                       }
        //                                     else if(phonecontroller.text=="")
        //                                     {
        //                                       ShowSnackbar("Please Enter Your Phone Number!");
        //                                     }
        //                                     else if(emailidcontroller.text=="")
        //                                       {
        //                                         ShowSnackbar("Please Enter Your Email id!");
        //                                       }
        //                                     else if(passwordcontroller.text=="")
        //                                       {
        //                                         ShowSnackbar("Please Enter Your Password!");
        //                                       }
        //                                     else if(confirmpasswordcontroller.text=="")
        //                                       {
        //                                         ShowSnackbar("Please Enter Confirm Password");
        //                                       }
        //                                     else if(passwordcontroller.text != confirmpasswordcontroller.text)
        //                                     {
        //                                       ShowSnackbar("Passwords Don't Match");
        //                                     }
        //                                     else if(!passwordregex.hasMatch(passwordcontroller.text))
        //                                     {
        //                                         ShowSnackbar("Password must be 8 characters long and contain atleast one uppercase letter, one lowercase letter, one digit and one special character (!@#\$&*~)");
        //                                     }
        //                                     else if(subofinterestvalue=="")
        //                                       {
        //                                         ShowSnackbar("Please Select the Subjects of Your Interest!");
        //                                       }
        //                                     else if(academicquacontroller.text=="")
        //                                       {
        //                                         ShowSnackbar("Please Enter Your Academic Qualification!");
        //                                       }
        //                                     else if(professionalquacontroller.text=="")
        //                                       {
        //                                         ShowSnackbar("Please Enter Your Professional Qualification!");
        //                                       }
        //                                     // else if(MySignupPage.isMobileValidate==false)
        //                                     //   {
        //                                     //     ShowSnackbar("Please Verify Your Mobile Number!");
        //                                     //   }
        //                                     // else if(MySignupPage.isEmailValidate==false)
        //                                     //   {
        //                                     //     ShowSnackbar("Please Verify Your Email Id");
        //                                     //   }
        //                                     else {
        //                                     int teaching_exvalue;
        //                                     int classtaughtvalue;
        //                                     teaching_excontroller.text == "" ? teaching_exvalue=0 : teaching_exvalue=int.parse(teaching_excontroller.text);
        //                                     classtaughtcontroller.text == "" ? classtaughtvalue=0 : classtaughtvalue=int.parse(classtaughtcontroller.text);
        //                                     if(roles=="Select Role")
        //                                       {
        //                                         roles="";
        //                                       }
        //                                     print(roles);
        //                                       registerUser(roles,
        //                                           namecontroller.text,
        //                                           designationcontroller.text,
        //                                           phonecontroller.text,
        //                                           emailidcontroller.text,
        //                                           passwordcontroller.text,
        //                                           confirmpasswordcontroller.text,
        //                                           teaching_exvalue,
        //                                           subofinterestvalue,
        //                                           classtaughtvalue,
        //                                           academicquacontroller.text,
        //                                           professionalquacontroller.text,
        //                                           technicalquacontroller.text,
        //                                           aboutcontroller.text,
        //                                           context);
        //                                     }
        //                                   },
        //                                   child: Text("REGISTER",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),),
        //                                   style: ButtonStyle(
        //                                       backgroundColor: MaterialStateProperty.all(Colors.lightBlue.shade700),
        //                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                                           RoundedRectangleBorder(
        //                                               borderRadius: BorderRadius.circular(15)
        //                                           )
        //                                       )
        //                                   )
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               )
        //           )
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
