// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/store.dart';

class FlowAssetPage extends StatelessWidget {
  const FlowAssetPage();

  static const textScaleFactor = 1.3;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder.flow(
      emptiable: true,
      listenable: true,
      builder: (store) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await store.dumpToInternal();
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully dumped'),
              ),
            );
          },
          label: const Text('Dump'),
          icon: const Icon(Icons.file_copy),
        ),
        body: ListView.builder(
          itemCount: store.length,
          itemBuilder: (context, listIndex) {
            final word = store.at(listIndex);
            return ListTile(
              title: Text(
                word.word,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(
                word.translation,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => store.delete(listIndex),
              ),
            );
          },
        ),
      ),
    );
  }
}
