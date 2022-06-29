// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class VerticalSwipeableTarget<T extends Widget> extends StatelessWidget {
  const VerticalSwipeableTarget({
    required this.child,
    required this.alignment,
    required this.onAccept,
    this.widthFactor = 0.4,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Alignment alignment;
  final void Function<T>(T data) onAccept;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: SwipeableTarget<T>(
          onAccept: onAccept,
          child: child,
        ),
      ),
    );
  }
}

class SwipeableTarget<T extends Widget> extends StatefulWidget {
  const SwipeableTarget({
    required this.child,
    required this.onAccept,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final void Function<T>(T data) onAccept;

  @override
  State<SwipeableTarget> createState() => _SwipeableTargetState();
}

class _SwipeableTargetState<T extends Widget> extends State<SwipeableTarget> {
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<T>(
      onWillAccept: (_) {
        setState(() => _visibility = true);
        return true;
      },
      onAccept: (T data) => setState(() {
        _visibility = false;
        widget.onAccept(data);
      }),
      onLeave: (_) => setState(() => _visibility = false),
      builder: (_, __, ___) => Visibility(
        visible: _visibility,
        maintainSize: true,
        maintainState: true,
        maintainAnimation: true,
        child: widget.child,
      ),
    );
  }
}
