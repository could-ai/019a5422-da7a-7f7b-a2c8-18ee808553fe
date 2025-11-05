import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      final email = prefs.getString('user_email');
      final name = prefs.getString('user_name');
      final plan = prefs.getString('user_plan') ?? 'free';

      if (userId != null && email != null) {
        _user = UserModel(
          id: userId,
          email: email,
          name: name ?? 'User',
          subscriptionPlan: plan,
          createdAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual Supabase authentication
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful login
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      _user = UserModel(
        id: userId,
        email: email,
        name: email.split('@')[0],
        subscriptionPlan: 'free',
        createdAt: DateTime.now(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
      await prefs.setString('user_email', email);
      await prefs.setString('user_name', _user!.name);
      await prefs.setString('user_plan', 'free');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String email, String password, String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual Supabase authentication
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful signup
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      _user = UserModel(
        id: userId,
        email: email,
        name: name,
        subscriptionPlan: 'free',
        createdAt: DateTime.now(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
      await prefs.setString('user_email', email);
      await prefs.setString('user_name', name);
      await prefs.setString('user_plan', 'free');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Signup failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Implement Google Sign-In with Supabase
      await Future.delayed(const Duration(seconds: 2));

      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      _user = UserModel(
        id: userId,
        email: 'user@gmail.com',
        name: 'Google User',
        subscriptionPlan: 'free',
        createdAt: DateTime.now(),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Google login failed.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _user = null;
    notifyListeners();
  }

  Future<void> upgradePlan(String plan) async {
    if (_user != null) {
      _user = UserModel(
        id: _user!.id,
        email: _user!.email,
        name: _user!.name,
        subscriptionPlan: plan,
        createdAt: _user!.createdAt,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_plan', plan);
      notifyListeners();
    }
  }
}
