import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:droos/cubit/register_cubit.dart';
import 'package:droos/layout/layout.dart';
import 'package:droos/modules/login.dart';
import 'package:droos/shared/comp.dart';
import 'package:droos/shared/const.dart';
import 'package:droos/states/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatelessWidget{
  const Register({super.key});
  @override
  Widget build(BuildContext context) {
    var registerNameController = TextEditingController();
    var registerEmailController = TextEditingController();
    var registerPhoneController = TextEditingController();
    var registerPasswordController = TextEditingController();
    var registerConfirmPasswordController = TextEditingController();
    var registerFormKey = GlobalKey<FormState>();
    return  BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
          builder: (context,state){
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Form(
                      key: registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          SizedBox(height: 70.h,),
                          Text('Sign Up to Droos',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: darkText
                            ),
                          ),
                          Row(
                            children: [
                              Text('Already have an account?',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: lightText
                                ),
                              ),
                              TextButton(onPressed: (){navigateAndFinish(context, const Login());}, child: Text('Login',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: blue
                                ),
                              ),)
                            ],
                          ),
                          SizedBox(height: 24.h,),
                          startTextField(
                              'Full Name',
                              registerNameController,
                              validator: (String? value){
                                if(value!.isEmpty)
                                {
                                  return 'This Can\'t be Empty';
                                }
                                return null ;
                              }
                          ),
                          SizedBox(height: 16.h,),
                          startTextField(
                              'Email ',
                              registerEmailController,
                              type: TextInputType.emailAddress,
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
                          SizedBox(height: 16.h,),
                          startTextField(
                              'Phone Number',
                              registerPhoneController,
                              type: TextInputType.phone,
                              validator: (String? value){
                                if(value!.isEmpty)
                                {
                                  return 'This Can\'t be Empty';
                                }
                                if(value.length<11){
                                  return 'Please Enter a valid Phone';
                                }
                                return null ;
                              }
                          ),
                          SizedBox(height: 16.h,),
                          startTextField(
                              'Password',
                              registerPasswordController,
                              hide: RegisterCubit.get(context).passwordHidden,
                              suffixIcon: IconButton(onPressed: (){RegisterCubit.get(context).changePasswordVisibility();}, icon:RegisterCubit.get(context).passwordHidden?iconVisible:iconNotVisible,),
                              validator: (String? value){
                                if(value!.isEmpty)
                                {
                                  return 'This Can\'t be Empty';
                                }
                                if(value.length<6){
                                  return 'Password Can\'t be less that 6 letters';
                                }
                                return null ;
                              }
                          ),
                          SizedBox(height: 16.h,),
                          startTextField(
                              'Confirm Password',
                              registerConfirmPasswordController,
                              hide: RegisterCubit.get(context).confirmPasswordHidden,
                              suffixIcon: IconButton(onPressed: (){RegisterCubit.get(context).changeConfirmPasswordVisibility();}, icon:RegisterCubit.get(context).confirmPasswordHidden?iconVisible:iconNotVisible ),
                              validator: (String? value){
                                if(value!.isEmpty)
                                {
                                  return 'ReEnter Your Password';
                                }
                                if(registerPasswordController.text!=registerConfirmPasswordController.text){
                                  return 'Password does not match';
                                }
                                return null ;
                              }
                          ),
                          SizedBox(height: 16.h,),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: (){
                                if(registerFormKey.currentState!.validate()){
                                  RegisterCubit.get(context).registerWithEmailAndPassword(registerNameController.text, registerEmailController.text, registerPhoneController.text, registerPasswordController.text);
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
                                  condition: state is! RegisterLoadingState,
                                  builder: (context){
                                    return const Text('Create Account');
                                  },
                                  fallback: (context){
                                    return const Center(child: CircularProgressIndicator(color:Colors.white,),);
                                  }
                                  ),
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
            if(state is CreateUserValidState) {
              navigateAndFinish(context, const Layout());
            }
          }
      ),
    );
  }

}