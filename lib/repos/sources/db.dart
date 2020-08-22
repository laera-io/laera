// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> _db;

  static Future<Database> get db => _db = _db ?? _init();

  static Future<Database> _init() => getDatabasesPath().then(
        (path) => openDatabase(
          join(path, 'laera.db'),
          version: 1,
          onCreate: (db, version) {
            return db.execute(
              'CREATE TABLE ${WordTable.NAME} '
              '(${WordTable.COLUMN_ID} INTEGER PRIMARY KEY, '
              '${WordTable.COLUMN_DATA} TEXT)',
            );
          },
        ),
      );
}

class WordTable {
  WordTable._();

  static const NAME = 'word';

  static const COLUMN_ID = 'id';
  static const COLUMN_DATA = 'data';
}
