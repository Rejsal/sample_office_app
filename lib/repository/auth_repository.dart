import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sample_office_project/utils/constants.dart';

class AuthRepository {
  const AuthRepository({required this.storage});

  final FlutterSecureStorage storage;

  // store token
  Future<void> addToken(String token) async {
    return await storage.write(key: kToken, value: token);
  }

  // get token from storage
  Future<String?> getToken() async {
    return await storage.read(key: kToken);
  }

  // clear token from storage
  Future<void> clearToken() async {
    return await storage.delete(key: kToken);
  }
}
