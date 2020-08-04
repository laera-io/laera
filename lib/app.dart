// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/home.dart';

class AppWidget extends StatelessWidget {
  static const _title = 'Laera 🤓';
  static const _color = Colors.lightGreen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: _color,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: HomePage(),
      ),
    );
  }
}
