// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Emptiable extends StatelessWidget {
  const Emptiable({
    @required List data,
    @required this.builder,
    this.onEmpty = const NoData(),
  })  : assert(builder != null),
        this.data = data ?? const [];

  final List data;
  final Widget Function(List) builder;
  final Widget onEmpty;

  @override
  Widget build(BuildContext context) => data.isEmpty ? onEmpty : builder(data);
}

class NoData extends StatelessWidget {
  const NoData({
    this.label = "Nothing here 🥺",
    this.textScaleFactor = 1.5,
  });

  final String label;
  final double textScaleFactor;

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
