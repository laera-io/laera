// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

// flutter pub run build_runner build
part 'word.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Word {
  final int id;
  final String word, translation;

  const Word(this.word, this.translation, {this.id});

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
