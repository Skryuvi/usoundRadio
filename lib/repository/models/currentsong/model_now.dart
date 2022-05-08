
class NowPlaying {
  Radio? radio;
  NowPlaying({this.radio});
  factory NowPlaying.fromJson(Map<String, dynamic> j){
    return NowPlaying(radio: Radio.fromJson(j['radio']));
  }
}
class Radio {
  Now? now;
  PathImages? images;
  Radio({this.now, this.images});
  factory Radio.fromJson(Map<String, dynamic> j){
    return Radio(now: Now.fromJson(j['now']), images: PathImages.fromJson(j['image']));
  }
}
class PathImages {
  Images? images;
  PathImages({ this.images});
  factory PathImages.fromJson(Map<String, dynamic> j){
    return PathImages(images: Images.fromJson(j['webpath']));
  }
}
class Now{
  String? playTime;
  String? artist;
  String? title;
  String? played;

  Now({this.playTime,this.played,this.artist, this.title});
  factory Now.fromJson(Map<String, dynamic> j){
    return Now(playTime: j['playtime'],
        title: j['title'], artist: j['artist'], played: j['played_at']);
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