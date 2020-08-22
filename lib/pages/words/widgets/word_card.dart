// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/models/word.dart';

class WordCard extends StatelessWidget {
  static const _textScale = 1.5;
  static const _height = 70.0;

  final Word _word;
  final Future<int> Function(int id) _delete;

  final Function _rebuildParent;

  WordCard(this._word, this._delete, this._rebuildParent);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              _word.word,
              textScaleFactor: _textScale,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              _delete(_word.id);
              _rebuildParent();
            },
          ),
        ],
      );
}
