abstract class SecureStorage {
  Future<String?> read(String key);
  Future<void> write({required String key, required String value});
  Future<bool> delete(String key);
}
