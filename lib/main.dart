// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/new/new.dart';
import 'package:laera/pages/flow/flow.dart';
import 'package:laera/pages/words/words.dart';
import 'package:laera/repos/sources/db.dart';
import 'package:laera/repos/word.dart';

final _backgroundColor = Colors.grey[100];

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.grey[400],
        ),
        initialRoute: FlowPage.route,
        routes: {
          // TODO: Don't create new copy of Scaffold with BottomNavigationBar.
          FlowPage.route: (context) => Foo(route: 0),
          NewPage.route: (context) => Foo(route: 1),
          WordsPage.route: (context) => Foo(route: 2),
        },
      ),
    );

class Foo extends StatelessWidget {
  // final Widget child;
  final int route;

  Foo({
    // @required this.child,
    @required this.route,
  });

  static const _defaultRoute = 0;

  final _routes = {
    0: _Route(
      route: FlowPage.route,
      item: const BottomNavigationBarItem(
        icon: Icon(Icons.all_inclusive),
        title: Text('Flow'),
      ),
      builder: () => FlowPage(WordRepo(DB.db)),
    ),
    1: _Route(
      route: NewPage.route,
      item: const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Add'),
      ),
      builder: () => NewPage(WordRepo(DB.db)),
    ),
    2: _Route(
      route: WordsPage.route,
      item: const BottomNavigationBarItem(
        icon: Icon(Icons.list),
        title: Text('Words'),
      ),
      builder: () => WordsPage(WordRepo(DB.db)),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: Scaffold(
        body: _routes[route].builder(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (route != index) {
              return Navigator.pushNamed(
                context,
                index < _routes.length
                    ? _routes[index].route
                    : _routes[_defaultRoute].route,
              );
            }
          },
          currentIndex: route,
          items: [for (var route in _routes.values) route.item],
        ),
      ),
    );
  }
}

class _Route {
  final String route;
  final BottomNavigationBarItem item;
  final Widget Function() builder;

  const _Route({
    @required this.route,
    @required this.item,
    @required this.builder,
  });
}
