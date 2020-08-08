// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/swipable_card_stack.dart';

class FlowPage extends StatelessWidget {
  static const cardsData = [
    const Word("to run", "бежать"),
    const Word("to swipe", "провести"),
    const Word("a guitar", "гитара"),
  ];

  @override
  Widget build(BuildContext context) =>
      SwipableCardStackWidget(cardsData: cardsData);
}
