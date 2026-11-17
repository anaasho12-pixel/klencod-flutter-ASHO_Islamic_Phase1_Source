import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asho_islamic/app.dart';

void main() {
  testWidgets('ASHO home screen renders Arabic brand', (tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: AshoApp(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('أشو'), findsOneWidget);
    expect(find.text('أهلاً بك في أشو'), findsOneWidget);
    expect(find.text('المسبحة الإلكترونية'), findsOneWidget);
  });
}
