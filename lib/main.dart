import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/global.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(
    /*// comment this if you want to disable DevicePreview entirely on debug
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp()
    )*/
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          /*useInheritedMediaQuery: true, // comment this if you want to disable DevicePreview entirely on debug
          locale: DevicePreview.locale(context), // comment this if you want to disable DevicePreview entirely on debug
          builder: DevicePreview.appBuilder, // comment this if you want to disable DevicePreview entirely on debug*/
          title: 'Cek LPSE Pre-Test Mobile Dev',
          theme: MyTheme.lightTheme(context),
          getPages: AppPages.routes,
          initialRoute: localStorage.read('access_token') != null
              ? Routes.HOME
              : Routes.AUTH,
        );
      },
    );
  }
}
