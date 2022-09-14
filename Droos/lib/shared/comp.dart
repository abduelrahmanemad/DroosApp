import 'package:droos/modules/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../modules/edit_profile.dart';
import 'const.dart';

void navigateTo (context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,

    ));
void navigateAndFinish (context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (Route<dynamic> route)=>false
);

Widget startTextField(String hint,controller,{hide=false,suffixIcon,type=TextInputType.text,String? Function(String?)? validator}) => TextFormField(
  validator: validator,
  keyboardType: type,
  obscureText: hide,
  controller: controller,
  decoration: InputDecoration(
    suffixIcon: suffixIcon,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent,width: 0)
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent,width: 0)
      ),
      filled: true,
      fillColor: textFieldColor,
      hintText: hint,
      hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400

      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 14.h)
  ),
);

void showToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: textFieldColor,
      textColor: darkText,
      fontSize: 16.0.sp
  );
}

void onSelected (context,item){
  switch(item){
    case 0:
      navigateTo(context, const Edit());
      break;
    case 1:
      FirebaseAuth.instance.signOut();
      navigateAndFinish(context, const Login());
      break;

  }
}