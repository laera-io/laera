// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    required this.word,
    this.widthFactor = 0.75,
    this.heightFactor = 0.75,
    this.aspectRatio = 0.75,
    this.textScale = 1.5,
    this.translateSpaceFactor = 0.1,
    super.key,
  });

  final Word word;

  final double widthFactor;
  final double heightFactor;
  final double aspectRatio;
  final double textScale;
  final double translateSpaceFactor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      child: Align(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  word.word,
                  textScaleFactor: textScale,
                ),
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: translateSpaceFactor,
                  ),
                ),
                Text(
                  word.translation,
                  textScaleFactor: textScale,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
