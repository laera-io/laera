// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/widgets/store.dart';

class InternalAssetsPage extends StatelessWidget {
  const InternalAssetsPage();

  @override
  Widget build(BuildContext context) {
    // TODO: Update widget data.
    return Async<List<String>>(
      future: CycleStore.listInternals(),
      builder: (internalNames) => ListView(
        children: [
          for (final internalName in internalNames)
            ListTile(
              // TODO: Pretify file names.
              title: Text(internalName),
              // TODO: Use drop down list of commands instead of leading+trailing buttons.
              leading: IconButton(
                icon: const Icon(Icons.file_upload),
                onPressed: () async {
                  // TODO: Ask to save current flow state.
                  final flow = await CycleStore.openFlow();
                  flow.restoreFromInternal(internalName);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully upload asset: $internalName'),
                    ),
                  );
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  final internal = await CycleStore.openInternal(internalName);
                  internal.deleteFully();
                },
              ),
            )
        ],
      ),
    );
  }
}
