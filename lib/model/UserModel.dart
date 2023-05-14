import 'dart:convert';
import 'dart:io';

UserModel usermodeljson(String str) => UserModel.fromJson(json.decode(str));

String usermodeltojson(UserModel data) => json.encode(data.toJson());

class UserModel{

  late final dynamic id;
  late final String role;
  late final String name;
  late final String designation;
  late final String phone_number;
  late final String emailid;
  late final String password;
  late final String confirmpassword;
  late final String gender;
  late final dynamic teaching_ex;
  late final String subofinterest;
  late final dynamic classtaught;
  late final String academicqua;
  late final String professionalqua;
  late final String technicalqua;
  late final String about;
  late final String imagefile;

  UserModel({required this.id,
  required this.role,
  required this.name,
  required this.designation,
  required this.phone_number,
  required this.emailid,
    required this.password,
    required this.confirmpassword,
    required this.gender,
  required this.teaching_ex,
  required this.subofinterest,
  required this.classtaught,
  required this.academicqua,
  required this.professionalqua,
  required this.technicalqua,
  required this.about,
  required this.imagefile});

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        id: json['id'],
        role: json['role'],
        name: json['name'],
        designation: json['designation'],
        phone_number: json['phone_number'],
        emailid: json['emailid'],
        password: json['password'],
        confirmpassword: json['confirm_password'],
        gender: json['gender'],
        teaching_ex: json['teaching_ex'],
        subofinterest: json['subofinterest'],
        classtaught: json['classtaught'],
        academicqua: json['academicqua'],
        professionalqua: json['professionalqua'],
        technicalqua: json['technicalqua'],
        about: json['about'],
      imagefile: json['imagefile']
    );
  }

  Map<String,dynamic> toJson()=>{
    "id":id,
    "role":role,
    "name":name,
    "designation":designation,
    "phone_number":phone_number,
    "emailid":emailid,
    "password":password,
    "confirm_password":confirmpassword,
    "gender":gender,
    "teaching_ex":teaching_ex,
    "subofinterest":subofinterest,
    "classtaught":classtaught,
    "academicqua":academicqua,
    "professionalqua":professionalqua,
    "technicalqua":technicalqua,
    "about":about,
    "imagefile":imagefile
  };

  String get getrole => role;
  String get getname => name;
  String get getdesignation => designation;
  String get getphone_number => phone_number;
  String get getemailid => emailid;
  String get getpassword => password;
  String get getconfirm_password => confirmpassword;
  String get getgender => gender;
  dynamic get getteaching_ex => teaching_ex;
  String get getsubofinterest => subofinterest;
  dynamic get getclasstaught => classtaught;
  String get getacademicqua => academicqua;
  String get getprofessionalqua => professionalqua;
  String get gettechnicalqua => technicalqua;
  String get getabout => about;
  String get getimagefile => imagefile;

}

// UserModel usermodeljson(String str)=>
//     UserModel.fromJson(json.decode(str));
//
// String usermodeltojson(UserModel data) => jsonEncode(data.toJson());

// class UserModel{
//
//   int? id;
//   String? role;
//   String? name;
//   String? designation;
//   String? phone_number;
//   String? emailid;
//   int? teaching_ex;
//   String? subofinterest;
//   int? classtaught;
//   String? academicqua;
//   String? professionalqua;
//   String? technicalqua;
//   String? about;
//
//   UserModel({
//     this.id,
//     this.role,
//     this.name,
//     this.designation,
//     this.phone_number,
//     this.emailid,
//     this.teaching_ex,
//     this.subofinterest,
//     this.classtaught,
//     this.academicqua,
//     this.professionalqua,
//     this.technicalqua,
//     this.about
//   });
//
//   UserModel.fromJson(Map<String,dynamic> json)
//   {
//     id= json['id'];
//     role=json['role'];
//     name=json['name'];
//     designation=json['designation'];
//     phone_number=json['phone_number'];
//     emailid=json['emailid'];
//     teaching_ex=json['teaching_ex'];
//     subofinterest=json['subofinterest'];
//     classtaught=json['classtaught'];
//     academicqua=json['academicqua'];
//     professionalqua=json['professionalqua'];
//     technicalqua=json['technicalqua'];
//     about=json['about'];
//   }
//
//   Map<String,dynamic> toJson() => {
//     "id":id,
//     "role":role,
//     "name":name,
//     "designation":designation,
//     "phone_number":phone_number,
//     "emailid":emailid,
//     "teaching_ex":teaching_ex,
//     "subofinterest":subofinterest,
//     "classtaught": classtaught,
//     "academicqua": academicqua,
//     "professionalqua": professionalqua,
//     "technicalqua": technicalqua,
//     "about": about
//   };


  // UserModel({required this.id,required this.role,required this.name,required this.designation,required this.phone_number,required this.emailid,required this.teaching_ex,required this.subofinterest,required this.classtaught,required this.academicqua,required this.professionalqua,required this.technicalqua,required this.about});
  //
  // factory UserModel.fromJson(Map<String,dynamic> json)
  // {
  //   return UserModel(id: json['id'],
  //       role: json['role'],
  //       name: json['name'],
  //       designation: json['designation'],
  //       phone_number: json['phone_number'],
  //       emailid: json['emailid'],
  //       teaching_ex: json['teaching_ex'],
  //       subofinterest: json['subofinterest'],
  //       classtaught: json['classtaught'],
  //       academicqua: json['academicqua'],
  //       professionalqua: json['professionalqua'],
  //       technicalqua: json['technicalqua'],
  //       about: json['about']
  //   );
  // }
  //
  // Map<String,dynamic> toJson()=>{
  //
  //   "id": id,
  //   "role": role,
  //   "name": name,
  //   "designation": designation,
  //   "phone_number": phone_number,
  //   "emailid": emailid,
  //   "teaching_ex":teaching_ex,
  //   "subofinterest": subofinterest,
  //   "classtaught": classtaught,
  //   "academicqua": academicqua,
  //   "professionalqua": professionalqua,
  //   "technicalqua": technicalqua,
  //   "about": about,
  //
  // };