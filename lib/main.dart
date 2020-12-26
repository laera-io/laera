// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/pages/words/words.dart';
import 'package:laera/widgets/navbar.dart';

void main() async {
  registerHive();
  runApp(App());
}

void registerHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColorBrightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.lightGreen,
                secondary: Colors.white,
              ),
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Navbar(
        elements: [
          NavbarElement(
            label: 'Flow',
            icon: Icons.all_inclusive,
            page: FlowPage(),
          ),
          NavbarElement(
            label: 'New',
            icon: Icons.add,
            page: const NewPage(),
          ),
          NavbarElement(
            label: 'Words',
            icon: Icons.list,
            page: const WordsPage(),
          ),
        ],
      ),
    );
  }
}
