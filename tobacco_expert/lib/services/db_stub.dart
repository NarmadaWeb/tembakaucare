import 'package:sqflite/sqlite_api.dart';

Future<DatabaseFactory> getDatabaseFactory() {
  throw UnsupportedError('Cannot create a database factory without dart:html or dart:io');
}

Future<String> getDbPath(DatabaseFactory factory) async {
  throw UnsupportedError('Cannot get db path');
}
