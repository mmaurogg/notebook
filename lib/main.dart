import 'package:flutter/material.dart';
import 'package:notebook/src/config/app_theme.dart';
import 'package:notebook/src/config/routes.dart';
import 'package:notebook/src/providers/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return NotesProvider();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
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
