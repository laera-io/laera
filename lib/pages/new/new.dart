// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';

class NewPage extends StatelessWidget {
  final WordRepo _wordRepo;

  NewPage(this._wordRepo);

  final _formKey = GlobalKey<FormState>();
  final _wordText = TextEditingController();
  final _translationText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _wordText,
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
              Container(height: 20),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _add(context),
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validateInput(String value) =>
      value?.isEmpty ?? true ? 'Please input some data' : null;

  Function() _add(BuildContext context) => () {
        if (!(_formKey.currentState?.validate() ?? false)) return;
        _wordRepo.add(
          Word(
            _wordText.value.text,
            _translationText.value.text,
          ),
        );
        _formKey.currentState?.reset();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Word added'),
          ),
        );
      };
}
