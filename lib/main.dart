import 'dart:async';
import 'dart:io';
import 'package:chokchey_finance/providers/customerRegistration.dart';
import 'package:chokchey_finance/providers/groupLoan/index.dart';
import 'package:chokchey_finance/providers/listCustomerRegistration.dart';
import 'package:chokchey_finance/providers/lmapProvider/index.dart';
import 'package:chokchey_finance/providers/loan/createLoan.dart';
import 'package:chokchey_finance/providers/loan/loanApproval.dart';
import 'package:chokchey_finance/providers/notification/index.dart';
import 'package:chokchey_finance/providers/approvalList.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app/module/splash/splash_screen.dart';
import 'app/utils/helpers/firebase_service_api.dart';
import 'app/utils/helpers/local_storage.dart';
import 'localizations/appLocalizations.dart';
import 'providers/loanArrearProvider/loanArrearProvider.dart';
import 'providers/login.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await Firebase.initializeApp();
  await LocalStorage.init();
  await dotenv.load();

  await FirebaseHelperApi().initNotifications();
  // await Upgrader.clearSavedSettings();
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyHomePageState state =
        context.findAncestorStateOfType<_MyHomePageState>()!;
    state.setLocale(locale);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // advancedStatusCheck(NewVersion newVersion) async {
  //   final status = await newVersion.getVersionStatus();
  //   if (status != null) {
  //     debugPrint(status.releaseNotes);
  //     debugPrint(status.appStoreLink);
  //     debugPrint(status.localVersion);
  //     debugPrint(status.storeVersion);
  //     debugPrint(status.canUpdate.toString());
  //     newVersion.showUpdateDialog(
  //       context: context,
  //       versionStatus: status,
  //       dialogTitle: 'Custom Title',
  //       dialogText: 'Custom Text',
  //     );
  //   }
  // }

  // basicStatusCheck(NewVersion newVersion) async {
  //   if (Platform.isIOS) {
  //     newVersion.showAlertIfNecessary(context: context);
  //   }
  // }

  // final newVersion = NewVersion(
  //   iOSId: 'com.ccf.coapp',
  //   androidId: 'com.ccf.coapp',
  // );

  @override
  void initState() {
    super.initState();
  }

  final storage = new FlutterSecureStorage();
  bool isLogins = false;
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    // isLogin();

    super.didChangeDependencies();
  }

  Future<void> isLogin() async {
    String? ids = await storage.read(key: 'user_id');
    logger().e("ids: ${ids}");
    if (ids != '') {
      setState(() {
        isLogins = true;
      });
    } else {
      setState(() {
        isLogins = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<LoginProvider>(create: (_) => LoginProvider()),
        Provider<ApprovelistProvider>(create: (_) => ApprovelistProvider()),
        Provider<ListCustomerRegistrationProvider>(
            create: (_) => ListCustomerRegistrationProvider()),
        Provider<CustomerRegistrationProvider>(
            create: (_) => CustomerRegistrationProvider()),
        Provider<LoanInternal>(create: (_) => LoanInternal()),
        Provider<LoanApproval>(create: (_) => LoanApproval()),
        Provider<NotificationProvider>(create: (_) => NotificationProvider()),
        Provider<GroupLoanProvider>(create: (_) => GroupLoanProvider()),
        Provider<LoanArrearProvider>(create: (_) => LoanArrearProvider()),
        Provider<LmapProvider>(create: (_) => LmapProvider()),
      ],
      child: MaterialApp(
        locale: _locale,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // _checkPlatform(
        //   SplashScreen(),
        // ),
        // UpgradeAlert(
        //     upgrader: Upgrader(
        //       appcastConfig: cfg,
        //       // appcast: ,
        //       dialogStyle: Platform.isIOS
        //           ? UpgradeDialogStyle.cupertino
        //           : UpgradeDialogStyle.material,
        //       messages: UpgraderMessages(code: 'es'),
        //       canDismissDialog: true,
        //       durationUntilAlertAgain: Duration(minutes: 5),
        //       showIgnore: false,
        //       shouldPopScope: () => true,
        //     ),
        //     child: SplashScreen()),

        // _isLogin ? Home() : Login(),
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('km', 'KH'), // Hebrew, no country code
          const Locale('en', 'US'), // English, no country code
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        navigatorKey: navigatorKey,
        // routes: {
        //   ApprovalLists.routeName: (cxt) => ApprovalLists(),
        //   LoanCollectionDetailScreen.route: (context) {
        //     return LoanCollectionDetailScreen();
        //   }
        // },
      ),
    );
  }
}
