// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Emptiable<T, I extends Iterable<T>> extends StatelessWidget {
  const Emptiable({
    required this.values,
    required this.builder,
    this.onEmpty = const NoData(),
  });

  final I values;
  final Widget Function(I) builder;
  final Widget onEmpty;

  @override
  Widget build(BuildContext context) => isEmpty ? onEmpty : builder(values);

  bool get isEmpty => values.length == 0;
}

class NoData extends StatelessWidget {
  const NoData({
    this.label = 'Nothing here 🥺',
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
