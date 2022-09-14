import 'package:droos/shared/comp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/const.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<StatefulWidget> createState() {
    return ResetState();
  }
}

class ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    var resetEmailController = TextEditingController();
    var resetFormKey = GlobalKey<FormState>();

    Future resetPassword() async {
      FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmailController.text.trim()).
      then((value){
        showToast('Password reset email sent');
      }
      ).catchError((onError){
        showToast(onError.toString());
      }
      );
    }

    return Scaffold(
      appBar:AppBar(
        title: const Text('Reset Password',style: TextStyle(color: darkText),),
      ),
      body: Form(
        key: resetFormKey ,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                startTextField(
                    'Email',
                    resetEmailController,
                    validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'This Can\'t be Empty';
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please Enter a valid Email';
                      }
                      return null ;
                    }
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      if(resetFormKey.currentState!.validate()){
                        resetPassword();
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
                    child: const Text('Reset Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}