class Licence {
  String? title;
  String? text;

  Licence({this.title, this.text});

  Licence.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['text'] = text;
    return data;
  }
}
