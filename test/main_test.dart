import 'package:divide_ai/main.dart';
import 'package:divide_ai/core/app_routes.dart';
import 'package:divide_ai/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DivideAiApp', () {
    testWidgets(
      'should render MaterialApp with router configured and open home screen',
      (
        WidgetTester tester,
      ) async {
        final router = setupRoutes();
        await tester.pumpWidget(DivideAiApp(router: router));

        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        expect(materialApp.routerConfig, equals(router));

        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );
  });
}
