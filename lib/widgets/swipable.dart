// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Swipable extends StatefulWidget {
  const Swipable({
    @required children,
    List<Widget> targets = const [rejectTarget, acceptTarget],
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

// TODO: refactor colors
const acceptTarget = VerticalTarget(
  alignment: Alignment.centerRight,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFF5F5F5), // Colors.grey[100]
        Color(0xFFDCEDC8), // Colors.lightGreen[100]
      ],
    ),
  ),
);

const rejectTarget = VerticalTarget(
  alignment: Alignment.centerLeft,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFFF5F5F5), // Colors.grey[100]
        Color(0xFFFFCDD2), // Colors.red[100]
      ],
    ),
  ),
);

class VerticalTarget extends StatefulWidget {
  const VerticalTarget({
    @required this.alignment,
    @required this.decoration,
    this.widthFactor = 0.4,
  });

  final Alignment alignment;
  final Decoration decoration;
  final double widthFactor;

  @override
  _VerticalTargetState createState() => _VerticalTargetState();
}

class _VerticalTargetState extends State<VerticalTarget> {
  Decoration decoration;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
        decoration: decoration,
        child: DragTarget(
          onWillAccept: (data) {
            setState(() => decoration = widget.decoration);
            return true;
          },
          onAcceptWithDetails: (details) => setState(() => decoration = null),
          onLeave: (data) => setState(() => decoration = null),
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
