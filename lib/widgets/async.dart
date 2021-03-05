// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Async<T> extends StatelessWidget {
  const Async({
    required this.future,
    required this.builder,
    this.onProgress = const CircularProgressIndicator(),
    this.onError = _onError,
  });

  final Future<T> future;
  final Widget Function(T data) builder;
  final Widget onProgress;
  final Widget Function(Object error) onError;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        // FIXME:
        // ════════════════════════════════════════════════════════════════════════════════
        // ...
        // #4      MultiDragGestureRecognizer._handleEvent
        // package:flutter/…/gestures/multidrag.dart:245
        // #3      MultiDragPointerState._up
        // package:flutter/…/gestures/multidrag.dart:144
        // #2      _DragAvatar.end
        // package:flutter/…/widgets/drag_target.dart:782
        // #1      _DragAvatar.finishDrag
        // package:flutter/…/widgets/drag_target.dart:864
        // #0      _DragTargetState.didDrop
        // package:flutter/…/widgets/drag_target.dart:702
        // When the exception was thrown, this was the stack

        // Null check operator used on a null value
        // The following _CastError was thrown while routing a pointer event:

        // ════════ Exception caught by gesture library ═══════════════════════════════════

        if (snapshot.error != null) {
          return onError(snapshot.error!);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return builder(snapshot.requireData);
        }
        return onProgress;
      },
    );
  }

  static Widget _onError(Object error) => Center(child: Text(error.toString()));
}
