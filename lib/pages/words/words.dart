// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/common/async.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/words/widgets/word_card.dart';
import 'package:laera/repos/word.dart';

class WordsPage extends StatefulWidget {
  final WordRepo _wordRepo;

  const WordsPage(this._wordRepo);

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  @override
  Widget build(BuildContext context) => asyncBuild(
        future: widget._wordRepo.getAll(),
        builder: (data) {
          var widgets = <Widget>[];
          (data as List<Word> ?? []).forEach((word) {
            widgets.add(
              WordCard(word, widget._wordRepo.delete, () => setState(() {})),
            );
            widgets.add(Divider());
          });
          return widgets.length > 0
              ? Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.95,
                    child: ListView(children: widgets),
                  ),
                )
              : Center(
                  child: Text(
                  "No words. Add some",
                  textScaleFactor: 1.5,
                ));
        },
      );
}
