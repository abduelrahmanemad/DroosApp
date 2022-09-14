import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droos/models/lec_model.dart';
import 'package:droos/shared/const.dart';
import 'package:droos/states/app_states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase;


import '../models/user_model.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(InitialState());
  static AppCubit get (context)=>BlocProvider.of(context);

  void changeIndex (i){
    index=i;
    if(i==1){
      getUser(userModel.id);
    }
    if(i==0){
      getLectures();
    }
    emit(ChangeIndexState());
  }

  Future<void> getUser(id) async{
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(id).get().
    then((value){
      userModel=UserModel.fromJson(value.data());
      emit(GetUserValidState());
    }).
    catchError((onError){
      print(onError.toString());
      emit(GetUserFailState());
    });
  }
  List<LecModel>lectures=[];

  void getLectures(){
    FirebaseFirestore.instance.collection('lectures').snapshots().
    listen((event) {
      event.docs.forEach((element) {
        bool check = false;
        if(lectures.isEmpty){
          lectures.add(LecModel.fromJson(element.data()));
        }else{
          for(int i =0 ; i<lectures.length;i++){
            if(element.data()['name']==lectures[i].name){
              check=true;
              break;
            }else{
              check=false;
            }
          }
          if(!check){
            lectures.add(LecModel.fromJson(element.data()));
          }
        }
      });
      emit(GetLecValidState());
    });

    // FirebaseFirestore.instance.collection('lectures').get().
    // then((value){
    //   print(value.docs.length);
    //   value.docs.forEach((element) {
    //     bool check = false;
    //       if(lectures.isEmpty){
    //         lectures.add(LecModel.fromJson(element.data()));
    //       }else{
    //         for(int i =0 ; i<lectures.length;i++){
    //           if(element.data()['name']==lectures[i].name){
    //             check=true;
    //             break;
    //           }else{
    //             check=false;
    //           }
    //         }
    //         if(!check){
    //           lectures.add(LecModel.fromJson(element.data()));
    //         }
    //       }
    //   });
    //   emit(GetLecValidState());
    // }).
    // catchError((error){
    //
    // });
  }

}