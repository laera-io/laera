// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:laera/pages/flow.dart';
import 'package:laera/pages/words.dart';
import 'package:laera/repos/sources/db.dart';
import 'package:laera/repos/word.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final Future<Database> _db;

  var _selectedIndex = 0;

  _AppWidgetState() : _db = DB.db;

  Widget _getSelectedWidget() {
    if (_selectedIndex == 1) {
      return WordsPage(WordRepo(_db));
    }
    return FlowPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedWidget(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            title: Text("Flow"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Words"),
          ),
        ],
      ),
    );
  }
}
