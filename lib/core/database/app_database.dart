import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column<Object>> get primaryKey => {key};
}

class QuranBookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get label => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ReadingProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Adhkar extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get content => text()();
  TextColumn get source => text().nullable()();
  IntColumn get repetitions => integer().withDefault(const Constant(1))();
}

class AdhkarSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get adhkarId => integer().nullable()();
  IntColumn get count => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TasbeehSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get phrase => text()();
  IntColumn get count => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class PersonalNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemType => text()();
  TextColumn get itemKey => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class AudioProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get audioKey => text().unique()();
  IntColumn get positionMs => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class PrayerSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cityName => text().nullable()();
  TextColumn get calculationMethod => text().withDefault(const Constant('UmmAlQura'))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(false))();
}

class KhatmaProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant('ختمتي'))();
  IntColumn get currentPage => integer().withDefault(const Constant(1))();
  IntColumn get targetDays => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class DownloadedFiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentKey => text().unique()();
  TextColumn get localPath => text()();
  IntColumn get sizeBytes => integer().withDefault(const Constant(0))();
  DateTimeColumn get downloadedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [
  AppSettings,
  QuranBookmarks,
  ReadingProgress,
  Adhkar,
  AdhkarSessions,
  TasbeehSessions,
  PersonalNotes,
  Favorites,
  AudioProgress,
  PrayerSettings,
  KhatmaProgress,
  DownloadedFiles,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {},
      );

  Future<int> incrementTasbeeh({
    required String phrase,
    required int count,
  }) async {
    final existing = await (select(tasbeehSessions)
          ..where((t) => t.phrase.equals(phrase)))
        .getSingleOrNull();

    if (existing == null) {
      return into(tasbeehSessions).insert(
        TasbeehSessionsCompanion.insert(phrase: phrase, count: Value(count)),
      );
    }

    await (update(tasbeehSessions)
          ..where((t) => t.id.equals(existing.id)))
        .write(TasbeehSessionsCompanion(
      count: Value(count),
      updatedAt: Value(DateTime.now()),
    ));
    return existing.id;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'asho_islamic.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
