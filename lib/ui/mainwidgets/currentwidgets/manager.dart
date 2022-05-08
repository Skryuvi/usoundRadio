

import 'dart:async';

import 'package:usoundradio/ui/mainwidgets/currentwidgets/selecting_page_success_widget.dart';

class Manager {
  Manager();
  static final StreamController<String> _mediaBroadcaster =
  StreamController<String>.broadcast();
  static MediaLifeCycle _lifeCycle = MediaLifeCycle.Stopped;
  static Stream get mediaStream => _mediaBroadcaster.stream;

  static final StreamController<String> _favoritesBroadcaster =
      StreamController<String>.broadcast();
  static Favorites _favorites = Favorites.undefined;
  static Stream get favoriteStream => _favoritesBroadcaster.stream;

  void setDownloaded(){
    _favorites = Favorites.favorite;
  }
  void setNotDownloaded(){
    _favorites = Favorites.notFavorite;
  }
  void setPaused(){
    _lifeCycle = MediaLifeCycle.Paused;
  }
  void setPlaying(){
    _lifeCycle = MediaLifeCycle.Playing;
  }
  static bool get isPlaying {
    return _lifeCycle == MediaLifeCycle.Playing;
  }
  static bool get isFavorite {
    return _favorites == Favorites.favorite;
  }
}
enum Favorites {favorite, notFavorite, undefined}