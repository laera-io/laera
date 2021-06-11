// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/widgets/store.dart';

class FlowAssetPage extends StatelessWidget {
  const FlowAssetPage();

  static const textScaleFactor = 1.3;

  @override
  Widget build(BuildContext context) {
    return StoreFactory.flowBuilder(
      emptiable: true,
      listenable: true,
      builder: (store) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _onDump(context, store),
          label: const Text('Dump'),
          icon: const Icon(Icons.file_copy_outlined),
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
                icon: const Icon(Icons.delete_forever_outlined),
                color: Theme.of(context).errorColor,
                onPressed: () => store.delete(listIndex),
              ),
            );
          },
        ),
      ),
    );
  }

  static Future<void> _onDump(BuildContext context, Store<Word> store) async {
    final newAssetName = await const DumpAlert().show(context);
    if (newAssetName == null || newAssetName == '') {
      return;
    }

    await store.dumpToInternal(newAssetName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully dumped'),
      ),
    );
  }
}

class DumpAlert extends StatelessWidget {
  const DumpAlert({Key? key}) : super(key: key);

  Future<String?> show(BuildContext context) async {
    return showDialog<String?>(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dump words as an asset'),
      actions: <Widget>[_DumpAlertForm()],
    );
  }
}

class _DumpAlertForm extends StatelessWidget {
  _DumpAlertForm({Key? key}) : super(key: key);

  static const __textFormWidthFactor = 0.8;
  static const _buttonsIndent = 15.0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: Pretify default file name.
    final assetNameText = TextEditingController(
      text: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: __textFormWidthFactor,
            child: TextFormField(
              controller: assetNameText,
              decoration: const InputDecoration(
                labelText: 'Asset name',
                icon: Icon(Icons.assignment_outlined),
              ),
              validator: _validateInput,
            ),
          ),
          Container(height: _buttonsIndent),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) return;
                  // TODO: Check asset name existing.
                  Navigator.of(context).pop(assetNameText.text);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input some data';
    }
    if (value.length > 100) {
      return 'Too large';
    }
    return null;
  }
}
