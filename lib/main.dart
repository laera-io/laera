// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laera/pages/assets/assets.dart';
import 'package:laera/pages/flow/cubit/flow_cubit.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/widgets/navbar.dart';
import 'package:laera/widgets/store.dart';

Future<void> main() async {
  await StoreFactory.initApp();
  runApp(App());
}

class App extends StatelessWidget {
  final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.cyan,
    secondary: Colors.deepPurpleAccent[100],
    error: Colors.deepPurpleAccent[100],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlowCubit(),
      child: MaterialApp(
        theme: themeData,
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
      ),
    );
  }

  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorSchemeSeed: colorScheme.primary,
        errorColor: colorScheme.error,
        indicatorColor: colorScheme.primary,
      ).copyWith(colorScheme: colorScheme);
}
