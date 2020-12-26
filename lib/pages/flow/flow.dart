// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/word_card.dart';
import 'package:laera/widgets/emptiable.dart';
import 'package:laera/widgets/store.dart';
import 'package:laera/widgets/swipable.dart';

class FlowPage extends StatelessWidget {
  const FlowPage();

  static const acceptTargetColor = Color(0xFFDCEDC8); // Colors.lightGreen[100]
  static const rejectTargetColor = Color(0xFFD6D6D6); // Colors.grey[350]

  @override
  Widget build(BuildContext context) {
    return Store.myWords(
      // TODO: Move Emptiable using to Store.
      builder: (CycleStore<Word> store) => Emptiable(
        store: store,
        builder: (CycleStore<Word> store) => Swipable(
          store: store,
          builder: (Word word) => WordCard(word: word),
          targets: [
            VerticalTarget(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    acceptTargetColor,
                  ],
                ),
              ),
            ),
            VerticalTarget(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    rejectTargetColor,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
