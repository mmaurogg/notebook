import 'package:go_router/go_router.dart';
import 'package:notebook/src/data/repositories/notes_repository_imp.dart';
import 'package:notebook/src/ui/pages/home_page.dart';
import 'package:notebook/src/ui/pages/note_detail_page.dart';
import 'package:notebook/src/ui/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  onException: (_, GoRouterState state, GoRouter router) {
    state.fullPath == '' ? router.go('/') : router.go('/');
  },
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),

    GoRoute(
      path: '/notes',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '0';
            return NoteDetailPage(
              id: int.parse(id),
              viewModel: HomeViewModel(
                notesRepository: context.read<NotesRepositoryImp>(),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
