// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';

import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/words/words.dart';
import 'package:laera/repos/sources/db.dart';
import 'package:laera/repos/word.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final WordRepo _wordRepo;

  var _selectedIndex = 0;

  _AppWidgetState() : _wordRepo = WordRepo(DB.db);

  Widget _getSelectedWidget() {
    if (_selectedIndex == 1) {
      return Scaffold(
        body: WordsPage(_wordRepo),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add, color: Colors.white),
          label: Text("Add", style: TextStyle(color: Colors.white)),
          // FIXME: Mock.
          onPressed: () => _wordRepo.add(Word("to teach", "учить")),
        ),
      );
    }
    return Scaffold(
      body: FlowPage(_wordRepo),
    );
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
