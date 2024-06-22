import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as size;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    size.ScreenUtil.init((context));
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.appBackground,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
