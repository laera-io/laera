// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/store.dart';

class Swipeable<T, W extends Widget> extends StatefulWidget {
  const Swipeable({
    @required this.store,
    @required this.builder,
    List<Widget> targets,
  })  : assert(store != null),
        assert(builder != null),
        targets = targets ?? const [];

  final Store<T> store;
  final W Function(T) builder;
  final List<Widget> targets;

  W at(int index) => builder(store.at(index));
  W next(int index) => builder(store.next(index));

  @override
  _SwipeableState<T, W> createState() => _SwipeableState();
}

class _SwipeableState<T, W extends Widget> extends State<Swipeable<T, W>> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...widget.targets,
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Draggable<W>(
                feedback: widget.at(_index),
                // IgnorePointer allows targets to accept the draggable even if
                // there's some widget.
                childWhenDragging: IgnorePointer(
                  child: widget.next(_index),
                ),
                onDragCompleted: () => setState(
                  () => _index = widget.store.nextIndex(_index),
                ),
                child: widget.at(_index),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class VerticalTarget<T> extends StatefulWidget {
  const VerticalTarget({
    @required this.alignment,
    @required this.decoration,
    this.widthFactor = 0.4,
  });

  final Alignment alignment;
  final Decoration decoration;
  final double widthFactor;

  @override
  _VerticalTargetState<T> createState() => _VerticalTargetState();
}

class _VerticalTargetState<T> extends State<VerticalTarget> {
  Decoration _decoration;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: DragTarget<T>(
        onWillAccept: (_) {
          setState(() => _decoration = widget.decoration);
          return true;
        },
        onAccept: (_) => setState(() => _decoration = null),
        onLeave: (_) => setState(() => _decoration = null),
        builder: (_, __, ___) => FractionallySizedBox(
          widthFactor: widget.widthFactor,
          child: Container(
            decoration: _decoration,
          ),
        ),
      ),
    );
  }
}
