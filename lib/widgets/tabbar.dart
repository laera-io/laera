import 'package:flutter/material.dart';

class Tabbar extends StatelessWidget {
  Tabbar({
    required List<TabbarElement> elements,
    super.key,
  })  : pages = [for (final e in elements) e.page],
        tabs = [for (final e in elements) Tab(text: e.label)];

  final List<Widget> pages;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            bottom: TabBar(
              tabs: tabs,
            ),
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
