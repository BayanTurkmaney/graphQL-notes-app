import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../core/utils/gql_strings.dart';
import '../models/note.dart';
import '../server_config/configs.dart';


class NoteRepository {
  final client = ServerConfig.client;

  Future<Note> getSingleNote({String? title}) async {
    QueryResult queryResult = await client.mutate(
      // use mutate method for mutation
      MutationOptions(
        // we use mutation options
        fetchPolicy: FetchPolicy
            .networkOnly, // you can use different policy as per your need
        document: gql(
          GQLSrings.getSingleNote,
          // as tou graphql need query string
        ),
        variables: {
          'title': title, // this is have you pass value for varible
        },
        onCompleted: (x) {
          print('get single note completed ...');
        },
        onError: (error) {},
      ),
    );

    return Note.fromJson(queryResult.data!['notes'][0]);
  }

  Future<List<Note>> getNotes() async {
    QueryResult queryResult = await client.query(
      // here it's get type so using query method
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(
          GQLSrings.getNotes, // let's see query string
        ),
        onComplete: (x) {
          print('get notes completed ...');
          
        },
        onError: (error) {},
      ),
    );

    ;
    List<dynamic> jsonNotesList = queryResult.data?['notes'];
       
    return jsonNotesList
        .map((note) => Note.fromJson(note))
        .toList(); // here i am getting list in getUsers field which i am return
  }
 
  Future<void> addNotes(Note note) async {
   
    // ignore , just for cacheing
   await client.mutate(
      // use mutate method for mutation
      MutationOptions(
        // we use mutation options
        fetchPolicy: FetchPolicy
            .networkOnly, // you can use different policy as per your need
        document: gql(
          GQLSrings.addNote,
          // as tou graphql need query string
        ),
        variables: {
          'title': note.title, // this is have you pass value for varible
          'body': note.body
        },
        onCompleted: (x) {
          print('completetd add note ...');
        },
        onError: (error) {},
      ),
    );
  }

  Future<void> updateNotes({String? oldTitle, Note? note}) async {
    await client.mutate(
      // use mutate method for mutation
      MutationOptions(
        // we use mutation options
        fetchPolicy: FetchPolicy
            .networkOnly, // you can use different policy as per your need
        document: gql(
          GQLSrings.updateNote,
          // as tou graphql need query string
        ),
        variables: {
          "oldTitle": oldTitle,
          "title": note!.title,
          "body": note.body
        },
        onCompleted: (x) {
          print('update note completed ...');
        },
        onError: (error) {},
      ),
    );

  }

  Future<void> deleteNote({String? title}) async {
    // ignore , just for cacheing
     await client.mutate(
      // use mutate method for mutation
      MutationOptions(
        // we use mutation options
        fetchPolicy: FetchPolicy
            .networkOnly, // you can use different policy as per your need
        document: gql(
          GQLSrings.deleteNote,
          // as tou graphql need query string
        ),
        variables: {
          'title': title, // this is have you pass value for varible
        },
        onCompleted: (x) {
          print('delete note completed ...');
        },
        onError: (error) {},
      ),
    );

  }

 
}
