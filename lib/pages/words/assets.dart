// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/pages/words/fs.dart';
import 'package:laera/widgets/async.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage();

  @override
  Widget build(BuildContext context) {
    // TODO: update widget data
    return Async<String>(
      future: FileSystem.myAssetsDir,
      builder: (dir) => ListView(
        children: [
          for (final i in FileSystem.listFiles(dir))
            ListTile(
              title: Text(i),
            )
        ],
      ),
    );
  }
}
