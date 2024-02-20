import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../module/log/screen/login_screen.dart';

class SqliteHelper {
  //////////// constactor init create_database
  SqliteHelper() {
    onCreateDatabase();
  }
  Database? database;
// var databasesPath = await getDatabasesPath();
  ////////////// OnCreate Database
  Future<void> onCreateDatabase() async {
    // ignore: unused_local_variable
    var databasesPath = await getDatabasesPath();

    database = await openDatabase(
      join(await getDatabasesPath(), 'databaseName.db'),
      onCreate: (db, version) {},
      version: 2,
    );
    // if (database != null) {
    // database!.execute('drop table if exists HomeParArrear');
    //   debugPrint("table was drop");
    // } else {
    //   debugPrint("No database");
    // }

    // database!.execute(
    //     'create table if not exists Login (userId varchar not null,password varchar not null, uname varchar, branch varchar)');

    // await database!.execute(
    //     'create table if not exists User(id num, name varchar, age varchar ,gender varchar)');
    //not null PRIMARY KEY UNIQUE
    // database!.execute(
    //     'create table if not exists HomeParArrear (id INTEGER PRIMARY KEY autoincrement, parRatio1 DOUBLE, parRatio14 DOUBLE, parRatio30 DOUBLE, parRatio60 DOUBLE, parRatio90 DOUBLE, parAcc1 INTEGER, parAcc14 INTEGER, parAcc30 INTEGER, parAcc60 INTEGER, parAcc90 INTEGER, parAmt1 DOUBLE, parAmt14 DOUBLE, parAmt30 DOUBLE, parAmt60 DOUBLE, parAmt90 DOUBLE, totalParAcc INTEGER, totalParAmt DOUBLE)');
    database!.execute(
        'create table if not exists ParArrearDetail (id INTEGER PRIMARY KEY autoincrement, overdueDays num, customerName varchar, cellPhoneNo varchar, totalAmount1 num, paymentApplyDate varchar, employeeName varchar, loanAmount num, loanPeriodMonthlyCount num, branchLocalName varchar, refereneceEmployeeNo varchar, currencyCode varchar, postalAddress varchar, overdueInterest num, repayPrincipal num, collateralMaintenanceFee num, repayInterest num, loanAccountNo varchar, villageName varchar, communeName varchar, districtName1 varchar, provinceName varchar, customerNo varchar, loanBranchCode varchar, branchName varchar)');
    // database!
    //     .execute('create table if not exists Token (token varchar not null)');
    // database!.execute(
    //     'create table if not exists LaonArrear (loanAccNo varchar not null, customerNo varchar not null, customerName varchar not null, phoneNo varchar not null, overDueDays interger not null, totalRepayment DOUBLE not null, coName varchar not null, coId varchar not null)');
    debugPrint('database already create');
  }

  /// On create table
  onCreateTable({
    String? tableName,
    String? tableColumn,
    // Database? database,
  }) async {
    try {
      await database!
          .execute('create table if not exists $tableName ($tableColumn);');
      database;
      debugPrint('Create Table success===:');
    } catch (e) {
      debugPrint('Catch===:${e.toString()}');
    }
  }

  Future<void> runQuery(String sql) async {
    final db = await database;
    await db!.execute(sql);
  }

// Insert Data into table
  Future<void> insertData({
    String? sql,
  }) async {
    final db = await database;
    await db!.execute(sql!);

    // .rawQuery('$columData'
    // 'INSERT INTO User (id, name, age, gender) VALUES (1,"Yingg" , "18","Female")'
  }

  Future<UserInfoLocalModel> getLocalUserInfo() {
    final db = database;
    var res = db!.rawQuery('SELECT * FROM Login');
    Future<UserInfoLocalModel> localUserInfo = res.then((value) {
      final userID = value.first['uid'] as String;
      final userName = value.first['uname'] as String;
      return UserInfoLocalModel(userID, userName);
    });
    debugPrint("db user : $localUserInfo");
    return localUserInfo;
  }

  // Get Data from table database
  Future<List<Map<String, Object?>>> getData({String? tableName}) async {
    final db = database;
    var res = await db!.rawQuery('Select * from $tableName');
    debugPrint('get data from sqlite:$res');
    return res;
  }

  Future<MyLoginModel?> getUserByUserId({String? userId}) async {
    var res =
        // await database!.rawQuery("Select * from Login where userId = '1'");
        await database!.query("Login",
            columns: ["userId", "password"],
            where: "userId = ?",
            whereArgs: [userId]);

    debugPrint("$res");
    if (res.length > 0) {
      var loginModel = MyLoginModel.fromMap(res.first);
      return loginModel;
    }
    return null;

    // var login = Map<String, Object?>.from(data);
    // debugPrint("$login >>>>>>");
  }

  var resQuery;
  Future<List<Map<String, Object?>>> queryData({String? sql}) async {
    final db = database;
    var res = await db!.rawQuery('$sql');
    resQuery = res;

    debugPrint('query data from sqlite:$res');
    return res;
  }

  Future<Database> getDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'databaseName.db'),
      onCreate: (db, version) {},
      version: 2,
    );
    return database!;
  }

  ////////////// Delete row in table
  Future<void> onDeleteRow(String? tableName) async {
    final db = database;
    var res = await db!.rawQuery('delete from $tableName');
    debugPrint('Table Row was deleted:$res');
  }

  ////////// Drop Table
  Future<void> onDropTable(String? tableName) async {
    final db = database;
    var res = await db!.rawQuery('drop table if exists $tableName');
    debugPrint('Table was deleted:$res');
  }
}

////////////////// How to use
/// - declear class on as SqliteHelper? helper;
/// - And then past this on build or initail => helper = SqliteHelper(); for assign value
/// - tableColumn: 'id int not null, name varchar not null, age varchar not null,gender varchar not null' Note=> (create table)
/// - columData:'INSERT INTO User (id, name, age, gender) VALUES (2,"yee" , "12","Female")' Note=>(for insert data)
///
///
///

class MyLoginModel {
  int? userId;
  String? password;

  MyLoginModel({this.userId, this.password});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'password': password,
    };
  }

  MyLoginModel.fromMap(Map<String, Object?> json) {
    userId = json['userId'] as int?;
    password = json['password'] as String?;
  }
}
