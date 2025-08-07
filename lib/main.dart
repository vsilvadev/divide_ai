import 'package:divide_ai/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    DivideAiApp(
      router: setupRoutes(),
    ),
  );
}

class DivideAiApp extends StatelessWidget {
  final GoRouter router;

  const DivideAiApp({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
