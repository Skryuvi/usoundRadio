import 'current_song_barrel.dart';
import 'current_song_radio.dart';

class CurrentSong {
  final Radio? radio;
  const CurrentSong({this.radio});
  factory CurrentSong.fromJson(Map<String, dynamic> j){
    return CurrentSong(radio: Radio.fromJson(j['radio']));
  }
  static const empty = CurrentSong();
}