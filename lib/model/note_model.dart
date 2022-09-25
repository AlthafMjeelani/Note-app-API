class NotesModel {
  NotesModel({
    this.noteId,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
  });

  String? noteId;
  String? noteTitle;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        noteId: json["noteID"],
        noteTitle: json["noteTitle"],
        createDateTime: DateTime.parse(json["createDateTime"]),
        latestEditDateTime: json["latestEditDateTime"] != null
            ? DateTime.parse(json["latestEditDateTime"])
            : DateTime.parse(json["createDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "noteID": noteId,
        "noteTitle": noteTitle,
        "createDateTime": createDateTime!.toIso8601String(),
        "latestEditDateTime": latestEditDateTime,
      };
}
