// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';

class AddPage extends StatefulWidget {
  final WordRepo _wordRepo;

  const AddPage(this._wordRepo);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final _wordText = TextEditingController();
  final _translationText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _wordText,
            decoration: const InputDecoration(
              hintText: 'Enter word',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some word';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _translationText,
            decoration: const InputDecoration(
              hintText: 'Enter translation',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some translation';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                return widget._wordRepo.add(
                  Word(
                    _wordText.value.text,
                    _translationText.value.text,
                  ),
                );
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
