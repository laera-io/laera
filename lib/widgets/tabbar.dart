// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Tabbar extends StatelessWidget {
  Tabbar({required List<TabbarElement> elements})
      : pages = [for (final e in elements) e.page],
        tabs = [for (final e in elements) Tab(text: e.label)];

  final List<Widget> pages;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}

class TabbarElement {
  const TabbarElement({
    required this.label,
    required this.page,
  });

  final String label;
  final Widget page;
}
