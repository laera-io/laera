// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laera/widgets/async.dart';

typedef StoreBuilder<T> = Widget Function(CycleStore<T> store);

class Store<T> extends StatelessWidget {
  Store.myWords({
    @required StoreBuilder<T> builder,
    bool listenable = false,
  })  : name = "my_words",
        this.builder = listenable ? _listenable(builder) : builder;

  final String name;
  final StoreBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return Async(
      // TODO: Sometimes box must be closed.
      future: Hive.openBox<T>(name),
      builder: (Box<T> box) => builder(CycleStore(box)),
    );
  }

  static StoreBuilder<T> _listenable<T>(StoreBuilder<T> builder) =>
      (CycleStore<T> store) => ValueListenableBuilder(
            valueListenable: store._box.listenable(),
            builder: (_, __, ___) => builder(store),
          );
}

class CycleStore<T> {
  const CycleStore(this._box);

  final Box<T> _box;

  int get length => _box.length;

  T at(int index) => index < length ? _box.getAt(index) : _box.getAt(0);
  T next(int index) => at(nextIndex(index));
  int nextIndex(int index) => index < _box.length - 1 ? index + 1 : 0;

  add(T value) => _box.add(value);

  delete(int index) => _box.deleteAt(index);
}
