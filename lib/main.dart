import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/core/routes/app_router.dart';
import 'package:atef_physics/core/utils/app_utils.dart';
import 'package:atef_physics/features/backdoor/Back_door_services.dart';
import 'package:atef_physics/features/notification/firebase_api.dart';
import 'package:atef_physics/gen/fonts.gen.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:atef_physics/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await dotenv.load();
  //FireBase Code
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  //-Firebase Code
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await BackDoorServices.main();

  await Storage.instance.initStorage();
  Storage.instance.isFirstTime = true;
  AppColors.isDarkMode = Storage.instance.isDarkMood;

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'i18n',
        child: const MyApp()),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        AppScreenUtils.initUtils(context);
        return MaterialApp.router(
          routeInformationParser: AppRouter.goRouter.routeInformationParser,
          routerDelegate: AppRouter.goRouter.routerDelegate,
          routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: AppColors.whiteBlack, //change your color here
              ),
              color: AppColors.blackWhite,
            ),
            colorScheme: AppColors.scheme,
            primaryColor: AppColors.blue,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColors.blue.withOpacity(0.5),
              selectionHandleColor: AppColors.blue,
            ),
            fontFamily: FontFamily.alexandria,
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.blackWhite,
          ),

          // theme: AppColors.lightTheme,
          // darkTheme: AppColors.dartTheme,
          // themeMode:
          //     Storage.instance.isDarkMood ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
