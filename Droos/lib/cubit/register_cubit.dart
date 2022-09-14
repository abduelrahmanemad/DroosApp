import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droos/models/user_model.dart';
import 'package:droos/shared/comp.dart';
import 'package:droos/shared/const.dart';
import 'package:droos/states/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  bool passwordHidden =true;
  bool confirmPasswordHidden =true;

  RegisterCubit():super(InitialState());
  static RegisterCubit get (context)=>BlocProvider.of(context);

  void changePasswordVisibility(){
    passwordHidden=!passwordHidden;
    emit(ChangePasswordVisibilityState());
  }
  void changeConfirmPasswordVisibility(){
    confirmPasswordHidden=!confirmPasswordHidden;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> registerWithEmailAndPassword(name,email,phone,password,) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
    then((value){
      createUser(name, value.user!.email, phone, value.user!.uid);
      id=value.user!.uid;
      emit(RegisterValidState());
    }).
    catchError((onError){
      print(onError.toString());
      emit(RegisterFailState());
    });
  }

  Future<void> createUser(name,email,phone,id,) async {
    emit(CreateUserLoadingState());
    userModel =UserModel(name, email, phone,id, 'Pending','');
    await FirebaseFirestore.instance.collection('users').doc(id).set(userModel.toMap()).
    then((value) {
      emit(CreateUserValidState());
    }).
    catchError((onError){
      print(onError.toString());
      emit(CreateUserFailState());
      showToast(onError.toString());
    });
  }
}