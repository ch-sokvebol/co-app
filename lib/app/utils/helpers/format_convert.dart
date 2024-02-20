import 'dart:io';

import 'package:intl/intl.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:path_provider/path_provider.dart';

class FormatConvert {
  static formatCurrency(double number, {bool isShowLast = true}) {
    final result = NumberFormat("#,##0.00", "en_US");
    return isShowLast
        ? result.format(number)
        : result.format(number).replaceAll('.00', '');
  }

  static formatAmountUSD(num number, {bool isShowLast = true}) {
    final result = NumberFormat("#,##0.00", "en_US");
    return isShowLast
        ? result.format(number)
        : result.format(number).replaceAll('.00', '');
  }

  static formatCurrencyNew(num number, {bool isShowLast = true}) {
    final result = NumberFormat("#,##0.0", "en_US");
    return isShowLast
        ? result.format(number)
        : result.format(number).replaceAll('.0', '');
  }

  static formatCurrencyUSD(num number, {bool isShowLast = true}) {
    final result = NumberFormat("#,###", "en_US");
    return isShowLast
        ? result.format(number)
        : result.format(number).replaceAll('', '');
  }

  static formatdigit(int number, {bool isShowLast = true}) {
    final result = NumberFormat("#,###", "en_US");
    return isShowLast
        ? result.format(number)
        : result.format(number).replaceAll('', '');
  }

  static formatString(String number, {bool isShowLast = true}) {
    final result = NumberFormat("#,###", "en_US");
    return isShowLast
        ? result.format(number)
        : result.format(number).replaceAll('', '');
  }

  static Future<File> getImageFileFromAssets( asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    //debugPrint('=========$file');
    return file;
  }
}
