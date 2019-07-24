import 'package:flutter_app/src/database/owners_table.dart';

abstract class PostersTable {
  static final name = 'posters';

  static final colPosterId = 'poster_id';
  static final colOwnerId = 'owner_id';
  static final colTheme = 'theme';
  static final colText = 'text';
  static final colPrice = 'price';
  static final colCurrency = 'currency';
  static final colImages = 'images';
  static final colContractPrice = 'contract_price';
  static final colLocation = 'location';
  static final colCategory = 'category';
  static final colActivatedAt = 'activated_at';
  static final colIsActive = 'is_active';

  static final create = '''CREATE TABLE ${PostersTable.name}(
        ${colPosterId} INTEGER PRIMARY KEY,
        ${colOwnerId} INTEGER,
        FOREIGN KEY (${colOwnerId}) 
        REFERENCES ${OwnersTable.name}(${OwnersTable.colOwnerId})
        ${colTheme} TEXT,
        ${colPrice} REAL,
        ${colImages} TEXT, 
        ${colContractPrice} INTEGER,
        ${colLocation} TEXT,
        ${colCategory} TEXT,
        ${colActivatedAt} TEXT,
        ${colIsActive} INTEGER
        )''';
}
