// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/repos/word.dart';

class NewPage extends StatefulWidget {
  final WordRepo _wordRepo;

  NewPage(this._wordRepo);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input some data';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _translationText,
                decoration: const InputDecoration(
                  labelText: 'Translation',
                  icon: Icon(Icons.text_fields),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input some data';
                  }
                  return null;
                },
              ),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.05,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.lightGreen,
                  colorBrightness: Brightness.dark,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      widget._wordRepo.add(
                        Word(
                          _wordText.value.text,
                          _translationText.value.text,
                        ),
                      );
                      _formKey.currentState?.reset();

                      final snackBar = SnackBar(
                        content: Text('Word added'),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
