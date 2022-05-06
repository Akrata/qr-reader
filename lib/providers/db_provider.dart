import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DBProvider {
  // ignore: unused_field
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //path almacen DB

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //crear base de datos

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
            ''');
      },
    );
  }

  nuevoScanRaw(ScanModel nuevoScan) async {
    //verificar la DB
    final db = await database;
    //insertar
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final res = db.rawInsert('''
            INSERT INTO Scans( id, tipo, valor)
            VALUES($id, '$tipo', '$valor')
                        ''');
    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);

    //res id ultimo registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    print(res.first);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel?>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    print(res);

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel?>> getScansByTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    final res2 = await db.rawQuery('''
            SELECT * FROM Scans WHERE tipo = '$tipo'
        ''');
    print(res);

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
