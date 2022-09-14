
import 'package:admin/cubit/layout_cubit.dart';
import 'package:admin/states/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/user_model.dart';
import '../shared/comp.dart';
import '../shared/const.dart';

class Layout extends StatelessWidget{
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    Icon filledValidIcon=const Icon(Icons.check_circle,color: Colors.green,);
    Icon filledFailIcon=const Icon(Icons.block,color: Colors.red,);
    Icon validIcon=const Icon(Icons.check_circle_outline,color: Colors.grey,);
    Icon failIcon=const Icon(Icons.block,color: Colors.grey,);
    Icon selectedValid = validIcon;
    Icon selectedFail = failIcon;
    return BlocConsumer<LayoutCubit,LayoutStates>(
        builder: (context,state){
          Widget list(List<UserModel> build )=>Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=> Row(
                  children:  [
                    CircleAvatar(
                      backgroundImage: build[index].image==''?const AssetImage('assets/user.jpg'):const NetworkImage('build[index].image') as ImageProvider,
                      radius: 25.r,
                    ),
                    SizedBox(width: 9.w,),
                    Text(
                      '${build[index].name}',
                      style:TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: darkText
                      ) ,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){
                          if(build[index].status!='Verified'){
                            LayoutCubit.get(context).updateUser(name: build[index].name, status: 'Verified', email: build[index].email, phone: build[index].phone, id: build[index].id, image: build[index].image);
                            build.removeAt(index);
                          }
                        },
                        icon:build[index].status=='Verified'?filledValidIcon:validIcon
                    ),
                    IconButton(
                        onPressed: (){
                          if(build[index].status!='Unverified'){
                            selectedFail=filledFailIcon;
                            selectedValid=validIcon;
                            LayoutCubit.get(context).updateUser(name: build[index].name, status: 'Unverified', email: build[index].email, phone: build[index].phone, id: build[index].id, image: build[index].image);
                            build.removeAt(index);
                          }

                        },
                        icon:build[index].status=='Unverified'?filledFailIcon:failIcon
                    )
                  ],
                ),
                separatorBuilder: (context,index)=> const Divider(color: lightText,),
                itemCount: build.length
            ),
          );
          List<Widget> screens = [
            list(LayoutCubit.get(context).usersVerified),
            list(LayoutCubit.get(context).usersUnverified),
            list(LayoutCubit.get(context).usersPending),
          ];

          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                onTap:(i){
                  LayoutCubit.get(context).changeIndex(i);
                } ,
                currentIndex: index,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline),label: 'Verified'),
                  BottomNavigationBarItem(icon: Icon(Icons.block),label: 'Unverified'),
                  BottomNavigationBarItem(icon: Icon(Icons.pending_outlined),label: 'Pending'),
                ]
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Users',
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
                                  child: Text('Upload')
                              ),
                              const PopupMenuItem<int>(
                                  value: 1,
                                  child: Text('Logout')
                              ),

                            ]
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    screens[index],
                  ],

                ),
              ),
            ),
          );
        },
        listener: (context,state){}
    );
  }

}