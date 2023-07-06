

import 'package:graphql_flutter/graphql_flutter.dart';

class GQLSrings{
static String addNote = """
mutation insert_notes(\$title :String,\$body:String){                                                                                                                                                               
  insert_notes(objects:[{
    title:\$title,
    body:\$body
  }]){
    returning {
      
      title
      body
    }
  }
}
""";


static String updateNote="""

mutation update_notes(\$title:String,\$body:String,\$oldTitle:String){
 update_notes(
  where: {title: {_eq:\$oldTitle}},
    _set:{body:\$body, title:\$title})
  {
  returning {
    title
    body
  }
  }
}
     """;


static String deleteNote="""

mutation delete_notes(\$title:String){
delete_notes(where:{title:{_eq:\$title
}}){
returning{
  title
}
}
}

 """;
static String getNotes="""
{
  notes {
    body
    title
  }
}

  """;

  static String getSingleNote="""
query getSingleNote(\$title:String) {
  notes( where: {title: {_eq:\$title}}) {
    body
    title
  }
}

""";
}
