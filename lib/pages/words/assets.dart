// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/pages/words/fs.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/widgets/store.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage();

  @override
  Widget build(BuildContext context) {
    // TODO: Update widget data.
    return Async<String>(
      future: FileSystem.myAssetsDir,
      builder: (assetsDir) => ListView(
        children: [
          // TODO: Do refactor?
          for (final fileName in FileSystem.listFiles(assetsDir))
            ListTile(
              // TODO: Pretify file names.
              title: Text(fileName),
              leading: IconButton(
                icon: const Icon(Icons.file_upload),
                // TODO: Implement.
                onPressed: () async {
                  // TODO: Ask to save current asset state.
                  // TODO: Refactor using of pure Hive box.
                  final box = await Hive.openBox<Word>(
                    fileName,
                    path: await FileSystem.myAssetsDir,
                  );
                  final store = CycleStore(
                    await Hive.openBox<Word>('my_words'),
                  );
                  store.deleteAll();
                  // TODO: Add some notification.
                  store.addAll(box.values);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully upload asset: $fileName'),
                    ),
                  );
                  box.close();
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  // TODO: Is it better to use `deleteAll` method of `CycleStore`?
                  final file = File(fileName);
                  file.delete();
                },
              ),
            )
        ],
      ),
    );
  }
}
