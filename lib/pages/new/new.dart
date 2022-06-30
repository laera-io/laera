import 'package:flutter/material.dart';
import 'package:laera/pages/new/widgets/add_word_form.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  static const widthFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: AddWordForm(),
      ),
    );
  }
}
