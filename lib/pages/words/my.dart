// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/widgets/emptiable.dart';
import 'package:laera/widgets/store.dart';
import 'package:path_provider/path_provider.dart';

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
              final json = jsonEncode(store.values.toList());
              final file = File(await newMyAssetPath);
              file.create(recursive: true);
              await file.writeAsString(json);
              Scaffold.of(context).showSnackBar(
                const SnackBar(content: Text('Saved')),
              );
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

  static Future<String> get newMyAssetPath async {
    return '${await assetsDir}/my/${DateTime.now().millisecondsSinceEpoch}.json';
  }

  static Future<String> get assetsDir async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/assets';
  }
}
