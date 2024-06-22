class GetCommentsResponse {
  int? status;
  List<Comments>? comments;
  int? length;

  GetCommentsResponse({this.status, this.comments, this.length});

  GetCommentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['length'] = this.length;
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
