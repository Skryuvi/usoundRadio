class Meta {
  String? url;
  String? title;

  Meta({this.url, this.title});
  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(title: json['title'], url:
    json['url']);
  }
}