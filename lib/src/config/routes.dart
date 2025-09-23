import 'package:go_router/go_router.dart';
import 'package:notebook/src/UI/pages/home_page.dart';
import 'package:notebook/src/UI/pages/note_detail_page.dart';

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
            final id = state.pathParameters['id'] ?? '';
            return NoteDetailPage(id: id);
          },
        ),
      ],
    ),
  ],
);
