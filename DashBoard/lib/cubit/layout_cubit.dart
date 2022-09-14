import 'package:admin/models/user_model.dart';
import 'package:admin/shared/const.dart';
import 'package:admin/states/layout_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(InitialState());
  static LayoutCubit get (context)=>BlocProvider.of(context);

  void changeIndex(i){
    index=i;
    emit(ChangeIndexState());
    getUsers();
  }


  List<UserModel>usersPending=[];
  List<UserModel>usersVerified=[];
  List<UserModel>usersUnverified=[];


  void getUsers(){

    FirebaseFirestore.instance.collection('users').get().
    then((value){
      print(value.docs.length);
      value.docs.forEach((element) {
        bool check = false;
        if (element.data()['status'] == 'Pending') {
          if(usersPending.isEmpty){
            usersPending.add(UserModel.fromJson(element.data()));
          }else{
            for(int i =0 ; i<usersPending.length;i++){
              if(element.data()['id']==usersPending[i].id){
                check=true;
                break;
              }else{
                check=false;
              }
            }
            if(!check){
              usersPending.add(UserModel.fromJson(element.data()));
            }
          }
        }
        if (element.data()['status'] == 'Verified') {
          if(usersVerified.isEmpty){
            usersVerified.add(UserModel.fromJson(element.data()));
          }else{
            for(int i =0 ; i<usersVerified.length;i++){
              if(element.data()['id']==usersVerified[i].id){
                check=true;
                break;
              }else{
                check=false;
              }
            }
            if(!check){
              usersVerified.add(UserModel.fromJson(element.data()));
            }
          }
        }
        if (element.data()['status'] == 'Unverified') {
          if(usersUnverified.isEmpty){
            usersUnverified.add(UserModel.fromJson(element.data()));
          }else{
            for(int i =0 ; i<usersUnverified.length;i++){
              if(element.data()['id']==usersUnverified[i].id){
                check=true;
                break;
              }else{
                check=false;
              }
            }
            if(!check){
              usersUnverified.add(UserModel.fromJson(element.data()));
            }
          }
        }
      });
    }).
    catchError((error){

    });
  }

  Future<void> updateUser(
      {
        required name,
        required status,
        required email,
        required phone,
        required id,
        required image,
      }
      )
  async {
    emit(UpdateUserLoadingState());
    UserModel model =UserModel(name, email, phone, id, status, image);
    FirebaseFirestore.instance.collection('users').doc(id).update(model.toMap()).
    then((value){
      emit(UpdateUserValidState());
      getUsers();
    }).
    catchError((error){
      emit(UpdateUserFailState());
    });
  }

}