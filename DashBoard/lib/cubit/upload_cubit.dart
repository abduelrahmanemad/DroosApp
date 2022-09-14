import 'dart:io';
import 'package:admin/models/lec_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase;
import 'package:admin/states/upload_states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadCubit extends Cubit<UploadStates>{
  UploadCubit():super(InitialState());
  static UploadCubit get (context)=>BlocProvider.of(context);

  PlatformFile? pickedFile ;
  String? pdfUrl;

  Future selectFile() async{
    emit(LoadingSelectState());
    await FilePicker.platform.pickFiles().
    then((value){
      if(value==null){
        return;
      }
      pickedFile=value.files.first;
      emit(ValidSelectState());
    }
    ).catchError((onError){
      emit(FailSelectState());
    });
  }
  Future uploadFile()async{
    emit(LoadingUploadState());
    final path ='malazem/${pickedFile!.name}';
    final file =File('${pickedFile!.path}');
    final ref = firebase.FirebaseStorage.instance.ref().child(path);
    ref.putFile(file).
    then((value){
      value.ref.getDownloadURL().then((value){
        pdfUrl=value;
        emit(ValidUploadState());
      });
    }).
    catchError((onError){emit(FailUploadState());});
  }
  void removeFile(){
    pickedFile=null;
    emit(ValidRemoveState());
    if(pdfUrl!=null){
      pdfUrl=null;
      emit(ValidRemoveState());
    }
  }
  Future<void> uploadLec(name,lecUrl,examUrl,malzamaUrl,) async {
    emit(LoadingUploadLecState());
    LecModel lecModel= LecModel(name, lecUrl, examUrl, malzamaUrl);
    await FirebaseFirestore.instance.collection('lectures').doc(name).set(lecModel.toMap()).
    then((value) {
      emit(ValidUploadLecState());
    }).
    catchError((onError){
      print(onError.toString());
      emit(FailUploadLecState());
    });
  }
}