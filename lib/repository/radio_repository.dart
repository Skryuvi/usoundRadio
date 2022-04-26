
import 'package:usoundradio/repository/models/currentsong/current_song.dart';
import 'package:usoundradio/repository/services/api_service.dart';

class RadioRepository {
  const RadioRepository({
    required this.service
  });
  final ApiRadioService service;
  Future<CurrentSong> getCurrent() async => service.getCurrentSong();
}