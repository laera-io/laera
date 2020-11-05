// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/words/words.dart';
import 'package:laera/repos/sources/db.dart';
import 'package:laera/repos/word.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  static final _backgroundColor = Colors.grey[100];

  final _routes = {
    0: _Route(
      child: Container(
        color: _backgroundColor,
        child: FlowPage(WordRepo(DB.db)),
      ),
      item: const BottomNavigationBarItem(
        icon: Icon(Icons.all_inclusive),
        label: 'Flow',
      ),
    ),
    1: _Route(
      child: Container(
        color: _backgroundColor,
        child: NewPage(WordRepo(DB.db)),
      ),
      item: const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'New',
      ),
    ),
    2: _Route(
      child: Container(
        color: _backgroundColor,
        child: WordsPage(WordRepo(DB.db)),
      ),
      item: const BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Words',
      ),
    ),
  };

  static const _defaultIndex = 0;

  var _selectedIndex = 0;

  Widget _getSelectedWidget() =>
      _routes[_selectedIndex].child ?? _routes[_defaultIndex].child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedWidget(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        items: [for (var route in _routes.values) route.item],
      ),
    );
  }
}

class _Route {
  final Widget child;
  final BottomNavigationBarItem item;

  const _Route({
    @required this.child,
    @required this.item,
  });
}
