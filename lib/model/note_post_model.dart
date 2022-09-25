class PostNoteModel {
  PostNoteModel({
    this.noteTitle,
    this.noteContent,
  });

  String? noteTitle;
  String? noteContent;

  factory PostNoteModel.fromJson(Map<String, dynamic> json) => PostNoteModel(
        noteTitle: json["noteTitle"],
        noteContent: json["noteContent"],
      );

  Map<String, dynamic> toJson() => {
        "noteTitle": noteTitle,
        "noteContent": noteContent,
      };
}
