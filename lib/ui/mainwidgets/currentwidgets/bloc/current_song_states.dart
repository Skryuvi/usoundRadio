part of 'current_song_bloc.dart';

enum CurrentSongStates {loading, success, error, initial}
extension CurrentSongStatesX on CurrentSongStates {
  bool get isLoading => this == CurrentSongStates.loading;
  bool get isSuccess => this == CurrentSongStates.success;
  bool get isError => this == CurrentSongStates.error;
  bool get isInitial => this == CurrentSongStates.initial;
}
class CurrentSongState extends Equatable {
  const CurrentSongState({
      CurrentSong? song,
      this.status = CurrentSongStates.initial
  }) : song = song ?? CurrentSong.empty;
  final CurrentSong song;
  final CurrentSongStates status;
  @override
  List<Object?> get props => [status, song];

  CurrentSongState copyWith({
    CurrentSong? song,
    CurrentSongStates? status
    }){
      return CurrentSongState(
        song: song ?? this.song,
        status: status ?? this.status
      );
  }
}