// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/words/fs.dart';
import 'package:laera/widgets/emptiable.dart';
import 'package:laera/widgets/store.dart';

class MyWordsPage extends StatelessWidget {
  const MyWordsPage();

  static const textScaleFactor = 1.3;

  @override
  Widget build(BuildContext context) {
    return Store<Word>.myWords(
      listenable: true,
      builder: (store) => Emptiable<Word>(
        store: store,
        builder: (store) => Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // TODO: Refactor using of pure Hive box.
              final box = await Hive.openBox<Word>(
                "${DateTime.now().millisecondsSinceEpoch}",
                path: await FileSystem.myAssetsDir,
              );
              box.addAll(store.all);
              box.close();
            },
            label: const Text('Backup'),
            icon: const Icon(Icons.file_copy),
          ),
          body: ListView.builder(
            itemCount: store.length,
            itemBuilder: (context, listIndex) {
              final word = store.at(listIndex);
              return ListTile(
                title: Text(
                  word.word,
                  textScaleFactor: textScaleFactor,
                ),
                subtitle: Text(word.translation),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => store.delete(listIndex),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
