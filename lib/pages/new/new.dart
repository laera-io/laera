// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/new/widgets/adding_form.dart';
import 'package:laera/repos/word.dart';

class NewPage extends StatelessWidget {
  NewPage(this._wordRepo);

  final WordRepo _wordRepo;

  static const widthFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: AddingForm(_wordRepo),
      ),
    );
  }
}
