import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/child.dart';
import 'mock_data_service.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userTypeKey = 'user_type';

  // Simulate login
  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    // Find user in mock data
    final user = MockDataService.mockUsers.firstWhere(
      (u) => u.email == email,
      orElse: () => throw Exception('Usuario no encontrado'),
    );

    // In a real app, check password here
    // For mock, accept any password

    // Save token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, 'mock_token_${user.id}');
    await prefs.setString(_userIdKey, user.id);
    await prefs.setString(_userTypeKey, user.userType);

    return user;
  }

  // Simulate child login with PIN
  Future<Child?> loginChild(String childId, String pin) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final child = MockDataService.mockChildren.firstWhere(
      (c) => c.id == childId && c.pin == pin,
      orElse: () => throw Exception('PIN incorrecto'),
    );

    // Save child session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, 'mock_child_token_${child.id}');
    await prefs.setString(_userIdKey, child.id);
    await prefs.setString(_userTypeKey, 'child');

    return child;
  }

  // Register new user
  Future<User?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // Check if user already exists
    final exists = MockDataService.mockUsers.any((u) => u.email == email);
    if (exists) {
      throw Exception('El correo ya está registrado');
    }

    // Create new user
    final newUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      firstName: firstName,
      lastName: lastName,
      userType: userType,
      preferences: UserPreferences(),
      createdAt: DateTime.now(),
    );

    // Add to mock data
    MockDataService.mockUsers.add(newUser);

    // Save token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, 'mock_token_${newUser.id}');
    await prefs.setString(_userIdKey, newUser.id);
    await prefs.setString(_userTypeKey, newUser.userType);

    return newUser;
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userTypeKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }

  // Get current user type
  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  // Get current user ID
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    final userId = await getUserId();
    final userType = await getUserType();

    if (userId == null || userType != 'parent' && userType != 'educator') {
      return null;
    }

    return MockDataService.mockUsers.firstWhere(
      (u) => u.id == userId,
      orElse: () => throw Exception('Usuario no encontrado'),
    );
  }

  // Get current child
  Future<Child?> getCurrentChild() async {
    final childId = await getUserId();
    final userType = await getUserType();

    if (childId == null || userType != 'child') {
      return null;
    }

    return MockDataService.mockChildren.firstWhere(
      (c) => c.id == childId,
      orElse: () => throw Exception('Niño no encontrado'),
    );
  }
}
