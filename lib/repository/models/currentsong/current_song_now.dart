
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