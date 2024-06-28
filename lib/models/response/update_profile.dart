class UpdateProfileResponse {
  int? status;
  LoginData? data;
  String? message;

  UpdateProfileResponse({this.status, this.data, this.message});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class LoginData {
  String? sId;
  String? email;
  String? verified;
  int? visitCount;
  String? createdAt;
  int? iV;
  List<ProfilePicture>? profilePicture;

  LoginData(
      {this.sId,
        this.email,
        this.verified,
        this.visitCount,
        this.createdAt,
        this.iV,
        this.profilePicture});

  LoginData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    verified = json['verified'];
    visitCount = json['visitCount'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    if (json['profilePicture'] != null) {
      profilePicture = <ProfilePicture>[];
      json['profilePicture'].forEach((v) {
        profilePicture!.add(new ProfilePicture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['visitCount'] = this.visitCount;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    if (this.profilePicture != null) {
      data['profilePicture'] =
          this.profilePicture!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfilePicture {
  String? url;
  String? id;
  String? sId;

  ProfilePicture({this.url, this.id, this.sId});

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['id'] = this.id;
    data['_id'] = this.sId;
    return data;
  }
}
