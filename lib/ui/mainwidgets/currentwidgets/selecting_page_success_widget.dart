import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usoundradio/ui/customized/custom_text.dart';
import 'package:usoundradio/ui/mainwidgets/currentwidgets/manager.dart';
import 'dart:io' as io;
import '../../../repository/models/currentsong/model_latest.dart';
import '../../../repository/models/currentsong/model_now.dart';
import '../../../repository/openers.dart';
import '../../../repository/services/downloader_imgs.dart';
import '../../colors_assets.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../favorites/favorites_widget.dart';
import 'notification_util.dart';

List<String> allDownloads = [];

class SelectingPageSuccess extends StatefulWidget {
  const SelectingPageSuccess({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateSuccessSelectingPage();
}

FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

class _StateSuccessSelectingPage extends State<SelectingPageSuccess> {
  var listImages = [
    'assets/happy_frame.png',
    'assets/sad_frame.png',
    'assets/calm_frame.png',
    'assets/cheerful_frame.png'
  ];
  var listImagesGeneres = [
    'assets/rock_image.png',
    'assets/pop_image.png',
    'assets/rap_image.png',
    'assets/club_image.png',
    'assets/tik_tok_image.png'
  ];
  var listTitles = ['Радостное', 'Печальное', 'Спокойное', 'Бодрое'];
  late BorderRadiusTween borderRadius;
  List<LatestModel> listPrevious = [];
  final Duration _duration = Duration(milliseconds: 500);
  double percentage = 1.0;
  var isFave = ValueNotifier(false);

  Map<String, int>? favorites;
  var playing = NowPlaying();
  late Manager presenterManager;
  var titleCurentSong = '';
  final currentPlay = ValueNotifier<String>('');
  var newPercentage = 1.0;
  SharedPreferences? pref;
  late Dio dio;
  List<io.FileSystemEntity> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [beginBackColor, endBackColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 80,
              child:Stack(
                children: [
                  Positioned(
                      top: 32,
                      right: 24,
                      child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          PageTransition(type: PageTransitionType.fade, child: DrawerPage()))
                          .then((value) => setState(() {}));
                    },
                    child: Icon(Icons.star_border_rounded, size: 40, color: Colors.white,),
                  ))
                ],
              ),
            ),
            Positioned(
                top: 80,
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height * 0.11,
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    firstSliver(),
                    SliverToBoxAdapter(
                        child: Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Жанры',
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.white),
                            ))),
                    secondSliver()
                  ],
                )),
            Positioned(
                child: FutureBuilder(
                    future: getPrevious(),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        var answer = snapshots.data as LatestAnswer;
                        var second = answer.model;
                        List<LatestModel> datas = [];
                        second?.forEach((element) {
                          datas.add(element);
                        });
                        return StreamBuilder(
                          stream: _flutterRadioPlayer.isPlayingStream,
                          builder: (context, isPlayingStream) {
                            return StreamBuilder(
                                stream: _flutterRadioPlayer.metaDataStream,
                                builder: (context, snapStream) {
                                  if (playing.radio != null) {
                                    getNow().then((value) => upd(
                                        int.parse(value.radio!.now!.playTime!),
                                        value.radio!.now!.title));
                                  }
                                  return DraggableScrollableSheet(
                                    initialChildSize: 0.17,
                                    minChildSize: 0.17,
                                    maxChildSize: 0.3,
                                    builder: (BuildContext context,
                                        ScrollController scrollController) {
                                      return AnimatedBuilder(
                                          animation: scrollController,
                                          builder: (context, child) {
                                            if (scrollController.hasClients) {
                                              percentage = scrollController
                                                      .position
                                                      .viewportDimension /
                                                  (MediaQuery.of(context)
                                                      .size
                                                      .height);
                                              newPercentage = scrollController
                                                  .position.viewportDimension;
                                            }
                                            return Container(
                                                child: ListView.builder(
                                              itemCount: 1,
                                              itemBuilder: (context, index) {
                                                return ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(24),
                                                        topRight: Radius.circular(
                                                            24)),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                        24),
                                                                topRight:
                                                                    Radius.circular(
                                                                        24)),
                                                            color: Color.fromRGBO(
                                                                22, 22, 52, 1)),
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                percentage,
                                                        width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                        child: Stack(
                                                          children: [
                                                            Positioned.fill(
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.65,
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.17,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      btnElse(),
                                                                )),
                                                            Positioned.fill(
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.25,
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.17,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      btnShare(),
                                                                )),
                                                            Positioned.fill(
                                                                left: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.25,
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.17,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      copyBtn(),
                                                                )),
                                                            Positioned.fill(
                                                                left: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.65,
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.17,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child: btnLike(),
                                                                )),
                                                            Positioned.fill(
                                                                top: 16,
                                                                left: 16,
                                                                child: playPause(
                                                                    isPlayingStream)),
                                                            Positioned.fill(
                                                                top: 16,
                                                                left: 88,
                                                                right: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          datas.first.title ??
                                                                              '',
                                                                          style: GoogleFonts.roboto(
                                                                              color: Colors.white,
                                                                              fontSize: 16),
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              7,
                                                                        ),
                                                                        Opacity(
                                                                          child: Text(
                                                                              datas.first.artist ?? '',
                                                                              style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
                                                                          opacity:
                                                                              0.7,
                                                                        )
                                                                      ],
                                                                    )))
                                                          ],
                                                        )));
                                              },
                                              controller: scrollController,
                                              scrollDirection: Axis.vertical,
                                            ));
                                          });
                                    },
                                  );
                                });
                          },
                        );
                      } else {
                        return Container();
                      }

                    }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    presenterManager = Manager();
    dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    getPrevious()
        .then((value) {
      listPrevious = value.model ?? [];
      fileList.then((value) => updateFiles(value));
      _flutterRadioPlayer.isPlaying().then((value) => NotificationUtil.updateNotificationMediaPlayer(listPrevious.first.artist, listPrevious.first.info?.images?.large, listPrevious.first.title));
    } );

    _flutterRadioPlayer.metaDataStream?.listen((event) {
      updateInfoSongs();
    });
    streamDownload.stream.listen((event) {
      getPrevious().then((val) => fileList.then((value) => updateFiles(value)));
    });
    initRadio('');
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      if (receivedNotification.buttonKeyInput.isNotEmpty) {
        processInputTextReceived(receivedNotification);
      } else if (receivedNotification.buttonKeyPressed.startsWith('MEDIA_')) {
        processMediaControls(receivedNotification);
      } else {
        processDefaultActionReceived(receivedNotification);
      }
    });
    super.initState();
  }

  Future<void> updateInfoSongs() async {
    await  getPrevious().then((value) => listPrevious = value.model ?? []);
    currentPlay.value = listPrevious.first.title ?? '';

    _flutterRadioPlayer.isPlaying().then((value) => NotificationUtil.updateNotificationMediaPlayer(listPrevious.first.artist, listPrevious.first.info?.images?.large, listPrevious.first.title));
    await fileList.then((value) => updateFiles(value));
  }
  void updateFiles(List<io.FileSystemEntity> list) {
    files.clear();
    allDownloads.clear();
    setState(() {
      for (int i = 0; i < list.length; i++) {
        if (list[i].path.endsWith('.jpg')) {
          var name = basename(list[i].path);
          var sub = name.substring(0, name.length - 4);
          files.add(list[i]);
          allDownloads.add(sub);
          if(allDownloads.contains('${listPrevious.first.artist}---${listPrevious.first.title}')){
            isFave.value = true;
            presenterManager.setNotDownloaded();
          }else{
            isFave.value = false;
            presenterManager.setDownloaded();
          }
        }
      }
    });
  }

  Widget firstSliver() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        bottom: 25,
                        left: 30,
                        right: 30,
                        child: Image.asset(listImages[index]),
                      ),
                      Positioned(
                          bottom: 4,
                          right: 0,
                          left: 0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GradientText(
                              listTitles[index],
                              style: GoogleFonts.roboto(fontSize: 15),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.3)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                            ),
                          ))
                    ],
                  )),
              onTap: () {},
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
        ),
      ),
    );
  }

  Widget secondSliver() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listImagesGeneres.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(18, 18, 30, 1)),
                  child: Center(child: Image.asset(listImagesGeneres[index]))),
              onTap: () {},
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
        ),
      ),
    );
  }

  Widget playPause(AsyncSnapshot<Object?> isPlayingStream) {
    return Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
            onTap: () {
              if (isPlayingStream.data ==
                  FlutterRadioPlayer.flutter_radio_playing) {
                _flutterRadioPlayer.stop();
                initRadio('');
                presenterManager.setPaused();
              } else {
                _flutterRadioPlayer.play();
                presenterManager.setPlaying();
              }
              setState(() {});
            },
            child:
                isPlayingStream.data == FlutterRadioPlayer.flutter_radio_playing
                    ? Image.asset('assets/pause_btn.png',
                        color: Colors.white, height: 54, width: 54)
                    : Image.asset('assets/play_btn.png',
                        color: Colors.white, height: 54, width: 54)));
  }

  Widget copyBtn() {
    return CupertinoButton(
      onPressed: () {
        getFromPrefs()
            .then((value) => Clipboard.setData(ClipboardData(text: value)));
        Fluttertoast.showToast(
            msg: "Название скопировано",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      },
      child: Icon(Icons.copy_all_rounded,
          size: 28, color: Color.fromRGBO(234, 167, 206, 1)),
    );
  }


  Widget btnLike() {
    return ValueListenableBuilder(
      valueListenable: isFave,
      builder: (context, isfavor, child) {
        if(isfavor == false){
          return CupertinoButton(
              onPressed: (){
                Downloader().downloadFile(
                    url: listPrevious.first.info?.images?.large,
                    name:
                    '${listPrevious.first.artist}---${listPrevious.first.title}');
                isFave.value = true;
                presenterManager.setNotDownloaded();
              },
              child:Icon(Icons.favorite_outline_rounded, size: 28, color: Color.fromRGBO(234, 167, 206, 1),)
          );
        }else{
          return CupertinoButton(
              onPressed: () async {
                var path =  await  getApplicationDocumentsDirectory();
                var str = basename(File(path.path+'${listPrevious.first.artist}---${listPrevious.first.title}.jpg').path);
                var nes =
                str.substring(0, str.length - 4);
                allDownloads.remove(nes);
                File(path.path+'/${listPrevious.first.artist}---${listPrevious.first.title}.jpg').delete();
                files.remove(File(path.path+'${listPrevious.first.artist}---${listPrevious.first.title}.jpg'));
                isFave.value = false;
                presenterManager.setDownloaded();

                setState((){});
              },
              child:Icon(Icons.favorite_rounded, size: 28, color: Color.fromRGBO(234, 167, 206, 1))
          );
        }
      },
    );
  }

  Widget btnShare() {
    return CupertinoButton(
      onPressed: () {
        getFromPrefs()
            .then((value) => Share.share("Послушай $value на USOUND Radio!"));
      },
      child: Icon(Icons.share_outlined,
          size: 28, color: Color.fromRGBO(171, 193, 227, 1.0)),
    );
  }

  Widget btnElse() {
    return CupertinoButton(
      onPressed: () {
        _showDialog(this.context);
      },
      child: Icon(Icons.workspaces_outline,
          size: 28, color: Color.fromRGBO(196, 193, 227, 1.0)),
    );
  }

  Future<NowPlaying> getNow() async {
    try {
      var response =
          await dio.get('https://radio2.zaycev.fm/export/pop/now_.json');
      NowPlaying answer;
      answer = NowPlaying.fromJson(response.data);
      savetoShared(answer.radio?.now?.title ?? '');
      return answer;
    } catch (e) {
      return NowPlaying();
    }
  }

  void upd(int delay, String? title) {
    Future.delayed(Duration(seconds: delay), () {
      if (listPrevious.isNotEmpty) {
        listPrevious.clear();
        getPrevious().then((value) => listPrevious = value.model ?? []);
      }
    });
  }

  Future<LatestAnswer> getPrevious() async {
    try {
      var response = await dio.get(
          'https://api.zaycev.fm/api/v1/channels/pop/latest?page=1&limit=25');
      return LatestAnswer.fromJson(response.data);
    } catch (e) {
      print(e);
      return LatestAnswer();
    }
  }

  Future<String?> getFromPrefs() async {
    pref = await SharedPreferences.getInstance();
    return pref?.getString('title');
  }

  void savetoShared(String title) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('title', title);
  }

  Future<List<io.FileSystemEntity>> get fileList async {
    final path = (await getApplicationDocumentsDirectory()).path;
    List<io.FileSystemEntity> l;
    l = io.Directory(path).listSync();
    return l;
  }

  void _showDialog(BuildContext cxt) {
    var listSheet = [
      'Найти на YouTube.music',
      'Найти в интернете',
      'Скопировать название',
      'О нас'
    ];
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
              actions: List<Widget>.generate(
                  4,
                  (int index) => Container(
                      decoration: BoxDecoration(color: Colors.grey[700]),
                      child: CupertinoActionSheetAction(
                          child: Text(listSheet[index],
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if (index == 0) {
                              getFromPrefs().then((value) => Openers()
                                  .openIosYoutube(value
                                      ?.replaceAll(" ", "+")
                                      .replaceAll(".", "")));
                            } else if (index == 1) {
                              getFromPrefs().then((value) => Openers()
                                  .openIosBrowser(value
                                      ?.replaceAll(" ", "+")
                                      .replaceAll(".", "")));
                            } else if (index == 2) {
                              getFromPrefs().then((value) => Clipboard.setData(
                                  ClipboardData(text: value)));
                              Fluttertoast.showToast(
                                  msg: "Название скопировано",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 14.0);
                            } else if (index == 3) {
                              // Openers().openAddingInfo(this.context);
                            }
                          }))));

          return dialog;
        });
  }
  void processDefaultActionReceived(ReceivedAction receivedNotification) {
    Fluttertoast.showToast(msg: 'Action received');
  }
  void processInputTextReceived(ReceivedAction receivedNotification) {
    Fluttertoast.showToast(
        msg: 'Msg: ' + receivedNotification.buttonKeyInput,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }
  void processMediaControls(actionReceived) async {
    switch (actionReceived.buttonKeyPressed) {
      case 'MEDIA_LIKE':
          presenterManager.setNotDownloaded();
          Downloader().downloadFile(
              url: listPrevious.first.info?.images?.large,
              name:
              '${listPrevious.first.artist}---${listPrevious.first.title}');
          isFave.value = true;
          NotificationUtil.updateNotificationMediaPlayer(listPrevious.first.artist, listPrevious.first.info?.images?.large, listPrevious.first.title);
          print('LIKEEE');
        break;
      case 'MEDIA_UNLIKE':
        presenterManager.setDownloaded();
        var path =  await  getApplicationDocumentsDirectory();
        var str = basename(File(path.path+'${listPrevious.first.artist}---${listPrevious.first.title}.jpg').path);
        var nes =
        str.substring(0, str.length - 4);
        allDownloads.remove(nes);
        File(path.path+'/${listPrevious.first.artist}---${listPrevious.first.title}.jpg').delete();
        files.remove(File(path.path+'${listPrevious.first.artist}---${listPrevious.first.title}.jpg'));
        isFave.value = false;
        NotificationUtil.updateNotificationMediaPlayer(listPrevious.first.artist, listPrevious.first.info?.images?.large, listPrevious.first.title);
        print('UNLIKEEE');
        break;
      case 'MEDIA_PLAY':
        _flutterRadioPlayer.play();
        presenterManager.setPlaying();
        NotificationUtil.updateNotificationMediaPlayer(listPrevious.first.artist, listPrevious.first.info?.images?.large, listPrevious.first.title);
        break;
      case 'MEDIA_PAUSE':

        _flutterRadioPlayer.pause();
        presenterManager.setPaused();
        NotificationUtil.updateNotificationMediaPlayer(listPrevious.first.artist, listPrevious.first.info?.images?.large, listPrevious.first.title);
        break;

      default:
        break;
    }
  }

  void initRadio(String title) async {
    await _flutterRadioPlayer.init(
        "radio", "Live", "http://air.zaycev.fm:8016/pop-air-2", "false");
  }
}
enum MediaLifeCycle {
  Stopped,
  Paused,
  Playing,
}
