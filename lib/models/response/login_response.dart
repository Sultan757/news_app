import 'package:showcase_app/preferences/user_preferences.dart';

class LoginResponse {
  int? status;
  LoginData? data;
  String? token;
  String? message;

  LoginResponse({this.status, this.data, this.token, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

class LoginData implements JsonSerializable{
  String? sId;
  String? email;
  String? verified;
  int? visitCount;
  String? createdAt;
  int? iV;

  LoginData(
      {this.sId,
        this.email,
        this.verified,
        this.visitCount,
        this.createdAt,
        this.iV});

  LoginData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    verified = json['verified'];
    visitCount = json['visitCount'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['visitCount'] = this.visitCount;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
