import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/child.dart';
import '../services/auth_service.dart';
import '../services/mock_data_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _currentUser;
  Child? _currentChild;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  Child? get currentChild => _currentChild;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null || _currentChild != null;
  bool get isParent => _currentUser != null;
  bool get isChild => _currentChild != null;

  // Check authentication status on app start
  Future<void> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final userType = await _authService.getUserType();
        if (userType == 'child') {
          _currentChild = await _authService.getCurrentChild();
        } else {
          _currentUser = await _authService.getCurrentUser();
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login as parent
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.login(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Login as child
  Future<bool> loginChild(String childId, String pin) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentChild = await _authService.loginChild(childId, pin);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String userType = 'parent',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        userType: userType,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    _currentChild = null;
    notifyListeners();
  }

  // Get children for current parent
  List<Child> getChildren() {
    if (_currentUser == null) return [];
    return MockDataService.mockChildren
        .where((c) => c.parentId == _currentUser!.id)
        .toList();
  }

  // Get child by ID
  Child? getChildById(String childId) {
    try {
      return MockDataService.mockChildren.firstWhere((c) => c.id == childId);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
