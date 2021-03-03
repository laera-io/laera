// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:laera/models/word.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/widgets/emptiable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

typedef StoreBuilderFunc<T> = Widget Function(Store<T> store);

class StoreBuilder<T> extends StatelessWidget {
  StoreBuilder._(
    this._storeFuture,
    StoreBuilderFunc<T> builder,
    bool emptiable,
    bool listenable,
  )   : assert(_storeFuture != null),
        assert(builder != null),
        builder = _listenable(_emptiable(builder, emptiable), listenable);

  // Dart does not currently support concretization of the generic constructors.
  // ignore: prefer_constructors_over_static_methods
  static StoreBuilder<Word> flow({
    @required StoreBuilderFunc<Word> builder,
    bool emptiable = false,
    bool listenable = false,
  }) {
    return StoreBuilder._(
      Store.openFlow(),
      builder,
      emptiable,
      listenable,
    );
  }

  final StoreBuilderFunc<T> builder;
  final Future<Store<T>> _storeFuture;

  @override
  Widget build(BuildContext context) {
    return Async(
      // TODO: Sometimes store must be closed manually.
      future: _storeFuture,
      builder: (Store<T> store) => builder(store),
    );
  }

  static StoreBuilderFunc<T> _listenable<T>(
    StoreBuilderFunc<T> builder,
    bool listenable,
  ) {
    if (!listenable) {
      return builder;
    }
    return (Store<T> store) => ValueListenableBuilder<Box<T>>(
          valueListenable: store.listenable(),
          builder: (_, __, ___) => builder(store),
        );
  }

  static StoreBuilderFunc<T> _emptiable<T>(
    StoreBuilderFunc<T> builder,
    bool emptiable,
  ) {
    if (!emptiable) {
      return builder;
    }
    return (Store<T> store) => Emptiable<T, Store<T>>(
          values: store,
          builder: builder,
        );
  }
}

class Store<T> extends Iterable<T> {
  const Store(this._box);

  // TODO: Support LazyBox.
  final Box<T> _box;

  static Future<void> init() async {
    // TODO: Do create directory tree?
    await Hive.initFlutter();
    Hive.registerAdapter(WordAdapter());
    Directory(await _internalAssetsDir).create(recursive: true);
    Directory(await _externalAssetsDir).create(recursive: true);
  }

  // TODO: Move `Word` store static methods to a separate class.
  static Future<Store<Word>> openFlow() async {
    return _open<Word>('flow', await _assetsDir);
  }

  static Future<Store<Word>> openInternal(String name) async {
    return _open<Word>(name, await _internalAssetsDir);
  }

  static Future<Store<Word>> openExternal(String name) async {
    return _open<Word>(name, await _externalAssetsDir);
  }

  static Future<Store<T>> _open<T>(String name, String path) async {
    return Store(await Hive.openBox<T>(name, path: path));
  }

  static Future<List<String>> listInternals() async {
    return _list(await _internalAssetsDir);
  }

  static Future<List<String>> listExternals() async {
    return _list(await _externalAssetsDir);
  }

  static Future<List<String>> _list(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) {
      return [];
    }
    return [
      await for (final p in dir.list()) basenameWithoutExtension(p.path),
    ];
  }

  static Future<String> get _assetsDir async =>
      join((await getApplicationDocumentsDirectory()).path, 'assets');
  static Future<String> get _internalAssetsDir async =>
      join(await _assetsDir, 'internal');
  static Future<String> get _externalAssetsDir async =>
      join(await _assetsDir, 'external');

  T at(int index) => index < length ? _box.getAt(index) : _box.getAt(0);
  T next(int index) => at(nextIndex(index));
  int nextIndex(int index) => index < _box.length - 1 ? index + 1 : 0;

  Future<void> dumpToInternal() async {
    final newAssetName = DateTime.now().millisecondsSinceEpoch.toString();
    final internal = await openInternal(newAssetName);
    await internal.addAll(all.cast());
    await internal.close();
  }

  Future<void> restoreFromInternal(String internalName) async {
    final internal = await openInternal(internalName);
    deleteAll();
    addAll(internal.all.cast());
    internal.close();
  }

  Iterable<T> get all => _box.values;
  Iterable<dynamic> get keys => _box.keys;

  Future<int> add(T value) => _box.add(value);
  Future<Iterable<int>> addAll(Iterable<T> values) => _box.addAll(values);
  Future<void> delete(int index) => _box.deleteAt(index);
  Future<void> deleteAll() => _box.deleteAll(_box.keys);
  Future<void> deleteFully() => _box.deleteFromDisk();
  ValueListenable<Box<T>> listenable() => _box.listenable();
  Future<void> close() => _box.close();

  @override
  int get length => _box.length;

  @override
  Iterator<T> get iterator => all.iterator;
}
