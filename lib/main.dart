// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/pages/words/words.dart';
import 'package:laera/repos/sources/db.dart';
import 'package:laera/repos/word.dart';
import 'package:laera/widgets/navbar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Navbar(
        elements: [
          NavbarElement(
            label: 'Flow',
            icon: Icons.all_inclusive,
            page: FlowPage(WordRepo(DB.db)),
          ),
          NavbarElement(
            label: 'New',
            icon: Icons.add,
            page: NewPage(WordRepo(DB.db)),
          ),
          NavbarElement(
            label: 'Words',
            icon: Icons.list,
            page: WordsPage(WordRepo(DB.db)),
          ),
        ],
      ),
    );
  }
}
