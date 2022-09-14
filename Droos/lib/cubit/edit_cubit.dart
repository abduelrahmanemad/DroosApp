import 'dart:io';
import 'package:droos/modules/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droos/shared/comp.dart';
import 'package:droos/states/edit_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../shared/const.dart';

class EditCubit extends Cubit<EditProfileStates>{
  EditCubit():super(InitialState());
  static EditCubit get (context)=>BlocProvider.of(context);

  bool passwordHidden =true;
  bool confirmPasswordHidden =true;

  void changePasswordVisibility(){
    passwordHidden=!passwordHidden;
    emit(ChangePasswordVisibilityState());
  }

  void changeConfirmPasswordVisibility(){
    confirmPasswordHidden=!confirmPasswordHidden;
    emit(ChangePasswordVisibilityState());
  }

  void changePassClick(){
    changePass= !changePass;
    emit(ChangePassClickState());
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

  File? image;
  var imagePicker= ImagePicker();
  bool check = false;

  Future<void> getImage() async{
    final pickedFile=await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      image=File(pickedFile.path);
      emit(PickProfilePhotoValid());
    }else{
      emit(PickCoverPhotoFail());
    }
  }

  Future<void> uploadImage() async {
    await firebase.FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(image!.path).pathSegments.last}').
    putFile(image!).
    then((value){
      value.ref.getDownloadURL().
      then((value){
        updateUser(name: userModel.name, phone: userModel.phone,image: value).
        then((value){
          emit(UploadPickedImageValidState());
        });

      }).
      catchError((onError){
        print(onError.toString());
      });
    }).
    catchError((onError){
      print(onError.toString());
    }
    );

  }

  Future<void> updateUser(
      {
        required String? name,
        String? email,
        required String? phone,
        String? image,
      }
      )
  async {
    emit(UpdateUserLoadingState());
    UserModel model =UserModel(name, email??userModel.email, phone, userModel.id, userModel.status, image??userModel.image);
    FirebaseFirestore.instance.collection('users').doc(userModel.id).update(model.toMap()).
    then((value){
      emit(UpdateUserValidState());
    }).
    catchError((error){
      emit(UpdateUserFailState());
      showToast(error.toString());
    });
  }

  Future<void> changePassword(newPassword,context)async {
    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword).
    then((value){
      FirebaseAuth.instance.signOut();
      navigateTo(context, const Login());
      emit(ChangePasswordValidState());
    }).
    catchError((onError){
      emit(ChangePasswordFailState());
      print(onError.toString());
    });
  }

  Future<void> changeEmail(email,context,)async {
    await FirebaseAuth.instance.currentUser!.updateEmail(email).
    then((value){
      FirebaseAuth.instance.signOut();
      updateUser(name: userModel.name, phone: userModel.phone,email: email);
      navigateTo(context, const Login());
      emit(ChangeEmailValidState());
    }).
    catchError((onError){
      emit(ChangeEmailFailState());
      showToast(onError);
      print(onError.toString());
    });
  }

  void removeProfileImage(){
    userModel.image='';
    updateUser(name: userModel.name, phone: userModel.phone,image: '').then((value){
      emit(RemoveImageState());
    });

  }

  void removePickedImage(){
    image=null;
    emit(RemovePickedImageState());
  }

}