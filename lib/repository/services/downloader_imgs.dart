import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

StreamController streamDownload = StreamController<int>();

class Downloader {
  Future<void> downloadFile({String? url, String? name}) async {
    Dio dio = Dio();
    int pos = 0;
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(url ?? '', "${dir.path}/$name.jpg",
          onReceiveProgress: (rec, total) {
            if (rec == total) {
              streamDownload.sink.add(pos+1);
            }
          });
    } catch (e) {

    }
  }
}
