import 'package:flutter_app/src/databases/sqflite/tables/tables.dart';

abstract class PostersTable {
  static final name = 'posters';

  static final colPosterId = 'pk';
  static final colOwnerId = 'ownerId';
  static final colTheme = 'theme';
  static final colText = 'text';
  static final colPrice = 'price';
  static final colCurrency = 'currency';
  static final colContractPrice = 'contract_price';
  static final colLocation = 'location';
  static final colCategory = 'category';
  static final colActivatedAt = 'activated_at';
  static final colIsActive = 'is_active';

  static final create = '''CREATE TABLE $name(
        $colPosterId INTEGER PRIMARY KEY,
        $colOwnerId INTEGER,
        $colTheme TEXT,
        $colText TEXT,
        $colPrice REAL,
        $colCurrency REAL,
        $colContractPrice INTEGER,
        $colLocation TEXT,
        $colCategory TEXT,
        $colActivatedAt TEXT,
        $colIsActive INTEGER,
        FOREIGN KEY ($colOwnerId)
        REFERENCES ${UsersTable.name}(${UsersTable.colUserId})
        )''';
}
