// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:laera/main.dart';

void main() {
  testWidgets('App loads fine', (WidgetTester tester) async {
    await registerHive();
    await tester.pumpWidget(App());

    expect(find.text('Flow'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Words'), findsOneWidget);
  });
}
