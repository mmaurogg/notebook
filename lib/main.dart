import 'package:flutter/material.dart';
import 'package:notebook/src/config/app_theme.dart';
import 'package:notebook/src/config/routes.dart';
import 'package:notebook/src/data/services/local/data_base.dart';
import 'package:notebook/src/data/repositories/notes_repository_imp.dart';
import 'package:notebook/src/ui/view_models/home_view_model.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // Services
        Provider(create: (context) => SqlDatabase.instance),

        // Repositories
        ProxyProvider<SqlDatabase, NotesRepositoryImp>(
          update: (_, db, __) => NotesRepositoryImp(sqlDatabase: db),
        ),

        // ViewModels
        ChangeNotifierProxyProvider<NotesRepositoryImp, HomeViewModel>(
          create: (context) {
            return HomeViewModel(
              notesRepository: context.read<NotesRepositoryImp>(),
            );
          },
          update: (_, repo, __) => HomeViewModel(notesRepository: repo),
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
