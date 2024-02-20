import 'dart:async';
import 'package:chokchey_finance/app/module/log/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../module/log/model/loanarrear_offline.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('local.db');
    return _database;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    await db.execute('''
CREATE TABLE LocalUserInfo (
  id $idType,
  userID TEXT,
  userName TEXT
)
''');
// Create table for Loan Arrear
    await db.execute('''
    CREATE TABLE IF NOT EXISTS Test(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId TEXT,
    userName TEXT,
    userType TEXT,
    branchCode TEXT,
    employeeCode TEXT,
    overDueDay INTEGER,
    baseDate TEXT,
    totalAmount FLOAT,
    currencyCode TEXT,
    amount INTEGER
    )
    ''');
  }

  ///LocalUserInfo for User Login Offline
  Future<int> insertUser(Map<String, dynamic> row) async {
    await removeOldOfflineUser();
    final db = await instance.database;
    debugPrint("local db $db");
    return await db!.insert('LocalUserInfo', row);
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    final db = await instance.database;
    return await db!.query('LocalUserInfo');
  }

  Future<UserInfoLocalModel?> getOfflineUserInfo() {
    return queryAllUsers().then((value) {
      if (value.isEmpty) {
        return Future.value(null);
      }
      final name = value[0]['userName'] as String;
      final id = value[0]['userID'] as String;
      return UserInfoLocalModel(id, name);
    });
  }

  Future<int> removeOldOfflineUser() async {
    final db = await instance.database;
    return db!.delete("LocalUserInfo");
  }

  //?! Local User for Loan Arrear Offline
  checkTableCreation() async {
    final db = await instance.database;
    List<Map<String, dynamic>> tables =
        await db!.rawQuery('SELECT * FROM Test');

// Check if the contacts table exists
    if (tables.isNotEmpty) {
      debugPrint('Table created successfully!');
    } else {
      // debugPrint('Table loan area not created !');
    }
  }

  // Future<int> insertLoanArrear(Map<String, dynamic> row) async {
  //   // await removeOldOfflineLoanArrear();
  //   final db = await instance.database;
  //   // return await db!.insert('Test', row);
  // }

  Future<List<Map<String, dynamic>>> queryLaonArrear() async {
    final db = await instance.database;
    return await db!.query('Test');
  }

  Future<LoanArrearOfflineModel?> getOfflineLoanArrearInfo() {
    return queryLaonArrear().then(
      (value) {
        if (value.isEmpty) {
          return Future.value(null);
        }
        final name = value[0]['userName'] as String;
        final id = value[0]['userId'] as String;
        final type = value[0]['userType'] as String;
        final branch = value[0]['branchCode'] as String;
        final employee = value[0]['employeeCode'] as String;
        final bastDate = value[0]['baseDate'] as String;
        final overDueDay = value[0]['overDueDay'] as int;
        final currency = value[0]['currencyCode'] as String;
        final total = value[0]['totalAmount'] as double;
        final amount = value[0]['amount'] as int;
        debugPrint("name 111111111 $name");
        debugPrint("id 111111111 $id");
        debugPrint("type 111111111 $type");
        debugPrint("branch 111111111 $branch");
        debugPrint("em 111111111 $employee");
        debugPrint("day 111111111 $bastDate");
        debugPrint("over 111111111 $overDueDay");
        debugPrint("totla 111111111 $total");
        debugPrint("currency 111111111 $currency");
        debugPrint("amount 111111111 $amount");
        return LoanArrearOfflineModel(
          id,
          name,
          type,
          branch,
          employee,
          overDueDay,
          bastDate,
          total,
          currency,
          amount,
        );
      },
    );
  }

  Future<int> removeOldOfflineLoanArrear() async {
    final db = await instance.database;
    return db!.delete("Test");
  }
}
