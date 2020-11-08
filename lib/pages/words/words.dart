// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';

class WordsPage extends StatefulWidget {
  final WordRepo _wordRepo;

  const WordsPage(this._wordRepo);

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  static const textScaleFactor = 1.3;
  static const leadingSpaceScaleFactor = 0.05;

  @override
  Widget build(BuildContext context) {
    return Async(
      future: widget._wordRepo.getAll(),
      builder: (data) {
        final words = data as List<Word> ?? [];
        if (words.isEmpty) {
          return const Center(
            child: Text(
              "No words. Add some",
              textScaleFactor: 1.5,
            ),
          );
        }
        var widgets = <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * leadingSpaceScaleFactor,
          ),
        ];
        (words).forEach((word) {
          widgets.add(
            ListTile(
              title: Text(
                word.word,
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(word.translation),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => setState(
                  () => widget._wordRepo.delete(word.id),
                ),
              ),
            ),
          );
        });
        return Center(
          child: ListView(
            children: widgets,
          ),
        );
      },
    );
  }
}
