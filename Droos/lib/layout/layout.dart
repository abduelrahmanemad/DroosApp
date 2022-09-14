import 'package:droos/cubit/app_cubit.dart';
import 'package:droos/shared/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../modules/lectuers.dart';
import '../modules/login.dart';
import '../modules/profile.dart';
import '../shared/comp.dart';
import '../states/app_states.dart';

class Layout extends StatelessWidget{
  const Layout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..getLectures(),
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          List<Widget>screens=[lec(AppCubit.get(context).lectures),profile(context)];
          if(userModel.status!='Verified'){
            return Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('Your Account state is ${userModel.status} ,'),
                            Text('Contact the support for more info,'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 7.h,),
                    OutlinedButton(onPressed: (){
                      FirebaseAuth.instance.signOut();
                      navigateAndFinish(context, const Login());
                    },
                        child: const Text('Logout'))
                  ],
                ),
              ),
            );
          }else{
            return Scaffold(
                body: screens[index],
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: index,
                    onTap: (i){
                      AppCubit.get(context).changeIndex(i);
                    },
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.library_books),label: ''),
                      BottomNavigationBarItem(icon: Icon(Icons.person),label: ''),
                    ])
            );
          }
        },
        listener: (context,state){},
      ),
    );
  }
  
}