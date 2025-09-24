import 'package:flutter/material.dart';
import 'package:notebook/src/config/app_theme.dart';
import 'package:notebook/src/config/dependencies.dart';
import 'package:notebook/src/config/routes.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notes',
      routerConfig: router,
      theme: AppTheme().getTheme(),
    );
  }
}
