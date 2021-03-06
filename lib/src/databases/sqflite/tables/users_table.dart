abstract class UsersTable {
  static final name = 'users';

  static final colUserId = 'id';
  static final colUsername = 'username';
  static final colEmail = 'email';
  static final colFirstName = 'first_name';
  static final colLastName = 'last_name';
  static final colAvatar = 'avatar';
  static final colLocation = 'location';
  static final colColorScheme = 'color_scheme';
  static final colLanguage = 'language';

  static final create = '''CREATE TABLE $name(
        $colUserId INTEGER PRIMARY KEY,
        $colUsername TEXT,
        $colEmail TEXT,
        $colFirstName TEXT,
        $colLastName TEXT, 
        $colAvatar TEXT,
        $colLocation TEXT,
        $colColorScheme TEXT,
        $colLanguage TEXT
        )''';
}
