part of 'local_storage_impl.dart';

abstract interface class LocalStorage {
  Future<String> saveFileAndReturnPath({
    required File file,
    bool upsert = true,
  });

  Future<void> deleteFile(String path);
}
