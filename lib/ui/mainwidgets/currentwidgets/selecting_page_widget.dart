
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usoundradio/ui/mainwidgets/currentwidgets/bloc/current_song_bloc.dart';
import 'package:usoundradio/ui/mainwidgets/currentwidgets/selecting_page_success_widget.dart';

class SelectingPageWidget extends StatelessWidget{
  const SelectingPageWidget({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSongsBloc,CurrentSongState>(builder: (context, state) {
      return state.status.isSuccess ? SelectingPageSuccess() : state.status.isLoading ?
      Container(color: Colors.black,): Container(color: Colors.blue);
    },);
  }
}