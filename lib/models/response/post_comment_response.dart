import 'get_news_response.dart';

class postCommentResponse {
  String? sId;
  String? title;
  String? heading;
  String? description;
  List<Image>? image;
  List<Video>? video;
  String? createdAt;
  int? iV;
  List<Comments>? comments;

  postCommentResponse(
      {this.sId,
        this.title,
        this.heading,
        this.description,
        this.image,
        this.video,
        this.createdAt,
        this.iV,
        this.comments});

  postCommentResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    iV = json['__v'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['heading'] = this.heading;
    data['description'] = this.description;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? url;
  String? id;
  String? sId;

  Image({this.url, this.id, this.sId});

  Image.fromJson(Map<String, dynamic> json) {
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

class Comments {
  String? author;
  String? content;
  String? createdAt;
  String? sId;

  Comments({this.author, this.content, this.createdAt, this.sId});

  Comments.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    createdAt = json['createdAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    return data;
  }
}
