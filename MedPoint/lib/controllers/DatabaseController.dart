class Record {
  String name;
  String email;

  Record({this.name, this.email});

  factory Record.responseJson(final json) {
    return Record(
      email: json["email"],
      name: json["name"],
    );
  }
}
