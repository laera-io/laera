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
  await StoreFactory.initApp();
  runApp(App());
}

class App extends StatelessWidget {
  static const primaryColor = Colors.amberAccent;
  static const backgroundColor = Color(0xFF212121);
  static const errorColor = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        indicatorColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        canvasColor: backgroundColor,
        errorColor: errorColor,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: primaryColor,
          onPrimary: backgroundColor,
          onSecondary: backgroundColor,
        ),
      ),
      home: Navbar(
        elements: [
          NavbarElement(
            label: 'Flow',
            icon: Icons.all_inclusive_outlined,
            page: const FlowPage(),
          ),
          NavbarElement(
            label: 'New Word',
            icon: Icons.post_add_outlined,
            page: const NewPage(),
          ),
          NavbarElement(
            label: 'Assets',
            icon: Icons.list_alt_outlined,
            page: const AssetsPage(),
          ),
        ],
      ),
    );
  }
}
