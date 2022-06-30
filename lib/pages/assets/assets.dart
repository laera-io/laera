import 'package:flutter/material.dart';
import 'package:laera/pages/assets/flow.dart';
import 'package:laera/pages/assets/internal.dart';
import 'package:laera/widgets/tabbar.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Tabbar(
      elements: const [
        TabbarElement(label: 'Flow', page: FlowAssetPage()),
        TabbarElement(label: 'Internal', page: InternalAssetsPage()),
      ],
    );
  }
}
