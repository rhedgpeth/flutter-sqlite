# Flutter + SQLite 

![Build status](https://app.bitrise.io/app/a3e6d55c1d6ee760/status.svg?token=wqZw6gGe-o-P4SLLYl1Caw) [![License (MIT)][licence-image]][licence-url]

This repository contains a simple [Flutter](https://flutter.dev/) application that manages contact information using [SQLite](https://www.sqlite.org/index.html) (via [SQFLite](https://pub.dev/packages/sqflite)).

<p align="center" spacing="10">
    <kbd>
        <img src="media/demo.gif" />
    </kbd>
</p>

## Requirements 

To run this application be sure to check out [the Flutter documentation](https://docs.flutter.dev/get-started/install) for getting started. 

## Key takeaways 

To use SQLite within a Flutter application you're going to need to add a couple dependencies to the [pubspec.yaml](src/pubspec.yaml) file.

> Note: The [Dart](dart.dev) ecosystem uses packages to manage shared software such as libraries and tools. To get Dart packages, you use the pub package manager. Find more information on Dart package management [here](https://dart.dev/guides/packages).

More specifically, the [sqflite](https://pub.dev/packages/sqflite) and [path_provider](https://pub.dev/packages/path_provider) packages are required.

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: any
  path_provider: any
```

From there a SQLite database (and tables) can be created and used within the application. 

For this applicaiton I have put all of the SQLite usages within [database_help.dart](src/data/database_help.dart).

```dart
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rolodex/models/base_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    _db ??= await init();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> init() async {
      io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "main.db");
      return openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) async =>
      await db.execute('CREATE TABLE contacts (id INTEGER PRIMARY KEY NOT NULL, firstName STRING, lastName STRING, phone STRING, email STRING)');

  Future<List<Map<String, dynamic>>> query(String table) async => (await db).query(table);

  Future<int> insert(String table, BaseModel model) async => (await db).insert(table, model.toMap());

  Future<int> update(String table, BaseModel model) async => (await db).update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  Future<int> delete(String table, BaseModel model) async => (await db).delete(table, where: 'id = ?', whereArgs: [model.id]);
}
```

## Questions / Feedback

If you have any questions or feedback for this sample please feel free to submit an issue here or email me at rob.hedgpeth@gmail.com. 

Happy coding!

[bitrise-image]:https://travis-ci.com/mariadb-corporation/mariadb-connector-nodejs.svg?branch=master
[travis-url]:https://app.travis-ci.com/github/mariadb-corporation/mariadb-connector-nodejs
[licence-image]:https://img.shields.io/badge/License-MIT-blue.svg?style=plastic
[licence-url]:https://opensource.org/licenses/MIT
