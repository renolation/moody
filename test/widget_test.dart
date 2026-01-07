import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:moody/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MoodHolderApp(),
      ),
    );

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify the app renders without crashing
    expect(find.byType(MoodHolderApp), findsOneWidget);
  });
}
