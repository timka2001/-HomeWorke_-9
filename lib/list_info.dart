class InfoList {
  String uuid;
  String name;
  String poster;

  InfoList({this.uuid = "", this.name = "", this.poster = ""});

  factory InfoList.fromJson(Map<String, dynamic> json) {
    return InfoList(
        uuid: json['uuid'], name: json['name'], poster: json['poster']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['poster'] = this.poster;

    return data;
  }
}
