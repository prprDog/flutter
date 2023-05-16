import 'dart:async';

import 'package:fluttertest/bean.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _tableComponent = "component";
const _tableLabel = "label";

Future<Database> getDataBase() async{
  return openDatabase(join(await getDatabasesPath(), 'label_database.db'), onCreate: (db, version) {
    db.execute('CREATE TABLE $_tableComponent(id TEXT PRIMARY KEY, x DOUBLE, y DOUBLE, rotation DOUBLE, width DOUBLE, height DOUBLE)');
    db.execute('CREATE TABLE $_tableLabel(id TEXT PRIMARY KEY, width DOUBLE, height DOUBLE, color INTEGER, components TEXT)');
  }, version: 1);
}

Future<void> insertComponent(ComponentData componentData) async{
  final db = await getDataBase();
  db.insert(_tableComponent, componentData.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> insertLabel(Label label) async {
  final db = await getDataBase();
  db.insert(_tableComponent, label.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> insertComponentList(List<ComponentData> list) async {
  for (var component in list) {
    insertComponent(component);
  }
}

Future<void> deleteAllComponent() async {
  final db = await getDataBase();
  db.delete(_tableComponent);
}

Future<List<ComponentData>> queryComponent() async {
  final db = await getDataBase();
  List<Map<String, dynamic>> result = await db.query(_tableComponent);
  return List.generate(result.length, (index) {
    return ComponentData.fromMap(result[index]);
  });
}