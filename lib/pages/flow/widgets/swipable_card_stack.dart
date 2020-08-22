// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/word_card.dart';

class SwipableCardStackWidget extends StatefulWidget {
  final List<Word> _words;

  SwipableCardStackWidget(this._words);

  @override
  _SwipableCardStackWidgetState createState() =>
      _SwipableCardStackWidgetState(_words);
}

class _SwipableCardStackWidgetState extends State<SwipableCardStackWidget> {
  final List<Word> _words;

  var _pos = 0;

  _SwipableCardStackWidgetState(this._words);

  int _getNextPos() => _pos >= _words.length - 1 ? 0 : _pos + 1;

  Word _get(int pos) => _words[pos];

  _getTarget(Alignment alignment) => Align(
        alignment: alignment,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) => Container(
            width: 90,
            height: double.infinity,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => _words.length > 0
      ? Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Draggable(
                    child: WordCardWidget(word: _get(_pos)),
                    feedback: WordCardWidget(word: _get(_pos)),
                    childWhenDragging:
                        WordCardWidget(word: _get(_getNextPos())),
                    onDragCompleted: () => setState(() => _pos = _getNextPos()),
                  )
                ],
              ),
            ),
            _getTarget(Alignment.centerLeft),
            _getTarget(Alignment.centerRight),
          ],
        )
      : Center(
          child: Text(
          "No words. Add some",
          textScaleFactor: 1.5,
        ));
}
