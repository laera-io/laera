// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/word_card.dart';
import 'package:laera/widgets/store.dart';
import 'package:laera/widgets/swipeable.dart';

class FlowPage extends StatelessWidget {
  const FlowPage();

  static const acceptTargetColor = Color(0xAA554821);
  static const rejectTargetColor = Color(0xAA151515);

  @override
  Widget build(BuildContext context) {
    return StoreFactory.flowBuilder(
      emptiable: true,
      builder: (store) => Swipeable<Word, WordCard>(
        store: store,
        builder: (word) => WordCard(word: word),
        targets: [
          VerticalTarget<WordCard>(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  acceptTargetColor,
                ],
              ),
            ),
          ),
          VerticalTarget<WordCard>(
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
    );
  }
}
