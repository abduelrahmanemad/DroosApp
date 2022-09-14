import 'package:droos/modules/video.dart';
import 'package:droos/shared/comp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/lec_model.dart';
import '../shared/const.dart';
import 'lecture_details.dart';

Widget lec(List<LecModel>lectures)=>Padding(
  padding:  EdgeInsets.symmetric(horizontal: 15..w,vertical: 10.h),
  child: SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h,),
        Text('Lectures',
          style:TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: darkText
          ) ,
        ),
        SizedBox(height: 15.h,),
        Expanded(
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=> InkWell(
                onTap: (){
                  navigateTo(context, LecVideo(lectures[index].urlLec, lectures[index].urlMalzama, lectures[index].urlExam,lectures[index].name));
                },
                child: Row(
                  children:  [
                    CircleAvatar(
                      backgroundColor: blue,
                      radius: 22.r,
                    ),
                    SizedBox(width: 9.w,),
                    Text(
                      '${lectures[index].name}',
                      style:TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: darkText
                      ) ,
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context,index)=> const Divider(color: lightText,),
              itemCount: lectures.length
          ),
        ),
      ],
    ),
  ),
);