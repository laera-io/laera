// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Swipable extends StatefulWidget {
  const Swipable({
    @required this.children,
    this.targets = const [
      VerticalTarget(alignment: Alignment.centerLeft),
      VerticalTarget(alignment: Alignment.centerRight),
    ],
  });

  final List<Widget> children;
  final List<Widget> targets;

  @override
  _SwipableState createState() => _SwipableState();

  Widget at(int index) =>
      index < children.length ? children[index] : children[0];

  int getNextIndex(int index) => index < children.length - 1 ? index + 1 : 0;
}

class _SwipableState extends State<Swipable> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Draggable(
                child: widget.at(_currentIndex),
                feedback: widget.at(_currentIndex),
                childWhenDragging: widget.at(
                  widget.getNextIndex(_currentIndex),
                ),
                onDragCompleted: () => setState(
                  () => _currentIndex = widget.getNextIndex(_currentIndex),
                ),
              )
            ],
          ),
        ),
        ...?widget.targets,
      ],
    );
  }
}

class VerticalTarget extends StatelessWidget {
  const VerticalTarget({
    @required this.alignment,
    this.widthFactor = 0.2,
  });

  final Alignment alignment;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: DragTarget(
        builder: (context, candidateData, rejectedData) => FractionallySizedBox(
          widthFactor: widthFactor,
          child: Container(),
        ),
      ),
    );
  }
}
