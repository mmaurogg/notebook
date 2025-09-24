import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:notebook/src/data/repositories/notes_repository_imp.dart';
import 'package:notebook/src/data/services/local/data_base.dart';

import 'package:notebook/src/ui/view_models/notes_view_model.dart';

List<SingleChildWidget> providers = [
  // Services
  Provider(create: (context) => SqlDatabase.instance),

  // Repositories
  ProxyProvider<SqlDatabase, NotesRepositoryImp>(
    update: (_, db, __) => NotesRepositoryImp(sqlDatabase: db),
  ),

  // ViewModels
  ChangeNotifierProxyProvider<NotesRepositoryImp, NotesViewModel>(
    create: (context) {
      return NotesViewModel(
        notesRepository: context.read<NotesRepositoryImp>(),
      );
    },
    update: (_, repo, __) => NotesViewModel(notesRepository: repo),
  ),
];
