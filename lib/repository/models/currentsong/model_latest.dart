class LatestModel {
  String? artist;
  String? title;
  String? played;
  int? stationId;
  InfoTrack? info;
  LatestModel({this.title, this.artist, this.info, this.played,this.stationId});
  factory LatestModel.fromJson(Map<String, dynamic> json){
    var infoTrack = InfoTrack.fromJson(json['InfoTrack']);
    return LatestModel(title: json['title'], artist: json['artist'], played: json['played'], stationId: json['station_id'], info: infoTrack);
  }
}
class LatestAnswer {
  List<LatestModel>? model;
  LatestAnswer({this.model});
  factory LatestAnswer.fromJson(Map<String, dynamic> json){
    var list = json['latest'] as List;
    List<LatestModel>latestModel = list.map((e) => LatestModel.fromJson(e)).toList();
    return LatestAnswer(model: latestModel);
  }
}
class InfoTrack {
  Images? images;
  InfoTrack({this.images});
  factory InfoTrack.fromJson(Map<String, dynamic> json){
    var ims = Images.fromJson(json['images']);
    return InfoTrack(images: ims);
  }
}
class Images {
  String? small;
  String? medium;
  String? large;
  String? extralarge;
  String? mega;
  String? original;
  String? blurred;
  Images({this.blurred, this.extralarge,this.large,this.medium,this.mega,this.original,this.small});
  factory Images.fromJson(Map<String, dynamic> json){
    return Images(small: json['small'], medium: json['medium'], large: json['large'], extralarge: json['extralarge'],
    mega: json['mega'], original: json['original'], blurred: json['blurred']);
  }
}