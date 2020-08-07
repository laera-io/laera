// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:laera/widgets/app.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: AppWidget(),
      ),
    );
