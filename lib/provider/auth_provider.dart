import 'package:flutter/material.dart';
import 'package:sample_office_project/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.authRepository});

  final AuthRepository authRepository;

  String? _token;
  bool _loading = false;

  String? get token => _token;
  bool get loading => _loading;

  // store token
  Future<void> addToken(String token) async {
    _loading = true;
    notifyListeners();
    try {
      await authRepository.addToken(token);
      _token = token;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  // set token in state
  Future<void> getToken() async {
    _loading = true;
    notifyListeners();
    try {
      _token = await authRepository.getToken();
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  // remove token
  Future<void> clearToken() async {
    _loading = true;
    notifyListeners();
    try {
      await authRepository.clearToken();
      _token = null;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw e.toString();
    }
  }
}
