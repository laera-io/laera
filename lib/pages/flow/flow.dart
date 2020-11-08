// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/word_card.dart';
import 'package:laera/repos/word.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/widgets/no_data.dart';
import 'package:laera/widgets/swipable.dart';

class FlowPage extends StatelessWidget {
  final WordRepo _wordRepo;

  const FlowPage(this._wordRepo);

  @override
  Widget build(BuildContext context) {
    return Async(
      future: _wordRepo.getAll(),
      builder: (data) {
        final words = data as List<Word> ?? [];
        return words.isEmpty
            ? const NoData()
            : Swipable(
                children: [for (final word in words) WordCard(word: word)],
              );
      },
    );
  }
}
