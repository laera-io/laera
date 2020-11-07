// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;
  final int defaultElementIndex;

  Navbar({
    @required List<NavbarElement> elements,
    this.defaultElementIndex = 0,
  })  : pages = [for (final element in elements ?? []) element.page],
        items = [for (final element in elements ?? []) element.item];

  Widget pageAt(int index) =>
      index < pages.length ? pages[index] : pages[defaultElementIndex];

  @override
  _NavbarState createState() => _NavbarState();
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
  final Widget page;
  final BottomNavigationBarItem item;
  final Color backgroundColor;

  static const materialGrey100 = Color(0xFFF5F5F5);

  NavbarElement({
    @required Widget page,
    @required IconData icon,
    @required String label,
    this.backgroundColor = materialGrey100,
  })  : page = Container(
          color: backgroundColor,
          child: page,
        ),
        item = BottomNavigationBarItem(
          icon: Icon(icon),
          label: label,
        );
}
