class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String userType; // 'parent' or 'educator'
  final UserPreferences preferences;
  final DateTime? lastLogin;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.preferences,
    this.lastLogin,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userType: json['userType'] as String,
      preferences: UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userType': userType,
      'preferences': preferences.toJson(),
      'lastLogin': lastLogin?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class UserPreferences {
  final String language;
  final bool emailNotifications;
  final bool pushNotifications;
  final String theme; // 'light' or 'dark'

  UserPreferences({
    this.language = 'es',
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.theme = 'light',
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      language: json['language'] as String? ?? 'es',
      emailNotifications: json['emailNotifications'] as bool? ?? true,
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      theme: json['theme'] as String? ?? 'light',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'theme': theme,
    };
  }
}
