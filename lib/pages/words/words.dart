// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/widgets/emptiable.dart';

class WordsPage extends StatefulWidget {
  const WordsPage(this._wordRepo);

  final WordRepo _wordRepo;

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
      builder: (words) => Emptiable(
        data: words as List<Word>,
        builder: (words) => Center(
          child: ListView(
            children: <Widget>[
              Container(
                height:
                    MediaQuery.of(context).size.width * leadingSpaceScaleFactor,
              ),
              ...[
                for (final word in words)
                  ListTile(
                    title: Text(
                      word.word,
                      textScaleFactor: textScaleFactor,
                    ),
                    subtitle: Text(word.translation),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        widget._wordRepo.delete(word.id);
                        setState(() => {});
                      },
                    ),
                  )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
