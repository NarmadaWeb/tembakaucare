import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqlite_api.dart';

Future<DatabaseFactory> getDatabaseFactory() async {
  return databaseFactoryFfiWeb;
}

Future<String> getDbPath(DatabaseFactory factory) async {
  return 'tobacco_expert.db';
}
