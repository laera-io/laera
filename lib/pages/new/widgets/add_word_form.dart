// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/widgets/store.dart';

class AddWordForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _wordText = TextEditingController();
  final _wordsFocus = FocusNode();

  final _translationText = TextEditingController();

  static const addButtonIndent = 20.0;
  static const myWordsBoxName = 'my_words';

  @override
  Widget build(BuildContext context) {
    return StoreFactory.flowBuilder(
      builder: (store) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _wordText,
              focusNode: _wordsFocus,
              decoration: const InputDecoration(
                labelText: 'Word',
                icon: Icon(Icons.translate),
              ),
              validator: _validateInput,
            ),
            TextFormField(
              controller: _translationText,
              decoration: const InputDecoration(
                labelText: 'Translation',
                icon: Icon(Icons.text_fields),
              ),
              validator: _validateInput,
            ),
            Container(height: addButtonIndent),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  store.add(
                    Word(
                      word: _wordText.value.text,
                      translation: _translationText.value.text,
                    ),
                  );
                  _wordText.clear();
                  _translationText.clear();
                  _wordsFocus.requestFocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Word added')),
                  );
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
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
