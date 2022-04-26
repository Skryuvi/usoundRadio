
import 'package:json_annotation/json_annotation.dart';

class Images {
  String? small;
  String? medium;
  String? large;
  String? extralarge;
  String? mega;
  String? original;
  String? blurred;
  Images({this.blurred, this.extralarge,this.large,this.medium,this.mega,this.original,this.small});
  factory Images.fromJson(Map<String, dynamic> json){
    return Images(small: json['small'], medium: json['medium'], large: json['large'], extralarge: json['extralarge'],
        mega: json['mega'], original: json['original'], blurred: json['blurred']);
  }
}