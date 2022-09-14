import 'package:admin/layout/layout.dart';
import 'package:admin/shared/comp.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/const.dart';

class Login extends StatelessWidget{
  var loginUserNameController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();
  String userName ='admin1';
  String password='a123456';

  Login({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(15.sp),
          child: Form(
            key:loginFormKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                startTextField('username', loginUserNameController,validator:
                    (String? value){
                      if(value!.isEmpty)
                      {
                        return 'This Can\'t be Empty';
                      }
                      if(loginUserNameController.text.trim() != userName){
                        return 'Please Enter a valid username';
                      }
                      return null ;
                    }
                  ),
                SizedBox(height: 10.h,),
                startTextField('Password', loginPasswordController,hide: true,validator:
                    (String? value){
                  if(value!.isEmpty)
                  {
                    return 'This Can\'t be Empty';
                  }
                  if(loginPasswordController.text.trim()!=password){
                    return 'Please Enter a valid password';
                  }
                  return null ;
                }
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      if(loginFormKey.currentState!.validate()){
                        navigateAndFinish(context, Layout());
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14.h)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 16.sp,
                      )),
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ) ,
      ),
    );
  }

}