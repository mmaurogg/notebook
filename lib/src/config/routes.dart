import 'package:go_router/go_router.dart';
import 'package:notebook/src/ui/pages/home_page.dart';
import 'package:notebook/src/ui/pages/note_detail_page.dart';
import 'package:notebook/src/ui/pages/note_form.dart';

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
            return NoteDetailPage(id: int.parse(id));
          },
        ),
      ],
    ),

    GoRoute(path: '/add', builder: (context, state) => NoteForm()),

    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return NoteForm(noteId: int.parse(id!));
      },
    ),
  ],
);
