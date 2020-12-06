// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Swipable<T> extends StatefulWidget {
  const Swipable({
    @required this.store,
    @required this.builder,
    List<Widget> targets,
  })  : assert(store != null),
        assert(builder != null),
        this.targets = targets ?? const [];

  final CycleStore<T> store;
  final Widget Function(T) builder;
  final List<Widget> targets;

  Widget at(int index) => builder(store.at(index));
  Widget next(int index) => builder(store.next(index));

  @override
  _SwipableState createState() => _SwipableState();
}

class _SwipableState extends State<Swipable> {
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
              Draggable(
                child: widget.at(_index),
                feedback: widget.at(_index),
                // IgnorePointer allows targets to accept the draggable even if
                // there's some widget.
                childWhenDragging: IgnorePointer(
                  child: widget.next(_index),
                ),
                onDragCompleted: () => setState(
                  () => _index = widget.store.nextIndex(_index),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// TODO: move `CycleStore` to separate file
class CycleStore<T> {
  const CycleStore(this.box);

  final Box<T> box;

  T at(int index) => index < box.length ? box.getAt(index) : box.getAt(0);
  T next(int index) => at(nextIndex(index));
  int nextIndex(int index) => index < box.length - 1 ? index + 1 : 0;
}

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
  Decoration _decoration;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: DragTarget(
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
