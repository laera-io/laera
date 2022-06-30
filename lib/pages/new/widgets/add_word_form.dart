import 'package:flutter/material.dart';
import 'package:laera/models/word.dart';
import 'package:laera/widgets/store.dart';

class AddWordForm extends StatelessWidget {
  AddWordForm({super.key});

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
                icon: Icon(Icons.translate_outlined),
              ),
              validator: _validateInput,
            ),
            TextFormField(
              controller: _translationText,
              decoration: const InputDecoration(
                labelText: 'Translation',
                icon: Icon(Icons.text_fields_outlined),
              ),
              validator: _validateInput,
            ),
            Container(height: addButtonIndent),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) return;
                  store.add(
                    Word(
                      word: _wordText.text,
                      translation: _translationText.text,
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
