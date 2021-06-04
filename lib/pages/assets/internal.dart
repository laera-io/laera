// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/async.dart';
import 'package:laera/widgets/emptiable.dart';
import 'package:laera/widgets/store.dart';

class InternalAssetsPage extends StatelessWidget {
  const InternalAssetsPage();

  @override
  Widget build(BuildContext context) {
    // TODO: Update widget data.
    return Async<List<String>>(
      future: StoreFactory.listInternals(),
      builder: (internalNames) => Emptiable<String, List<String>>(
        values: internalNames,
        builder: (internalNames) => ListView(
          children: [
            for (final assetName in internalNames)
              ListTile(
                // TODO: Pretify file names.
                title: Text(assetName),
                // TODO: Use drop down list of commands instead of leading+trailing buttons.
                leading: IconButton(
                  icon: const Icon(Icons.file_upload),
                  onPressed: () async {
                    if (await _showRestoreAlert(context, assetName) ?? false) {
                      _restore(context, assetName);
                    }
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () async {
                    final internal = await StoreFactory.openInternal(
                      assetName,
                    );
                    internal.deleteFully();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showRestoreAlert(
    BuildContext context,
    String assetName,
  ) async {
    return showDialog<bool?>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Do you want to restore asset $assetName?',
        ),
        content: const Text(
          'Restoring will delete all the curent words',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _restore(BuildContext context, String assetName) async {
    final flow = await StoreFactory.openFlow();
    flow.restoreFromInternal(assetName);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Successfully upload asset: $assetName',
        ),
      ),
    );
  }
}
