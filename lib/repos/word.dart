// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:sqflite/sqflite.dart';

import 'package:laera/models/word.dart';
import 'package:laera/repos/sources/db.dart';

class WordRepo {
  Future<Database> _source;

  WordRepo(this._source);

  Future<List<Word>> getAll() async =>
      _source.then((repo) => repo.query(WordTable.NAME)).then((values) {
        var result = List<Word>(values.length);
        values.forEach((word) => result.add(Word.fromJson(word)));
        return result;
      });
}
