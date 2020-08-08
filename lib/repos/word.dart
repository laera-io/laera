// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'package:laera/models/word.dart';
import 'package:laera/repos/sources/db.dart';

class WordRepo {
  Future<Database> _source;

  WordRepo(this._source);

  Future<List<Word>> getAll() =>
      _source.then((db) => db.query(WordTable.NAME)).then(
        (words) {
          var result = List<Word>();
          words.forEach(
            (word) {
              var wordMap = jsonDecode(word[WordTable.COLUMN_DATA]);
              wordMap[WordTable.COLUMN_ID] = word[WordTable.COLUMN_ID];
              result.add(Word.fromJson(wordMap));
            },
          );
          return result;
        },
      );

  Future<void> add(Word word) => _source.then(
        (db) => db.execute(
          "INSERT INTO ${WordTable.NAME} (${WordTable.COLUMN_DATA}) VALUES ("
          "'{\"word\": \"${word.word}\", \"translation\": \"${word.translation}\"}'"
          ")",
        ),
      );

  Future<int> delete(int id) => _source.then(
        (db) => db.delete(
          WordTable.NAME,
          where: "${WordTable.COLUMN_ID} = ?",
          whereArgs: [id],
        ),
      );
}
