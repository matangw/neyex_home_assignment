import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'source_model.g.dart';

@JsonSerializable (explicitToJson :  true )
class Source{
  String name;
  String id;

  Source({required this.name,required this.id});


  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);


  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  String toString() => json.encode(toJson());

}