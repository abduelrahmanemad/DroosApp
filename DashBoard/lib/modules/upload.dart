import 'package:admin/cubit/upload_cubit.dart';
import 'package:admin/shared/const.dart';
import 'package:admin/states/upload_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/comp.dart';

class Upload extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var urlLecController = TextEditingController();
    var nameLecController = TextEditingController();
    var urlExamController = TextEditingController();
    var uploadFormKey =GlobalKey<FormState>();
    return BlocProvider(
        create: (context)=>UploadCubit(),
        child: BlocConsumer<UploadCubit,UploadStates>(
            builder: (context,state){
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Upload Lecture',style: TextStyle(color: darkText),),
                  actions: [
                    IconButton(
                        onPressed: (){
                          UploadCubit.get(context).uploadLec(nameLecController.text, urlLecController.text??'', urlExamController.text??'', UploadCubit.get(context).pdfUrl??'');
                        },
                        icon: const Icon(Icons.upload)
                    )
                  ],
                ),
                body: Form(
                  key: uploadFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
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
                          Expanded(child: startTextField('', nameLecController,
                              validator:
                                  (String? value){
                                if(value!.isEmpty)
                                {
                                  return 'This Can\'t be Empty';
                                }
                                return null ;
                              }
                          ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              'URL : ',
                              style:TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis
                              ) ,
                            ),
                          ),
                          Expanded(child: startTextField('', urlLecController,),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              'Exam : ',
                              style:TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis
                              ) ,
                            ),
                          ),
                          Expanded(child: startTextField('', urlExamController,),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(UploadCubit.get(context).pickedFile==null)
                            OutlinedButton(
                              onPressed: (){
                                UploadCubit.get(context).selectFile();
                              },
                              child: const Text('Malzama')),
                          if(UploadCubit.get(context).pickedFile!=null)
                            OutlinedButton(
                                onPressed: (){
                                  UploadCubit.get(context).uploadFile();
                                },
                                child: const Text('Upload')),
                          SizedBox(width: 7.w,),
                          if(UploadCubit.get(context).pickedFile!=null)
                            IconButton(onPressed: (){UploadCubit.get(context).removeFile();}, icon: const Icon(Icons.remove_circle_outlined))
                        ],
                      )

                    ],
                  ),
                ),
              );
            },
            listener: (context,state){
              if(state is ValidUploadLecState ){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Uploaded')));
              }
            }
        ),

    );
  }

}