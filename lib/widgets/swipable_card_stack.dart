// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/word_card.dart';

class SwipableCardStackWidget extends StatefulWidget {
  final List<WordCardData> _cardsData;

  SwipableCardStackWidget({@required cardsData}) : _cardsData = cardsData;

  @override
  _SwipableCardStackWidgetState createState() =>
      _SwipableCardStackWidgetState(cardsData: _cardsData);
}

class _SwipableCardStackWidgetState extends State<SwipableCardStackWidget> {
  final List<WordCardData> _cardsData;

  var _pos = 0;

  _SwipableCardStackWidgetState({@required cardsData}) : _cardsData = cardsData;

  int _getNextPos() => _pos >= _cardsData.length - 1 ? 0 : _pos + 1;

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
  Widget build(BuildContext context) => Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Draggable(
                  child: WordCardWidget(word: _cardsData[_pos]),
                  feedback: WordCardWidget(word: _cardsData[_pos]),
                  childWhenDragging:
                      WordCardWidget(word: _cardsData[_getNextPos()]),
                  onDragCompleted: () => setState(() => _pos = _getNextPos()),
                )
              ],
            ),
          ),
          _getTarget(Alignment.centerLeft),
          _getTarget(Alignment.centerRight),
        ],
      );
}
