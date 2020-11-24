// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Swipable extends StatefulWidget {
  const Swipable({
    @required children,
    targets = const [
      VerticalTarget(
        alignment: Alignment.centerLeft,
        // TODO: refactor colors
        color: Color(0x99DCFFC8),
      ),
      VerticalTarget(
        alignment: Alignment.centerRight,
        color: Color(0x88FFDDDD),
      ),
    ],
  })  : this.children = children ?? const [],
        this.targets = targets ?? const [];

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
        // TODO: make target areas fully allowed
        ...widget.targets,
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
      ],
    );
  }
}

class VerticalTarget extends StatefulWidget {
  const VerticalTarget({
    @required this.alignment,
    @required this.color,
    this.widthFactor = 0.3,
  });

  final Alignment alignment;
  final Color color;
  final double widthFactor;

  @override
  _VerticalTargetState createState() => _VerticalTargetState();
}

class _VerticalTargetState extends State<VerticalTarget> {
  var color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: ColoredBox(
        color: color,
        child: DragTarget(
          onWillAccept: (data) {
            setState(() => color = widget.color);
            return true;
          },
          onAcceptWithDetails: (details) {
            setState(() => color = Colors.transparent);
          },
          onLeave: (data) {
            setState(() => color = Colors.transparent);
          },
          builder: (context, candidateData, rejectedData) =>
              FractionallySizedBox(
            widthFactor: widget.widthFactor,
            child: Container(),
          ),
        ),
      ),
    );
  }
}
