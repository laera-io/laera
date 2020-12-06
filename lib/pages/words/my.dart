// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:laera/models/word.dart';
import 'package:laera/widgets/async.dart';

class MyWordsPage extends StatelessWidget {
  const MyWordsPage();

  static const textScaleFactor = 1.3;
  static const myWordsBoxName = 'my_words';

  @override
  Widget build(BuildContext context) {
    return Async(
      future: Hive.openBox<Word>(myWordsBoxName),
      builder: (Box<Word> myWordsBox) => ValueListenableBuilder(
        valueListenable: myWordsBox.listenable(),
        builder: (_, __, ___) => ListView.builder(
          itemCount: myWordsBox.length,
          itemBuilder: (context, listIndex) {
            final word = myWordsBox.getAt(listIndex);
            return ListTile(
              title: Text(
                word.word,
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(word.translation),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => myWordsBox.deleteAt(listIndex),
              ),
            );
          },
        ),
      ),
    );
  }
}
