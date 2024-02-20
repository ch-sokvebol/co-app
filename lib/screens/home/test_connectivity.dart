import 'dart:async';

import 'package:chokchey_finance/app/utils/helpers/internet_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityTest extends StatefulWidget {
  const ConnectivityTest({super.key});

  @override
  State<ConnectivityTest> createState() => _ConnectivityTestState();
}

class _ConnectivityTestState extends State<ConnectivityTest> {
  final con = Get.put(ConnenctivityApp());
  StreamSubscription? connection;
  // bool isoffline = false;
  Future<void> onConnetion() async {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          con.isoffline.value = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          con.isoffline.value = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          con.isoffline.value = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          con.isoffline.value = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          con.isoffline.value = false;
        });
      }
    });
  }

  @override
  void initState() {
    onConnetion();
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 30),
              color: con.isoffline.value ? Colors.red : Colors.lightGreen,
              //red color on offline, green on online
              padding: EdgeInsets.all(10),
              child: Text(
                con.isoffline.value ? "Device is Offline" : "Device is Online",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var result = await Connectivity().checkConnectivity();
                  if (result == ConnectivityResult.mobile) {
                    print("Internet connection is from Mobile data");
                  } else if (result == ConnectivityResult.wifi) {
                    print("internet connection is from wifi");
                  } else if (result == ConnectivityResult.ethernet) {
                    print("internet connection is from wired cable");
                  } else if (result == ConnectivityResult.bluetooth) {
                    print("internet connection is from bluethooth threatening");
                  } else if (result == ConnectivityResult.none) {
                    print("No internet connection");
                  }
                },
                child: Text("Check Internet Connection")),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    if (con.isoffline.value == false) {
                      con.isoffline.value = false;
                    } else {
                      con.isoffline.value = true;
                    }
                  });
                },
                child: Text("refresh")),
          ],
        ),
      ),
    );
  }
}
