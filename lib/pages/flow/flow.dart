// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/word_card.dart';
import 'package:laera/widgets/store.dart';
import 'package:laera/widgets/swipeable.dart';
import 'package:laera/widgets/swipeable_target.dart';

class FlowPage extends StatelessWidget {
  const FlowPage();

  @override
  Widget build(BuildContext context) {
    return StoreFactory.flowBuilder(
      emptiable: true,
      builder: (store) => Swipeable<Word, WordCard>(
        store: store,
        builder: (word) => WordCard(word: word),
        targets: [
          VerticalSwipeableTarget<WordCard>(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.0),
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          VerticalSwipeableTarget<WordCard>(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Theme.of(context).colorScheme.secondary.withOpacity(0.0),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
