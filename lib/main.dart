// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/assets/assets.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/widgets/navbar.dart';
import 'package:laera/widgets/store.dart';

Future<void> main() async {
  await StoreFactory.initApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        brightness: Brightness.dark,
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
