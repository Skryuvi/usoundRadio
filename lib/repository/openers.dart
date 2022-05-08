import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Openers {

  void openIosBrowser(String? url){
    _launchURL(url ?? '');
  }
  void openIosYoutube(String? url){
    _launchMusicSearch(url ?? '');
  }
  void _launchMusicSearch(String url) async{
    try {
    await launch("https://music.youtube.com/search?q=$url");
    } catch (e) {
    throw 'Could not launch $url';
    }
  }

  _launchURL(String url) async {
    try {
      await launch("https://www.google.com/search?q=$url");
    } catch(e) {
      throw 'Could not launch $url';
    }
  }
  Future<void> _launchInWebViewOrVC(String url) async {
      try{
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: false,
        );
      }catch(e){
        print('$e');
      }
  }
}