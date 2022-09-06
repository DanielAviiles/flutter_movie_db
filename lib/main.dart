import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/core/api/api_route_config.dart';
import 'package:flutter_movies_db/app/routes/app_pages_route.dart';
import 'package:flutter_movies_db/app/routes/app_routes.dart';
import '/app/di/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.configureAppInjection();
  await ApiRouteConfig.loadEnviroments();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: AppRoutes.home,
      routes: AppPagesRoute.getRoutes(),
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: Colors.red,
      )),
    );
  }
}
