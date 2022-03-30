import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/handlers/handlers.dart';
import 'package:volt_driver/presentation/theme/light_theme.dart';
import 'package:volt_driver/utils/utils.dart';
import 'presentation/shared/dialog_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnvFile();
  final url = dotenv.env['STAGING_API']!;

  await setupLocator(baseApi: url);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (value) {
      runApp(const VoltDriverApp());
    },
  );
}

class VoltDriverApp extends StatelessWidget {
  const VoltDriverApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 630),
        builder: () => MultiProvider(
            providers: AppProviders.providers,
            builder: (context, child) {
              return MaterialApp(
                theme: lightTheme,
                debugShowCheckedModeBanner: false,
                navigatorKey: locator<NavigationHandler>().navigatorKey,
                onGenerateRoute: RouteGenerator.onGenerateRoute,
                initialRoute: splashScreenViewRoute,
                builder: (context, widget) => Navigator(
                  onGenerateRoute: (settings) => CupertinoPageRoute(
                    builder: (context) => DialogManager(
                      child: widget!,
                    ),
                  ),
                ),
              );
            }));
  }
}
