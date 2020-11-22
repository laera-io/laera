// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Async extends StatelessWidget {
  const Async({
    @required this.future,
    @required this.builder,
    this.onProgress = const CircularProgressIndicator(),
    this.onError = _onError,
  });

  final Future future;
  final Widget Function(dynamic data) builder;
  final Widget onProgress;
  final Widget Function(Object error) onError;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return onError(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return builder(snapshot.data);
        }
        return onProgress;
      },
    );
  }

  static Widget _onError(Object error) => Center(child: Text(error.toString()));
}
