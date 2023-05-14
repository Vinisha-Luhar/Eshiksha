import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eshiksha_temp/admin/userdetails.dart';
import 'package:eshiksha_temp/model/UserModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
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
  String imagefile="";
  Uint8List? imagebytes;
  ImageProvider? imageProvider;
  List<UserModel>? usermodel;

  @override
  void initState() {
    fetchAllUser();
  }

  Future<List<UserModel>> fetchAllUser() async
  {
    final response=await http.get(Uri.parse('http://192.168.43.61:8089/getalluser'));
    if(response.statusCode==200)
    {
      List<dynamic> jsonalluserlist=jsonDecode(response.body);
      List<UserModel> usermodellist=jsonalluserlist.map((json) => UserModel.fromJson(json)).toList();
      print("Successfully got all users");
      return usermodellist;
    }
    else
    {
      throw Exception('Failed to fetch all users');
    }
  }

  Future<List<UserModel>> fetchAllAdminUser() async
  {
    final response=await http.get(Uri.parse('http://192.168.43.61:8089/getalladmin'));
    if(response.statusCode==200)
    {
      List<dynamic> jsonalluserlist=jsonDecode(response.body);
      List<UserModel> usermodellist=jsonalluserlist.map((json) => UserModel.fromJson(json)).toList();
      print("Successfully got all users");
      return usermodellist;
    }
    else
    {
      throw Exception('Failed to fetch all users');
    }
  }

  Future<List<UserModel>> fetchAllContentDeveloperUser() async
  {
    final response=await http.get(Uri.parse('http://192.168.43.61:8089/getallcontentdeveloper'));
    if(response.statusCode==200)
    {
      List<dynamic> jsonalluserlist=jsonDecode(response.body);
      List<UserModel> usermodellist=jsonalluserlist.map((json) => UserModel.fromJson(json)).toList();
      print("Successfully got all users");
      return usermodellist;
    }
    else
    {
      throw Exception('Failed to fetch all users');
    }
  }

  Future<List<UserModel>> fetchAllQualityCheckerUser() async
  {
    final response=await http.get(Uri.parse('http://192.168.43.61:8089/getallqualitychecker'));
    if(response.statusCode==200)
    {
      List<dynamic> jsonalluserlist=jsonDecode(response.body);
      List<UserModel> usermodellist=jsonalluserlist.map((json) => UserModel.fromJson(json)).toList();
      print("Successfully got all users");
      return usermodellist;
    }
    else
    {
      throw Exception('Failed to fetch all users');
    }
  }

  @override
  Widget build(BuildContext context) {

    TabController tabcontroller=TabController(length: 4, vsync: this);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xfff1f4f9)
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.25,
                decoration: BoxDecoration(
                    color: Color(0xff152942)
                ),
                child: Center(child: Text("User Management",style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w400,color: Colors.white),)),
              ),
              Container(
                //margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xfff1f4f9)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 7),
                  child: TabBar(
                    controller: tabcontroller,
                    labelColor: Color(0xff152942),
                    unselectedLabelColor: Colors.grey.shade500,
                    isScrollable: true,
                    physics: BouncingScrollPhysics(),
                    indicator: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xff152942),width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    //indicator: CircleTabIndicator(color: Colors.black, radius: 4.5),
                    tabs: [
                      Tab(
                        child: Container(
                          width: 120,
                          child: Text("All",textAlign: TextAlign.center,),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: 120,
                          child: Text("Admin",textAlign: TextAlign.center,)
                          ,),
                      ),
                      Tab(
                        child: Container(
                          width: 120,
                          child: Text("Content Developer",textAlign: TextAlign.center,),
                        ),
                      ),
                      Tab(
                        child: Container(
                            width: 120,
                            child: Text("Quality Checker",textAlign: TextAlign.center,)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.65,
                decoration: BoxDecoration(
                    color: Color(0xfff1f4f9)
                ),
                child: TabBarView(
                  controller: tabcontroller,
                  children: [
                    FutureBuilder<List<UserModel>>(
                        future: fetchAllUser(),
                        builder: (context,snapshot) {
                          if(snapshot.hasData)
                          {
                            List<UserModel> usermodel=snapshot.data!;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=> UserDetailsPage(snapshot.data![index])));
                                    },
                                    child: Card(
                                      color: Colors.grey.shade50,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 17),
                                        title: Row(
                                          children: [
                                            snapshot.data![index].imagefile=="" ?
                                            snapshot.data![index].gender=="Male" ?
                                            CircleAvatar(radius: 30,child: Image.asset("images/profileformen.png"),)
                                                : CircleAvatar(radius: 30,child: Image.asset("images/profileforwomen.png"),)
                                                : CircleAvatar(radius: 30,backgroundImage: Image.memory(base64Decode(snapshot.data![index].imagefile)).image,),
                                            SizedBox(width: 15,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index].name,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Color(0xff152942)),),
                                                  Text(snapshot.data![index].role,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.grey.shade700,),)
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,color: Color(0xff152942)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          else if(snapshot.hasError)
                          {
                            return Text("${snapshot.error}");
                          }
                          return Shimmer.fromColors(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Column(
                                  children: [
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                  ],
                                ),
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100
                          );
                        }
                    ),
                    FutureBuilder<List<UserModel>>(
                        future: fetchAllAdminUser(),
                        builder: (context,snapshot) {
                          if(snapshot.hasData)
                          {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=> UserDetailsPage(snapshot.data![index])));
                                    },
                                    child: Card(
                                      color: Colors.grey.shade50,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 17),
                                        title: Row(
                                          children: [
                                            snapshot.data![index].imagefile=="" ?
                                            snapshot.data![index].gender=="Male" ?
                                            CircleAvatar(radius: 30,child: Image.asset("images/profileformen.png"),)
                                                : CircleAvatar(radius: 30,child: Image.asset("images/profileforwomen.png"),)
                                                : CircleAvatar(radius: 30,backgroundImage: Image.memory(base64Decode(snapshot.data![index].imagefile)).image,),
                                            SizedBox(width: 15,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index].name,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Color(0xff152942)),),
                                                  Text(snapshot.data![index].role,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.grey.shade700,),)
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,color: Color(0xff152942)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          else if(snapshot.hasError)
                          {
                            return Text("${snapshot.error}");
                          }
                          return Shimmer.fromColors(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Column(
                                  children: [
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                  ],
                                ),
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100
                          );
                        }
                    ),
                    FutureBuilder<List<UserModel>>(
                        future: fetchAllContentDeveloperUser(),
                        builder: (context,snapshot) {
                          if(snapshot.hasData)
                          {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=> UserDetailsPage(snapshot.data![index])));
                                    },
                                    child: Card(
                                      color: Colors.grey.shade50,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 17),
                                        title: Row(
                                          children: [
                                            snapshot.data![index].imagefile=="" ?
                                            snapshot.data![index].gender=="Male" ?
                                            CircleAvatar(radius: 30,child: Image.asset("images/profileformen.png"),)
                                                : CircleAvatar(radius: 30,child: Image.asset("images/profileforwomen.png"),)
                                                : CircleAvatar(radius: 30,backgroundImage: Image.memory(base64Decode(snapshot.data![index].imagefile)).image,),
                                            SizedBox(width: 15,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index].name,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Color(0xff152942)),),
                                                  Text(snapshot.data![index].role,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.grey.shade700,),)
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,color: Color(0xff152942)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          else if(snapshot.hasError)
                          {
                            return Text("${snapshot.error}");
                          }
                          return Shimmer.fromColors(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Column(
                                  children: [
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                  ],
                                ),
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100
                          );
                        }
                    ),
                    FutureBuilder<List<UserModel>>(
                        future: fetchAllQualityCheckerUser(),
                        builder: (context,snapshot) {
                          if(snapshot.hasData)
                          {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=> UserDetailsPage(snapshot.data![index])));
                                    },
                                    child: Card(
                                      color: Colors.grey.shade50,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 17),
                                        title: Row(
                                          children: [
                                            snapshot.data![index].imagefile=="" ?
                                            snapshot.data![index].gender=="Male" ?
                                            CircleAvatar(radius: 30,child: Image.asset("images/profileformen.png"),backgroundColor: Colors.white,)
                                                : CircleAvatar(radius: 30,child: Image.asset("images/profileforwomen.png"),backgroundColor: Colors.white,)
                                                : CircleAvatar(radius: 30,backgroundImage: Image.memory(base64Decode(snapshot.data![index].imagefile)).image,backgroundColor: Colors.white,),
                                            SizedBox(width: 15,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index].name,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Color(0xff152942)),),
                                                  Text(snapshot.data![index].role,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.grey.shade700,),)
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,color: Color(0xff152942)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          else if(snapshot.hasError)
                          {
                            return Text("${snapshot.error}");
                          }
                          return Shimmer.fromColors(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                                child: Column(
                                  children: [
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                    SizedBox(height: 15,),
                                    Expanded(child: Container(color: Colors.white,)),
                                  ],
                                ),
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100
                          );
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]){
    return _CirclePainter(color:color, radius:radius);
  }
}

class _CirclePainter extends BoxPainter {

  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late  Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint ..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}



