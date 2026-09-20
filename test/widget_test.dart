import 'package:flutter_test/flutter_test.dart';
import 'package:keep_clone/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KeepCloneApp());
    expect(find.text('Search your notes'), findsOneWidget);
  });
}
