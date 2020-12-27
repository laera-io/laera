// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  Navbar({
    @required List<NavbarElement> elements,
    this.defaultElementIndex = 0,
  })  : pages = elements?.map((e) => e.page)?.toList() ?? [],
        items = elements?.map((e) => e.item)?.toList() ?? [];

  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;
  final int defaultElementIndex;

  @override
  _NavbarState createState() => _NavbarState();

  Widget pageAt(int index) =>
      index < pages.length ? pages[index] : pages[defaultElementIndex];
}

class _NavbarState extends State<Navbar> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pageAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        items: widget.items,
      ),
    );
  }
}

class NavbarElement {
  NavbarElement({
    @required this.page,
    @required IconData icon,
    @required String label,
  }) : item = BottomNavigationBarItem(icon: Icon(icon), label: label);

  final Widget page;
  final BottomNavigationBarItem item;
}
