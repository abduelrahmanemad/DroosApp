import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:droos/cubit/login_cubit.dart';
import 'package:droos/layout/layout.dart';
import 'package:droos/modules/register.dart';
import 'package:droos/modules/reset_password.dart';
import 'package:droos/states/login_states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/comp.dart';
import '../shared/const.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var loginEmailController = TextEditingController();
    var loginPasswordController = TextEditingController();
    var loginFormKey = GlobalKey<FormState>();
    return  BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
          builder: (context,state){
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginFormKey ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          SizedBox(height: 165.h,),
                          Text('Sign In to Droos',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: darkText
                            ),
                          ),
                          Row(
                            children: [
                              Text('Don\'t have an account?',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: lightText
                                ),
                              ),
                              TextButton(onPressed: (){navigateAndFinish(context, const Register());}, child: Text('Register',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: blue
                                ),
                              ),)
                            ],
                          ),
                          SizedBox(height: 24.h,),
                          startTextField('Email ',loginEmailController,type: TextInputType.emailAddress,
                              validator:(String? value){
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
                          SizedBox(height: 16.h,),
                          startTextField(
                              'Password',
                              loginPasswordController,
                              hide: LoginCubit.get(context).passwordHidden,
                              validator: (String? value){
                                if(value!.isEmpty)
                                {
                                  return 'This Can\'t be Empty';
                                }
                                if(value.length<6){
                                  return 'Password Can\'t be less that 6 letters';
                                }
                                return null ;
                              },
                              suffixIcon:IconButton(onPressed: (){LoginCubit.get(context).changeVisibility();}, icon: LoginCubit.get(context).passwordHidden?iconVisible:iconNotVisible,),
                          ),
                          SizedBox(height: 16.h,),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: (){
                                if(loginFormKey.currentState!.validate()){
                                  LoginCubit.get(context).loginWithEmailAndPassword(loginEmailController.text, loginPasswordController.text);
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
                              child: ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context){
                                    return const Text('Login');
                                  },
                                  fallback: (context){
                                    return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                                  }
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: lightText
                                ),
                                children:  [
                                  TextSpan(
                                    text: 'Can\'t remember your Password?',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: blue
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap=(){
                                      navigateTo(context, const Reset());
                                    },
                                  ),
                                ]
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context,state){
            if(state is GetUserValidState){
              navigateAndFinish(context, const Layout());
            }
          }
      ),
    );
  }

}