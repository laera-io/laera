// Copyright 2020 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

Widget asyncBuild({
  Future<dynamic> future,
  Widget Function(dynamic data) builder,
}) =>
    FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }
          return builder(snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
