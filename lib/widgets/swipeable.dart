// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/store.dart';

class Swipeable<T, W extends Widget> extends StatefulWidget {
  const Swipeable({
    required this.store,
    required this.builder,
    required this.targets,
  });

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
          child: Draggable<W>(
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
            data: widget.at(_index),
          ),
        ),
      ],
    );
  }
}
