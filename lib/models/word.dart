import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@HiveType(typeId: 0)
class Word {
  const Word({
    required this.word,
    required this.translation,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @HiveField(0)
  final String word;

  @HiveField(1)
  final String translation;

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
