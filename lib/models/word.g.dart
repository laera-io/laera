// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
    word: json['word'] as String,
    translation: json['translation'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'translation': instance.translation,
    };
