import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:droos/cubit/edit_cubit.dart';
import 'package:droos/layout/layout.dart';
import 'package:droos/shared/comp.dart';
import 'package:droos/shared/const.dart';
import 'package:droos/states/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Edit extends StatelessWidget{
  const Edit({super.key});

  @override
  Widget build(BuildContext context) {

    var editNameController = TextEditingController();
    var editEmailController = TextEditingController();
    var editPhoneController = TextEditingController();
    var editPasswordController = TextEditingController();
    var editConfirmPasswordController = TextEditingController();
    var editFormKey =GlobalKey<FormState>();

    return BlocProvider(
      create: (context)=>EditCubit(),
      child:BlocConsumer<EditCubit,EditProfileStates>(
          builder:(context,state)=>Scaffold(
            appBar: AppBar(
              title: const Text('Edit Your Info',style: TextStyle(color: darkText),),
              actions: [
                if(!changePass)
                  ConditionalBuilder(
                      condition: state is! UpdateUserLoadingState ,
                      builder: (context){
                        return IconButton(
                          onPressed: (){
                            if(EditCubit.get(context).image!=null){
                              EditCubit.get(context).uploadImage();
                            }
                            if(editEmailController.text.isNotEmpty){
                              if(editFormKey.currentState!.validate()){
                                EditCubit.get(context).changeEmail(editEmailController.text, context);
                              }
                            }
                            if(editNameController.text.isNotEmpty||editPhoneController.text.isNotEmpty){
                              EditCubit.get(context).check=true;
                              EditCubit.get(context).updateUser(name: editNameController.text.isEmpty?userModel.name:editNameController.text,phone: editPhoneController.text.isEmpty?userModel.phone:editPhoneController.text);
                            }else{
                              EditCubit.get(context).check=false;
                            }
                            EditCubit.get(context).getUser(userModel.id);
                          },
                          icon: const Icon(Icons.upload)
                      );
                        },
                      fallback: (context)=>const Center(child: CircularProgressIndicator(strokeWidth: 4,))
                  )
              ],
            ),
            body: Padding(
              padding:EdgeInsets.symmetric(horizontal: 15.w,vertical:10.h),
              child: SingleChildScrollView(
                child: Form(
                  key: editFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      if(!changePass)
                        SizedBox(
                          height: 20.h,
                        ),
                      if(!changePass)
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
                                backgroundImage: EditCubit.get(context).image == null ? userModel.image==''? const AssetImage('assets/user.jpg') : NetworkImage('${userModel.image}') as ImageProvider : FileImage(EditCubit.get(context).image!)
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: (){
                                      EditCubit.get(context).getImage();
                                    },
                                    child: const Text('Change profile picture'),
                                  ),
                                  if(userModel.image!=''&&EditCubit.get(context).image == null)
                                    TextButton(
                                      onPressed: (){
                                        EditCubit.get(context).check=true;
                                        EditCubit.get(context).removeProfileImage();
                                      },
                                      child:const Text('Remove profile picture',style: TextStyle(color: Colors.red))
                                    ),
                                  if(userModel.image==''&&EditCubit.get(context).image != null)
                                    TextButton(
                                        onPressed: (){
                                          EditCubit.get(context).removePickedImage();
                                        },
                                        child:const Text('Remove picked picture',style: TextStyle(color: Colors.red))
                                    ),
                                  if(userModel.image!=''&&EditCubit.get(context).image != null)
                                    TextButton(
                                        onPressed: (){
                                          EditCubit.get(context).removePickedImage();
                                        },
                                        child:const Text('Remove picked picture',style: TextStyle(color: Colors.red))
                                    )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      if(!changePass)
                        SizedBox(
                        height: 50.h,
                      ),
                      if(!changePass)
                        Row(
                          children: [
                            SizedBox(
                              width: 70.w,
                              child: Text(
                                'Name : ',
                                style:TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis
                                ) ,
                              ),
                            ),
                            Expanded(child: startTextField(
                                '${userModel.name}',
                                editNameController,
                              ),
                            )
                          ],
                        ),
                      if(!changePass)
                        SizedBox(height: 10.h,),
                      if(!changePass)
                        Row(
                          children: [
                            SizedBox(
                              width: 70.w,
                              child: Text(
                                'Email : ',
                                style:TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis
                                ) ,
                              ),
                            ),
                            Expanded(child: startTextField(
                                '${userModel.email}',editEmailController,
                                type: TextInputType.emailAddress,
                                validator: (String? value){
                                  if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value!)){
                                    return 'Please Enter a valid Email';
                                  }
                                  return null ;
                                }
                              )
                            )
                          ],
                        ),
                      if(!changePass)
                        SizedBox(height: 10.h,),
                      if(!changePass)
                        Row(
                          children: [
                            SizedBox(
                              width: 70.w,
                              child: Text(
                                'Phone : ',
                                style:TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis
                                ) ,
                              ),
                            ),
                            Expanded(child: startTextField(
                                '${userModel.phone}',
                                editPhoneController,
                                type: TextInputType.phone,
                              )
                            )
                          ],
                        ),
                      if(!changePass)
                        SizedBox(height: 10.h,),
                      if(!changePass)
                        TextButton(
                            onPressed: (){
                              EditCubit.get(context).changePassClick();
                            },
                            child: const Text('Change Password')),
                      if(changePass)
                        TextButton(
                            onPressed: (){
                              EditCubit.get(context).changePassClick();
                            },
                            child: const Text('Undo')),
                      if(changePass)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'New Password',
                            style:TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis
                            ) ,
                          ),
                        ),
                      if(changePass)
                        SizedBox(height: 5.h,),
                      if(changePass)
                        startTextField(
                            '',
                            editPasswordController,
                            hide:EditCubit.get(context).passwordHidden ,
                            suffixIcon: IconButton(onPressed: (){EditCubit.get(context).changePasswordVisibility();}, icon:EditCubit.get(context).passwordHidden?iconVisible:iconNotVisible),
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
                      if(changePass)
                        SizedBox(height: 10.h,),
                      if(changePass)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                          'Confirm your Password',
                          style:TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis
                          ) ,
                      ),
                        ),
                      if(changePass)
                        SizedBox(height: 5.h,),
                      if(changePass)
                        startTextField(
                            '',
                            editConfirmPasswordController,
                            hide:EditCubit.get(context).confirmPasswordHidden ,
                            suffixIcon: IconButton(
                                onPressed: (){
                                  EditCubit.get(context).changeConfirmPasswordVisibility();
                                  },
                                icon:EditCubit.get(context).confirmPasswordHidden?iconVisible:iconNotVisible),
                            validator: (String? value){
                              if(value!.isEmpty)
                              {
                                return 'This Can\'t be Empty';
                              }
                              if(editPasswordController.text!=editConfirmPasswordController.text){
                                return 'Password does not match';
                              }
                              return null ;
                            }
                        ),
                      if(changePass)
                        SizedBox(width: 10.h,),
                      if(changePass)
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: TextButton(
                              onPressed: (){
                                if(editFormKey.currentState!.validate()){
                                  changePass=!changePass;
                                  EditCubit.get(context).changePassword(editPasswordController.text, context);
                                }
                              },
                              child: const Text('Confirm')),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ) ,
          listener:(context,state){
            if(state is RemoveImageState||state is UploadPickedImageValidState){
              navigateAndFinish(context, const Layout());
            }
          } ,
    ) ,
    );
  }


}