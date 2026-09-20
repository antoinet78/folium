import 'package:flutter_test/flutter_test.dart';
import 'package:folium/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FoliumApp());
    expect(find.text('Search your notes'), findsOneWidget);
  });
}
