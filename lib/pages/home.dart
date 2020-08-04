// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/word_card.dart';
import 'package:laera/widgets/swipable_card_stack.dart';

class HomePage extends StatelessWidget {
  static const cardsData = [
    const WordCardData("to run", "бежать"),
    const WordCardData("to swipe", "провести"),
    const WordCardData("a guitar", "гитара"),
  ];

  @override
  Widget build(BuildContext context) =>
      SwipableCardStackWidget(cardsData: cardsData);
}
