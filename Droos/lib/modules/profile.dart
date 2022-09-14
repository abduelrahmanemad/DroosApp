import 'package:droos/shared/comp.dart';
import 'package:droos/shared/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget profile(context)=>Padding(
  padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
  child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Row(
            children: [
              Text('Student Info',
                style:TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  color: darkText
                ) ,
              ),
              const Spacer(),
              PopupMenuButton<int>(
                  padding: EdgeInsets.zero,

                  constraints:const BoxConstraints(),
                  onSelected: (item)=>onSelected(context, item),
                  itemBuilder: (context)=>[
                    const PopupMenuItem<int>(
                        value: 0,
                        child: Text('Edit Profile')
                    ),
                    const PopupMenuItem<int>(
                        value: 1,
                        child: Text('Logout')
                    ),
                  ]
              ),
            ],
          ),
          SizedBox(height: 40.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius:50.r ,
                    backgroundColor: blue,
                    backgroundImage: userModel.image==''? const AssetImage('assets/user.jpg') : NetworkImage('${userModel.image}') as ImageProvider,
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    '${userModel.name}',
                    style:TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis
                    ) ,
                  ),

                ],
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Text(
                'Account Status :',
                style:TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                ) ,
              ),
              Text(
                ' ${userModel.status}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: userModel.status=='Pending'?Colors.grey : userModel.status=='Unverified'?Colors.red : CupertinoColors.systemGreen
                ),
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Text(
                'Email :',
                style:TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ) ,
              ),
              Text(
                ' ${userModel.email}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Text(
                'Phone :',
                style:TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ) ,
              ),
              Text(
                ' ${userModel.phone}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 20.h,),
          // Text(
          //   'What you have watched',
          //   style: TextStyle(
          //     fontSize: 15.sp,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // SizedBox(height: 10.h,),
          // Expanded(
          //     child: ListView.separated(
          //         padding: EdgeInsets.zero,
          //         physics: const BouncingScrollPhysics(),
          //         itemBuilder: (context,index)=> InkWell(
          //           onTap: (){},
          //           child: Row(
          //             children:  [
          //                CircleAvatar(
          //                 backgroundColor: blue,
          //                 radius: 22.r,
          //               ),
          //               SizedBox(width: 9.w,),
          //               Text(
          //                 'Lecture ${index+1}',
          //                 style:TextStyle(
          //                     fontSize: 15.sp,
          //                     fontWeight: FontWeight.w500,
          //                     color: darkText
          //                 ) ,
          //               ),
          //             ],
          //           ),
          //         ),
          //         separatorBuilder: (context,index)=> const Divider(color: lightText,),
          //         itemCount: 10
          //     ),
          // ),



        ],
      ),
  ),
);