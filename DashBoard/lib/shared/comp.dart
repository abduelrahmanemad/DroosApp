import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../modules/login.dart';
import '../modules/upload.dart';
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


void onSelected (context,item){
  switch(item){
    case 0:
      navigateTo(context, Upload());
      break;
    case 1:
      navigateAndFinish(context,Login());
      break;

  }
}

Widget startTextField(String hint,controller,{hide=false,suffixIcon,type=TextInputType.text,String? Function(String?)? validator,Function(String)? onChanged}) => TextFormField(
  validator: validator,
  onChanged: onChanged ,
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
