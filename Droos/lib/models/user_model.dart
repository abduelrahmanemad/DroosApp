class UserModel {
  String? name;
  String? email;
  String? phone;
  String? id;
  String? status;
  String? image;

  UserModel(this.name,this.email,this.phone,this.id,this.status,this.image);

  UserModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    email=json['email'];
    phone=json['phone'];
    id=json['id'];
    status=json['status'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'id':id,
      'status':status,
      'image':image,
    };
  }

}