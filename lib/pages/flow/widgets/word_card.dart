// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';

class WordCard extends StatelessWidget {
  const WordCard({@required this.word});

  final Word word;

  static const textScale = 1.5;
  static const widthFactor = 0.8;
  static const heightFactor = 0.7;
  static const spaceFactor = 0.1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word.word,
              textScaleFactor: textScale,
            ),
            const Flexible(
              child: FractionallySizedBox(
                heightFactor: spaceFactor,
              ),
            ),
            Text(
              word.translation,
              textScaleFactor: textScale,
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ],
        ),
      ),
    );
  }
}
