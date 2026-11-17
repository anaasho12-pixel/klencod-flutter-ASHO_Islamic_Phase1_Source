import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:asho_islamic/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('database creates tables and persists a tasbeeh row in session', () async {
    await database.into(database.tasbeehSessions).insert(
      TasbeehSessionsCompanion.insert(
        phrase: 'سبحان الله',
        count: const Value(3),
      ),
    );

    final rows = await database.select(database.tasbeehSessions).get();
    expect(rows, hasLength(1));
    expect(rows.first.count, 3);
  });
}
