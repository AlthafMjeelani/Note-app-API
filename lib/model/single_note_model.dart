class SingleNotesModel {
  SingleNotesModel({
    this.noteId,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
    this.noteContent,
  });

  String? noteId;
  String? noteTitle;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;
  String? noteContent;

  factory SingleNotesModel.fromJson(Map<String, dynamic> json) =>
      SingleNotesModel(
        noteId: json["noteID"],
        noteTitle: json["noteTitle"],
        noteContent: json["noteContent"],
        createDateTime: DateTime.parse(json["createDateTime"]),
        latestEditDateTime: json["latestEditDateTime"] != null
            ? DateTime.parse(json["latestEditDateTime"])
            : DateTime.parse(json["createDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "noteID": noteId,
        "noteTitle": noteTitle,
        "noteContent": noteContent,
        "createDateTime": createDateTime!.toIso8601String(),
        "latestEditDateTime": latestEditDateTime,
      };
}
