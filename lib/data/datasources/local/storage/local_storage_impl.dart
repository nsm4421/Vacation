import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  Directory? _appDir;
  final Logger? _logger;

  LocalStorageImpl({required Logger? logger}) : _logger = logger;

  @override
  Future<String> saveFileAndReturnPath({
    required File file,
    bool upsert = true,
  }) async {
    final savePath = await genRandomFilePath(file);
    if (await _isFileExist(savePath) && !upsert) {
      _logger?.e('already file exists but upsert option is false');
      throw Exception(savePath);
    }
    return await file.copy(savePath).then((res) => res.path);
  }

  @override
  Future<void> deleteFile(String path) async {
    if (!await _isFileExist(path)) {
      _logger?.e('nothing to delete');
      throw Exception(path);
    }
    await File(path).delete();
  }

  Future<String> genRandomFilePath(File file) async {
    _appDir ??= await getApplicationDocumentsDirectory();
    return '${_appDir!.path}/${await _genRandomFilename(file)}';
  }

  Future<String> _genRandomFilename(File file) async {
    final extension = p.extension(file.path);
    return '${Uuid().v4()}$extension';
  }

  Future<bool> _isFileExist(String path) async {
    return await File(path).exists();
  }
}
