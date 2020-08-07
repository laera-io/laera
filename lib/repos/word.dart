// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:laera/models/word.dart';
import 'package:laera/repos/sources/db.dart';

class WordRepo extends DB {
  Future<List<Word>> getAll() async =>
      db.then((repo) => repo.query(WordTable.NAME)).then((values) {
        var result = List<Word>(values.length);
        values.forEach((word) => result.add(Word.fromJson(word)));
        return result;
      });
}
