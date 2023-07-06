class Note{
  final String? title;
  final String? body;

  Note(this.title, this.body);

  factory Note.fromJson(Map<String, dynamic> json){
    return Note(json['title'], json['body']);
  }

  Map<String, dynamic> toJson(){
    return{
      'title':title,
      'body':body
    };
  }
}