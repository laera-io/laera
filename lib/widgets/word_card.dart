// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/models/word.dart';

class WordCardWidget extends StatelessWidget {
  static const _textScale = 1.5;
  static const _width = 350.0;
  static const _height = 500.0;
  static const _space = 20.0;

  final Word _word;

  const WordCardWidget({
    Key key,
    @required Word word,
  })  : _word = word,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _word.word,
              textScaleFactor: _textScale,
            ),
            SizedBox(
              height: _space,
            ),
            Text(
              _word.translation,
              textScaleFactor: _textScale,
            ),
          ],
        ),
      ),
    );
  }
}
