// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/assets/flow.dart';
import 'package:laera/pages/assets/internal.dart';
import 'package:laera/widgets/tabbar.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage();

  @override
  Widget build(BuildContext context) {
    return Tabbar(
      elements: const [
        TabbarElement(label: 'Flow', page: FlowAssetPage()),
        TabbarElement(label: 'Internal', page: InternalAssetsPage()),
        TabbarElement(
          label: 'External',
          page: Center(
            child: Text('under development 👷', textScaleFactor: 1.5),
          ),
        ),
      ],
    );
  }
}
