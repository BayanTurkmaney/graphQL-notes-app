part of 'note_cubit.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class LoadingState extends NoteState {}

class LoadSingleNote extends NoteState {
  final Note note;

  LoadSingleNote(this.note);
}

class LoadedNotesState extends NoteState {
  final List<Note> notes;

  LoadedNotesState(this.notes);
}

class MessageAddUpdateDelete extends NoteState {
  final String message;

  MessageAddUpdateDelete(this.message);
}
class FailureLoading extends NoteState{

}
