// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';

class WordsPage extends StatelessWidget {
  final WordRepo _wordRepo;

  WordsPage(this._wordRepo);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _wordRepo.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var widgets = <Widget>[];
          var words = snapshot.data as List<Word>;
          words.forEach((word) {
            widgets.add(Card(child: Text(word.word)));
          });
          return ListView(children: widgets);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
