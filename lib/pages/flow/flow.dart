// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/common/async.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/widgets/swipable_card_stack.dart';
import 'package:laera/repos/word.dart';

class FlowPage extends StatelessWidget {
  final WordRepo _wordRepo;

  FlowPage(this._wordRepo);

  @override
  Widget build(BuildContext context) => asyncBuild(
        future: _wordRepo.getAll(),
        builder: (data) => SwipableCardStackWidget(data as List<Word> ?? []),
      );
}
