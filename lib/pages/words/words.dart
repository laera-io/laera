// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/common/async.dart';
import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';

class WordsPage extends StatelessWidget {
  final WordRepo _wordRepo;

  WordsPage(this._wordRepo);

  @override
  Widget build(BuildContext context) => asyncBuild(
        future: _wordRepo.getAll(),
        builder: (data) {
          var widgets = <Widget>[];
          (data as List<Word> ?? []).forEach((word) {
            widgets.add(Card(child: Text(word.word)));
          });
          return ListView(children: widgets);
        },
      );
}
