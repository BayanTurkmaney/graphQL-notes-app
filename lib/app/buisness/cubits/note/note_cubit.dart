import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/utils/messages_strings.dart';

import '../../../data/models/note.dart';
import '../../../data/repos/note_repo.dart';


part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository repository;
  NoteCubit(this.repository) : super(NoteInitial());

  Future<void> getAllNotes() async {
    try {
      print('ppppppppppppppppppppppppppppppppppppppppppppppppp');
      emit(LoadingState());
      List<Note> notes = await repository.getNotes();
      emit(LoadedNotesState(notes));
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getSingleNote() async {
    try {
      emit(LoadingState());
      Note note = await repository.getSingleNote();
      emit(LoadSingleNote(note));
    } catch (e) {
      throw (e);
    }
  }

  Future<void> deleteNote(String title) async {
    try {
      emit(LoadingState());
      await repository.deleteNote(title: title);
      emit(MessageAddUpdateDelete(Message.deleteMessage));
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addNote(Note note) async {
    try {
      emit(LoadingState());
      await repository.addNotes(note);
      emit(MessageAddUpdateDelete(Message.addMessage));
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateNote(String title, Note note) async {
    try {
      emit(LoadingState());
      await repository.updateNotes(note: note, oldTitle: title);
      emit(MessageAddUpdateDelete(Message.updateMessage));
    } catch (e) {
      throw (e);
    }
  }
}
