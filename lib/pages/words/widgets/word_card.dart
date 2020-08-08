// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/models/word.dart';

class WordCard extends StatelessWidget {
  final Word _word;
  final Future<int> Function(int id) _delete;

  WordCard(this._word, this._delete);

  @override
  Widget build(BuildContext context) => LimitedBox(
        maxHeight: 80,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                child: Center(
                  child: Text(
                    _word.word,
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => _delete(_word.id),
              ),
            ],
          ),
        ),
      );
}
