import 'dart:async';
import 'dart:io';

import 'package:chokchey_finance/app/utils/helpers/local_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/sqlite_helper.dart';
import '../../base/api_base.dart';

class LogController extends GetxController {
  final maxlenght = 0.obs;
  final userID = ''.obs;
  // var imageSell = <Asset>[];
  var imageFileSell = <File>[].obs;
  File? imageProfile;
  var isImage = false.obs;
  final image = ''.obs;
  final password = ''.obs;
  final list = [].obs;
  final apiBaseHelper = ApiBaseHelper();
  final isLoading = false.obs;
  var isLoadingUser = false.obs;
  var isLoadingChangeProfilePhoto = false.obs;
  var userType = ''.obs;
  //
  SqliteHelper? sqliteHelper; // = SqliteHelper();
  StreamSubscription? connection;
  var isoffline = false.obs;
  var getUserId = 0.obs;
  var userName = ''.obs;

  Future<void> onLogin(String? userID, String? password) async {
    try {
      await apiBaseHelper.onNetworkRequesting(
          url: 'token',
          methode: METHODE.post,
          isAuthorize: true,
          body: {
            "user_id": "$userID",
            "password": "$password",
          }).then(
        (response) {
          final _token = response['access_token'];
          LocalStorage.storeData(key: 'token', value: '$_token');
        },
      ).onError(
        (error, stackTrace) {},
      );
    } catch (e) {
      // debugPrint("catch: $e");
    }
  }

  Future<void> onConnection() async {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection

        isoffline.value = true;
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network

        isoffline.value = false;
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi

        isoffline.value = false;
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection

        isoffline.value = false;
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening

        isoffline..value = false;
      }
    });
  }
}
