import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usoundradio/repository/models/currentsong/current_song.dart';
import 'package:usoundradio/repository/radio_repository.dart';
part 'current_song_events.dart';
part 'current_song_states.dart';
class CurrentSongsBloc extends Bloc<CurrentSongEvent, CurrentSongState>{
  CurrentSongsBloc({
    required this.radioRepository,

  }): super(const CurrentSongState()){
    on<GetCurrentSong>(_mapGetGamesEventToState);
  }
  final RadioRepository radioRepository;
  void _mapGetGamesEventToState(
      GetCurrentSong event, Emitter<CurrentSongState> emit) async {
    try {
      emit(state.copyWith(status: CurrentSongStates.loading));
      final song = await radioRepository.getCurrent();
      emit(
        state.copyWith(
          status: CurrentSongStates.success,
          song: song,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CurrentSongStates.error));
    }
  }
}