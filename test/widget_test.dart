// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laera/widgets/app.dart';

void main() {
  testWidgets('App loads fine', (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: AppWidget()),
    ));

    expect(find.text('Flow'), findsOneWidget);
    expect(find.text('Words'), findsOneWidget);
    expect(find.text('to run'), findsOneWidget);
  });
}
