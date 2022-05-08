import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:share/share.dart';

import '../../../repository/openers.dart';
import '../../colors_assets.dart';
import '../currentwidgets/selecting_page_success_widget.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<DrawerPage> createState() => _MyHomePageState();
}

final StreamController<List<String>> _currentUserStreamCtrl =
    StreamController<List<String>>.broadcast();

Stream<List<String>> get onCurrentUserChanged => _currentUserStreamCtrl.stream;

class _MyHomePageState extends State<DrawerPage> {
  List<FileSystemEntity> files = [];
  var adsLength = 7;
  var additionalContent = 0;
  var ad = 1;
  List<String> gete = [];
  FToast? fToast;
  var brightness = SchedulerBinding.instance!.window.platformBrightness;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [beginBackColor, endBackColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Stack(children: [
                  Positioned(
                    top: 24,
                    left: 24,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28,),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.135,
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      child: ListView.builder(
                        itemCount: files.length ,
                        itemBuilder: (context, index) {
                          var fileNames =
                              basename(files[index].path);
                          var artist = fileNames.split('---').first;

                          var subname = fileNames.split('---').last.substring(
                              0, fileNames.split('---').last.length - 4);

                          return GestureDetector(
                              onTap: () {
                                _showDialog(context, index);
                              },
                              child: Container(
                                  height: 80,
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  width: double.infinity,
                                  child: Stack(children: [
                                    Positioned.fill(
                                        left: 70,
                                        bottom: 10,
                                        right: 70,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(subname,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white)))),
                                    Positioned.fill(
                                        left: 70,
                                        top: 18,
                                        right: 70,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Opacity(
                                              opacity: 0.7,
                                              child: Text(
                                                artist,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white),
                                              ),
                                            ))),
                                    Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Image.file(File(
                                                        files[index]
                                                            .path)))))),
                                  ])));
                        },
                      ))
                ]))));
  }

  @override
  initState() {
    super.initState();
    isDarkMode = brightness == Brightness.dark;
    fileList.then((value) => updateFiles(value));
    fToast = FToast();
    fToast?.init(this.context);
  }

  _showDialog(BuildContext ctx, int index) {
    var fileNames = basename(files[index].path);
    var artist = fileNames.split('---').first;

    var subname = fileNames
        .split('---')
        .last
        .substring(0, fileNames.split('---').last.length - 4);

    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                    height: 500,
                    child: Stack(children: [
                      Positioned(
                          bottom: MediaQuery.of(ctx).size.height * 0.5 + 60,
                          right: 0,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: CupertinoButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Icon(Icons.close, size: 32, color: Colors.white,)))),
                      Positioned(
                          child: Center(
                              child: Container(
                                  height: 160,
                                  width: MediaQuery.of(ctx).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(24),),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Image.file(File(
                                                        files[index]
                                                            .path)))))),
                                    Positioned(
                                        top: 12,
                                        left: 92,
                                        right: 12,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(subname,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black)))),
                                    Positioned(
                                        top: 64,
                                        right: 12,
                                        left: 92,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(artist,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)))),
                                    Positioned(
                                        bottom: 0,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.52,
                                        child: CupertinoButton(
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      subname + ' ' + artist));
                                              Fluttertoast.showToast(
                                                  msg: "Название скопировано",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  fontSize: 14.0);
                                            },
                                            child: Icon(Icons.copy, size: 32, color: Colors.black,))),
                                    Positioned(
                                        bottom: 0,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.68,
                                        child: CupertinoButton(
                                            onPressed: () {
                                              var str = basename(
                                                  files[index]
                                                      .path);
                                              var nes = str.substring(
                                                  0, str.length - 4);
                                              allDownloads.remove(nes);
                                              File(files[index]
                                                      .path)
                                                  .delete();
                                              files.removeAt(
                                                 index);
                                              setState(() {});
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Icon(Icons.delete_forever_rounded, size: 32, color: Colors.black,))),
                                  ]))))
                    ]))),
          );
        });
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey[500],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Название песни скопировано",
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );

    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void updateFiles(List<FileSystemEntity> list) {
    files.clear();
    setState(() {
      for (int i = 0; i < list.length; i++) {
        if (list[i].path.endsWith('.jpg')) {
          var name = basename(list[i].path);
          var sub = name.substring(0, name.length - 4);
          files.add(list[i]);
          gete.add(sub);
        }
      }
      updateCurrentUserUI();
    });
    if (files.isNotEmpty && adsLength > 0 && files.length > adsLength) {
      additionalContent = (files.length / adsLength).round();
    }
  }

  Future<List<io.FileSystemEntity>> get fileList async {
    final path = (await getApplicationDocumentsDirectory()).path;
    List<io.FileSystemEntity> l;
    l = io.Directory(path).listSync();
    return l;
  }

  void updateCurrentUserUI() => _currentUserStreamCtrl.sink.add(allDownloads);
}
