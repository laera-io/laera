// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';

class WordCard extends StatelessWidget {
  static const _textScale = 1.5;
  static const _widthFactor = 0.8;
  static const _heightFactor = 0.7;
  static const _spaceFactor = 0.1;

  final Word word;

  const WordCard({@required this.word});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * _widthFactor,
      height: MediaQuery.of(context).size.height * _heightFactor,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word.word,
              textScaleFactor: _textScale,
            ),
            const Flexible(
              child: FractionallySizedBox(
                heightFactor: _spaceFactor,
              ),
            ),
            Text(
              word.translation,
              textScaleFactor: _textScale,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
