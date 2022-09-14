class LecModel{
  String? name;
  String? urlLec;
  String? urlExam;
  String? urlMalzama;
  LecModel(this.name,this.urlLec,this.urlExam,this.urlMalzama,);

  LecModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    urlLec=json['urlLec'];
    urlExam=json['urlExam'];
    urlMalzama=json['urlMalzama'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'urlLec':urlLec,
      'urlExam':urlExam,
      'urlMalzama':urlMalzama,
    };
  }
}