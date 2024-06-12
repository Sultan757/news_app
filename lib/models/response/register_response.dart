import 'package:showcase_app/preferences/user_preferences.dart';

class RegisterResponse {
  int? status;
  FinalUser? finalUser;
  String? token;
  String? message;

  RegisterResponse({this.status, this.finalUser, this.token, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    finalUser = json['finalUser'] != null
        ? new FinalUser.fromJson(json['finalUser'])
        : null;
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.finalUser != null) {
      data['finalUser'] = this.finalUser!.toJson();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

class FinalUser implements JsonSerializable{
  String? email;
  String? verified;
  int? visitCount;
  String? createdAt;
  String? sId;
  int? iV;

  FinalUser(
      {this.email,
        this.verified,
        this.visitCount,
        this.createdAt,
        this.sId,
        this.iV});

  FinalUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    verified = json['verified'];
    visitCount = json['visitCount'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['visitCount'] = this.visitCount;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
