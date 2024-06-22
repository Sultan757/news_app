import 'dart:ui';

class GetNewsResponse {
  List<Data> data;
  int status;
  int length;

  GetNewsResponse({required this.data, required this.status, required this.length});

  factory GetNewsResponse.fromJson(Map<String, dynamic> json) {
    return GetNewsResponse(
      data: List<Data>.from(json['data'].map((item) => Data.fromJson(item))),
      status: json['status'],
      length: json['length'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
      'status': status,
      'length': length,
    };
  }
}

class Data {
  String id;
  String title;
  String heading;
  String description;
  List<Photo> image;
  List<Video> myvideo;
  String createdAt;
  int v;

  Data({
    required this.id,
    required this.title,
    required this.heading,
    required this.description,
    required this.image,
    required this.myvideo,
    required this.createdAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      title: json['title'],
      heading: json['heading'],
      description: json['description'],
      image: List<Photo>.from(json['image'].map((item) => Photo.fromJson(item))),
      myvideo: List<Video>.from(json['video'].map((item) => Video.fromJson(item))),
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'heading': heading,
      'description': description,
      'image': List<dynamic>.from(image.map((item) => item.toJson())),
      'video': List<dynamic>.from(myvideo.map((item) => item.toJson())),
      'createdAt': createdAt,
      '__v': v,
    };
  }
}

class Photo {
  String url;
  String id;
  String imageId;

  Photo({required this.url, required this.id, required this.imageId});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      url: json['url'],
      id: json['id'],
      imageId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'id': id,
      '_id': imageId,
    };
  }
}

class Video {
  String url;
  String id;
  String videoId;

  Video({required this.url, required this.id, required this.videoId});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: json['url'],
      id: json['id'],
      videoId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'id': id,
      '_id': videoId,
    };
  }
}
