// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Emptiable extends StatelessWidget {
  final List data;
  final Widget Function(List) builder;
  final Widget onEmpty;

  const Emptiable({
    @required List data,
    @required this.builder,
    this.onEmpty = const NoData(),
  })  : assert(builder != null),
        this.data = data ?? const [];

  @override
  Widget build(BuildContext context) => data.isEmpty ? onEmpty : builder(data);
}

class NoData extends StatelessWidget {
  final String label;
  final double textScaleFactor;

  const NoData({
    this.label = "No words. Add some",
    this.textScaleFactor = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        textScaleFactor: textScaleFactor,
      ),
    );
  }
}
