// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/tabbar.dart';
import 'package:laera/pages/words/my.dart';
import 'package:laera/pages/words/assets.dart';

class WordsPage extends StatelessWidget {
  const WordsPage();

  @override
  Widget build(BuildContext context) {
    return Tabbar(
      elements: const [
        TabbarElement(label: 'My Words', page: MyWordsPage()),
        TabbarElement(label: 'Assets', page: AssestsPage()),
      ],
    );
  }
}
