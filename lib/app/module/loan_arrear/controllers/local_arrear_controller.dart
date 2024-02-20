import 'package:chokchey_finance/app/utils/helpers/sqlite_helper.dart';

import '../../home_new/model/arrear_model_new.dart';

class LocalArrearController {
  LocalArrearController() {
    // getArrearLocal();
    sqliteHelper = SqliteHelper();
  }
  // Database db;
  SqliteHelper? sqliteHelper;
  getArrearLocal(ArrearModelNew arr) async {
    await sqliteHelper!.runQuery(
        '''INSERT INTO ParArrearDetail($arr) VALUES ("${arr.alternativeTransferAccountNo}")''');
    // return arr;
  }
}
