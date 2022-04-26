import 'package:json_annotation/json_annotation.dart';
import 'current_song_barrel.dart';

@JsonSerializable()
class Radio {
  Now? now;
  PathImages? images;
  Radio({this.now, this.images});
  factory Radio.fromJson(Map<String, dynamic> j){
    return Radio(now: Now.fromJson(j['now']), images: PathImages.fromJson(j['image']));
  }
}