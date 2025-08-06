import 'package:divide_ai/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter setupRoutes() {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  return router;
}
