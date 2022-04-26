import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usoundradio/repository/radio_repository.dart';
import 'package:usoundradio/repository/services/api_service.dart';
import 'package:usoundradio/ui/colors_assets.dart';
import 'package:usoundradio/ui/mainwidgets/currentwidgets/selecting_page_widget.dart';
import 'mainwidgets/currentwidgets/bloc/current_song_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => RadioRepository(service: ApiRadioService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => 
                    CurrentSongsBloc(
                        radioRepository:
                        context.read<RadioRepository>())..add(GetCurrentSong()))
          ], child: HomeLayout(),
          
        ),
      )
    );
  }
}
class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SelectingPageWidget());
  }
}
