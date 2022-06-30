// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/cubit/flow_cubit.dart';
import 'package:laera/pages/flow/widgets/word_card.dart';
import 'package:laera/widgets/store.dart';
import 'package:laera/widgets/swipeable.dart';
import 'package:laera/widgets/swipeable_target.dart';

class FlowPage extends StatelessWidget {
  const FlowPage({super.key});

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
            onAccept: <WordCard>(_) {
              context.read<FlowCubit>().accept();
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0),
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ],
                ),
              ),
              child: Container(),
            ),
          ),
          VerticalSwipeableTarget<WordCard>(
            alignment: Alignment.centerLeft,
            onAccept: <WordCard>(_) {
              context.read<FlowCubit>().reject();
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Theme.of(context).colorScheme.secondary.withOpacity(0),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
              ),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
