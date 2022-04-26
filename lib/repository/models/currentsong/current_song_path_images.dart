import 'package:json_annotation/json_annotation.dart';
import 'current_song_barrel.dart';
import 'current_song_images.dart';

class PathImages {
  Images? images;
  PathImages({ this.images});
  factory PathImages.fromJson(Map<String, dynamic> j){
    return PathImages(images: Images.fromJson(j['webpath']));
  }
}