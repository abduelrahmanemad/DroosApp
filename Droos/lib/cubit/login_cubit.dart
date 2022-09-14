import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droos/models/user_model.dart';
import 'package:droos/shared/comp.dart';
import 'package:droos/states/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/const.dart';

class LoginCubit extends Cubit<LoginStates>{
  bool passwordHidden =true;

  LoginCubit():super(InitialState());
  static LoginCubit get (context)=>BlocProvider.of(context);

  void changeVisibility(){
    passwordHidden=!passwordHidden;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> loginWithEmailAndPassword(email,password) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value){
      id=value.user!.uid;
      getUser(value.user!.uid);
      emit(LoginValidState());
    }).
    catchError((onError){
      showToast(onError.toString());
      emit(LoginFailState());
    });
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

}