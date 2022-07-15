

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/mainfortest.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end-test', () {
    testWidgets('tap on the floation action button,verify counter', (tester) async {
      app.MyHomePage;
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);

      final Finder fab = find.byTooltip("Increment");
      await tester.tap(fab);

      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });
  });
}