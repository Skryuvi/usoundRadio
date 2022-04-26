import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:usoundradio/repository/models/currentsong/current_song.dart';
import 'package:usoundradio/repository/models/errors/fetching_errors.dart';
class ApiRadioService {
  ApiRadioService({
    http.Client? httpClient,
    this.baseUrl = 'https://radio2.zaycev.fm/',
  }): _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client _httpClient;
  Uri getUrl({required String url}){
    return Uri.parse('$baseUrl/$url');
  }
  Future<CurrentSong> getCurrentSong() async {
    final response = await _httpClient.get(getUrl(url: 'export/pop/now_.json'));
    if(response.statusCode==200){
      if(response.body.isNotEmpty){
        return CurrentSong.fromJson(json.decode(response.body));
      }else{
        throw ErrorEmptyResponse();
      }
    }else{
      throw ErrorFetching('error getting current song');
    }
  }
}