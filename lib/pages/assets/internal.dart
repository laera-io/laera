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
    return Async<List<String>>(
      future: StoreFactory.listInternals(),
      builder: (internalAssetNames) => Emptiable<String, List<String>>(
        values: internalAssetNames,
        builder: (internalNames) => ListView(
          children: [
            for (final assetName in internalNames)
              ListTile(
                title: Text(assetName),
                leading: IconButton(
                  icon: const Icon(Icons.file_upload_outlined),
                  onPressed: () => _onRestore(context, assetName),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever_outlined),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => _onDelete(assetName),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Future<void> _onRestore(BuildContext context, String assetName) async {
    final messenger = ScaffoldMessenger.of(context);

    if (await _RestoreAlert(assetName).show(context) != true) {
      return;
    }

    await Store.restoreFlowFromInternal(assetName);
    messenger.showSnackBar(
      SnackBar(
        content: Text('Successfully restore asset $assetName'),
      ),
    );
  }

  static Future<void> _onDelete(String assetName) async =>
      (await StoreFactory.openInternal(assetName)).deleteFully();
}

class _RestoreAlert extends StatelessWidget {
  const _RestoreAlert(this._assetName, {Key? key}) : super(key: key);

  final String _assetName;

  Future<bool?> show(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Do you want to restore asset $_assetName?',
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
    );
  }
}
