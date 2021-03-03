// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/pages/assets/assets.dart';
import 'package:laera/widgets/navbar.dart';
import 'package:laera/widgets/store.dart';

Future<void> main() async {
  await Store.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColorBrightness: Brightness.dark,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
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
            page: const FlowPage(),
          ),
          NavbarElement(
            label: 'New Word',
            icon: Icons.post_add_outlined,
            page: const NewPage(),
          ),
          NavbarElement(
            label: 'Assets',
            icon: Icons.list_alt,
            page: const AssetsPage(),
          ),
        ],
      ),
    );
  }
}
