// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:laera/app.dart';

void main() {
  testWidgets('App widget works fine', (WidgetTester tester) async {
    await tester.pumpWidget(AppWidget());

    expect(find.text('Laera 🤓'), findsOneWidget);
  });
}
