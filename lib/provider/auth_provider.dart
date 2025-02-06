import 'package:flutter/material.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _token;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _token = await _authRepository.loginUser(email, password);
    } catch (e) {
      _errorMessage = "Invalid credentials!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
