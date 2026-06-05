import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

Future<sqflite.DatabaseFactory> getDatabaseFactory() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    return databaseFactoryFfi;
  }
  return sqflite.databaseFactory;
}

Future<String> getDbPath(sqflite.DatabaseFactory factory) async {
  return join(await factory.getDatabasesPath(), 'tobacco_expert.db');
}
