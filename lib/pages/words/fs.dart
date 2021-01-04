// Copyright 2021 The Laera Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileSystem {
  FileSystem._();

  static Future<String> get newMyAssetPath async {
    return '${await myAssetsDir}/${DateTime.now().millisecondsSinceEpoch}.json';
  }

  static Future<String> get myAssetsDir async {
    return '${await assetsDir}/my';
  }

  static Future<String> get assetsDir async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/assets';
  }

  static Future<void> write(
    BuildContext context,
    String path,
    String data,
  ) async {
    final file = File(path);
    file.create(recursive: true);
    await file.writeAsString(data);
    Scaffold.of(context).showSnackBar(
      const SnackBar(content: Text('Saved')),
    );
  }

  // TODO: Add some async?
  static List<String> listFiles(String path) {
    return [for (final p in Directory(path).listSync()) p.path];
  }
}
