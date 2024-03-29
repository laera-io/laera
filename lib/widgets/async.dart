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
