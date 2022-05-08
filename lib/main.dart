import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usoundradio/ui/appblock/app_bloc_observer.dart';
import 'package:usoundradio/ui/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize('resource://drawable/ic_logo',
    [
      NotificationChannel(
          channelGroupKey: 'media_player_tests',
          icon: 'resource://drawable/ic_logo',
          channelKey: 'media_player_tests',
          channelName: 'Media player controller',
          channelDescription: 'Media player controller',
          defaultPrivacy: NotificationPrivacy.Public,
          enableVibration: false,
          enableLights: false,
          playSound: false,
          locked: true),

    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'media_player_tests',
          channelGroupName: 'Media Player tests')
    ]
  );

  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


