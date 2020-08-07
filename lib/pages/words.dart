// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/repos/word.dart';

class WordsPage extends StatelessWidget {
  WordRepo _wordRepo;

  WordsPage(this._wordRepo);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text("Coming soon", textScaleFactor: 1.5));
}
